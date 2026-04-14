package db

import (
	"context"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
)

type SearchTherapistsParams struct {
	Query       string
	SessionType string // empty = no filter
	Limit       int32
	Offset      int32
}

func (d *DB) SearchTherapists(ctx context.Context, p SearchTherapistsParams) ([]schema.TherapistCardRow, error) {
	st := pgtype.Text{}
	if p.SessionType != "" {
		st = pgtype.Text{String: p.SessionType, Valid: true}
	}
	return d.query.SearchTherapists(ctx, schema.SearchTherapistsParams{
		Query:       p.Query,
		SessionType: st,
		Limit:       p.Limit,
		Offset:      p.Offset,
	})
}

func (d *DB) CountSearchTherapists(ctx context.Context, query, sessionType string) (int64, error) {
	st := pgtype.Text{}
	if sessionType != "" {
		st = pgtype.Text{String: sessionType, Valid: true}
	}
	return d.query.CountSearchTherapists(ctx, schema.CountSearchTherapistsParams{
		Query:       query,
		SessionType: st,
	})
}

func (d *DB) GetRecommendedTherapists(ctx context.Context, state, nation string, limit, offset int32) ([]schema.TherapistCardRow, error) {
	return d.query.GetRecommendedTherapists(ctx, schema.GetRecommendedTherapistsParams{
		State:  state,
		Nation: nation,
		Limit:  limit,
		Offset: offset,
	})
}
