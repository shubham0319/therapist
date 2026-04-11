-- name: CreateBlog :one
INSERT INTO blogs (therapist_id, title, slug, cover_image_url, content, image_urls)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: GetBlogByID :one
SELECT * FROM blogs WHERE id = $1;

-- name: GetBlogByTherapistAndSlug :one
SELECT * FROM blogs WHERE therapist_id = $1 AND slug = $2;

-- name: UpdateBlog :one
UPDATE blogs
SET title = $2, cover_image_url = $3, content = $4, image_urls = $5, updated_at = NOW()
WHERE id = $1 AND status = 'draft'
RETURNING *;

-- name: PublishBlog :one
UPDATE blogs
SET status = 'published', published_at = NOW(), updated_at = NOW()
WHERE id = $1 AND status = 'draft'
RETURNING *;

-- name: DeleteBlog :exec
DELETE FROM blogs WHERE id = $1 AND therapist_id = $2;

-- name: IncrementBlogViews :exec
UPDATE blogs SET views = views + 1 WHERE id = $1 AND status = 'published';

-- name: ListPublishedBlogs :many
SELECT * FROM blogs
WHERE status = 'published'
ORDER BY published_at DESC
LIMIT $1 OFFSET $2;

-- name: ListPublishedBlogsByTherapist :many
SELECT * FROM blogs
WHERE status = 'published' AND therapist_id = $1
ORDER BY published_at DESC
LIMIT $2 OFFSET $3;

-- name: CountPublishedBlogs :one
SELECT COUNT(*) FROM blogs WHERE status = 'published';

-- name: CountPublishedBlogsByTherapist :one
SELECT COUNT(*) FROM blogs WHERE status = 'published' AND therapist_id = $1;

-- name: UpsertBlogLike :one
INSERT INTO blog_likes (blog_id, therapist_id) VALUES ($1, $2)
ON CONFLICT (blog_id, therapist_id) DO NOTHING
RETURNING id;

-- name: DeleteBlogLike :exec
DELETE FROM blog_likes WHERE blog_id = $1 AND therapist_id = $2;

-- name: GetBlogLike :one
SELECT id FROM blog_likes WHERE blog_id = $1 AND therapist_id = $2;

-- name: CountBlogLikes :one
SELECT COUNT(*) FROM blog_likes WHERE blog_id = $1;
