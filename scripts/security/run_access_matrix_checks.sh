#!/usr/bin/env bash
set -euo pipefail

if ! command -v snow >/dev/null 2>&1; then
  echo "snow CLI is not installed or not on PATH"
  exit 1
fi

if [[ -z "${SNOWFLAKE_ACCOUNT:-}" || -z "${SNOWFLAKE_USER:-}" ]]; then
  echo "SNOWFLAKE_ACCOUNT and SNOWFLAKE_USER must be set"
  exit 1
fi

if [[ -z "${SNOWFLAKE_ROLE:-}" || -z "${SNOWFLAKE_WAREHOUSE:-}" || -z "${SNOWFLAKE_DATABASE:-}" ]]; then
  echo "SNOWFLAKE_ROLE, SNOWFLAKE_WAREHOUSE, and SNOWFLAKE_DATABASE must be set"
  exit 1
fi

OUTPUT_DIR="${1:-artifacts/security}"
mkdir -p "$OUTPUT_DIR"

ROLE_PREFIX="${ORG_PREFIX:-${SNOWFLAKE_DATABASE%%_*}}"
if [[ -z "$ROLE_PREFIX" ]]; then
  ROLE_PREFIX="GPI"
fi

ROLE_PREFIX_PATTERN="${ROLE_PREFIX}_%"

TMP_SQL_FILE="$(mktemp)"
trap 'rm -f "$TMP_SQL_FILE"' EXIT

sed \
  -e "s|<ROLE_PREFIX_PATTERN>|$ROLE_PREFIX_PATTERN|g" \
  -e "s|<SNOWFLAKE_USER_IDENTIFIER>|$SNOWFLAKE_USER|g" \
  -e "s|<SNOWFLAKE_ROLE_IDENTIFIER>|$SNOWFLAKE_ROLE|g" \
  -e "s|<SNOWFLAKE_WAREHOUSE_IDENTIFIER>|$SNOWFLAKE_WAREHOUSE|g" \
  -e "s|<SNOWFLAKE_DATABASE_IDENTIFIER>|$SNOWFLAKE_DATABASE|g" \
  scripts/security/access_matrix_checks.sql > "$TMP_SQL_FILE"

SNOW_SQL_ARGS=(
  --temporary-connection
  --account "$SNOWFLAKE_ACCOUNT"
  --user "$SNOWFLAKE_USER"
)

if [[ -n "${SNOWFLAKE_HOST:-}" ]]; then
  SNOW_SQL_ARGS+=(--host "$SNOWFLAKE_HOST")
fi

if [[ -n "${SNOWFLAKE_AUTHENTICATOR:-}" ]]; then
  SNOW_SQL_ARGS+=(--authenticator "$SNOWFLAKE_AUTHENTICATOR")
fi

if [[ -n "${SNOWFLAKE_PASSWORD:-}" ]]; then
  SNOW_SQL_ARGS+=(--password "$SNOWFLAKE_PASSWORD")
fi

if [[ -n "${SNOWFLAKE_MFA_PASSCODE:-}" ]]; then
  SNOW_SQL_ARGS+=(--mfa-passcode "$SNOWFLAKE_MFA_PASSCODE")
fi

if [[ -n "${SNOWFLAKE_TOKEN:-}" ]]; then
  SNOW_SQL_ARGS+=(--token "$SNOWFLAKE_TOKEN")
fi

if [[ -n "${SNOWFLAKE_TOKEN_FILE_PATH:-}" ]]; then
  SNOW_SQL_ARGS+=(--token-file-path "$SNOWFLAKE_TOKEN_FILE_PATH")
fi

if [[ -n "${SNOWFLAKE_ROLE:-}" ]]; then
  SNOW_SQL_ARGS+=(--role "$SNOWFLAKE_ROLE")
fi

if [[ -n "${SNOWFLAKE_WAREHOUSE:-}" ]]; then
  SNOW_SQL_ARGS+=(--warehouse "$SNOWFLAKE_WAREHOUSE")
fi

if [[ -n "${SNOWFLAKE_DATABASE:-}" ]]; then
  SNOW_SQL_ARGS+=(--database "$SNOWFLAKE_DATABASE")
fi

if [[ -n "${SNOWFLAKE_SCHEMA:-}" ]]; then
  SNOW_SQL_ARGS+=(--schema "$SNOWFLAKE_SCHEMA")
fi

snow sql "${SNOW_SQL_ARGS[@]}" -f "$TMP_SQL_FILE" > "$OUTPUT_DIR/access-matrix.txt"

echo "Access matrix report written to $OUTPUT_DIR/access-matrix.txt"
