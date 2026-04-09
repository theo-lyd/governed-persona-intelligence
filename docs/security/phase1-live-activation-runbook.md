# Phase I Live Activation Runbook

## Purpose
Resolve the current Phase I.1 live-activation blocker by providing the required runtime credentials, executing connector/monitor activation, and collecting completion evidence.

## Blocker Summary
Batch I.1 cannot be closed while these are missing in the runtime environment:
- Airbyte connector and destination credentials (`AIRBYTE_*` and `AWS_*` variables)
- Monte Carlo API endpoint/token (`MONTE_CARLO_API_BASE_URL`, `MONTE_CARLO_API_TOKEN`)
- Source endpoint/API values for ingestion templates

## Required Secrets and Endpoints

### Airbyte and source systems
- `AIRBYTE_WORKSPACE_ID`
- `AIRBYTE_SOURCE_DEF_HTTP_API_ID`
- `AIRBYTE_SOURCE_DEF_S3_ID`
- `AIRBYTE_DEST_DEF_SNOWFLAKE_ID`
- `AIRBYTE_WEB_EVENTS_SOURCE_ID` (if updating existing source)
- `AIRBYTE_TRANSACTIONS_SOURCE_ID` (if updating existing source)
- `AIRBYTE_SNOWFLAKE_DESTINATION_ID` (if updating existing destination)
- `WEB_EVENTS_ENDPOINT`
- `WEB_EVENTS_API_KEY`
- `TRANSACTION_BUCKET`
- `TRANSACTION_PREFIX`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `SOURCE_NAMESPACE`

### Snowflake destination
- `SNOWFLAKE_HOST`
- `AIRBYTE_SNOWFLAKE_USER`
- `AIRBYTE_SNOWFLAKE_ROLE`
- `AIRBYTE_SNOWFLAKE_WAREHOUSE`
- `AIRBYTE_SNOWFLAKE_DATABASE`
- `AIRBYTE_SNOWFLAKE_PRIVATE_KEY`

### Monte Carlo
- `MONTE_CARLO_API_BASE_URL`
- `MONTE_CARLO_API_TOKEN`

## Step-by-Step Activation

1. Export secrets into the runtime shell (or inject through CI secrets manager).
2. Render connector payloads:
   - `bash scripts/ingestion/airbyte/render_templates.sh src/ingestion/airbyte/config artifacts/airbyte/rendered`
3. Apply rendered payloads via Airbyte API or UI.
4. Run initial sync for both sources.
5. Run reconciliation query for each load using `src/ingestion/airbyte/sql/01_reconciliation_checks.sql`.
6. Register monitor specs from `src/observability/monte_carlo/phase1/raw_ingestion_monitors.yaml` in Monte Carlo.
7. Validate monitor registration and alert routing in `docs/phases/phase1/evidence/i1c-monitor-activation.md`.
8. Capture at least 5 ingestion runs in `docs/phases/phase1/evidence/i1c-load-success-runs.csv` with status and source/landed counts.
9. Evaluate completion criteria:
   - `python scripts/ingestion/airbyte/evaluate_load_success.py`

## Closure Criteria for Batch I.1
Batch I.1 can be closed when all are true:
- Monitor activation checklist fully checked in `docs/phases/phase1/evidence/i1c-monitor-activation.md`
- Reconciliation checks pass within tolerance for live runs
- `success_rate >= 0.99` and `five_consecutive_success=true`
- Phase I.1 report and execution tracker updated accordingly

## Safety Measures
- Renderer fails fast when required variables are missing, preventing empty credential payloads.
- Keep secrets out of source control; use workspace/CI secret stores only.
- Do not mark quality gates complete using template rows or synthetic placeholders.
