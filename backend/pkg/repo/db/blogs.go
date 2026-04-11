package db

import (
	"context"
	schema "therapist/pkg/repo/db/schema/gen"

	"github.com/jackc/pgx/v5/pgtype"
	"go.uber.org/zap"
)

// CreateBlogParams is the application-facing input for creating a blog.
type CreateBlogParams struct {
	TherapistID   pgtype.UUID
	Title         string
	Slug          string
	CoverImageURL string // empty = NULL
	Content       string
	ImageURLs     []string
}

// UpdateBlogParams is the application-facing input for updating a draft blog.
type UpdateBlogParams struct {
	ID            pgtype.UUID
	Title         string
	CoverImageURL string
	Content       string
	ImageURLs     []string
}

func (d *DB) CreateBlog(ctx context.Context, p CreateBlogParams) (schema.Blog, error) {
	d.log.Debug("CreateBlog", zap.String("therapist_id", p.TherapistID.String()))
	b, err := d.query.CreateBlog(ctx, schema.CreateBlogParams{
		TherapistID:   p.TherapistID,
		Title:         p.Title,
		Slug:          p.Slug,
		CoverImageURL: nullText(p.CoverImageURL),
		Content:       p.Content,
		ImageURLs:     p.ImageURLs,
	})
	if err != nil {
		d.log.Error("CreateBlog failed", zap.Error(err))
	}
	return b, err
}

func (d *DB) GetBlogByID(ctx context.Context, id pgtype.UUID) (schema.Blog, error) {
	d.log.Debug("GetBlogByID", zap.String("id", id.String()))
	b, err := d.query.GetBlogByID(ctx, id)
	if err != nil {
		d.log.Warn("GetBlogByID not found", zap.Error(err))
	}
	return b, err
}

func (d *DB) GetBlogByTherapistAndSlug(ctx context.Context, therapistID pgtype.UUID, slug string) (schema.Blog, error) {
	return d.query.GetBlogByTherapistAndSlug(ctx, therapistID, slug)
}

func (d *DB) UpdateBlog(ctx context.Context, p UpdateBlogParams) (schema.Blog, error) {
	d.log.Debug("UpdateBlog", zap.String("id", p.ID.String()))
	b, err := d.query.UpdateBlog(ctx, schema.UpdateBlogParams{
		ID:            p.ID,
		Title:         p.Title,
		CoverImageURL: nullText(p.CoverImageURL),
		Content:       p.Content,
		ImageURLs:     p.ImageURLs,
	})
	if err != nil {
		d.log.Error("UpdateBlog failed", zap.Error(err))
	}
	return b, err
}

func (d *DB) PublishBlog(ctx context.Context, id pgtype.UUID) (schema.Blog, error) {
	d.log.Debug("PublishBlog", zap.String("id", id.String()))
	b, err := d.query.PublishBlog(ctx, id)
	if err != nil {
		d.log.Error("PublishBlog failed", zap.Error(err))
	}
	return b, err
}

func (d *DB) DeleteBlog(ctx context.Context, id, therapistID pgtype.UUID) error {
	d.log.Debug("DeleteBlog", zap.String("id", id.String()))
	return d.query.DeleteBlog(ctx, id, therapistID)
}

func (d *DB) IncrementBlogViews(ctx context.Context, id pgtype.UUID) error {
	return d.query.IncrementBlogViews(ctx, id)
}

func (d *DB) ListPublishedBlogs(ctx context.Context, limit, offset int32) ([]schema.Blog, error) {
	return d.query.ListPublishedBlogs(ctx, limit, offset)
}

func (d *DB) ListPublishedBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID, limit, offset int32) ([]schema.Blog, error) {
	return d.query.ListPublishedBlogsByTherapist(ctx, therapistID, limit, offset)
}

func (d *DB) CountPublishedBlogs(ctx context.Context) (int64, error) {
	return d.query.CountPublishedBlogs(ctx)
}

func (d *DB) CountPublishedBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID) (int64, error) {
	return d.query.CountPublishedBlogsByTherapist(ctx, therapistID)
}

// ToggleBlogLike inserts or removes a like. Returns (liked=true, totalLikes) after the operation.
func (d *DB) ToggleBlogLike(ctx context.Context, blogID, therapistID pgtype.UUID) (bool, int64, error) {
	d.log.Debug("ToggleBlogLike",
		zap.String("blog_id", blogID.String()),
		zap.String("therapist_id", therapistID.String()),
	)

	// Check if like already exists.
	_, err := d.query.GetBlogLike(ctx, blogID, therapistID)
	alreadyLiked := err == nil

	if alreadyLiked {
		if err := d.query.DeleteBlogLike(ctx, blogID, therapistID); err != nil {
			d.log.Error("DeleteBlogLike failed", zap.Error(err))
			return false, 0, err
		}
	} else {
		if _, err := d.query.UpsertBlogLike(ctx, blogID, therapistID); err != nil {
			d.log.Error("UpsertBlogLike failed", zap.Error(err))
			return false, 0, err
		}
	}

	count, err := d.query.CountBlogLikes(ctx, blogID)
	if err != nil {
		d.log.Error("CountBlogLikes failed", zap.Error(err))
		return false, 0, err
	}

	liked := !alreadyLiked
	d.log.Debug("ToggleBlogLike done", zap.Bool("liked", liked), zap.Int64("total", count))
	return liked, count, nil
}

func (d *DB) IsBlogLikedBy(ctx context.Context, blogID, therapistID pgtype.UUID) (bool, error) {
	_, err := d.query.GetBlogLike(ctx, blogID, therapistID)
	if err != nil {
		return false, nil // not liked (or not found)
	}
	return true, nil
}

func (d *DB) CountBlogLikes(ctx context.Context, blogID pgtype.UUID) (int64, error) {
	return d.query.CountBlogLikes(ctx, blogID)
}
