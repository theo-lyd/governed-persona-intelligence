# Phase 0 CI Guardrails and Release Controls

## Scope
This document defines the Batch 0.2 guardrails that sit immediately after the validated access baseline.

## GitHub Actions Checks
The Phase 0 CI workflow is expected to surface these required checks on every PR:
- `lint`
- `unit-tests`
- `dbt-parse`

The `clone-plan` job remains path-aware and is available for PRs that touch clone, security, or infrastructure-adjacent paths.

## Branch Protection Policy
The `master` branch should be protected with the following merge controls:
- Require pull request reviews before merge.
- Require the always-on checks above to pass before merge.
- Dismiss stale approvals when new commits are pushed.
- Restrict direct pushes to maintain audited change control.

## PR Validation Clone Strategy
The PR validation environment uses Snowflake zero-copy clones to isolate changes without duplicating source data.

Recommended shape:
- Clone the source database into a transient PR-specific database.
- Clone the required schema(s) from the source database into the PR database.
- Create a disposable validation warehouse for PR execution.
- Drop all PR-scoped objects after validation completes.

## Release Tagging Convention
Use two tag families:
- Batch evidence tags: `phase<phase>-b<batch>-YYYYMMDD`
- Formal releases: `vMAJOR.MINOR.PATCH` with optional `-rc.N` suffix

Examples:
- `phase0-b0.2-20260409`
- `v0.2.0`
- `v0.2.0-rc.1`

## When to Revisit
Revisit this policy after the CI skeleton proves stable for three consecutive PR dry-runs or when release automation moves into a dedicated deployment pipeline.
