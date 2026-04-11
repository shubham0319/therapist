package handler

import (
	"context"
	"therapist/pkg/service"

	"github.com/jackc/pgx/v5/pgtype"
)

// therapistService is the slice of *service.Service the handler depends on.
// Keeping it as an interface makes the handler independently testable.
type therapistService interface {
	HandleAuthCallback(ctx context.Context, supabaseToken string) (*service.AuthResult, service.TokenPair, error)
	GetTherapistStatus(ctx context.Context, supabaseToken string) (*service.AuthResult, error)
	CompleteOnboarding(ctx context.Context, therapistID string, in service.OnboardingInput) error
	ApproveTherapist(ctx context.Context, therapistID string) error
	RejectTherapist(ctx context.Context, therapistID, reason string) error
	UploadFile(ctx context.Context, fileName, fileType string, data []byte) (string, error)
	RefreshSession(ctx context.Context, refreshToken string) (*service.AuthResult, service.TokenPair, error)
	Logout(ctx context.Context, refreshToken string) error
	LogoutAll(ctx context.Context, therapistID pgtype.UUID) error
	// Blog
	CreateBlog(ctx context.Context, therapistID, title, content, coverImageURL string, imageURLs []string) (*service.BlogResult, error)
	UpdateBlog(ctx context.Context, therapistID, blogID, title, content, coverImageURL string, imageURLs []string) (*service.BlogResult, error)
	PublishBlog(ctx context.Context, therapistID, blogID string) (*service.BlogResult, error)
	DeleteBlog(ctx context.Context, therapistID, blogID string) error
	GetBlog(ctx context.Context, blogID, viewerID string) (*service.BlogResult, error)
	ListBlogs(ctx context.Context, therapistID, viewerID string, page, pageSize int32) ([]*service.BlogResult, int64, error)
	ToggleLikeBlog(ctx context.Context, therapistID, blogID string) (bool, int64, error)
	UploadBlogImage(ctx context.Context, therapistID, fileName, contentType string, data []byte) (string, error)
}
