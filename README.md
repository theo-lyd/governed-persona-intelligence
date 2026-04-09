# governed-persona-intelligence
A production-grade AE framework for dynamic behavioral segmentation. Leveraging Snowflake Snowpark for in-warehouse ML and Cortex AI for automated persona synthesis. Features rigorous data quality (GE), observability (Monte Carlo), and CI/CD via GitHub Actions. #dbt #snowpark #snowflake-cortex #machine-learning #data-observability #airflow #pyspark

## Project Execution Roadmap
See the production delivery plan in [docs/implementation-roadmap.md](docs/implementation-roadmap.md).

## Delivery Operations
- Execution tracker checklist: [docs/execution-tracker.md](docs/execution-tracker.md)
- Phase sign-off issue template: [.github/ISSUE_TEMPLATE/phase-signoff.md](.github/ISSUE_TEMPLATE/phase-signoff.md)

## Governance and Batch Standards
- Repo standing instructions: [doc/repo-standing-instructions.md](doc/repo-standing-instructions.md)
- Agent standing instructions: [.github/copilot-instructions.md](.github/copilot-instructions.md)
- Batch report template: [doc/phases/batch-report-template.md](doc/phases/batch-report-template.md)
- Git LFS policy: [doc/git-lfs-policy.md](doc/git-lfs-policy.md)

## Command Logs
- Git: [doc/command/git-commands.md](doc/command/git-commands.md)
- Make: [doc/command/make-commands.md](doc/command/make-commands.md)
- Bash/Shell: [doc/command/bash-shell-commands.md](doc/command/bash-shell-commands.md)
- Lint: [doc/command/lint-commands.md](doc/command/lint-commands.md)
- dbt/DuckDB: [doc/command/dbt-duckdb-commands.md](doc/command/dbt-duckdb-commands.md)
- Python: [doc/command/python-commands.md](doc/command/python-commands.md)
- Docker: [doc/command/docker-commands.md](doc/command/docker-commands.md)

## Issues Encountered
- Index: [doc/issues-encountered/README.md](doc/issues-encountered/README.md)
- Phase 0: [doc/issues-encountered/phase-0-issues.md](doc/issues-encountered/phase-0-issues.md)
- Phase I: [doc/issues-encountered/phase-1-issues.md](doc/issues-encountered/phase-1-issues.md)
- Phase II: [doc/issues-encountered/phase-2-issues.md](doc/issues-encountered/phase-2-issues.md)
- Phase III: [doc/issues-encountered/phase-3-issues.md](doc/issues-encountered/phase-3-issues.md)
- Phase IV: [doc/issues-encountered/phase-4-issues.md](doc/issues-encountered/phase-4-issues.md)
- Phase V: [doc/issues-encountered/phase-5-issues.md](doc/issues-encountered/phase-5-issues.md)
- Phase VI: [doc/issues-encountered/phase-6-issues.md](doc/issues-encountered/phase-6-issues.md)

## Deliverables Index
- Beginner tutorial: [doc/beginner-tutorial.md](doc/beginner-tutorial.md)
- Thesis defense brief: [doc/thesis-defense-brief.md](doc/thesis-defense-brief.md)
- Standard MSc thesis report: [doc/msc-thesis-report.md](doc/msc-thesis-report.md)
- Project presentation (technical): [doc/project-presentation-technical.md](doc/project-presentation-technical.md)
- Project presentation (non-technical): [doc/project-presentation-nontechnical.md](doc/project-presentation-nontechnical.md)
- Project walkthrough: [doc/project-walkthrough.md](doc/project-walkthrough.md)
- Project runbook: [doc/project-runbook.md](doc/project-runbook.md)

## Quick-Start Commands
```bash
# show changed files and status
git status --short

# view core planning artifacts
sed -n '1,120p' docs/implementation-roadmap.md
sed -n '1,120p' docs/execution-tracker.md

# open command logs directory
ls -la doc/command
```
