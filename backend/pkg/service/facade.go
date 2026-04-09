package service

import (
	"context"
	"therapist/pkg/repo/db"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
)

// dbHelper is the interface the service depends on.
type dbHelper interface {
	CreateTherapist(ctx context.Context, supabaseUID, email string) (schema.Therapist, error)
	GetTherapistBySupabaseUID(ctx context.Context, uid string) (schema.Therapist, error)
	GetTherapistByID(ctx context.Context, id pgtype.UUID) (schema.Therapist, error)
	CompleteOnboarding(ctx context.Context, id pgtype.UUID, params db.OnboardingParams) error
	ApproveTherapist(ctx context.Context, id pgtype.UUID, referralID string) error
	RejectTherapist(ctx context.Context, id pgtype.UUID, reason string) error
	IsReferralIDTaken(ctx context.Context, referralID string) (bool, error)
}

// storageHelper abstracts the file-storage backend (S3 stub for now).
type storageHelper interface {
	Upload(ctx context.Context, fileName, fileType string, data []byte) (string, error)
}

type cacheHelper interface{}
