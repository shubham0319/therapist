package service

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"strings"
	"therapist/pkg/auth"
	"therapist/pkg/repo/db"
	schema "therapist/pkg/repo/db/schema/gen"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// UserResult is the user-facing result returned from auth / profile calls.
type UserResult struct {
	UserID              string
	Status              string // "needs_onboarding" | "active"
	OnboardingCompleted bool
	State               string
	Nation              string
}

// UserOnboardingInput is the handler-facing input for CompleteUserOnboarding.
type UserOnboardingInput struct {
	Name       string
	Phone      string
	State      string
	Nation     string
	LookingFor []string
}

// HandleUserAuthCallback upserts a user record and issues tokens.
// Accepts the same dev-bypass "dev:<email>" token as the therapist flow.
func (s *Service) HandleUserAuthCallback(ctx context.Context, supabaseToken string) (*UserResult, TokenPair, error) {
	s.log.Debug("user auth callback started")

	var uid, email string

	if !s.cfg.IsProdEnv && strings.HasPrefix(supabaseToken, "dev:") {
		email = strings.TrimPrefix(supabaseToken, "dev:")
		if email == "" {
			return nil, TokenPair{}, ErrBadInput
		}
		uid = "dev:" + email
		s.log.Warn("dev user auth bypass used — NOT safe for production", zap.String("email", email))
	} else {
		claims, err := auth.VerifySupabaseToken(supabaseToken, s.cfg.SupabaseJWTSecret)
		if err != nil {
			s.log.Warn("invalid supabase token for user auth", zap.Error(err))
			return nil, TokenPair{}, ErrInvalidToken
		}
		uid = claims.Sub
		email = claims.Email
	}

	u, err := s.db.UpsertUser(ctx, uid, email)
	if err != nil {
		s.log.Error("failed to upsert user", zap.String("supabase_uid", uid), zap.Error(err))
		return nil, TokenPair{}, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	pair, err := s.IssueUserTokens(ctx, u.ID)
	if err != nil {
		return nil, TokenPair{}, err
	}

	return toUserResult(u), pair, nil
}

// CompleteUserOnboarding saves name, phone, state, nation, looking_for.
func (s *Service) CompleteUserOnboarding(ctx context.Context, userID string, in UserOnboardingInput) error {
	if err := validateUserOnboarding(in); err != nil {
		s.log.Warn("user onboarding validation failed", zap.String("user_id", userID), zap.Error(err))
		return err
	}

	id, err := parseUUID(userID)
	if err != nil {
		return ErrBadInput
	}

	if err := s.db.CompleteUserOnboarding(ctx, id, db.UserOnboardingParams{
		Name:       in.Name,
		Phone:      in.Phone,
		State:      in.State,
		Nation:     in.Nation,
		LookingFor: in.LookingFor,
	}); err != nil {
		s.log.Error("CompleteUserOnboarding db failed", zap.String("user_id", userID), zap.Error(err))
		return fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	s.log.Info("user onboarding completed", zap.String("user_id", userID))
	return nil
}

// GetUserProfile fetches the user's current profile.
func (s *Service) GetUserProfile(ctx context.Context, userID string) (*UserResult, error) {
	id, err := parseUUID(userID)
	if err != nil {
		return nil, ErrBadInput
	}

	u, err := s.db.GetUserByID(ctx, id)
	if err != nil {
		return nil, ErrDBRecordNotFound
	}

	return toUserResult(u), nil
}

// IssueUserTokens creates a JWT + refresh token stored in user_sessions.
func (s *Service) IssueUserTokens(ctx context.Context, userID pgtype.UUID) (TokenPair, error) {
	accessTTL := time.Duration(s.cfg.AccessTokenTTLMinutes) * time.Minute
	expiresAt := time.Now().Add(accessTTL)

	claims := jwt.MapClaims{
		"sub":  userID.String(),
		"iat":  time.Now().Unix(),
		"exp":  expiresAt.Unix(),
		"typ":  "access",
		"kind": "user",
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	accessToken, err := token.SignedString([]byte(s.cfg.JWTSecret))
	if err != nil {
		s.log.Error("failed to sign user access token", zap.Error(err))
		return TokenPair{}, ErrUnexpected
	}

	raw := make([]byte, 32)
	if _, err := rand.Read(raw); err != nil {
		return TokenPair{}, ErrUnexpected
	}
	refreshToken := hex.EncodeToString(raw)
	refreshExpiry := time.Now().Add(time.Duration(s.cfg.RefreshTokenTTLDays) * 24 * time.Hour)

	if _, err := s.db.CreateUserSession(ctx, userID, refreshToken, refreshExpiry); err != nil {
		return TokenPair{}, ErrDBQuery
	}

	return TokenPair{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
		ExpiresAt:    expiresAt.Unix(),
	}, nil
}

// UserRefreshSession validates a user refresh token and rotates it.
func (s *Service) UserRefreshSession(ctx context.Context, refreshToken string) (*UserResult, TokenPair, error) {
	if refreshToken == "" {
		return nil, TokenPair{}, ErrInvalidToken
	}

	row, err := s.db.GetUserSessionByRefreshToken(ctx, refreshToken)
	if err != nil {
		return nil, TokenPair{}, ErrInvalidToken
	}

	if row.ExpiresAt.Time.Before(time.Now()) {
		_ = s.db.DeleteUserSession(ctx, refreshToken)
		return nil, TokenPair{}, ErrTokenExpired
	}

	user, err := s.db.GetUserByID(ctx, row.UserID)
	if err != nil {
		return nil, TokenPair{}, ErrDBQuery
	}

	if err := s.db.DeleteUserSession(ctx, refreshToken); err != nil {
		return nil, TokenPair{}, ErrDBQuery
	}

	pair, err := s.IssueUserTokens(ctx, user.ID)
	if err != nil {
		return nil, TokenPair{}, err
	}

	return toUserResult(user), pair, nil
}

// UserLogout invalidates the given user refresh token.
func (s *Service) UserLogout(ctx context.Context, refreshToken string) error {
	if refreshToken == "" {
		return nil
	}
	return s.db.DeleteUserSession(ctx, refreshToken)
}

// ── helpers ───────────────────────────────────────────────────────────────────

func toUserResult(u schema.User) *UserResult {
	status := "active"
	if !u.OnboardingCompleted {
		status = "needs_onboarding"
	}
	return &UserResult{
		UserID:              u.ID.String(),
		Status:              status,
		OnboardingCompleted: u.OnboardingCompleted,
		State:               u.State,
		Nation:              u.Nation,
	}
}

// validateUserOnboarding returns an error if required fields are missing.
func validateUserOnboarding(in UserOnboardingInput) error {
	if strings.TrimSpace(in.Name) == "" {
		return fmt.Errorf("%w: name is required", ErrImportantFieldMissing)
	}
	return nil
}
