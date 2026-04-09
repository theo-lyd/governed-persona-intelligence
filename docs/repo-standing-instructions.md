# Repo Standing Instructions and Execution Governance

## Purpose
This document operationalizes implementation discipline for phase-by-phase delivery in this repository.

## 1. Batch Execution Protocol
Every batch shall:
1. Be announced with clear scope and objectives.
2. Receive user approval before work starts.
3. Use atomic commits with one logical change per commit.
4. Be published with commit and push.
5. Include batch-specific documentation.

If phase work grows large, split phase execution into 2-4 smaller batches.

## 2. Batch Documentation Report Template
Use this structure for every batch report in phase docs:

### Batch Metadata
- Batch ID:
- Phase:
- Date:
- Owner:
- Estimated time:

### What Was Built
- Files created:
- Files modified:
- Infrastructure changes:

### Tool and Methodology Justifications
- Choice:
- Alternatives considered:
- Decision rationale:
- Trade-offs:
- When to reconsider:

### Issues Encountered
- Issue:
- Root cause:
- Resolution:
- Validation after fix:

### Acceptance Criteria Met
- Criterion 1:
- Criterion 2:
- Criterion 3:

### Dependencies Introduced
- Package:
- Version:
- Why needed:

## 3. Command Log Policy
Maintain and update command logs under `docs/command/`:
- `git-commands.md`
- `make-commands.md`
- `bash-shell-commands.md`
- `lint-commands.md`
- `dbt-duckdb-commands.md`
- `python-commands.md`
- `docker-commands.md`

Every command entry should include:
- Command
- Purpose
- Expected output
- Notes or troubleshooting hints

## 4. Deliverables Index Policy
README must link all phase and batch deliverables and quick-start commands.

Required document set:
- Beginner tutorial
- Thesis defense brief
- Standard MSc thesis report
- Project presentation (technical)
- Project presentation (non-technical)
- Project walkthrough
- Project runbook

## 5. Issues and Incident Documentation
Maintain per-phase issue logs in `docs/issues-encountered/`.

Each issue record must capture:
- What issue occurred
- Cause
- Solution applied
- How the solution was implemented
- How to avoid recurrence
- Lesson learned

## 6. Git LFS Policy
- Use Git LFS only when required by binary or large-asset needs.
- If not required, keep LFS unconfigured.
- If required, define tracked patterns and onboarding notes in LFS documentation.

## 7. Phase Checkpoint Policy
Before phase promotion:
- Acceptance criteria complete
- Why documentation complete
- Command logs updated
- Batch summary written
- README links updated
- Commits pushed
- No blocking backlog items
