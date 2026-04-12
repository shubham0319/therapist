-- +goose Up

-- 1. Add state / nation to therapist_addresses
-- +goose StatementBegin
ALTER TABLE therapist_addresses
    ADD COLUMN state  TEXT NOT NULL DEFAULT '',
    ADD COLUMN nation TEXT NOT NULL DEFAULT '';
-- +goose StatementEnd

-- 2. Users (clients / patients)
-- +goose StatementBegin
CREATE TABLE users (
    id                   UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    supabase_uid         TEXT        NOT NULL UNIQUE,
    email                TEXT        NOT NULL UNIQUE,
    name                 TEXT        NOT NULL DEFAULT '',
    phone                TEXT        NOT NULL DEFAULT '',
    state                TEXT        NOT NULL DEFAULT '',
    nation               TEXT        NOT NULL DEFAULT '',
    looking_for          TEXT[]      NOT NULL DEFAULT '{}',
    onboarding_completed BOOLEAN     NOT NULL DEFAULT FALSE,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX idx_users_supabase_uid ON users(supabase_uid);
CREATE INDEX idx_users_email        ON users(email);
-- +goose StatementEnd

-- 3. User sessions (refresh-token store — mirrors therapist_sessions)
-- +goose StatementBegin
CREATE TABLE user_sessions (
    id            UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id       UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    refresh_token TEXT        NOT NULL UNIQUE,
    expires_at    TIMESTAMPTZ NOT NULL,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX idx_user_sessions_user_id       ON user_sessions(user_id);
CREATE INDEX idx_user_sessions_refresh_token ON user_sessions(refresh_token);
-- +goose StatementEnd

-- +goose Down

-- +goose StatementBegin
DROP TABLE IF EXISTS user_sessions;
-- +goose StatementEnd

-- +goose StatementBegin
DROP TABLE IF EXISTS users;
-- +goose StatementEnd

-- +goose StatementBegin
ALTER TABLE therapist_addresses
    DROP COLUMN IF EXISTS state,
    DROP COLUMN IF EXISTS nation;
-- +goose StatementEnd
