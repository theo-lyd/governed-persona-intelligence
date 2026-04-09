# Phase I.1C Monte Carlo Monitor Specs

This folder defines monitor specifications for Phase I raw-ingestion quality gates.

## Monitor Objectives
- Freshness: detect stale loads for raw landing tables.
- Volume: detect anomalous row-count swings.

## Scope
- `GPI_DEV.RAW.RAW_WEB_EVENTS_JSON`
- `GPI_DEV.RAW.RAW_TRANSACTIONS_CSV`

## Activation Notes
- These are spec files designed to be applied in a live Monte Carlo workspace.
- Activation IDs, destinations, and alert channels should be documented in
  `docs/phases/phase1/evidence/i1c-monitor-activation.md`.
