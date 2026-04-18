package service

import (
	"context"
	"therapist/pkg/repo/db"
	schema "therapist/pkg/repo/db/schema/gen"
)

// TherapistCard is the public-facing representation of a therapist for discovery.
type TherapistCard struct {
	TherapistID     string
	FullName        string
	Bio             string
	ProfilePhoto    string
	Specializations []string
	SessionFee      float64
	SessionTypes    []string
	Rating          float64
	TotalSessions   int32
	State           string
	Nation          string
	AddressText     string
}

func toTherapistCard(r schema.TherapistCardRow) TherapistCard {
	bio := ""
	if r.Bio.Valid {
		bio = r.Bio.String
	}
	photo := ""
	if r.ProfilePhoto.Valid {
		photo = r.ProfilePhoto.String
	}
	fee := 0.0
	if r.SessionFee.Valid {
		f, _ := r.SessionFee.Float64Value()
		fee = f.Float64
	}
	rating := 0.0
	if r.Rating.Valid {
		rv, _ := r.Rating.Float64Value()
		rating = rv.Float64
	}
	types := make([]string, len(r.SessionTypes))
	for i, t := range r.SessionTypes {
		types[i] = string(t)
	}
	idStr := ""
	if r.ID.Valid {
		idStr = r.ID.String()
	}
	return TherapistCard{
		TherapistID:     idStr,
		FullName:        r.FullName,
		Bio:             bio,
		ProfilePhoto:    photo,
		Specializations: r.Specializations,
		SessionFee:      fee,
		SessionTypes:    types,
		Rating:          rating,
		TotalSessions:   r.TotalSessions,
		State:           r.State,
		Nation:          r.Nation,
		AddressText:     r.AddressText,
	}
}

func (s *Service) GetTherapistProfile(ctx context.Context, therapistID string) (*TherapistCard, error) {
	tid, err := parseUUID(therapistID)
	if err != nil {
		return nil, ErrBadInput
	}
	row, err := s.db.GetTherapistCardByID(ctx, tid)
	if err != nil {
		return nil, ErrDBRecordNotFound
	}
	card := toTherapistCard(row)
	return &card, nil
}

func (s *Service) SearchTherapists(ctx context.Context, query, sessionType string, page, pageSize int32) ([]TherapistCard, int64, error) {
	if pageSize <= 0 {
		pageSize = 20
	}
	if page <= 0 {
		page = 1
	}
	offset := (page - 1) * pageSize

	rows, err := s.db.SearchTherapists(ctx, db.SearchTherapistsParams{
		Query:       query,
		SessionType: sessionType,
		Limit:       pageSize,
		Offset:      offset,
	})
	if err != nil {
		return nil, 0, err
	}
	total, err := s.db.CountSearchTherapists(ctx, query, sessionType)
	if err != nil {
		return nil, 0, err
	}

	cards := make([]TherapistCard, len(rows))
	for i, r := range rows {
		cards[i] = toTherapistCard(r)
	}
	return cards, total, nil
}

func (s *Service) GetRecommendedTherapists(ctx context.Context, state, nation string, page, pageSize int32) ([]TherapistCard, error) {
	if pageSize <= 0 {
		pageSize = 20
	}
	if page <= 0 {
		page = 1
	}
	offset := (page - 1) * pageSize

	rows, err := s.db.GetRecommendedTherapists(ctx, state, nation, pageSize, offset)
	if err != nil {
		return nil, err
	}
	cards := make([]TherapistCard, len(rows))
	for i, r := range rows {
		cards[i] = toTherapistCard(r)
	}
	return cards, nil
}
