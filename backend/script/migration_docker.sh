#!/bin/bash
# migration_docker.sh — run goose migrations then exec the backend binary.
# Used as the Docker ENTRYPOINT.
#
# No hardcoded values. Config is resolved in this order:
#   1. Env vars already present in the environment  (highest priority)
#   2. ENV_FILE  (default: /root/etc/config.local.env)
set -euo pipefail

# ── Load env file (skip lines already set) ───────────────────────────────────
ENV_FILE="${ENV_FILE:-/root/etc/config.local.env}"

if [ -f "$ENV_FILE" ]; then
  while IFS= read -r line; do
    # Skip blank lines and comments
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    key="${line%%=*}"
    # Only export if not already in the environment
    [ -z "${!key:-}" ] && export "$line"
  done < "$ENV_FILE"
fi

# ── Guard ─────────────────────────────────────────────────────────────────────
if [ -z "${THERAPIST_POSTGRES_CONNECTION_STRING:-}" ]; then
  echo "ERROR: THERAPIST_POSTGRES_CONNECTION_STRING is not set." >&2
  echo "       Provide it as an env var or in ${ENV_FILE}" >&2
  exit 1
fi

DSN="${THERAPIST_POSTGRES_CONNECTION_STRING}"
MIGRATIONS_DIR="${MIGRATIONS_DIR:-/root/migrations}"
MAX_RETRIES="${MAX_RETRIES:-15}"
RETRY_INTERVAL="${RETRY_INTERVAL:-3}"

# ── Wait for Postgres ─────────────────────────────────────────────────────────
echo "Waiting for Postgres..."
for i in $(seq 1 "$MAX_RETRIES"); do
  if goose -dir "$MIGRATIONS_DIR" postgres "$DSN" status > /dev/null 2>&1; then
    echo "Postgres is reachable."
    break
  fi
  if [ "$i" -eq "$MAX_RETRIES" ]; then
    echo "ERROR: Postgres unreachable after $((MAX_RETRIES * RETRY_INTERVAL))s." >&2
    exit 1
  fi
  echo "  attempt $i/$MAX_RETRIES — retrying in ${RETRY_INTERVAL}s..."
  sleep "$RETRY_INTERVAL"
done

# ── Migrate ───────────────────────────────────────────────────────────────────
echo "Running migrations from ${MIGRATIONS_DIR} ..."
goose -dir "$MIGRATIONS_DIR" postgres "$DSN" up
echo "Migrations complete."

# ── Start backend ─────────────────────────────────────────────────────────────
echo "Starting therapist backend..."
exec /root/main
