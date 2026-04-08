package db

import (
	"context"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// OnboardingParams is the input type for CompleteOnboarding.
// The DB layer converts plain Go types into the pgtype values sqlc expects.
type OnboardingParams struct {
	FullName           string
	Gender             string // empty = NULL
	Bio                string
	ProfilePhoto       string
	PhoneNumber        string
	LanguagesSpoken    []string
	Specializations    []string
	YearsOfExperience  int32
	SessionFee         string // decimal string e.g. "1500.00"
	SessionTypes       []schema.SessionTypeEnum
	DegreeCertificate  string
	RegistrationNumber string
	IssuingBody        string
	GovernmentID       string // empty = NULL
}

func (d *DB) CreateTherapist(ctx context.Context, supabaseUID, email string) (schema.Therapist, error) {
	d.log.Debug("CreateTherapist", zap.String("supabase_uid", supabaseUID), zap.String("email", email))

	t, err := d.query.CreateTherapist(ctx, schema.CreateTherapistParams{
		SupabaseUid: supabaseUID,
		Email:       email,
	})
	if err != nil {
		d.log.Error("CreateTherapist failed", zap.String("supabase_uid", supabaseUID), zap.Error(err))
	}
	return t, err
}

func (d *DB) GetTherapistBySupabaseUID(ctx context.Context, uid string) (schema.Therapist, error) {
	d.log.Debug("GetTherapistBySupabaseUID", zap.String("supabase_uid", uid))

	t, err := d.query.GetTherapistBySupabaseUID(ctx, uid)
	if err != nil {
		d.log.Warn("GetTherapistBySupabaseUID not found", zap.String("supabase_uid", uid), zap.Error(err))
	}
	return t, err
}

func (d *DB) GetTherapistByID(ctx context.Context, id pgtype.UUID) (schema.Therapist, error) {
	d.log.Debug("GetTherapistByID", zap.String("id", id.String()))

	t, err := d.query.GetTherapistByID(ctx, id)
	if err != nil {
		d.log.Warn("GetTherapistByID not found", zap.String("id", id.String()), zap.Error(err))
	}
	return t, err
}

func (d *DB) CompleteOnboarding(ctx context.Context, id pgtype.UUID, p OnboardingParams) error {
	d.log.Debug("CompleteOnboarding", zap.String("therapist_id", id.String()))

	fee := pgtype.Numeric{}
	_ = fee.Scan(p.SessionFee)

	err := d.query.CompleteOnboarding(ctx, schema.CompleteOnboardingParams{
		ID:                 id,
		FullName:           p.FullName,
		Gender:             nullGender(p.Gender),
		Bio:                nullText(p.Bio),
		ProfilePhoto:       nullText(p.ProfilePhoto),
		PhoneNumber:        nullText(p.PhoneNumber),
		LanguagesSpoken:    p.LanguagesSpoken,
		Specializations:    p.Specializations,
		YearsOfExperience:  pgtype.Int4{Int32: p.YearsOfExperience, Valid: true},
		SessionFee:         fee,
		Column11:           p.SessionTypes,
		DegreeCertificate:  nullText(p.DegreeCertificate),
		RegistrationNumber: nullText(p.RegistrationNumber),
		IssuingBody:        nullText(p.IssuingBody),
		GovernmentID:       nullText(p.GovernmentID),
	})
	if err != nil {
		d.log.Error("CompleteOnboarding failed", zap.String("therapist_id", id.String()), zap.Error(err))
	}
	return err
}

func (d *DB) ApproveTherapist(ctx context.Context, id pgtype.UUID, referralID string) error {
	d.log.Debug("ApproveTherapist", zap.String("therapist_id", id.String()))

	err := d.query.ApproveTherapist(ctx, schema.ApproveTherapistParams{
		ID:         id,
		ReferralID: pgtype.Text{String: referralID, Valid: true},
	})
	if err != nil {
		d.log.Error("ApproveTherapist failed", zap.String("therapist_id", id.String()), zap.Error(err))
	}
	return err
}

func (d *DB) RejectTherapist(ctx context.Context, id pgtype.UUID, reason string) error {
	d.log.Debug("RejectTherapist", zap.String("therapist_id", id.String()))

	err := d.query.RejectTherapist(ctx, schema.RejectTherapistParams{
		ID:              id,
		RejectionReason: nullText(reason),
	})
	if err != nil {
		d.log.Error("RejectTherapist failed", zap.String("therapist_id", id.String()), zap.Error(err))
	}
	return err
}

func (d *DB) IsReferralIDTaken(ctx context.Context, referralID string) (bool, error) {
	d.log.Debug("IsReferralIDTaken", zap.String("referral_id", referralID))

	taken, err := d.query.IsReferralIDTaken(ctx, pgtype.Text{String: referralID, Valid: true})
	if err != nil {
		d.log.Error("IsReferralIDTaken failed", zap.String("referral_id", referralID), zap.Error(err))
	}
	return taken, err
}

// --- helpers ---

func nullText(s string) pgtype.Text {
	if s == "" {
		return pgtype.Text{}
	}
	return pgtype.Text{String: s, Valid: true}
}

func nullGender(s string) schema.NullGenderEnum {
	if s == "" {
		return schema.NullGenderEnum{}
	}
	return schema.NullGenderEnum{GenderEnum: schema.GenderEnum(s), Valid: true}
}
