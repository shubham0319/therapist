package handler

import (
	"context"
	"therapist/pkg/logger"
	"therapist/pkg/proto/therapistpb"
	"therapist/pkg/service"

	"go.uber.org/zap"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func (h *TherapistHandler) SearchTherapists(ctx context.Context, req *therapistpb.SearchTherapistsRequest) (*therapistpb.SearchTherapistsResponse, error) {
	log := logger.Named("handler.discovery")

	page := req.Page
	pageSize := req.PageSize
	if page <= 0 {
		page = 1
	}
	if pageSize <= 0 || pageSize > 50 {
		pageSize = 20
	}

	cards, total, err := h.svc.SearchTherapists(ctx, req.Query, req.SessionType, page, pageSize)
	if err != nil {
		log.Error("SearchTherapists failed", zap.Error(err))
		return nil, status.Error(codes.Internal, "search failed")
	}

	return &therapistpb.SearchTherapistsResponse{
		Therapists: cardsToProto(cards),
		Total:      total,
	}, nil
}

func (h *TherapistHandler) GetRecommendedTherapists(ctx context.Context, req *therapistpb.GetRecommendedTherapistsRequest) (*therapistpb.GetRecommendedTherapistsResponse, error) {
	log := logger.Named("handler.discovery")

	page := req.Page
	pageSize := req.PageSize
	if page <= 0 {
		page = 1
	}
	if pageSize <= 0 || pageSize > 50 {
		pageSize = 20
	}

	cards, err := h.svc.GetRecommendedTherapists(ctx, req.State, req.Nation, page, pageSize)
	if err != nil {
		log.Error("GetRecommendedTherapists failed", zap.Error(err))
		return nil, status.Error(codes.Internal, "recommendations failed")
	}

	return &therapistpb.GetRecommendedTherapistsResponse{
		Therapists: cardsToProto(cards),
	}, nil
}

func (h *TherapistHandler) GetTherapistProfile(ctx context.Context, req *therapistpb.GetTherapistProfileRequest) (*therapistpb.GetTherapistProfileResponse, error) {
	log := logger.Named("handler.discovery")

	if req.TherapistId == "" {
		return nil, status.Error(codes.InvalidArgument, "therapist_id is required")
	}

	card, err := h.svc.GetTherapistProfile(ctx, req.TherapistId)
	if err != nil {
		log.Error("GetTherapistProfile failed", zap.Error(err))
		return nil, status.Error(codes.NotFound, "therapist not found")
	}

	return &therapistpb.GetTherapistProfileResponse{
		Therapist: cardsToProto([]service.TherapistCard{*card})[0],
	}, nil
}

func cardsToProto(cards []service.TherapistCard) []*therapistpb.TherapistCard {
	pb := make([]*therapistpb.TherapistCard, len(cards))
	for i, c := range cards {
		pb[i] = &therapistpb.TherapistCard{
			TherapistId:     c.TherapistID,
			FullName:        c.FullName,
			Bio:             c.Bio,
			ProfilePhoto:    c.ProfilePhoto,
			Specializations: c.Specializations,
			SessionFee:      c.SessionFee,
			SessionTypes:    c.SessionTypes,
			Rating:          c.Rating,
			TotalSessions:   c.TotalSessions,
			State:           c.State,
			Nation:          c.Nation,
			AddressText:     c.AddressText,
		}
	}
	return pb
}
