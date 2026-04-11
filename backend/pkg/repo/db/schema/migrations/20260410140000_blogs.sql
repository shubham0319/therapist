-- +goose Up
-- +goose StatementBegin
CREATE TYPE blog_status_enum AS ENUM ('draft', 'published');
-- +goose StatementEnd

-- +goose StatementBegin
CREATE TABLE blogs (
    id              UUID             PRIMARY KEY DEFAULT uuid_generate_v4(),
    therapist_id    UUID             NOT NULL REFERENCES therapists(id) ON DELETE CASCADE,
    title           TEXT             NOT NULL CHECK (char_length(title) BETWEEN 1 AND 300),
    slug            TEXT             NOT NULL,
    cover_image_url TEXT,
    content         TEXT             NOT NULL DEFAULT '' CHECK (char_length(content) <= 50000),
    image_urls      TEXT[]           NOT NULL DEFAULT '{}',
    status          blog_status_enum NOT NULL DEFAULT 'draft',
    views           BIGINT           NOT NULL DEFAULT 0,
    published_at    TIMESTAMPTZ,
    created_at      TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ      NOT NULL DEFAULT NOW()
);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE UNIQUE INDEX blogs_therapist_slug_idx ON blogs(therapist_id, slug);
CREATE INDEX blogs_therapist_id_idx         ON blogs(therapist_id);
CREATE INDEX blogs_status_created_idx       ON blogs(status, created_at DESC);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE TRIGGER set_blogs_updated_at
    BEFORE UPDATE ON blogs
    FOR EACH ROW EXECUTE PROCEDURE trigger_set_timestamp();
-- +goose StatementEnd

-- +goose StatementBegin
CREATE TABLE blog_likes (
    id           UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    blog_id      UUID        NOT NULL REFERENCES blogs(id) ON DELETE CASCADE,
    therapist_id UUID        NOT NULL REFERENCES therapists(id) ON DELETE CASCADE,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (blog_id, therapist_id)
);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX blog_likes_blog_id_idx ON blog_likes(blog_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS blog_likes;
-- +goose StatementEnd

-- +goose StatementBegin
DROP TABLE IF EXISTS blogs;
-- +goose StatementEnd

-- +goose StatementBegin
DROP TYPE IF EXISTS blog_status_enum;
-- +goose StatementEnd
