package schema

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const upsertUser = `-- name: UpsertUser :one
INSERT INTO users (supabase_uid, email)
VALUES ($1, $2)
ON CONFLICT (supabase_uid) DO UPDATE SET
    email      = EXCLUDED.email,
    updated_at = NOW()
RETURNING id, supabase_uid, email, name, phone, state, nation, looking_for, onboarding_completed, created_at, updated_at
`

func (q *Queries) UpsertUser(ctx context.Context, supabaseUID, email string) (User, error) {
	row := q.db.QueryRow(ctx, upsertUser, supabaseUID, email)
	return scanUser(row)
}

const getUserBySupabaseUID = `-- name: GetUserBySupabaseUID :one
SELECT id, supabase_uid, email, name, phone, state, nation, looking_for, onboarding_completed, created_at, updated_at
FROM users WHERE supabase_uid = $1
`

func (q *Queries) GetUserBySupabaseUID(ctx context.Context, uid string) (User, error) {
	row := q.db.QueryRow(ctx, getUserBySupabaseUID, uid)
	return scanUser(row)
}

const getUserByID = `-- name: GetUserByID :one
SELECT id, supabase_uid, email, name, phone, state, nation, looking_for, onboarding_completed, created_at, updated_at
FROM users WHERE id = $1
`

func (q *Queries) GetUserByID(ctx context.Context, id pgtype.UUID) (User, error) {
	row := q.db.QueryRow(ctx, getUserByID, id)
	return scanUser(row)
}

// CompleteUserOnboardingParams holds the fields set during user onboarding.
type CompleteUserOnboardingParams struct {
	ID         pgtype.UUID
	Name       string
	Phone      string
	State      string
	Nation     string
	LookingFor []string
}

const completeUserOnboarding = `-- name: CompleteUserOnboarding :exec
UPDATE users SET
    name                 = $2,
    phone                = $3,
    state                = $4,
    nation               = $5,
    looking_for          = $6,
    onboarding_completed = TRUE,
    updated_at           = NOW()
WHERE id = $1
`

func (q *Queries) CompleteUserOnboarding(ctx context.Context, arg CompleteUserOnboardingParams) error {
	lookingFor := arg.LookingFor
	if lookingFor == nil {
		lookingFor = []string{}
	}
	_, err := q.db.Exec(ctx, completeUserOnboarding,
		arg.ID,
		arg.Name,
		arg.Phone,
		arg.State,
		arg.Nation,
		lookingFor,
	)
	return err
}

// scanUser is a shared row scanner for all User queries.
func scanUser(row interface {
	Scan(...any) error
}) (User, error) {
	var u User
	err := row.Scan(
		&u.ID,
		&u.SupabaseUid,
		&u.Email,
		&u.Name,
		&u.Phone,
		&u.State,
		&u.Nation,
		&u.LookingFor,
		&u.OnboardingCompleted,
		&u.CreatedAt,
		&u.UpdatedAt,
	)
	if u.LookingFor == nil {
		u.LookingFor = []string{}
	}
	return u, err
}
