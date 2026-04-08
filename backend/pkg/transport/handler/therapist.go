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

// TherapistHandler implements therapistpb.TherapistServiceServer.
type TherapistHandler struct {
	therapistpb.UnimplementedTherapistServiceServer
	svc therapistService
	log *zap.Logger
}

func NewTherapistHandler(svc therapistService) *TherapistHandler {
	return &TherapistHandler{
		svc: svc,
		log: logger.Named("handler.therapist"),
	}
}

func (h *TherapistHandler) AuthCallback(ctx context.Context, req *therapistpb.AuthCallbackRequest) (*therapistpb.AuthCallbackResponse, error) {
	h.log.Debug("AuthCallback called")

	if req.SupabaseToken == "" {
		h.log.Warn("AuthCallback: missing supabase_token")
		return nil, status.Error(codes.InvalidArgument, "supabase_token is required")
	}

	result, err := h.svc.HandleAuthCallback(ctx, req.SupabaseToken)
	if err != nil {
		h.log.Error("AuthCallback failed", zap.Error(err))
		return nil, grpcError(err)
	}

	h.log.Info("AuthCallback succeeded",
		zap.String("therapist_id", result.TherapistID),
		zap.String("status", result.Status),
	)
	return toAuthCallbackResponse(result), nil
}

func (h *TherapistHandler) GetStatus(ctx context.Context, req *therapistpb.GetStatusRequest) (*therapistpb.GetStatusResponse, error) {
	h.log.Debug("GetStatus called")

	if req.SupabaseToken == "" {
		h.log.Warn("GetStatus: missing supabase_token")
		return nil, status.Error(codes.InvalidArgument, "supabase_token is required")
	}

	result, err := h.svc.GetTherapistStatus(ctx, req.SupabaseToken)
	if err != nil {
		h.log.Error("GetStatus failed", zap.Error(err))
		return nil, grpcError(err)
	}

	h.log.Debug("GetStatus succeeded",
		zap.String("therapist_id", result.TherapistID),
		zap.String("status", result.Status),
	)
	return &therapistpb.GetStatusResponse{
		TherapistId:         result.TherapistID,
		Status:              result.Status,
		OnboardingCompleted: result.OnboardingCompleted,
		ReferralId:          result.ReferralID,
		RejectionReason:     result.RejectionReason,
	}, nil
}

func (h *TherapistHandler) CompleteOnboarding(ctx context.Context, req *therapistpb.CompleteOnboardingRequest) (*therapistpb.CompleteOnboardingResponse, error) {
	h.log.Debug("CompleteOnboarding called", zap.String("therapist_id", req.TherapistId))

	if req.TherapistId == "" {
		h.log.Warn("CompleteOnboarding: missing therapist_id")
		return nil, status.Error(codes.InvalidArgument, "therapist_id is required")
	}

	err := h.svc.CompleteOnboarding(ctx, req.TherapistId, service.OnboardingInput{
		FullName:           req.FullName,
		Gender:             req.Gender,
		Bio:                req.Bio,
		ProfilePhoto:       req.ProfilePhoto,
		PhoneNumber:        req.PhoneNumber,
		LanguagesSpoken:    req.LanguagesSpoken,
		Specializations:    req.Specializations,
		YearsOfExperience:  req.YearsOfExperience,
		SessionFee:         req.SessionFee,
		SessionTypes:       req.SessionTypes,
		DegreeCertificate:  req.DegreeCertificate,
		RegistrationNumber: req.RegistrationNumber,
		IssuingBody:        req.IssuingBody,
		GovernmentID:       req.GovernmentId,
	})
	if err != nil {
		h.log.Error("CompleteOnboarding failed",
			zap.String("therapist_id", req.TherapistId),
			zap.Error(err),
		)
		return nil, grpcError(err)
	}

	h.log.Info("CompleteOnboarding succeeded", zap.String("therapist_id", req.TherapistId))
	return &therapistpb.CompleteOnboardingResponse{Success: true}, nil
}

func (h *TherapistHandler) ApproveTherapist(ctx context.Context, req *therapistpb.ApproveTherapistRequest) (*therapistpb.ApproveTherapistResponse, error) {
	h.log.Debug("ApproveTherapist called", zap.String("therapist_id", req.TherapistId))

	if req.TherapistId == "" {
		h.log.Warn("ApproveTherapist: missing therapist_id")
		return nil, status.Error(codes.InvalidArgument, "therapist_id is required")
	}

	if err := h.svc.ApproveTherapist(ctx, req.TherapistId); err != nil {
		h.log.Error("ApproveTherapist failed",
			zap.String("therapist_id", req.TherapistId),
			zap.Error(err),
		)
		return nil, grpcError(err)
	}

	h.log.Info("ApproveTherapist succeeded", zap.String("therapist_id", req.TherapistId))
	return &therapistpb.ApproveTherapistResponse{}, nil
}

func (h *TherapistHandler) RejectTherapist(ctx context.Context, req *therapistpb.RejectTherapistRequest) (*therapistpb.RejectTherapistResponse, error) {
	h.log.Debug("RejectTherapist called", zap.String("therapist_id", req.TherapistId))

	if req.TherapistId == "" {
		h.log.Warn("RejectTherapist: missing therapist_id")
		return nil, status.Error(codes.InvalidArgument, "therapist_id is required")
	}

	if err := h.svc.RejectTherapist(ctx, req.TherapistId, req.Reason); err != nil {
		h.log.Error("RejectTherapist failed",
			zap.String("therapist_id", req.TherapistId),
			zap.Error(err),
		)
		return nil, grpcError(err)
	}

	h.log.Info("RejectTherapist succeeded",
		zap.String("therapist_id", req.TherapistId),
		zap.String("reason", req.Reason),
	)
	return &therapistpb.RejectTherapistResponse{Success: true}, nil
}

func toAuthCallbackResponse(r *service.AuthResult) *therapistpb.AuthCallbackResponse {
	return &therapistpb.AuthCallbackResponse{
		TherapistId:         r.TherapistID,
		Status:              r.Status,
		OnboardingCompleted: r.OnboardingCompleted,
		ReferralId:          r.ReferralID,
		RejectionReason:     r.RejectionReason,
	}
}
