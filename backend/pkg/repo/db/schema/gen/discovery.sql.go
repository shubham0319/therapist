package schema

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

// ─── Search ───────────────────────────────────────────────────────────────────

const searchTherapists = `
SELECT
    t.id,
    t.full_name,
    t.bio,
    t.profile_photo,
    t.specializations,
    t.session_fee,
    t.session_types,
    t.rating,
    t.total_sessions,
    COALESCE(a.state, '')        AS state,
    COALESCE(a.nation, '')       AS nation,
    COALESCE(a.address_text, '') AS address_text
FROM therapists t
LEFT JOIN therapist_addresses a ON a.therapist_id = t.id
WHERE t.status = 'verified'
  AND t.onboarding_completed = TRUE
  AND ($1 = '' OR
       t.full_name ILIKE '%' || $1 || '%' OR
       t.bio       ILIKE '%' || $1 || '%' OR
       EXISTS (
           SELECT 1 FROM unnest(t.specializations) s
           WHERE s ILIKE '%' || $1 || '%'
       )
  )
  AND ($2::text IS NULL OR $2::session_type_enum = ANY(t.session_types))
ORDER BY t.rating DESC NULLS LAST, t.total_sessions DESC
LIMIT $3 OFFSET $4
`

type SearchTherapistsParams struct {
	Query       string
	SessionType pgtype.Text // pass {Valid:false} for "no filter"
	Limit       int32
	Offset      int32
}

func (q *Queries) SearchTherapists(ctx context.Context, arg SearchTherapistsParams) ([]TherapistCardRow, error) {
	rows, err := q.db.Query(ctx, searchTherapists,
		arg.Query,
		arg.SessionType,
		arg.Limit,
		arg.Offset,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var items []TherapistCardRow
	for rows.Next() {
		var i TherapistCardRow
		if err := rows.Scan(
			&i.ID,
			&i.FullName,
			&i.Bio,
			&i.ProfilePhoto,
			&i.Specializations,
			&i.SessionFee,
			&i.SessionTypes,
			&i.Rating,
			&i.TotalSessions,
			&i.State,
			&i.Nation,
			&i.AddressText,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	return items, rows.Err()
}

const countSearchTherapists = `
SELECT COUNT(*)
FROM therapists t
WHERE t.status = 'verified'
  AND t.onboarding_completed = TRUE
  AND ($1 = '' OR
       t.full_name ILIKE '%' || $1 || '%' OR
       t.bio       ILIKE '%' || $1 || '%' OR
       EXISTS (
           SELECT 1 FROM unnest(t.specializations) s
           WHERE s ILIKE '%' || $1 || '%'
       )
  )
  AND ($2::text IS NULL OR $2::session_type_enum = ANY(t.session_types))
`

type CountSearchTherapistsParams struct {
	Query       string
	SessionType pgtype.Text
}

func (q *Queries) CountSearchTherapists(ctx context.Context, arg CountSearchTherapistsParams) (int64, error) {
	row := q.db.QueryRow(ctx, countSearchTherapists, arg.Query, arg.SessionType)
	var count int64
	err := row.Scan(&count)
	return count, err
}

// ─── Recommendations ──────────────────────────────────────────────────────────

const getRecommendedTherapists = `
SELECT
    t.id,
    t.full_name,
    t.bio,
    t.profile_photo,
    t.specializations,
    t.session_fee,
    t.session_types,
    t.rating,
    t.total_sessions,
    COALESCE(a.state, '')        AS state,
    COALESCE(a.nation, '')       AS nation,
    COALESCE(a.address_text, '') AS address_text
FROM therapists t
LEFT JOIN therapist_addresses a ON a.therapist_id = t.id
WHERE t.status = 'verified'
  AND t.onboarding_completed = TRUE
ORDER BY
    CASE
        WHEN a.state = $1 AND a.nation = $2 THEN 2
        WHEN a.nation = $2 THEN 1
        ELSE 0
    END DESC,
    t.rating DESC NULLS LAST,
    t.total_sessions DESC
LIMIT $3 OFFSET $4
`

type GetRecommendedTherapistsParams struct {
	State  string
	Nation string
	Limit  int32
	Offset int32
}

func (q *Queries) GetRecommendedTherapists(ctx context.Context, arg GetRecommendedTherapistsParams) ([]TherapistCardRow, error) {
	rows, err := q.db.Query(ctx, getRecommendedTherapists,
		arg.State,
		arg.Nation,
		arg.Limit,
		arg.Offset,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var items []TherapistCardRow
	for rows.Next() {
		var i TherapistCardRow
		if err := rows.Scan(
			&i.ID,
			&i.FullName,
			&i.Bio,
			&i.ProfilePhoto,
			&i.Specializations,
			&i.SessionFee,
			&i.SessionTypes,
			&i.Rating,
			&i.TotalSessions,
			&i.State,
			&i.Nation,
			&i.AddressText,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	return items, rows.Err()
}
