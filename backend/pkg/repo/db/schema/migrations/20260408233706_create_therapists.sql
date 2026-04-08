-- +goose Up
-- +goose StatementBegin

CREATE TYPE session_type_enum AS ENUM ('chat', 'audio', 'video');
CREATE TYPE verification_status_enum AS ENUM ('pending', 'verified', 'rejected');

CREATE TABLE therapists (
    id                    UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Auth (links to Supabase auth.users)
    supabase_uid          TEXT        NOT NULL UNIQUE,

    -- Contact
    email                 TEXT        NOT NULL UNIQUE,
    phone_number          TEXT,

    -- Basic Info (filled during onboarding)
    full_name             TEXT        NOT NULL DEFAULT '',
    gender                gender_enum,
    bio                   TEXT,
    profile_photo         TEXT,
    languages_spoken      TEXT[]      NOT NULL DEFAULT '{}',
    specializations       TEXT[]      NOT NULL DEFAULT '{}',
    years_of_experience   INTEGER     CHECK (years_of_experience >= 0),
    session_fee           NUMERIC(10, 2) CHECK (session_fee >= 0),
    session_types         session_type_enum[] NOT NULL DEFAULT '{}',

    -- Verification Documents (filled during onboarding)
    degree_certificate    TEXT,
    registration_number   TEXT,
    issuing_body          TEXT,
    government_id         TEXT,

    -- Onboarding State
    onboarding_completed  BOOLEAN     NOT NULL DEFAULT FALSE,

    -- Verification Status (set by admin)
    status                verification_status_enum NOT NULL DEFAULT 'pending',
    rejection_reason      TEXT,
    verified_at           TIMESTAMPTZ,

    -- Referral (generated after admin approval)
    referral_id           TEXT        UNIQUE,

    -- Stats
    rating                NUMERIC(3, 2) NOT NULL DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    total_sessions        INTEGER     NOT NULL DEFAULT 0 CHECK (total_sessions >= 0),

    created_at            TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_therapists_supabase_uid ON therapists(supabase_uid);
CREATE INDEX idx_therapists_email        ON therapists(email);
CREATE INDEX idx_therapists_status       ON therapists(status);
CREATE INDEX idx_therapists_referral_id  ON therapists(referral_id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS therapists;
DROP TYPE  IF EXISTS verification_status_enum;
DROP TYPE  IF EXISTS session_type_enum;

-- +goose StatementEnd
