# Airbyte Source Event Contracts (Phase I.1A)

This folder stores versioned source contracts used for governed ingestion into Snowflake raw landing.

## Contract Rules
- Every contract defines required and optional fields.
- Unknown additive fields are allowed only when captured in flexible payload columns and logged.
- Missing required fields are rejected into quarantine workflows.
- Contract versions are immutable once published.

## Files
- `web_events_json_v1.contract.json`: JSON event contract for behavioral web/mobile events.
- `transactions_csv_v1.contract.json`: CSV contract for transaction landing.

## Drift Policy
- Additive drift:
  - JSON: allowed in payload; promoted only after contract review.
  - CSV: rejected unless explicitly mapped in a new contract version.
- Missing required field drift:
  - Marked as failed records and excluded from trusted downstream transforms.
- Type drift:
  - Rejected unless coercion rule is documented and approved.
