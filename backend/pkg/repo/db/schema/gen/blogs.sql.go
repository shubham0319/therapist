// Hand-written sqlc-style query file for blogs and blog_likes tables.

package schema

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

// ─── blogs ────────────────────────────────────────────────────────────────────

const createBlog = `-- name: CreateBlog :one
INSERT INTO blogs (therapist_id, title, slug, cover_image_url, content, image_urls, tags)
VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
`

type CreateBlogParams struct {
	TherapistID   pgtype.UUID
	Title         string
	Slug          string
	CoverImageURL pgtype.Text
	Content       string
	ImageURLs     []string
	Tags          []string
}

func (q *Queries) CreateBlog(ctx context.Context, arg CreateBlogParams) (Blog, error) {
	row := q.db.QueryRow(ctx, createBlog,
		arg.TherapistID, arg.Title, arg.Slug, arg.CoverImageURL, arg.Content,
		coalesceStrings(arg.ImageURLs), coalesceStrings(arg.Tags),
	)
	return scanBlog(row)
}

const getBlogByID = `-- name: GetBlogByID :one
SELECT id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
FROM blogs WHERE id = $1
`

func (q *Queries) GetBlogByID(ctx context.Context, id pgtype.UUID) (Blog, error) {
	row := q.db.QueryRow(ctx, getBlogByID, id)
	return scanBlog(row)
}

const getBlogByTherapistAndSlug = `-- name: GetBlogByTherapistAndSlug :one
SELECT id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
FROM blogs WHERE therapist_id = $1 AND slug = $2
`

func (q *Queries) GetBlogByTherapistAndSlug(ctx context.Context, therapistID pgtype.UUID, slug string) (Blog, error) {
	row := q.db.QueryRow(ctx, getBlogByTherapistAndSlug, therapistID, slug)
	return scanBlog(row)
}

const updateBlog = `-- name: UpdateBlog :one
UPDATE blogs
SET title = $2, cover_image_url = $3, content = $4, image_urls = $5, tags = $6, updated_at = NOW()
WHERE id = $1 AND status = 'draft'
RETURNING id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
`

type UpdateBlogParams struct {
	ID            pgtype.UUID
	Title         string
	CoverImageURL pgtype.Text
	Content       string
	ImageURLs     []string
	Tags          []string
}

func (q *Queries) UpdateBlog(ctx context.Context, arg UpdateBlogParams) (Blog, error) {
	row := q.db.QueryRow(ctx, updateBlog,
		arg.ID, arg.Title, arg.CoverImageURL, arg.Content,
		coalesceStrings(arg.ImageURLs), coalesceStrings(arg.Tags),
	)
	return scanBlog(row)
}

const publishBlog = `-- name: PublishBlog :one
UPDATE blogs
SET status = 'published', published_at = NOW(), updated_at = NOW()
WHERE id = $1 AND status = 'draft'
RETURNING id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
`

func (q *Queries) PublishBlog(ctx context.Context, id pgtype.UUID) (Blog, error) {
	row := q.db.QueryRow(ctx, publishBlog, id)
	return scanBlog(row)
}

const deleteBlog = `-- name: DeleteBlog :exec
DELETE FROM blogs WHERE id = $1 AND therapist_id = $2
`

func (q *Queries) DeleteBlog(ctx context.Context, id, therapistID pgtype.UUID) error {
	_, err := q.db.Exec(ctx, deleteBlog, id, therapistID)
	return err
}

const incrementBlogViews = `-- name: IncrementBlogViews :exec
UPDATE blogs SET views = views + 1 WHERE id = $1 AND status = 'published'
`

func (q *Queries) IncrementBlogViews(ctx context.Context, id pgtype.UUID) error {
	_, err := q.db.Exec(ctx, incrementBlogViews, id)
	return err
}

const listPublishedBlogs = `-- name: ListPublishedBlogs :many
SELECT id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
FROM blogs WHERE status = 'published'
ORDER BY published_at DESC
LIMIT $1 OFFSET $2
`

func (q *Queries) ListPublishedBlogs(ctx context.Context, limit, offset int32) ([]Blog, error) {
	rows, err := q.db.Query(ctx, listPublishedBlogs, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	return collectBlogs(rows)
}

const listPublishedBlogsByTherapist = `-- name: ListPublishedBlogsByTherapist :many
SELECT id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
FROM blogs WHERE status = 'published' AND therapist_id = $1
ORDER BY published_at DESC
LIMIT $2 OFFSET $3
`

func (q *Queries) ListPublishedBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID, limit, offset int32) ([]Blog, error) {
	rows, err := q.db.Query(ctx, listPublishedBlogsByTherapist, therapistID, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	return collectBlogs(rows)
}

const listAllBlogsByTherapist = `-- name: ListAllBlogsByTherapist :many
SELECT id, therapist_id, title, slug, cover_image_url, content, image_urls, tags, status, views, published_at, created_at, updated_at
FROM blogs WHERE therapist_id = $1
ORDER BY created_at DESC
LIMIT $2 OFFSET $3
`

func (q *Queries) ListAllBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID, limit, offset int32) ([]Blog, error) {
	rows, err := q.db.Query(ctx, listAllBlogsByTherapist, therapistID, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	return collectBlogs(rows)
}

const countAllBlogsByTherapist = `-- name: CountAllBlogsByTherapist :one
SELECT COUNT(*) FROM blogs WHERE therapist_id = $1
`

func (q *Queries) CountAllBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID) (int64, error) {
	var n int64
	err := q.db.QueryRow(ctx, countAllBlogsByTherapist, therapistID).Scan(&n)
	return n, err
}

const countPublishedBlogs = `-- name: CountPublishedBlogs :one
SELECT COUNT(*) FROM blogs WHERE status = 'published'
`

func (q *Queries) CountPublishedBlogs(ctx context.Context) (int64, error) {
	var n int64
	err := q.db.QueryRow(ctx, countPublishedBlogs).Scan(&n)
	return n, err
}

const countPublishedBlogsByTherapist = `-- name: CountPublishedBlogsByTherapist :one
SELECT COUNT(*) FROM blogs WHERE status = 'published' AND therapist_id = $1
`

func (q *Queries) CountPublishedBlogsByTherapist(ctx context.Context, therapistID pgtype.UUID) (int64, error) {
	var n int64
	err := q.db.QueryRow(ctx, countPublishedBlogsByTherapist, therapistID).Scan(&n)
	return n, err
}

// ─── blog_likes ───────────────────────────────────────────────────────────────

const upsertBlogLike = `-- name: UpsertBlogLike :one
INSERT INTO blog_likes (blog_id, therapist_id) VALUES ($1, $2)
ON CONFLICT (blog_id, therapist_id) DO NOTHING
RETURNING id
`

// UpsertBlogLike inserts a like. Returns pgtype.UUID{} (invalid) if row already existed.
func (q *Queries) UpsertBlogLike(ctx context.Context, blogID, therapistID pgtype.UUID) (pgtype.UUID, error) {
	var id pgtype.UUID
	err := q.db.QueryRow(ctx, upsertBlogLike, blogID, therapistID).Scan(&id)
	return id, err
}

const deleteBlogLike = `-- name: DeleteBlogLike :exec
DELETE FROM blog_likes WHERE blog_id = $1 AND therapist_id = $2
`

func (q *Queries) DeleteBlogLike(ctx context.Context, blogID, therapistID pgtype.UUID) error {
	_, err := q.db.Exec(ctx, deleteBlogLike, blogID, therapistID)
	return err
}

const getBlogLike = `-- name: GetBlogLike :one
SELECT id FROM blog_likes WHERE blog_id = $1 AND therapist_id = $2
`

func (q *Queries) GetBlogLike(ctx context.Context, blogID, therapistID pgtype.UUID) (pgtype.UUID, error) {
	var id pgtype.UUID
	err := q.db.QueryRow(ctx, getBlogLike, blogID, therapistID).Scan(&id)
	return id, err
}

const countBlogLikes = `-- name: CountBlogLikes :one
SELECT COUNT(*) FROM blog_likes WHERE blog_id = $1
`

func (q *Queries) CountBlogLikes(ctx context.Context, blogID pgtype.UUID) (int64, error) {
	var n int64
	err := q.db.QueryRow(ctx, countBlogLikes, blogID).Scan(&n)
	return n, err
}

// ─── helpers ─────────────────────────────────────────────────────────────────

// coalesceStrings returns an empty non-nil slice when s is nil, preventing
// NULL being sent to NOT NULL TEXT[] columns.
func coalesceStrings(s []string) []string {
	if s == nil {
		return []string{}
	}
	return s
}

type blogScanner interface {
	Scan(dest ...any) error
}

func scanBlog(row blogScanner) (Blog, error) {
	var b Blog
	err := row.Scan(
		&b.ID,
		&b.TherapistID,
		&b.Title,
		&b.Slug,
		&b.CoverImageURL,
		&b.Content,
		&b.ImageURLs,
		&b.Tags,
		&b.Status,
		&b.Views,
		&b.PublishedAt,
		&b.CreatedAt,
		&b.UpdatedAt,
	)
	if b.ImageURLs == nil {
		b.ImageURLs = []string{}
	}
	if b.Tags == nil {
		b.Tags = []string{}
	}
	return b, err
}

func collectBlogs(rows interface{ Next() bool; Scan(...any) error; Err() error }) ([]Blog, error) {
	var blogs []Blog
	for rows.Next() {
		b, err := scanBlog(rows)
		if err != nil {
			return nil, err
		}
		blogs = append(blogs, b)
	}
	return blogs, rows.Err()
}
