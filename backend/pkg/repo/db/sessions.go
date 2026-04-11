package db

import (
	"context"
	"time"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

func (d *DB) CreateSession(ctx context.Context, therapistID pgtype.UUID, refreshToken string, expiresAt time.Time) (schema.TherapistSessionRow, error) {
	d.log.Debug("CreateSession", zap.String("therapist_id", therapistID.String()))

	s, err := d.query.CreateSession(ctx, schema.CreateSessionParams{
		TherapistID:  therapistID,
		RefreshToken: refreshToken,
		ExpiresAt:    expiresAt,
	})
	if err != nil {
		d.log.Error("CreateSession failed", zap.String("therapist_id", therapistID.String()), zap.Error(err))
	}
	return s, err
}

func (d *DB) GetSessionByRefreshToken(ctx context.Context, refreshToken string) (schema.TherapistSessionRow, error) {
	s, err := d.query.GetSessionByRefreshToken(ctx, refreshToken)
	if err != nil {
		d.log.Warn("GetSessionByRefreshToken not found", zap.Error(err))
	}
	return s, err
}

func (d *DB) DeleteSession(ctx context.Context, refreshToken string) error {
	err := d.query.DeleteSession(ctx, refreshToken)
	if err != nil {
		d.log.Error("DeleteSession failed", zap.Error(err))
	}
	return err
}

func (d *DB) DeleteAllSessionsForTherapist(ctx context.Context, therapistID pgtype.UUID) error {
	err := d.query.DeleteAllSessionsForTherapist(ctx, therapistID)
	if err != nil {
		d.log.Error("DeleteAllSessionsForTherapist failed",
			zap.String("therapist_id", therapistID.String()), zap.Error(err))
	}
	return err
}
