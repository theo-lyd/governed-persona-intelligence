# Phase 0 Batch 0.1 Report

## Batch Overview
- Phase: 0
- Batch: 0.1
- Title: Environment and Access Baseline
- Status: In Progress (Blocked on runtime credentials)

## Technical Report
### What
- Implemented Snowflake provisioning scaffolding for environment databases, schemas, warehouses, resource monitors, roles, and role grants.
- Implemented service user and service-role binding scripts for Airbyte, Airflow, and dbt.
- Implemented `.devcontainer` baseline with Snowflake CLI, dbt-snowflake, and Snowpark dependencies.
- Added security templates and access-matrix validation scripts.

### How
- Added SQL scripts under `infra/snowflake/` for deterministic provisioning and grant management.
- Added containerized developer baseline in `.devcontainer/` with pinned dependency manifest.
- Added script-driven access verification in `scripts/security/` to produce auditable matrix outputs.
- Added governance docs in `docs/security/` and non-secret env template in `.env.example`.

### Why
- Choice: SQL-first infrastructure scripts and role-based least-privilege model.
- Alternatives considered: manual UI provisioning and shared admin role access.
- Rationale: SQL scripts are auditable, repeatable, and enforce environment separation.
- Trade-offs: upfront setup effort is higher than manual setup, but long-term governance is stronger.
- Reconsideration trigger: move to declarative Terraform provider when infrastructure maturity requires centralized multi-account management.

### Output
- Code/data artifacts produced:
	- `infra/snowflake/databases/01_databases.sql`
	- `infra/snowflake/schemas/01_schemas.sql`
	- `infra/snowflake/warehouses/01_warehouses.sql`
	- `infra/snowflake/resource_monitors/01_resource_monitors.sql`
	- `infra/snowflake/roles/01_roles.sql`
	- `infra/snowflake/roles/02_role_grants.sql`
	- `infra/snowflake/security/01_service_users.sql`
	- `infra/snowflake/security/02_service_role_grants.sql`
	- `.devcontainer/*`
	- `docs/security/*`
	- `scripts/security/*`
	- `docs/security/guides/workspace-novice-setup.md`
	- `scripts/security/run_access_matrix_and_capture.sh`
- Test and validation evidence:
	- Access-matrix validation scripts prepared.
	- Batch 0.1B execution attempted and logged at `docs/phases/phase0/evidence/access-matrix-run.txt`.
	- Local follow-up capture command: `bash scripts/security/run_access_matrix_and_capture.sh artifacts/security`
	- Current run output: `SNOWFLAKE_ACCOUNT and SNOWFLAKE_USER must be set`.
- Quality gate result:
	- Partially met: policy and scaffolding complete, runtime validation blocked pending secure credentials and snow CLI runtime availability.

## Non-Technical and Business Report
### What
- Established governance baseline for secure, controlled Snowflake operations before data onboarding.

### How
- Implemented environment boundaries (dev/test/prod), service-level access model, and spend controls.
- Prepared evidence-generation scripts for platform/security sign-off.

### Why
- Business rationale for chosen approach:
	- Prevents over-privileged access and reduces risk before production data flows begin.
	- Enables reliable, auditable onboarding for marketing-critical analytics.
- Alternatives and commercial trade-offs:
	- Fast manual setup is cheaper initially but increases operational and compliance risk.

### Output
- Expected business impact:
	- Reduced security and compliance risk during rollout.
	- Better confidence in platform controls for downstream ML/AI phases.
- Adoption and operational outcome:
	- Engineering teams can now onboard with consistent toolchain and role model.
- Risks and mitigations:
	- Risk: credentials and account bindings not yet provisioned.
	- Mitigation: explicit secrets and access runbook added in `docs/security/`; live validation script and artifact capture path implemented.

## Batch 0.1B Execution Note
- Date: 2026-04-09
- Action: attempted to run `scripts/security/run_access_matrix_checks.sh artifacts/security`.
- Result: blocked because required Snowflake credentials are not set in environment.
- Evidence artifact: `docs/phases/phase0/evidence/access-matrix-run.txt`.
- Next action to close gate:
	- Provide `SNOWFLAKE_ACCOUNT` and `SNOWFLAKE_USER` plus authentication credentials.
	- Run `scripts/security/run_access_matrix_and_capture.sh` and attach resulting `docs/phases/phase0/evidence/access-matrix-run.txt`.
	- Capture platform/security sign-off record.

## Batch Completion Checklist
- [x] Scope and objectives announced
- [x] User approval received before execution
- [x] Atomic commit completed
- [x] Commit pushed
- [x] Command logs updated
- [x] Issues log updated
- [ ] Acceptance criteria verified
