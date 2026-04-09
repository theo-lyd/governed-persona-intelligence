# I.1C Monitor Activation Evidence

## Purpose
Track the activation and validation of Monte Carlo freshness and volume monitors for Phase I Batch I.1.

## Monitor Registration Checklist
- [ ] `mc_phase1_raw_web_events_freshness` activated
- [ ] `mc_phase1_raw_web_events_volume` activated
- [ ] `mc_phase1_raw_transactions_freshness` activated
- [ ] `mc_phase1_raw_transactions_volume` activated

## Alert Routing
- Alert channel:
- Owner on-call group:
- Escalation policy:

## Activation Evidence
- Activation timestamp: 2026-04-09T00:00:00Z (attempt)
- Workspace/environment: Codespaces / dev
- Monitor dashboard links: N/A (activation not completed)
- Screenshot or run URL: N/A

## Test Drills
- Freshness drill outcome:
- Volume anomaly drill outcome:
- False positive rate notes:

## Status
- Current state: Activation attempted but blocked
- Blockers:
  - `MONTE_CARLO_API_BASE_URL` and `MONTE_CARLO_API_TOKEN` are not set in this workspace.
  - Airbyte connection rendering blocked by missing `AIRBYTE_*` runtime variables and cloud source credentials.
  - Without live connector runs, monitor trigger drills and alert routing evidence cannot be completed.

## Attempt Log
1. `bash scripts/ingestion/airbyte/render_templates.sh src/ingestion/airbyte/config artifacts/airbyte/rendered`
  - Result: failed fast with missing environment variables list.
2. Monte Carlo connectivity precheck
  - Command result: `MONTE_CARLO_API_BASE_URL and/or MONTE_CARLO_API_TOKEN not set`.
3. `python scripts/ingestion/airbyte/evaluate_load_success.py`
  - Result: `success_rate=0.0000`, `five_consecutive_success=false`.
