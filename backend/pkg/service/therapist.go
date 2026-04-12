package service

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"errors"
	"fmt"
	"strconv"
	"strings"
	"therapist/pkg/auth"
	"therapist/pkg/repo/db"
	schema "therapist/pkg/repo/db/schema/gen"
	"therapist/pkg/storage"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// AuthResult is what every auth/status call returns to the handler.
type AuthResult struct {
	TherapistID         string
	Status              string // "needs_onboarding" | "pending" | "verified" | "rejected"
	OnboardingCompleted bool
	ReferralID          string
	RejectionReason     string
}

// OnboardingInput is the handler-facing input type for CompleteOnboarding.
// Plain Go types; the DB layer handles pgtype conversion.
type OnboardingInput struct {
	FullName           string
	Gender             string
	Bio                string
	ProfilePhoto       string
	PhoneNumber        string
	LanguagesSpoken    []string
	Specializations    []string
	YearsOfExperience  int32
	SessionFee         string // decimal string e.g. "1500.00"
	SessionTypes       []string
	DegreeCertificate  string
	RegistrationNumber string
	IssuingBody        string
	GovernmentID       string

	// Address — required when session_types contains "in_person"
	AddressText string
	Latitude    float64
	Longitude   float64
	PlaceID     string
	AddressState  string
	AddressNation string
}

// HandleAuthCallback is called after Supabase authenticates the therapist.
// Upserts the therapist record and returns their current state.
//
// Dev bypass: if IsProdEnv=false, tokens prefixed with "dev:" are accepted
// without JWT verification. The email is taken from the token itself, e.g.
// "dev:jane@example.com". Never accepted in production.
func (s *Service) HandleAuthCallback(ctx context.Context, supabaseToken string) (*AuthResult, TokenPair, error) {
	s.log.Debug("auth callback started")

	// ── Dev bypass ───────────────────────────────────────────────────────────
	if !s.cfg.IsProdEnv && strings.HasPrefix(supabaseToken, "dev:") {
		email := strings.TrimPrefix(supabaseToken, "dev:")
		if email == "" {
			return nil, TokenPair{}, ErrBadInput
		}
		s.log.Warn("dev auth bypass used — NOT safe for production", zap.String("email", email))
		t, err := s.db.CreateTherapist(ctx, "dev:"+email, email)
		if err != nil {
			s.log.Error("dev auth: failed to upsert therapist", zap.Error(err))
			return nil, TokenPair{}, fmt.Errorf("%w: %v", ErrDBQuery, err)
		}
		pair, err := s.IssueTokens(ctx, t.ID)
		if err != nil {
			return nil, TokenPair{}, err
		}
		return toAuthResult(t), pair, nil
	}

	claims, err := auth.VerifySupabaseToken(supabaseToken, s.cfg.SupabaseJWTSecret)
	if err != nil {
		s.log.Warn("invalid supabase token", zap.Error(err))
		return nil, TokenPair{}, ErrInvalidToken
	}

	s.log.Debug("token verified", zap.String("supabase_uid", claims.Sub))

	t, err := s.db.CreateTherapist(ctx, claims.Sub, claims.Email)
	if err != nil {
		s.log.Error("failed to upsert therapist", zap.String("supabase_uid", claims.Sub), zap.Error(err))
		return nil, TokenPair{}, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	pair, err := s.IssueTokens(ctx, t.ID)
	if err != nil {
		return nil, TokenPair{}, err
	}

	result := toAuthResult(t)
	s.log.Info("auth callback completed",
		zap.String("therapist_id", result.TherapistID),
		zap.String("status", result.Status),
	)
	return result, pair, nil
}

// GetTherapistStatus returns the current state for an authenticated therapist.
func (s *Service) GetTherapistStatus(ctx context.Context, supabaseToken string) (*AuthResult, error) {
	s.log.Debug("get status started")

	claims, err := auth.VerifySupabaseToken(supabaseToken, s.cfg.SupabaseJWTSecret)
	if err != nil {
		s.log.Warn("invalid token on status check", zap.Error(err))
		return nil, ErrInvalidToken
	}

	t, err := s.db.GetTherapistBySupabaseUID(ctx, claims.Sub)
	if err != nil {
		s.log.Warn("therapist not found", zap.String("supabase_uid", claims.Sub), zap.Error(err))
		return nil, ErrDBRecordNotFound
	}

	result := toAuthResult(t)
	s.log.Debug("status fetched",
		zap.String("therapist_id", result.TherapistID),
		zap.String("status", result.Status),
	)
	return result, nil
}

// CompleteOnboarding saves the full onboarding form.
func (s *Service) CompleteOnboarding(ctx context.Context, therapistID string, in OnboardingInput) error {
	s.log.Debug("complete onboarding started",
		zap.String("therapist_id", therapistID),
		zap.String("full_name", in.FullName),
		zap.Strings("languages", in.LanguagesSpoken),
		zap.Strings("specializations", in.Specializations),
		zap.Strings("session_types", in.SessionTypes),
		zap.Int32("years_exp", in.YearsOfExperience),
		zap.String("session_fee", in.SessionFee),
		zap.String("degree_cert", in.DegreeCertificate),
		zap.String("reg_number", in.RegistrationNumber),
		zap.String("issuing_body", in.IssuingBody),
	)

	if err := validateOnboarding(in); err != nil {
		s.log.Warn("onboarding validation failed",
			zap.String("therapist_id", therapistID),
			zap.Error(err),
		)
		return err
	}

	id, err := parseUUID(therapistID)
	if err != nil {
		s.log.Warn("invalid therapist_id uuid", zap.String("therapist_id", therapistID))
		return ErrBadInput
	}

	hasInPerson := false
	sessionTypes := make([]schema.SessionTypeEnum, 0, len(in.SessionTypes))
	for _, st := range in.SessionTypes {
		switch schema.SessionTypeEnum(st) {
		case schema.SessionTypeEnumVideo, schema.SessionTypeEnumInPerson:
			sessionTypes = append(sessionTypes, schema.SessionTypeEnum(st))
			if schema.SessionTypeEnum(st) == schema.SessionTypeEnumInPerson {
				hasInPerson = true
			}
		default:
			s.log.Warn("invalid session type", zap.String("value", st))
			return ErrBadInput
		}
	}

	if hasInPerson && in.AddressText == "" {
		s.log.Warn("in_person selected but address_text missing",
			zap.String("therapist_id", therapistID))
		return fmt.Errorf("%w: address_text required for in_person sessions", ErrImportantFieldMissing)
	}

	if err := s.db.CompleteOnboarding(ctx, id, db.OnboardingParams{
		FullName:           in.FullName,
		Gender:             in.Gender,
		Bio:                in.Bio,
		ProfilePhoto:       in.ProfilePhoto,
		PhoneNumber:        in.PhoneNumber,
		LanguagesSpoken:    in.LanguagesSpoken,
		Specializations:    in.Specializations,
		YearsOfExperience:  in.YearsOfExperience,
		SessionFee:         in.SessionFee,
		SessionTypes:       sessionTypes,
		DegreeCertificate:  in.DegreeCertificate,
		RegistrationNumber: in.RegistrationNumber,
		IssuingBody:        in.IssuingBody,
		GovernmentID:       in.GovernmentID,
	}); err != nil {
		s.log.Error("failed to save onboarding data",
			zap.String("therapist_id", therapistID),
			zap.Error(err),
		)
		return err
	}

	// Upsert address when in_person is selected
	if hasInPerson {
		if err := s.db.UpsertTherapistAddress(ctx, id, db.AddressParams{
			AddressText: in.AddressText,
			Latitude:    in.Latitude,
			Longitude:   in.Longitude,
			PlaceID:     in.PlaceID,
			State:       in.AddressState,
			Nation:      in.AddressNation,
		}); err != nil {
			s.log.Error("failed to save therapist address",
				zap.String("therapist_id", therapistID),
				zap.Error(err),
			)
			return err
		}
	}

	s.log.Info("onboarding completed", zap.String("therapist_id", therapistID))
	return nil
}

// ApproveTherapist generates a unique referral ID and sets status=verified.
func (s *Service) ApproveTherapist(ctx context.Context, therapistID string) error {
	s.log.Debug("approve therapist started", zap.String("therapist_id", therapistID))

	id, err := parseUUID(therapistID)
	if err != nil {
		s.log.Warn("invalid therapist_id uuid on approval", zap.String("therapist_id", therapistID))
		return ErrBadInput
	}

	referralID, err := s.generateUniqueReferralID(ctx)
	if err != nil {
		s.log.Error("failed to generate referral id", zap.String("therapist_id", therapistID), zap.Error(err))
		return err
	}

	if err := s.db.ApproveTherapist(ctx, id, referralID); err != nil {
		s.log.Error("failed to approve therapist",
			zap.String("therapist_id", therapistID),
			zap.Error(err),
		)
		return err
	}

	s.log.Info("therapist approved",
		zap.String("therapist_id", therapistID),
		zap.String("referral_id", referralID),
	)
	return nil
}

// RejectTherapist sets status=rejected with an optional reason.
func (s *Service) RejectTherapist(ctx context.Context, therapistID, reason string) error {
	s.log.Debug("reject therapist started", zap.String("therapist_id", therapistID))

	id, err := parseUUID(therapistID)
	if err != nil {
		s.log.Warn("invalid therapist_id uuid on rejection", zap.String("therapist_id", therapistID))
		return ErrBadInput
	}

	if err := s.db.RejectTherapist(ctx, id, reason); err != nil {
		s.log.Error("failed to reject therapist",
			zap.String("therapist_id", therapistID),
			zap.Error(err),
		)
		return err
	}

	s.log.Info("therapist rejected",
		zap.String("therapist_id", therapistID),
		zap.String("reason", reason),
	)
	return nil
}

// UploadFile validates and stores a file, returning its URL.
// Accepts raw bytes; size is enforced here (max 3 MB).
func (s *Service) UploadFile(ctx context.Context, fileName, fileType string, data []byte) (string, error) {
	s.log.Debug("upload file started",
		zap.String("file_type", fileType),
		zap.String("file_name", fileName),
		zap.Int("bytes", len(data)),
	)

	if !storage.AllowedFileTypes[fileType] {
		s.log.Warn("invalid file type", zap.String("file_type", fileType))
		return "", ErrFileTypeInvalid
	}
	if len(data) == 0 {
		s.log.Warn("empty file upload attempt")
		return "", ErrBadInput
	}
	if len(data) > storage.MaxFileSize {
		s.log.Warn("file too large",
			zap.Int("bytes", len(data)),
			zap.Int("max", storage.MaxFileSize),
		)
		return "", ErrFileTooLarge
	}

	url, err := s.storage.Upload(ctx, fileName, fileType, data)
	if err != nil {
		if errors.Is(err, storage.ErrFileTooLarge) {
			return "", ErrFileTooLarge
		}
		s.log.Error("storage upload failed", zap.Error(err))
		return "", ErrUnexpected
	}

	s.log.Info("file uploaded successfully",
		zap.String("file_type", fileType),
		zap.String("url", url),
	)
	return url, nil
}

// --- internal helpers ---

func toAuthResult(t schema.Therapist) *AuthResult {
	r := &AuthResult{
		TherapistID:         t.ID.String(),
		OnboardingCompleted: t.OnboardingCompleted,
		Status:              string(t.Status),
	}
	if !t.OnboardingCompleted {
		r.Status = "needs_onboarding"
	}
	if t.ReferralID.Valid {
		r.ReferralID = t.ReferralID.String
	}
	if t.RejectionReason.Valid {
		r.RejectionReason = t.RejectionReason.String
	}
	return r
}

func validateOnboarding(in OnboardingInput) error {
	// ── Required string fields ────────────────────────────────────────────────
	type req struct {
		name  string
		value string
		max   int
	}
	required := []req{
		{"full_name", strings.TrimSpace(in.FullName), 100},
		{"session_fee", strings.TrimSpace(in.SessionFee), 20},
		{"degree_certificate", strings.TrimSpace(in.DegreeCertificate), 2048},
		{"registration_number", strings.TrimSpace(in.RegistrationNumber), 100},
		{"issuing_body", strings.TrimSpace(in.IssuingBody), 200},
	}
	for _, f := range required {
		if f.value == "" {
			return fmt.Errorf("%w: %s is required", ErrImportantFieldMissing, f.name)
		}
		if len(f.value) > f.max {
			return fmt.Errorf("%w: %s exceeds %d characters", ErrInvalidFormat, f.name, f.max)
		}
	}

	// ── full_name: at least 2 characters ─────────────────────────────────────
	if len(strings.TrimSpace(in.FullName)) < 2 {
		return fmt.Errorf("%w: full_name must be at least 2 characters", ErrInvalidFormat)
	}

	// ── session_fee: must be a positive decimal ───────────────────────────────
	fee, err := strconv.ParseFloat(strings.TrimSpace(in.SessionFee), 64)
	if err != nil {
		return fmt.Errorf("%w: session_fee must be a valid number", ErrInvalidFormat)
	}
	if fee < 0 {
		return fmt.Errorf("%w: session_fee must be >= 0", ErrInvalidFormat)
	}
	if fee > 1_000_000 {
		return fmt.Errorf("%w: session_fee exceeds maximum allowed value", ErrInvalidFormat)
	}

	// ── years_of_experience ───────────────────────────────────────────────────
	if in.YearsOfExperience < 0 {
		return fmt.Errorf("%w: years_of_experience must be >= 0", ErrInvalidFormat)
	}
	if in.YearsOfExperience > 70 {
		return fmt.Errorf("%w: years_of_experience exceeds maximum allowed value", ErrInvalidFormat)
	}

	// ── Required lists ────────────────────────────────────────────────────────
	if len(in.LanguagesSpoken) == 0 {
		return fmt.Errorf("%w: languages_spoken is required", ErrImportantFieldMissing)
	}
	if len(in.LanguagesSpoken) > 20 {
		return fmt.Errorf("%w: languages_spoken exceeds 20 entries", ErrInvalidFormat)
	}
	if len(in.Specializations) == 0 {
		return fmt.Errorf("%w: specializations is required", ErrImportantFieldMissing)
	}
	if len(in.Specializations) > 20 {
		return fmt.Errorf("%w: specializations exceeds 20 entries", ErrInvalidFormat)
	}
	if len(in.SessionTypes) == 0 {
		return fmt.Errorf("%w: session_types is required", ErrImportantFieldMissing)
	}

	// ── Optional fields: length caps ─────────────────────────────────────────
	if len(strings.TrimSpace(in.Gender)) > 50 {
		return fmt.Errorf("%w: gender exceeds 50 characters", ErrInvalidFormat)
	}
	if len(strings.TrimSpace(in.Bio)) > 2000 {
		return fmt.Errorf("%w: bio exceeds 2000 characters", ErrInvalidFormat)
	}
	if len(strings.TrimSpace(in.PhoneNumber)) > 20 {
		return fmt.Errorf("%w: phone_number exceeds 20 characters", ErrInvalidFormat)
	}

	return nil
}

func (s *Service) generateUniqueReferralID(ctx context.Context) (string, error) {
	for i := 0; i < 10; i++ {
		b := make([]byte, 6)
		if _, err := rand.Read(b); err != nil {
			return "", ErrUnexpected
		}
		id := hex.EncodeToString(b)
		taken, err := s.db.IsReferralIDTaken(ctx, id)
		if err != nil {
			return "", ErrDBQuery
		}
		if !taken {
			return id, nil
		}
		s.log.Warn("referral id collision, retrying", zap.Int("attempt", i+1))
	}
	s.log.Error("exhausted referral id generation attempts")
	return "", ErrUnexpected
}

func parseUUID(s string) (pgtype.UUID, error) {
	var id pgtype.UUID
	return id, id.Scan(s)
}
