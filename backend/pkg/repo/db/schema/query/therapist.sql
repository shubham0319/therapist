-- name: CreateTherapist :one
-- Called on every login. ON CONFLICT makes it idempotent.
INSERT INTO therapists (supabase_uid, email)
VALUES ($1, $2)
ON CONFLICT (supabase_uid) DO UPDATE SET email = EXCLUDED.email
RETURNING *;

-- name: GetTherapistBySupabaseUID :one
SELECT * FROM therapists WHERE supabase_uid = $1;

-- name: GetTherapistByID :one
SELECT * FROM therapists WHERE id = $1;

-- name: CompleteOnboarding :exec
UPDATE therapists SET
    full_name            = $2,
    gender               = $3,
    bio                  = $4,
    profile_photo        = $5,
    phone_number         = $6,
    languages_spoken     = $7,
    specializations      = $8,
    years_of_experience  = $9,
    session_fee          = $10,
    session_types        = $11::session_type_enum[],
    degree_certificate   = $12,
    registration_number  = $13,
    issuing_body         = $14,
    government_id        = $15,
    onboarding_completed = TRUE
WHERE id = $1;

-- name: ApproveTherapist :exec
UPDATE therapists
SET status          = 'verified',
    verified_at     = NOW(),
    referral_id     = $2,
    rejection_reason = NULL
WHERE id = $1;

-- name: RejectTherapist :exec
UPDATE therapists
SET status           = 'rejected',
    rejection_reason = $2
WHERE id = $1;

-- name: IsReferralIDTaken :one
SELECT EXISTS(SELECT 1 FROM therapists WHERE referral_id = $1) AS taken;
