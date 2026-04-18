-- +goose Up
-- +goose StatementBegin
CREATE TABLE user_blog_likes (
    id         UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    blog_id    UUID        NOT NULL REFERENCES blogs(id) ON DELETE CASCADE,
    user_id    UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (blog_id, user_id)
);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX user_blog_likes_blog_id_idx ON user_blog_likes(blog_id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS user_blog_likes;
-- +goose StatementEnd