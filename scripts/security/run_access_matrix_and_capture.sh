#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${SNOWFLAKE_ACCOUNT:-}" || -z "${SNOWFLAKE_USER:-}" ]]; then
  echo "SNOWFLAKE_ACCOUNT and SNOWFLAKE_USER must be set"
  exit 1
fi

if ! command -v snow >/dev/null 2>&1; then
  echo "snow CLI is not installed or not on PATH"
  exit 1
fi

WORK_DIR="${1:-artifacts/security}"
TRACKED_EVIDENCE_DIR="docs/phases/phase0/evidence"
TRACKED_EVIDENCE_FILE="$TRACKED_EVIDENCE_DIR/access-matrix-run.txt"

mkdir -p "$WORK_DIR" "$TRACKED_EVIDENCE_DIR"

# Run the checks and capture stdout/stderr for auditability.
if bash scripts/security/run_access_matrix_checks.sh "$WORK_DIR"; then
  cp "$WORK_DIR/access-matrix.txt" "$TRACKED_EVIDENCE_FILE"
  echo "Captured access matrix evidence to $TRACKED_EVIDENCE_FILE"
else
  echo "Access matrix validation failed before evidence capture"
  exit 1
fi
