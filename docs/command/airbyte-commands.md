# Airbyte Commands Log

## Entry Format
- Command:
- Purpose:
- Expected output:
- Actual result:
- Notes:

## Entries
1.
- Command: N/A
- Purpose: Placeholder for Airbyte connector sync, health, and reset commands.
- Expected output: Syncs complete and destination loads are validated.
- Actual result: Not yet used.
- Notes: Populate during ingestion phase.

2.
- Command: `python scripts/ingestion/airbyte/validate_drift_policy.py`
- Purpose: Validate I.1B contract drift behavior for additive and missing required fields.
- Expected output: PASS message confirming policy behavior.
- Actual result: Success, `PASS: additive and missing-field drift policy behavior validated`.
- Notes: Template/runtime sync checks will be added after live connector activation.

3.
- Command: `bash -n scripts/ingestion/airbyte/render_templates.sh`
- Purpose: Validate Airbyte template renderer syntax before deployment usage.
- Expected output: No output and exit code 0.
- Actual result: Success.
- Notes: Rendering execution requires environment variables and `envsubst`.
