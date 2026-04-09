package handler

import (
	"context"
	"therapist/pkg/service"
)

// therapistService is the slice of *service.Service the handler depends on.
// Keeping it as an interface makes the handler independently testable.
type therapistService interface {
	HandleAuthCallback(ctx context.Context, supabaseToken string) (*service.AuthResult, error)
	GetTherapistStatus(ctx context.Context, supabaseToken string) (*service.AuthResult, error)
	CompleteOnboarding(ctx context.Context, therapistID string, in service.OnboardingInput) error
	ApproveTherapist(ctx context.Context, therapistID string) error
	RejectTherapist(ctx context.Context, therapistID, reason string) error
	UploadFile(ctx context.Context, fileName, fileType string, data []byte) (string, error)
}
