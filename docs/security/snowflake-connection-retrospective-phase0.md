# Snowflake Connection Retrospective (Phase 0)

## Document Purpose
This document records the full connection and validation journey for Snowflake during Phase 0 Batch 0.1, including repeated failures, final resolution, and prevention controls for future phases.

## Scope
- Incident window: Phase 0 Batch 0.1 implementation and live validation cycle
- Affected area: Snowflake CLI authentication, account connectivity, context selection, and access-matrix evidence capture
- Primary objective: produce auditable access validation evidence at `docs/phases/phase0/evidence/access-matrix-run.txt`

## Executive Summary
The project reached a successful Snowflake validation outcome, but only after multiple independent blockers were identified and cleared in sequence. The failures were not caused by one defect; they were a chain of configuration, authentication, network, and context mismatches.

The final successful path used a programmatic access token with explicit connection parameters and corrected role, warehouse, database, and schema values. The run completed through `scripts/security/run_access_matrix_and_capture.sh`, producing both runtime and tracked evidence.

## What Failed Repeatedly and Why

### 1) Missing runtime prerequisites
- Symptom: access scripts failed immediately due to required environment variables not being set.
- Why it happened: local workspace did not yet have the Snowflake account and user credential context loaded.
- Impact: no runtime validation could begin.

### 2) Tooling not present at first execution attempt
- Symptom: initial execution path could not proceed reliably before Snowflake CLI tooling was confirmed and usable.
- Why it happened: dev environment bootstrap was still being finalized.
- Impact: troubleshooting moved from validation to environment bring-up.

### 3) Authentication method mismatch
- Symptom: SSO browser flow (`externalbrowser`) and password-oriented assumptions did not consistently work for the execution context.
- Why it happened: the environment constraints and account auth policy did not align with that auth path.
- Impact: repeated auth failures and uncertainty about the reliable login mode.

### 4) Network policy allowlist constraint (external factor)
- Symptom: connection attempts failed even with otherwise-correct credentials.
- Why it happened: Codespaces egress IP required allowlisting under Snowflake network policy.
- Impact: blocked access until external network policy requirements were satisfied.

### 5) Account and endpoint identity confusion
- Symptom: wrong or inconsistent account/host combinations caused connection and identity errors.
- Why it happened: multiple account identifiers (locator, account name, host) were used during troubleshooting.
- Impact: authentication appeared intermittently invalid because target identity was not stable.

### 6) Object naming mismatch
- Symptom: expected warehouse/database names in commands did not exist in the active environment.
- Why it happened: run assumptions used `WH_GOVERNED_*` naming while the real objects used the `GPI_*` pattern.
- Impact: execution failed after authentication due to invalid context objects.

### 7) SQL placeholder compilation failures
- Symptom: SQL failed with syntax/compile errors from unresolved placeholder tokens.
- Why it happened: template placeholders were not rendered before execution in some attempts.
- Impact: scripts authenticated successfully but still failed at query compile time.

### 8) Implicit context assumptions in script execution
- Symptom: runs depended on ambient/default connection behavior.
- Why it happened: script execution originally relied too much on default Snowflake CLI context rather than explicit, temporary parameters.
- Impact: inconsistent behavior across local sessions.

## Final Resolution Path

### What was done
- Standardized on token-based auth for deterministic non-interactive execution.
- Updated script flow to support explicit temporary connection parameters.
- Corrected account host and object context values.
- Ensured SQL placeholders are rendered before execution.
- Captured and copied evidence to both runtime and tracked report locations.

### How it was done
- Used PAT-based validation command path to prove account/user/role first.
- Executed `scripts/security/run_access_matrix_and_capture.sh artifacts/security` with corrected environment values.
- Validated both files after run:
  - `artifacts/security/access-matrix.txt`
  - `docs/phases/phase0/evidence/access-matrix-run.txt`

### Why this approach was chosen
- It removes interactive auth dependencies from the validation path.
- It keeps connection inputs explicit, reducing hidden defaults.
- It gives deterministic, auditable evidence suitable for quality gates.

## Evidence and Traceability
- Batch report: `docs/phases/phase0/batch-0.1.md`
- Incident log: `docs/issues-encountered/phase-0-issues.md`
- Snowflake command log: `docs/command/snowflake-commands.md`
- Tracked evidence output: `docs/phases/phase0/evidence/access-matrix-run.txt`
- Runtime evidence output: `artifacts/security/access-matrix.txt`
- Execution script: `scripts/security/run_access_matrix_checks.sh`
- Capture wrapper: `scripts/security/run_access_matrix_and_capture.sh`

## Key Lessons Learned
1. Authentication success does not imply run success; context object validation must follow immediately.
2. External factors (network allowlists, account policy) are first-class dependencies, not edge cases.
3. Script design must prefer explicit parameters over ambient defaults.
4. Placeholder templating must fail fast before SQL submission.
5. Evidence capture must be built into execution paths, not done manually after the fact.

## Preventive Controls for Future Phases

### Technical controls
- Add a preflight block in security scripts that validates all required env vars and object existence before running checks.
- Keep authentication mode explicit in scripts and docs, with one recommended default per environment.
- Include an account/host sanity check command before running full validation.
- Enforce template rendering validation (no unresolved token markers) before SQL execution.

### Process controls
- Require a connection readiness checklist before any runtime validation batch starts.
- Track final approved account, host, role, warehouse, database, and schema in one canonical parameter sheet.
- Treat command logs as mandatory acceptance evidence, not optional notes.

### External dependency controls
- Pre-register development egress ranges or document a rapid allowlist request path.
- Document auth policy dependencies (MFA, SSO mode, token policy) and owner contacts.
- Define a fallback authentication strategy in case the preferred method becomes unavailable.

## Operational Runbook (Recommended Sequence)
1. Verify Snowflake CLI availability and version.
2. Validate environment variable completeness.
3. Run a minimal identity query to confirm account, user, and role.
4. Confirm warehouse and database/schema existence.
5. Execute access-matrix script with explicit parameters.
6. Capture runtime artifact and copy tracked evidence.
7. Verify evidence contents and attach to batch report.

## Phase 0 Closure Position
Phase 0 Batch 0.1 runtime objective is completed and evidenced. This retrospective exists to prevent recurrence during Phase I onboarding and ingestion hardening.
