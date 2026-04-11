-- +goose Up

-- Step 1: remove the column default that references the old enum type
-- +goose StatementBegin
ALTER TABLE therapists ALTER COLUMN session_types DROP DEFAULT;
-- +goose StatementEnd

-- Step 2: convert column to plain TEXT[] (clears enum type dependency)
-- +goose StatementBegin
ALTER TABLE therapists
    ALTER COLUMN session_types TYPE TEXT[]
    USING session_types::TEXT[];
-- +goose StatementEnd

-- Step 3: drop the old enum (no dependents now)
-- +goose StatementBegin
DROP TYPE session_type_enum;
-- +goose StatementEnd

-- Step 4: create the new enum with only 'video' and 'in_person'
-- +goose StatementBegin
CREATE TYPE session_type_enum AS ENUM ('video', 'in_person');
-- +goose StatementEnd

-- Step 5a: remove any values that no longer exist in the new enum
-- +goose StatementBegin
UPDATE therapists
SET session_types = ARRAY(
    SELECT v FROM unnest(session_types) AS v
    WHERE v IN ('video', 'in_person')
);
-- +goose StatementEnd

-- Step 5b: now a simple cast is safe since all remaining values are valid
-- +goose StatementBegin
ALTER TABLE therapists
    ALTER COLUMN session_types TYPE session_type_enum[]
    USING session_types::session_type_enum[];
-- +goose StatementEnd

-- Step 6: restore the NOT NULL default
-- +goose StatementBegin
ALTER TABLE therapists
    ALTER COLUMN session_types SET DEFAULT '{}'::session_type_enum[];
-- +goose StatementEnd

-- Step 7: therapist practice-location table
-- +goose StatementBegin
CREATE TABLE therapist_addresses (
    id              UUID             PRIMARY KEY DEFAULT uuid_generate_v4(),
    therapist_id    UUID             NOT NULL
                        REFERENCES therapists(id) ON DELETE CASCADE,
    address_text    TEXT             NOT NULL,
    latitude        DOUBLE PRECISION NOT NULL,
    longitude       DOUBLE PRECISION NOT NULL,
    place_id        TEXT             NOT NULL DEFAULT '',
    created_at      TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ      NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_therapist_address UNIQUE (therapist_id)
);
-- +goose StatementEnd

-- +goose StatementBegin
CREATE INDEX idx_therapist_addresses_therapist_id
    ON therapist_addresses (therapist_id);
-- +goose StatementEnd

-- +goose Down

-- +goose StatementBegin
DROP TABLE IF EXISTS therapist_addresses;
-- +goose StatementEnd

-- +goose StatementBegin
ALTER TABLE therapists ALTER COLUMN session_types DROP DEFAULT;
-- +goose StatementEnd

-- +goose StatementBegin
ALTER TABLE therapists
    ALTER COLUMN session_types TYPE TEXT[]
    USING session_types::TEXT[];
-- +goose StatementEnd

-- +goose StatementBegin
DROP TYPE IF EXISTS session_type_enum;
-- +goose StatementEnd

-- +goose StatementBegin
CREATE TYPE session_type_enum AS ENUM ('chat', 'audio', 'video');
-- +goose StatementEnd

-- +goose StatementBegin
UPDATE therapists
SET session_types = ARRAY(
    SELECT v FROM unnest(session_types) AS v
    WHERE v IN ('chat', 'audio', 'video')
);
-- +goose StatementEnd

-- +goose StatementBegin
ALTER TABLE therapists
    ALTER COLUMN session_types TYPE session_type_enum[]
    USING session_types::session_type_enum[];
-- +goose StatementEnd

-- +goose StatementBegin
ALTER TABLE therapists
    ALTER COLUMN session_types SET DEFAULT '{}'::session_type_enum[];
-- +goose StatementEnd
