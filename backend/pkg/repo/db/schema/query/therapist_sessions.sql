-- name: CreateSession :one
INSERT INTO therapist_sessions (therapist_id, refresh_token, expires_at)
VALUES ($1, $2, $3)
RETURNING *;

-- name: GetSessionByRefreshToken :one
SELECT * FROM therapist_sessions WHERE refresh_token = $1;

-- name: DeleteSession :exec
DELETE FROM therapist_sessions WHERE refresh_token = $1;

-- name: DeleteAllSessionsForTherapist :exec
DELETE FROM therapist_sessions WHERE therapist_id = $1;

-- name: DeleteExpiredSessions :exec
DELETE FROM therapist_sessions WHERE expires_at < NOW();