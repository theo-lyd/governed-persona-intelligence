# Airbyte Ingestion Assets

This directory contains governed ingestion assets for Phase I.

## Structure
- `contracts/`: source event contracts and drift policy baselines.
- `config/`: Airbyte source/destination/connection template payloads.
- `sql/`: reconciliation and validation SQL for landing checks.

## Phase I.1 Intent
- Keep source schema expectations explicit before connector activation.
- Keep destination mapping to Snowflake raw landing deterministic.
- Validate volume and drift behavior with repeatable scripts and tests.
