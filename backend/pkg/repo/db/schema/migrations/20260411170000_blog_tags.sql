-- +goose Up
-- +goose StatementBegin
ALTER TABLE blogs ADD COLUMN tags TEXT[] NOT NULL DEFAULT '{}';
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE blogs DROP COLUMN IF EXISTS tags;
-- +goose StatementEnd
