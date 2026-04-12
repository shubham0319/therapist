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

func (h *TherapistHandler) UserAuthCallback(ctx context.Context, req *therapistpb.UserAuthCallbackRequest) (*therapistpb.UserAuthCallbackResponse, error) {
	log := logger.Named("handler.user")
	log.Debug("UserAuthCallback called")

	if req.SupabaseToken == "" {
		return nil, status.Error(codes.InvalidArgument, "supabase_token is required")
	}

	result, pair, err := h.svc.HandleUserAuthCallback(ctx, req.SupabaseToken)
	if err != nil {
		log.Error("UserAuthCallback failed", zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("UserAuthCallback succeeded",
		zap.String("user_id", result.UserID),
		zap.String("status", result.Status),
	)
	return &therapistpb.UserAuthCallbackResponse{
		UserId:              result.UserID,
		Status:              result.Status,
		OnboardingCompleted: result.OnboardingCompleted,
		AccessToken:         pair.AccessToken,
		RefreshToken:        pair.RefreshToken,
		ExpiresAt:           pair.ExpiresAt,
	}, nil
}

func (h *TherapistHandler) CompleteUserOnboarding(ctx context.Context, req *therapistpb.CompleteUserOnboardingRequest) (*therapistpb.CompleteUserOnboardingResponse, error) {
	log := logger.Named("handler.user")
	log.Debug("CompleteUserOnboarding called", zap.String("user_id", req.UserId))

	if req.UserId == "" {
		return nil, status.Error(codes.InvalidArgument, "user_id is required")
	}

	err := h.svc.CompleteUserOnboarding(ctx, req.UserId, service.UserOnboardingInput{
		Name:       req.Name,
		Phone:      req.Phone,
		State:      req.State,
		Nation:     req.Nation,
		LookingFor: req.LookingFor,
	})
	if err != nil {
		log.Error("CompleteUserOnboarding failed", zap.String("user_id", req.UserId), zap.Error(err))
		return nil, grpcError(err)
	}

	log.Info("CompleteUserOnboarding succeeded", zap.String("user_id", req.UserId))
	return &therapistpb.CompleteUserOnboardingResponse{Success: true}, nil
}

func (h *TherapistHandler) GetUserProfile(ctx context.Context, req *therapistpb.GetUserProfileRequest) (*therapistpb.GetUserProfileResponse, error) {
	log := logger.Named("handler.user")
	log.Debug("GetUserProfile called", zap.String("user_id", req.UserId))

	if req.UserId == "" {
		return nil, status.Error(codes.InvalidArgument, "user_id is required")
	}

	result, err := h.svc.GetUserProfile(ctx, req.UserId)
	if err != nil {
		log.Error("GetUserProfile failed", zap.String("user_id", req.UserId), zap.Error(err))
		return nil, grpcError(err)
	}

	return &therapistpb.GetUserProfileResponse{
		User: &therapistpb.User{
			Id:                  result.UserID,
			OnboardingCompleted: result.OnboardingCompleted,
		},
	}, nil
}

func (h *TherapistHandler) UserRefreshSession(ctx context.Context, req *therapistpb.UserRefreshSessionRequest) (*therapistpb.UserRefreshSessionResponse, error) {
	log := logger.Named("handler.user")
	if req.RefreshToken == "" {
		return nil, status.Error(codes.InvalidArgument, "refresh_token is required")
	}

	result, pair, err := h.svc.UserRefreshSession(ctx, req.RefreshToken)
	if err != nil {
		log.Warn("UserRefreshSession failed", zap.Error(err))
		return nil, grpcError(err)
	}

	return &therapistpb.UserRefreshSessionResponse{
		UserId:       result.UserID,
		Status:       result.Status,
		AccessToken:  pair.AccessToken,
		RefreshToken: pair.RefreshToken,
		ExpiresAt:    pair.ExpiresAt,
	}, nil
}

func (h *TherapistHandler) UserLogout(ctx context.Context, req *therapistpb.UserLogoutRequest) (*therapistpb.UserLogoutResponse, error) {
	if err := h.svc.UserLogout(ctx, req.RefreshToken); err != nil {
		return nil, grpcError(err)
	}
	return &therapistpb.UserLogoutResponse{Success: true}, nil
}
