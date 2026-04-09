#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${SNOWFLAKE_ACCOUNT:-}" || -z "${SNOWFLAKE_USER:-}" ]]; then
  echo "SNOWFLAKE_ACCOUNT and SNOWFLAKE_USER must be set"
  exit 1
fi

OUTPUT_DIR="${1:-artifacts/security}"
mkdir -p "$OUTPUT_DIR"

snow sql -f scripts/security/access_matrix_checks.sql > "$OUTPUT_DIR/access-matrix.txt"

echo "Access matrix report written to $OUTPUT_DIR/access-matrix.txt"
