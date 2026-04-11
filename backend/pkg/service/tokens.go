package service

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"errors"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// TokenPair holds the issued access + refresh tokens.
type TokenPair struct {
	AccessToken  string
	RefreshToken string
	ExpiresAt    int64 // Unix timestamp — when the access token expires
}

// IssueTokens generates a signed JWT access token and a random refresh token,
// persists the refresh token in the DB and returns the pair.
func (s *Service) IssueTokens(ctx context.Context, therapistID pgtype.UUID) (TokenPair, error) {
	// ── Access token (JWT) ────────────────────────────────────────────────────
	accessTTL := time.Duration(s.cfg.AccessTokenTTLMinutes) * time.Minute
	expiresAt := time.Now().Add(accessTTL)

	claims := jwt.MapClaims{
		"sub": therapistID.String(),
		"iat": time.Now().Unix(),
		"exp": expiresAt.Unix(),
		"typ": "access",
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	accessToken, err := token.SignedString([]byte(s.cfg.JWTSecret))
	if err != nil {
		s.log.Error("failed to sign access token", zap.Error(err))
		return TokenPair{}, ErrUnexpected
	}

	// ── Refresh token (random hex) ────────────────────────────────────────────
	raw := make([]byte, 32)
	if _, err := rand.Read(raw); err != nil {
		return TokenPair{}, ErrUnexpected
	}
	refreshToken := hex.EncodeToString(raw)
	refreshExpiry := time.Now().Add(time.Duration(s.cfg.RefreshTokenTTLDays) * 24 * time.Hour)

	if _, err := s.db.CreateSession(ctx, therapistID, refreshToken, refreshExpiry); err != nil {
		return TokenPair{}, ErrDBQuery
	}

	return TokenPair{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
		ExpiresAt:    expiresAt.Unix(),
	}, nil
}

// ValidateAccessToken parses and validates a JWT access token,
// returning the therapist ID embedded in the claims.
func (s *Service) ValidateAccessToken(tokenStr string) (string, error) {
	token, err := jwt.Parse(tokenStr, func(t *jwt.Token) (any, error) {
		if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, ErrInvalidToken
		}
		return []byte(s.cfg.JWTSecret), nil
	}, jwt.WithValidMethods([]string{"HS256"}))

	if err != nil {
		if errors.Is(err, jwt.ErrTokenExpired) {
			return "", ErrTokenExpired
		}
		return "", ErrInvalidToken
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		return "", ErrInvalidToken
	}
	sub, ok := claims["sub"].(string)
	if !ok || sub == "" {
		return "", ErrInvalidToken
	}
	return sub, nil
}

// RefreshSession validates a refresh token, rotates it (issues a new pair),
// and deletes the old one.
func (s *Service) RefreshSession(ctx context.Context, refreshToken string) (*AuthResult, TokenPair, error) {
	if refreshToken == "" {
		return nil, TokenPair{}, ErrInvalidToken
	}

	// Load session row
	row, err := s.db.GetSessionByRefreshToken(ctx, refreshToken)
	if err != nil {
		return nil, TokenPair{}, ErrInvalidToken
	}

	// Check expiry
	if row.ExpiresAt.Time.Before(time.Now()) {
		// Clean up expired token
		_ = s.db.DeleteSession(ctx, refreshToken)
		return nil, TokenPair{}, ErrTokenExpired
	}

	// Load therapist
	therapist, err := s.db.GetTherapistByID(ctx, row.TherapistID)
	if err != nil {
		return nil, TokenPair{}, ErrDBQuery
	}

	// Rotate: delete old refresh token before issuing new pair
	if err := s.db.DeleteSession(ctx, refreshToken); err != nil {
		return nil, TokenPair{}, ErrDBQuery
	}

	pair, err := s.IssueTokens(ctx, therapist.ID)
	if err != nil {
		return nil, TokenPair{}, err
	}

	return toAuthResult(therapist), pair, nil
}

// Logout invalidates the given refresh token.
func (s *Service) Logout(ctx context.Context, refreshToken string) error {
	if refreshToken == "" {
		return nil // idempotent
	}
	return s.db.DeleteSession(ctx, refreshToken)
}

// LogoutAll invalidates all sessions for a therapist (e.g. on password change).
func (s *Service) LogoutAll(ctx context.Context, therapistID pgtype.UUID) error {
	return s.db.DeleteAllSessionsForTherapist(ctx, therapistID)
}
