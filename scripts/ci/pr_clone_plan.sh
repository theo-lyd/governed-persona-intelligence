#!/usr/bin/env bash
set -euo pipefail

pr_number=""
source_database=""
source_schema="RAW"
validation_warehouse=""
output_file=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pr-number)
      pr_number="$2"
      shift 2
      ;;
    --source-database)
      source_database="$2"
      shift 2
      ;;
    --source-schema)
      source_schema="$2"
      shift 2
      ;;
    --validation-warehouse)
      validation_warehouse="$2"
      shift 2
      ;;
    --output)
      output_file="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$pr_number" || -z "$source_database" ]]; then
  echo "--pr-number and --source-database are required" >&2
  exit 1
fi

if [[ -z "$validation_warehouse" ]]; then
  validation_warehouse="PR_${pr_number}_VALIDATION_WH"
fi

clone_database="PR_${pr_number}_${source_database}"

plan=$(cat <<SQL
-- Phase 0 Batch 0.2 zero-copy clone plan for PR ${pr_number}
CREATE OR REPLACE TRANSIENT DATABASE ${clone_database} CLONE ${source_database};
CREATE OR REPLACE TRANSIENT SCHEMA ${clone_database}.${source_schema} CLONE ${source_database}.${source_schema};
CREATE WAREHOUSE IF NOT EXISTS ${validation_warehouse}
  WITH WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  COMMENT = 'Ephemeral validation warehouse for PR ${pr_number}';
GRANT USAGE ON DATABASE ${clone_database} TO ROLE GPI_DEV_ADMIN;
GRANT USAGE ON SCHEMA ${clone_database}.${source_schema} TO ROLE GPI_DEV_ADMIN;
GRANT USAGE ON WAREHOUSE ${validation_warehouse} TO ROLE GPI_DEV_ADMIN;
SQL
)

if [[ -n "$output_file" ]]; then
  printf '%s\n' "$plan" > "$output_file"
else
  printf '%s\n' "$plan"
fi
