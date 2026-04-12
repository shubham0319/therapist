package service

import (
	"context"
	"therapist/pkg/repo/db"
	schema "therapist/pkg/repo/db/schema/gen"
	"time"

	"github.com/jackc/pgx/v5/pgtype"
)

// dbHelper is the interface the service depends on.
type dbHelper interface {
	CreateTherapist(ctx context.Context, supabaseUID, email string) (schema.Therapist, error)
	GetTherapistBySupabaseUID(ctx context.Context, uid string) (schema.Therapist, error)
	GetTherapistByID(ctx context.Context, id pgtype.UUID) (schema.Therapist, error)
	CompleteOnboarding(ctx context.Context, id pgtype.UUID, params db.OnboardingParams) error
	ApproveTherapist(ctx context.Context, id pgtype.UUID, referralID string) error
	RejectTherapist(ctx context.Context, id pgtype.UUID, reason string) error
	IsReferralIDTaken(ctx context.Context, referralID string) (bool, error)
	UpsertTherapistAddress(ctx context.Context, therapistID pgtype.UUID, p db.AddressParams) error
	// Session management
	CreateSession(ctx context.Context, therapistID pgtype.UUID, refreshToken string, expiresAt time.Time) (schema.TherapistSessionRow, error)
	GetSessionByRefreshToken(ctx context.Context, refreshToken string) (schema.TherapistSessionRow, error)
	DeleteSession(ctx context.Context, refreshToken string) error
	DeleteAllSessionsForTherapist(ctx context.Context, therapistID pgtype.UUID) error
	// Blog management
	CreateBlog(ctx context.Context, p db.CreateBlogParams) (schema.Blog, error)
	GetBlogByID(ctx context.Context, id pgtype.UUID) (schema.Blog, error)
	GetBlogByTherapistAndSlug(ctx context.Context, therapistID pgtype.UUID, slug string) (schema.Blog, error)
	UpdateBlog(ctx context.Context, p db.UpdateBlogParams) (schema.Blog, error)
	PublishBlog(ctx context.Context, id pgtype.UUID) (schema.Blog, error)
	DeleteBlog(ctx context.Context, id, therapistID pgtype.UUID) error
	IncrementBlogViews(ctx context.Context, id pgtype.UUID) error
	ListPublishedBlogs(ctx context.Context, limit, offset int32) ([]schema.Blog, error)
	ListPublishedBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID, limit, offset int32) ([]schema.Blog, error)
	CountPublishedBlogs(ctx context.Context) (int64, error)
	CountPublishedBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID) (int64, error)
	ListAllBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID, limit, offset int32) ([]schema.Blog, error)
	CountAllBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID) (int64, error)
	ToggleBlogLike(ctx context.Context, blogID, therapistID pgtype.UUID) (bool, int64, error)
	IsBlogLikedBy(ctx context.Context, blogID, therapistID pgtype.UUID) (bool, error)
	CountBlogLikes(ctx context.Context, blogID pgtype.UUID) (int64, error)
}

// storageHelper abstracts the file-storage backend (S3 stub for now).
type storageHelper interface {
	Upload(ctx context.Context, fileName, fileType string, data []byte) (string, error)
}

type cacheHelper interface{}
