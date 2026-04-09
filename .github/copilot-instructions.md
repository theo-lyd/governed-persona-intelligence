# Repository Standing Instructions

This file defines mandatory operating rules for implementation in this repository.

## Batch Execution Protocol
- If a phase grows large, split into 2-4 smaller batches.
- Announce each batch with scope and objectives before implementation.
- Request user approval before proceeding with the batch.
- Use atomic commits (single logical change per commit).
- Publish batch changes with commit and push.
- Include batch-specific documentation with deliverables, acceptance evidence, issues, and time estimate.

## Commit Standard
- Every commit message must include explicit why rationale.
- Format recommendation: `<type>: <what changed> | why: <reason>`

## Documentation Requirements
For every phase deliverable:
- Maintain batch documentation report with:
  - What was built (files created or modified)
  - Why each tool and methodology was chosen
  - Issues encountered and resolution
  - Acceptance criteria met
  - Time taken estimate
  - Dependencies introduced
- Keep command logs under `docs/command/` and update continuously.
- Update README deliverables index with phase and batch links.

## Why Documentation Standard
For each significant decision, document:
- The choice
- Alternatives considered
- Decision rationale
- Trade-offs
- When to reconsider

## Phase Completion Checklist
Before moving to the next phase, verify all:
- Acceptance criteria 100% complete
- Why justifications documented
- Command logs populated
- Batch completion summary written
- README updated
- Commits pushed
- No blocking issues

## Error Recovery Protocol
If a batch fails:
- Diagnose root cause deeply
- Document failure, decision pathway, and prevention plan
- Remediate and retest
- Capture lesson learned and update standing process if recurring

## Pull Request Review Checklist
Verify the following before merge:
- Batch announcement included scope and objectives
- Commit messages include why reasoning
- Tool and package choices documented with rationale
- Alternatives and trade-offs documented
- Batch report includes why section
- Command log includes examples and expected outputs
- README phase and batch links updated
- Acceptance criteria verified
