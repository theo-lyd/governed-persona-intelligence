# Phase 0 Issues

## Issue: Runtime access validation blocked by missing credentials
- Batch: 0.1
- What happened: Access-matrix scripts are ready, but live execution is blocked due to unavailable Snowflake account credentials in this workspace.
- Root cause: Secret values and account-level service users are not provisioned in this environment yet.
- Solution: Added `docs/security/secrets-management.md`, `.env.example`, and script scaffolding for deterministic validation once secrets are configured.
- How implemented: Created `scripts/security/access_matrix_checks.sql` and `scripts/security/run_access_matrix_checks.sh` to generate evidence artifacts.
- How to avoid in future: Ensure security onboarding checklist is completed before starting runtime validation tasks.
- Lesson learned: Provisioning code and validation code should be created together, but acceptance sign-off must be gated on credential readiness.

## Template
- Issue title:
- Batch:
- What happened:
- Root cause:
- Solution:
- How implemented:
- How to avoid in future:
- Lesson learned:
