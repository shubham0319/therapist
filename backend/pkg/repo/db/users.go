package db

import (
	"context"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// UserOnboardingParams is the application-facing input for completing user onboarding.
type UserOnboardingParams struct {
	Name       string
	Phone      string
	State      string
	Nation     string
	LookingFor []string
}

func (d *DB) UpsertUser(ctx context.Context, supabaseUID, email string) (schema.User, error) {
	d.log.Debug("UpsertUser", zap.String("supabase_uid", supabaseUID), zap.String("email", email))

	u, err := d.query.UpsertUser(ctx, supabaseUID, email)
	if err != nil {
		d.log.Error("UpsertUser failed", zap.String("supabase_uid", supabaseUID), zap.Error(err))
	}
	return u, err
}

func (d *DB) GetUserBySupabaseUID(ctx context.Context, uid string) (schema.User, error) {
	d.log.Debug("GetUserBySupabaseUID", zap.String("supabase_uid", uid))

	u, err := d.query.GetUserBySupabaseUID(ctx, uid)
	if err != nil {
		d.log.Warn("GetUserBySupabaseUID not found", zap.String("supabase_uid", uid), zap.Error(err))
	}
	return u, err
}

func (d *DB) GetUserByID(ctx context.Context, id pgtype.UUID) (schema.User, error) {
	d.log.Debug("GetUserByID", zap.String("id", id.String()))

	u, err := d.query.GetUserByID(ctx, id)
	if err != nil {
		d.log.Warn("GetUserByID not found", zap.String("id", id.String()), zap.Error(err))
	}
	return u, err
}

func (d *DB) CompleteUserOnboarding(ctx context.Context, id pgtype.UUID, p UserOnboardingParams) error {
	d.log.Debug("CompleteUserOnboarding", zap.String("user_id", id.String()))

	err := d.query.CompleteUserOnboarding(ctx, schema.CompleteUserOnboardingParams{
		ID:         id,
		Name:       p.Name,
		Phone:      p.Phone,
		State:      p.State,
		Nation:     p.Nation,
		LookingFor: p.LookingFor,
	})
	if err != nil {
		d.log.Error("CompleteUserOnboarding failed",
			zap.String("user_id", id.String()),
			zap.Error(err),
		)
	}
	return err
}
