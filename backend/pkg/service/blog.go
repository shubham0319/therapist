package service

import (
	"context"
	"errors"
	"fmt"
	"regexp"
	"strings"
	"therapist/pkg/repo/db"
	schema "therapist/pkg/repo/db/schema/gen"
	"therapist/pkg/storage"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

const (
	maxBlogTitleLen   = 300
	maxBlogContentLen = 50_000
	maxBlogImages     = 2
	maxBlogPageSize   = 50
)

// ─── output types ─────────────────────────────────────────────────────────────

type BlogResult struct {
	ID            string
	TherapistID   string
	Title         string
	Slug          string
	CoverImageURL string
	Content       string
	ImageURLs     []string
	Tags          []string
	Status        string // "draft" | "published"
	Views         int64
	Likes         int64
	LikedByMe     bool
	CreatedAt     string
	UpdatedAt     string
	PublishedAt   string
}

// ─── CreateBlog ───────────────────────────────────────────────────────────────

func (s *Service) CreateBlog(ctx context.Context, therapistID, title, content, coverImageURL string, imageURLs, tags []string) (*BlogResult, error) {
	s.log.Debug("CreateBlog started", zap.String("therapist_id", therapistID))

	id, err := parseUUID(therapistID)
	if err != nil {
		return nil, ErrBadInput
	}

	// Verify therapist is verified.
	t, err := s.db.GetTherapistByID(ctx, id)
	if err != nil {
		return nil, ErrDBRecordNotFound
	}
	if t.Status != schema.VerificationStatusEnumVerified {
		s.log.Warn("non-verified therapist attempted to create blog",
			zap.String("therapist_id", therapistID),
			zap.String("status", string(t.Status)),
		)
		return nil, fmt.Errorf("%w: only verified therapists can write blogs", ErrForbidden)
	}

	if err := validateBlogInput(title, content, imageURLs); err != nil {
		return nil, err
	}

	slug := generateSlug(title)
	// Ensure slug uniqueness — append a random suffix on collision.
	slug, err = s.uniqueSlug(ctx, id, slug)
	if err != nil {
		return nil, err
	}

	blog, err := s.db.CreateBlog(ctx, db.CreateBlogParams{
		TherapistID:   id,
		Title:         title,
		Slug:          slug,
		CoverImageURL: coverImageURL,
		Content:       content,
		ImageURLs:     imageURLs,
		Tags:          tags,
	})
	if err != nil {
		s.log.Error("CreateBlog db failed", zap.Error(err))
		return nil, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	s.log.Info("blog created", zap.String("blog_id", blog.ID.String()))
	return toBlogResult(blog, 0, false), nil
}

// ─── UpdateBlog ───────────────────────────────────────────────────────────────

func (s *Service) UpdateBlog(ctx context.Context, therapistID, blogID, title, content, coverImageURL string, imageURLs, tags []string) (*BlogResult, error) {
	s.log.Debug("UpdateBlog started", zap.String("blog_id", blogID))

	tid, err := parseUUID(therapistID)
	if err != nil {
		return nil, ErrBadInput
	}
	bid, err := parseUUID(blogID)
	if err != nil {
		return nil, ErrBadInput
	}

	existing, err := s.db.GetBlogByID(ctx, bid)
	if err != nil {
		return nil, ErrDBRecordNotFound
	}
	if existing.TherapistID != tid {
		return nil, ErrForbidden
	}
	if existing.Status != schema.BlogStatusEnumDraft {
		return nil, fmt.Errorf("%w: only draft blogs can be updated", ErrForbidden)
	}

	if err := validateBlogInput(title, content, imageURLs); err != nil {
		return nil, err
	}

	blog, err := s.db.UpdateBlog(ctx, db.UpdateBlogParams{
		ID:            bid,
		Title:         title,
		CoverImageURL: coverImageURL,
		Content:       content,
		ImageURLs:     imageURLs,
		Tags:          tags,
	})
	if err != nil {
		s.log.Error("UpdateBlog db failed", zap.Error(err))
		return nil, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	likes, _ := s.db.CountBlogLikes(ctx, bid)
	s.log.Info("blog updated", zap.String("blog_id", blogID))
	return toBlogResult(blog, likes, false), nil
}

// ─── PublishBlog ──────────────────────────────────────────────────────────────

func (s *Service) PublishBlog(ctx context.Context, therapistID, blogID string) (*BlogResult, error) {
	s.log.Debug("PublishBlog started", zap.String("blog_id", blogID))

	tid, err := parseUUID(therapistID)
	if err != nil {
		return nil, ErrBadInput
	}
	bid, err := parseUUID(blogID)
	if err != nil {
		return nil, ErrBadInput
	}

	existing, err := s.db.GetBlogByID(ctx, bid)
	if err != nil {
		return nil, ErrDBRecordNotFound
	}
	if existing.TherapistID != tid {
		return nil, ErrForbidden
	}
	if existing.Status != schema.BlogStatusEnumDraft {
		return nil, fmt.Errorf("%w: blog is already published", ErrBadInput)
	}

	blog, err := s.db.PublishBlog(ctx, bid)
	if err != nil {
		s.log.Error("PublishBlog db failed", zap.Error(err))
		return nil, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	s.log.Info("blog published", zap.String("blog_id", blogID))
	return toBlogResult(blog, 0, false), nil
}

// ─── DeleteBlog ───────────────────────────────────────────────────────────────

func (s *Service) DeleteBlog(ctx context.Context, therapistID, blogID string) error {
	s.log.Debug("DeleteBlog started", zap.String("blog_id", blogID))

	tid, err := parseUUID(therapistID)
	if err != nil {
		return ErrBadInput
	}
	bid, err := parseUUID(blogID)
	if err != nil {
		return ErrBadInput
	}

	// Verify ownership before deletion.
	existing, err := s.db.GetBlogByID(ctx, bid)
	if err != nil {
		return ErrDBRecordNotFound
	}
	if existing.TherapistID != tid {
		return ErrForbidden
	}

	if err := s.db.DeleteBlog(ctx, bid, tid); err != nil {
		s.log.Error("DeleteBlog db failed", zap.Error(err))
		return fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	s.log.Info("blog deleted", zap.String("blog_id", blogID))
	return nil
}

// ─── GetBlog ──────────────────────────────────────────────────────────────────

func (s *Service) GetBlog(ctx context.Context, blogID, viewerID string) (*BlogResult, error) {
	bid, err := parseUUID(blogID)
	if err != nil {
		return nil, ErrBadInput
	}

	blog, err := s.db.GetBlogByID(ctx, bid)
	if err != nil {
		return nil, ErrDBRecordNotFound
	}

	// Increment views for published blogs (best-effort, don't fail the request).
	if blog.Status == schema.BlogStatusEnumPublished {
		_ = s.db.IncrementBlogViews(ctx, bid)
		blog.Views++
	}

	likes, _ := s.db.CountBlogLikes(ctx, bid)

	var likedByMe bool
	if viewerID != "" {
		vid, err := parseUUID(viewerID)
		if err == nil {
			likedByMe, _ = s.db.IsBlogLikedBy(ctx, bid, vid)
			if !likedByMe {
				likedByMe, _ = s.db.IsUserBlogLikedBy(ctx, bid, vid)
			}
		}
	}

	return toBlogResult(blog, likes, likedByMe), nil
}

// ─── ListBlogs ────────────────────────────────────────────────────────────────

func (s *Service) ListBlogs(ctx context.Context, therapistID, viewerID string, page, pageSize int32) ([]*BlogResult, int64, error) {
	if pageSize <= 0 || pageSize > maxBlogPageSize {
		pageSize = maxBlogPageSize
	}
	if page <= 0 {
		page = 1
	}
	offset := (page - 1) * pageSize

	var (
		blogs []schema.Blog
		total int64
		err   error
	)

	if therapistID != "" {
		tid, e := parseUUID(therapistID)
		if e != nil {
			return nil, 0, ErrBadInput
		}
		blogs, err = s.db.ListPublishedBlogsByTherapist(ctx, tid, pageSize, offset)
		if err == nil {
			total, err = s.db.CountPublishedBlogsByTherapist(ctx, tid)
		}
	} else {
		blogs, err = s.db.ListPublishedBlogs(ctx, pageSize, offset)
		if err == nil {
			total, err = s.db.CountPublishedBlogs(ctx)
		}
	}
	if err != nil {
		return nil, 0, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	var vid pgtype.UUID
	hasViewer := false
	if viewerID != "" {
		if e := vid.Scan(viewerID); e == nil {
			hasViewer = true
		}
	}

	results := make([]*BlogResult, 0, len(blogs))
	for _, b := range blogs {
		likes, _ := s.db.CountBlogLikes(ctx, b.ID)
		var likedByMe bool
		if hasViewer {
			likedByMe, _ = s.db.IsBlogLikedBy(ctx, b.ID, vid)
			if !likedByMe {
				likedByMe, _ = s.db.IsUserBlogLikedBy(ctx, b.ID, vid)
			}
		}
		results = append(results, toBlogResult(b, likes, likedByMe))
	}
	return results, total, nil
}

// ─── ListMyBlogs ──────────────────────────────────────────────────────────────

func (s *Service) ListMyBlogs(ctx context.Context, therapistID string, page, pageSize int32) ([]*BlogResult, int64, error) {
	if pageSize <= 0 || pageSize > maxBlogPageSize {
		pageSize = maxBlogPageSize
	}
	if page <= 0 {
		page = 1
	}
	offset := (page - 1) * pageSize

	tid, err := parseUUID(therapistID)
	if err != nil {
		return nil, 0, ErrBadInput
	}

	blogs, err := s.db.ListAllBlogsByTherapist(ctx, tid, pageSize, offset)
	if err != nil {
		return nil, 0, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}
	total, err := s.db.CountAllBlogsByTherapist(ctx, tid)
	if err != nil {
		return nil, 0, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}

	results := make([]*BlogResult, 0, len(blogs))
	for _, b := range blogs {
		likes, _ := s.db.CountBlogLikes(ctx, b.ID)
		// likedByMe is always false for own drafts — owner never "likes" their own draft
		results = append(results, toBlogResult(b, likes, false))
	}
	return results, total, nil
}

// ─── ToggleLikeBlog ───────────────────────────────────────────────────────────

func (s *Service) ToggleLikeBlog(ctx context.Context, therapistID, blogID string) (bool, int64, error) {
	tid, err := parseUUID(therapistID)
	if err != nil {
		return false, 0, ErrBadInput
	}
	bid, err := parseUUID(blogID)
	if err != nil {
		return false, 0, ErrBadInput
	}

	// Only published blogs can be liked.
	blog, err := s.db.GetBlogByID(ctx, bid)
	if err != nil {
		return false, 0, ErrDBRecordNotFound
	}
	if blog.Status != schema.BlogStatusEnumPublished {
		return false, 0, fmt.Errorf("%w: can only like published blogs", ErrBadInput)
	}

	liked, count, err := s.db.ToggleBlogLike(ctx, bid, tid)
	if err != nil {
		return false, 0, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}
	return liked, count, nil
}

// ─── UserToggleLikeBlog ───────────────────────────────────────────────────────

func (s *Service) UserToggleLikeBlog(ctx context.Context, userID, blogID string) (bool, int64, error) {
	uid, err := parseUUID(userID)
	if err != nil {
		return false, 0, ErrBadInput
	}
	bid, err := parseUUID(blogID)
	if err != nil {
		return false, 0, ErrBadInput
	}

	blog, err := s.db.GetBlogByID(ctx, bid)
	if err != nil {
		return false, 0, ErrDBRecordNotFound
	}
	if blog.Status != schema.BlogStatusEnumPublished {
		return false, 0, fmt.Errorf("%w: can only like published blogs", ErrBadInput)
	}

	liked, count, err := s.db.ToggleUserBlogLike(ctx, bid, uid)
	if err != nil {
		return false, 0, fmt.Errorf("%w: %v", ErrDBQuery, err)
	}
	return liked, count, nil
}

// ─── UploadBlogImage ──────────────────────────────────────────────────────────

func (s *Service) UploadBlogImage(ctx context.Context, therapistID, fileName, contentType string, data []byte) (string, error) {
	s.log.Debug("UploadBlogImage started",
		zap.String("therapist_id", therapistID),
		zap.String("content_type", contentType),
		zap.Int("bytes", len(data)),
	)

	tid, err := parseUUID(therapistID)
	if err != nil {
		return "", ErrBadInput
	}

	// Verify therapist is verified.
	t, err := s.db.GetTherapistByID(ctx, tid)
	if err != nil {
		return "", ErrDBRecordNotFound
	}
	if t.Status != schema.VerificationStatusEnumVerified {
		return "", fmt.Errorf("%w: only verified therapists can upload blog images", ErrForbidden)
	}

	if !storage.AllowedBlogImageContentTypes[contentType] {
		s.log.Warn("invalid blog image content type", zap.String("content_type", contentType))
		return "", fmt.Errorf("%w: allowed types are image/jpeg, image/png, image/webp", ErrFileTypeInvalid)
	}
	if len(data) == 0 {
		return "", ErrBadInput
	}
	if len(data) > storage.MaxBlogImageSize {
		s.log.Warn("blog image too large", zap.Int("bytes", len(data)))
		return "", fmt.Errorf("%w: blog images must be ≤ 2 MB", ErrFileTooLarge)
	}

	url, err := s.storage.Upload(ctx, fileName, "blog_image", data)
	if err != nil {
		if errors.Is(err, storage.ErrFileTooLarge) {
			return "", ErrFileTooLarge
		}
		s.log.Error("blog image storage upload failed", zap.Error(err))
		return "", ErrUnexpected
	}

	s.log.Info("blog image uploaded", zap.String("url", url))
	return url, nil
}

// ─── internal helpers ─────────────────────────────────────────────────────────

func validateBlogInput(title, content string, imageURLs []string) error {
	title = strings.TrimSpace(title)
	if title == "" {
		return fmt.Errorf("%w: title is required", ErrImportantFieldMissing)
	}
	if utf8.RuneCountInString(title) > maxBlogTitleLen {
		return fmt.Errorf("%w: title exceeds %d characters", ErrInvalidFormat, maxBlogTitleLen)
	}
	if utf8.RuneCountInString(content) > maxBlogContentLen {
		return fmt.Errorf("%w: content exceeds %d characters", ErrInvalidFormat, maxBlogContentLen)
	}
	if len(imageURLs) > maxBlogImages {
		return fmt.Errorf("%w: blogs may have at most %d inline images", ErrInvalidFormat, maxBlogImages)
	}
	return nil
}

var (
	slugNonAlphanumeric = regexp.MustCompile(`[^a-z0-9]+`)
	slugTrimDashes      = regexp.MustCompile(`^-+|-+$`)
)

func generateSlug(title string) string {
	s := strings.ToLower(strings.TrimSpace(title))
	s = slugNonAlphanumeric.ReplaceAllString(s, "-")
	s = slugTrimDashes.ReplaceAllString(s, "")
	if len(s) > 80 {
		s = s[:80]
	}
	if s == "" {
		s = "blog"
	}
	return s
}

func (s *Service) uniqueSlug(ctx context.Context, therapistID pgtype.UUID, base string) (string, error) {
	slug := base
	for i := 0; i < 10; i++ {
		_, err := s.db.GetBlogByTherapistAndSlug(ctx, therapistID, slug)
		if errors.Is(err, pgx.ErrNoRows) || err != nil {
			// No existing blog with this slug (ErrNoRows means available).
			return slug, nil
		}
		// Collision — append numeric suffix.
		slug = fmt.Sprintf("%s-%d", base, i+2)
	}
	return "", ErrUnexpected
}

func toBlogResult(b schema.Blog, likes int64, likedByMe bool) *BlogResult {
	r := &BlogResult{
		ID:          b.ID.String(),
		TherapistID: b.TherapistID.String(),
		Title:       b.Title,
		Slug:        b.Slug,
		Content:     b.Content,
		ImageURLs:   b.ImageURLs,
		Tags:        b.Tags,
		Status:      string(b.Status),
		Views:       b.Views,
		Likes:       likes,
		LikedByMe:   likedByMe,
	}
	if b.CoverImageURL.Valid {
		r.CoverImageURL = b.CoverImageURL.String
	}
	if b.CreatedAt.Valid {
		r.CreatedAt = b.CreatedAt.Time.UTC().Format("2006-01-02T15:04:05Z")
	}
	if b.UpdatedAt.Valid {
		r.UpdatedAt = b.UpdatedAt.Time.UTC().Format("2006-01-02T15:04:05Z")
	}
	if b.PublishedAt.Valid {
		r.PublishedAt = b.PublishedAt.Time.UTC().Format("2006-01-02T15:04:05Z")
	}
	if r.Tags == nil {
		r.Tags = []string{}
	}
	if r.ImageURLs == nil {
		r.ImageURLs = []string{}
	}
	if r.Tags == nil {
		r.Tags = []string{}
	}
	return r
}
