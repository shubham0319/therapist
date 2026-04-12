package schema

import (
	"context"
	"time"

	"github.com/jackc/pgx/v5/pgtype"
)

const createUserSession = `-- name: CreateUserSession :one
INSERT INTO user_sessions (user_id, refresh_token, expires_at)
VALUES ($1, $2, $3)
RETURNING id, user_id, refresh_token, expires_at, created_at
`

type CreateUserSessionParams struct {
	UserID       pgtype.UUID
	RefreshToken string
	ExpiresAt    time.Time
}

func (q *Queries) CreateUserSession(ctx context.Context, arg CreateUserSessionParams) (UserSessionRow, error) {
	row := q.db.QueryRow(ctx, createUserSession, arg.UserID, arg.RefreshToken, arg.ExpiresAt)
	var s UserSessionRow
	err := row.Scan(&s.ID, &s.UserID, &s.RefreshToken, &s.ExpiresAt, &s.CreatedAt)
	return s, err
}

const getUserSessionByRefreshToken = `-- name: GetUserSessionByRefreshToken :one
SELECT id, user_id, refresh_token, expires_at, created_at
FROM user_sessions WHERE refresh_token = $1
`

func (q *Queries) GetUserSessionByRefreshToken(ctx context.Context, refreshToken string) (UserSessionRow, error) {
	row := q.db.QueryRow(ctx, getUserSessionByRefreshToken, refreshToken)
	var s UserSessionRow
	err := row.Scan(&s.ID, &s.UserID, &s.RefreshToken, &s.ExpiresAt, &s.CreatedAt)
	return s, err
}

const deleteUserSession = `-- name: DeleteUserSession :exec
DELETE FROM user_sessions WHERE refresh_token = $1
`

func (q *Queries) DeleteUserSession(ctx context.Context, refreshToken string) error {
	_, err := q.db.Exec(ctx, deleteUserSession, refreshToken)
	return err
}

const deleteAllUserSessions = `-- name: DeleteAllUserSessions :exec
DELETE FROM user_sessions WHERE user_id = $1
`

func (q *Queries) DeleteAllUserSessions(ctx context.Context, userID pgtype.UUID) error {
	_, err := q.db.Exec(ctx, deleteAllUserSessions, userID)
	return err
}

const deleteExpiredUserSessions = `-- name: DeleteExpiredUserSessions :exec
DELETE FROM user_sessions WHERE expires_at < NOW()
`

func (q *Queries) DeleteExpiredUserSessions(ctx context.Context) error {
	_, err := q.db.Exec(ctx, deleteExpiredUserSessions)
	return err
}
