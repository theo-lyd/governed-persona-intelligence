# Phase 0 Issues

## Issue: Runtime access validation blocked by missing credentials
- Batch: 0.1
- What happened: Access-matrix scripts are ready, but live execution is blocked due to unavailable Snowflake account credentials in this workspace.
- Root cause: Secret values and account-level service users are not provisioned in this environment yet.
- Solution: Added `docs/security/secrets-management.md`, `.env.example`, a novice Workspace setup guide, and script scaffolding for deterministic validation once secrets are configured.
- How implemented: Created `scripts/security/access_matrix_checks.sql`, `scripts/security/run_access_matrix_checks.sh`, `scripts/security/run_access_matrix_and_capture.sh`, and `docs/security/guides/workspace-novice-setup.md` to generate, capture, and explain the evidence workflow.
- How to avoid in future: Ensure security onboarding checklist is completed before starting runtime validation tasks.
- Lesson learned: Provisioning code and validation code should be created together, but acceptance sign-off must be gated on credential readiness.

### 0.1B Attempt Evidence
- Execution command attempted: `bash scripts/security/run_access_matrix_checks.sh artifacts/security`
- Evidence file: `docs/phases/phase0/evidence/access-matrix-run.txt`
- Observed message: `SNOWFLAKE_ACCOUNT and SNOWFLAKE_USER must be set`
- Closure condition: rerun with credentials and capture `artifacts/security/access-matrix.txt` output.

### Resolution Update
- Date resolved: 2026-04-09
- Final auth path: programmatic access token from user profile.
- Additional blockers resolved during execution:
	- SAML externalbrowser mismatch for CLI path.
	- Network policy allowlist requirement for Codespaces egress IP.
	- Warehouse/database naming mismatch (`WH_GOVERNED_*` vs `GPI_*`).
	- Placeholder SQL tokens causing compile error.
- Final evidence:
	- `artifacts/security/access-matrix.txt`
	- `docs/phases/phase0/evidence/access-matrix-run.txt`
- Final status: Closed.

## Template
- Issue title:
- Batch:
- What happened:
- Root cause:
- Solution:
- How implemented:
- How to avoid in future:
- Lesson learned:

## Batch 0.2: Delivery Guardrails and CI Skeleton
- Batch: 0.2
- What happened: CI skeleton, zero-copy clone planning, and release-tag validation were implemented and validated locally.
- Root cause: N/A - this was planned foundation work rather than a blocker-driven issue.
- Solution: Added GitHub Actions workflow with always-on lint, unit-tests, and dbt-parse jobs, plus a path-aware PR clone-plan helper and release-tag validator.
- How implemented: Workflow and helper scripts were added under `.github/workflows/` and `scripts/ci/`, with validation-backed unit tests.
- How to avoid in future: Keep CI skeleton changes small and validate shell, pytest, and dbt parse in the same batch.
- Lesson learned: A clean access baseline makes CI guardrail work easier to validate and document.
