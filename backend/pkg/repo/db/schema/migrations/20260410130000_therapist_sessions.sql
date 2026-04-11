-- +goose Up
-- +goose StatementBegin
CREATE TABLE therapist_sessions (
    id              UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
    therapist_id    UUID        NOT NULL
                        REFERENCES therapists(id) ON DELETE CASCADE,
    refresh_token   TEXT        NOT NULL UNIQUE,
    expires_at      TIMESTAMPTZ NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_therapist_sessions_therapist_id ON therapist_sessions(therapist_id);
CREATE INDEX idx_therapist_sessions_refresh_token ON therapist_sessions(refresh_token);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS therapist_sessions;
-- +goose StatementEnd