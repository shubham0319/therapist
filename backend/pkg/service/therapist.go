package service

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"errors"
	"fmt"
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
}

// HandleAuthCallback is called after Supabase authenticates the therapist.
// Upserts the therapist record and returns their current state.
//
// Dev bypass: if IsProdEnv=false, tokens prefixed with "dev:" are accepted
// without JWT verification. The email is taken from the token itself, e.g.
// "dev:jane@example.com". Never accepted in production.
func (s *Service) HandleAuthCallback(ctx context.Context, supabaseToken string) (*AuthResult, error) {
	s.log.Debug("auth callback started")

	// ── Dev bypass ───────────────────────────────────────────────────────────
	if !s.cfg.IsProdEnv && strings.HasPrefix(supabaseToken, "dev:") {
		email := strings.TrimPrefix(supabaseToken, "dev:")
		if email == "" {
			return nil, ErrBadInput
		}
		s.log.Warn("dev auth bypass used — NOT safe for production", zap.String("email", email))
		t, err := s.db.CreateTherapist(ctx, "dev:"+email, email)
		if err != nil {
			s.log.Error("dev auth: failed to upsert therapist", zap.Error(err))
			return nil, fmt.Errorf("%w: %v", ErrDBQuery, err)
		}
		return toAuthResult(t), nil
	}

	claims, err := auth.VerifySupabaseToken(supabaseToken, s.cfg.SupabaseJWTSecret)
	if err != nil {
		s.log.Warn("invalid supabase token", zap.Error(err))
		return nil, ErrInvalidToken
	}

	s.log.Debug("token verified", zap.String("supabase_uid", claims.Sub))

	t, err := s.db.CreateTherapist(ctx, claims.Sub, claims.Email)
	if err != nil {
		s.log.Error("failed to upsert therapist", zap.String("supabase_uid", claims.Sub), zap.Error(err))
		return nil, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	result := toAuthResult(t)
	s.log.Info("auth callback completed",
		zap.String("therapist_id", result.TherapistID),
		zap.String("status", result.Status),
	)
	return result, nil
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

	sessionTypes := make([]schema.SessionTypeEnum, 0, len(in.SessionTypes))
	for _, st := range in.SessionTypes {
		switch schema.SessionTypeEnum(st) {
		case schema.SessionTypeEnumChat, schema.SessionTypeEnumAudio, schema.SessionTypeEnumVideo:
			sessionTypes = append(sessionTypes, schema.SessionTypeEnum(st))
		default:
			s.log.Warn("invalid session type", zap.String("value", st))
			return ErrBadInput
		}
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
	switch {
	case in.FullName == "":
		return fmt.Errorf("%w: full_name", ErrImportantFieldMissing)
	case len(in.LanguagesSpoken) == 0:
		return fmt.Errorf("%w: languages_spoken", ErrImportantFieldMissing)
	case len(in.Specializations) == 0:
		return fmt.Errorf("%w: specializations", ErrImportantFieldMissing)
	case len(in.SessionTypes) == 0:
		return fmt.Errorf("%w: session_types", ErrImportantFieldMissing)
	case in.YearsOfExperience < 0:
		return fmt.Errorf("%w: years_of_experience must be >= 0", ErrImportantFieldMissing)
	case in.SessionFee == "":
		return fmt.Errorf("%w: session_fee", ErrImportantFieldMissing)
	case in.DegreeCertificate == "":
		return fmt.Errorf("%w: degree_certificate", ErrImportantFieldMissing)
	case in.RegistrationNumber == "":
		return fmt.Errorf("%w: registration_number", ErrImportantFieldMissing)
	case in.IssuingBody == "":
		return fmt.Errorf("%w: issuing_body", ErrImportantFieldMissing)
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
