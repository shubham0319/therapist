package db

import (
	"context"
	"time"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

func (d *DB) CreateUserSession(ctx context.Context, userID pgtype.UUID, refreshToken string, expiresAt time.Time) (schema.UserSessionRow, error) {
	d.log.Debug("CreateUserSession", zap.String("user_id", userID.String()))

	s, err := d.query.CreateUserSession(ctx, schema.CreateUserSessionParams{
		UserID:       userID,
		RefreshToken: refreshToken,
		ExpiresAt:    expiresAt,
	})
	if err != nil {
		d.log.Error("CreateUserSession failed", zap.String("user_id", userID.String()), zap.Error(err))
	}
	return s, err
}

func (d *DB) GetUserSessionByRefreshToken(ctx context.Context, refreshToken string) (schema.UserSessionRow, error) {
	s, err := d.query.GetUserSessionByRefreshToken(ctx, refreshToken)
	if err != nil {
		d.log.Warn("GetUserSessionByRefreshToken not found", zap.Error(err))
	}
	return s, err
}

func (d *DB) DeleteUserSession(ctx context.Context, refreshToken string) error {
	err := d.query.DeleteUserSession(ctx, refreshToken)
	if err != nil {
		d.log.Error("DeleteUserSession failed", zap.Error(err))
	}
	return err
}

func (d *DB) DeleteAllUserSessions(ctx context.Context, userID pgtype.UUID) error {
	err := d.query.DeleteAllUserSessions(ctx, userID)
	if err != nil {
		d.log.Error("DeleteAllUserSessions failed",
			zap.String("user_id", userID.String()), zap.Error(err))
	}
	return err
}
