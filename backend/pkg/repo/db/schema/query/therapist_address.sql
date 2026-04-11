-- name: UpsertTherapistAddress :exec
INSERT INTO therapist_addresses (therapist_id, address_text, latitude, longitude, place_id)
VALUES ($1, $2, $3, $4, $5)
ON CONFLICT (therapist_id) DO UPDATE SET
    address_text = EXCLUDED.address_text,
    latitude     = EXCLUDED.latitude,
    longitude    = EXCLUDED.longitude,
    place_id     = EXCLUDED.place_id,
    updated_at   = NOW();

-- name: GetTherapistAddress :one
SELECT * FROM therapist_addresses WHERE therapist_id = $1;

-- name: DeleteTherapistAddress :exec
DELETE FROM therapist_addresses WHERE therapist_id = $1;