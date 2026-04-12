package db

import (
	"context"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// AddressParams is the input type for UpsertTherapistAddress.
type AddressParams struct {
	AddressText string
	Latitude    float64
	Longitude   float64
	PlaceID     string
	State       string
	Nation      string
}

func (d *DB) UpsertTherapistAddress(ctx context.Context, therapistID pgtype.UUID, p AddressParams) error {
	d.log.Debug("UpsertTherapistAddress", zap.String("therapist_id", therapistID.String()))

	err := d.query.UpsertTherapistAddress(ctx, schema.UpsertTherapistAddressParams{
		TherapistID: therapistID,
		AddressText: p.AddressText,
		Latitude:    p.Latitude,
		Longitude:   p.Longitude,
		PlaceID:     p.PlaceID,
		State:       p.State,
		Nation:      p.Nation,
	})
	if err != nil {
		d.log.Error("UpsertTherapistAddress failed",
			zap.String("therapist_id", therapistID.String()),
			zap.Error(err),
		)
	}
	return err
}

func (d *DB) GetTherapistAddress(ctx context.Context, therapistID pgtype.UUID) (schema.TherapistAddress, error) {
	d.log.Debug("GetTherapistAddress", zap.String("therapist_id", therapistID.String()))

	a, err := d.query.GetTherapistAddress(ctx, therapistID)
	if err != nil {
		d.log.Warn("GetTherapistAddress not found", zap.String("therapist_id", therapistID.String()), zap.Error(err))
	}
	return a, err
}
