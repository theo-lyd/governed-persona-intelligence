# Airbyte Configuration Templates (Phase I.1B)

This directory contains local and CI-safe templates for Airbyte source, destination, and connection definitions.

## Important
- These files are templates and must not contain real secrets.
- Replace `${...}` placeholders at runtime via environment variables or a secrets manager.
- Keep connector IDs and workspace IDs environment-specific.

## Template Files
- `source_web_events.template.json`
- `source_transactions.template.json`
- `destination_snowflake_raw.template.json`
- `connection_web_events_raw.template.json`
- `connection_transactions_raw.template.json`

## Validation Intent
- Ensure source-to-destination mappings are explicit.
- Preserve traceability metadata (`_ingest_ts`, `_source_file`, `_load_id`) in destination tables.
- Keep schedule and namespace behavior deterministic between environments.
