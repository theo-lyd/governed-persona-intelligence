# governed-persona-intelligence
A production-grade AE framework for dynamic behavioral segmentation. Leveraging Snowflake Snowpark for in-warehouse ML and Cortex AI for automated persona synthesis. Features rigorous data quality (GE), observability (Monte Carlo), and CI/CD via GitHub Actions. #dbt #snowpark #snowflake-cortex #machine-learning #data-observability #airflow #pyspark

## Project Execution Roadmap
See the production delivery plan in [docs/implementation-roadmap.md](docs/implementation-roadmap.md).

## Planning Artifacts
- Master backlog and sprint milestones: [docs/planning/master-backlog.md](docs/planning/master-backlog.md)

## Jira Artifacts
- Jira import CSV: [docs/jira/jira-import.csv](docs/jira/jira-import.csv)
- Jira import notes: [docs/jira/README.md](docs/jira/README.md)

## Delivery Operations
- Execution tracker checklist: [docs/execution-tracker.md](docs/execution-tracker.md)
- Phase sign-off issue template: [.github/ISSUE_TEMPLATE/phase-signoff.md](.github/ISSUE_TEMPLATE/phase-signoff.md)

## Governance and Batch Standards
- Repo standing instructions: [docs/repo-standing-instructions.md](docs/repo-standing-instructions.md)
- Agent standing instructions: [.github/copilot-instructions.md](.github/copilot-instructions.md)
- Batch report template: [docs/batch-report-template.md](docs/batch-report-template.md)
- Phase batch reports root: [docs/phases](docs/phases)
- Git LFS policy: [docs/git-lfs-policy.md](docs/git-lfs-policy.md)

## Command Logs
- Git: [docs/command/git-commands.md](docs/command/git-commands.md)
- Make: [docs/command/make-commands.md](docs/command/make-commands.md)
- Bash/Shell: [docs/command/bash-shell-commands.md](docs/command/bash-shell-commands.md)
- Lint: [docs/command/lint-commands.md](docs/command/lint-commands.md)
- dbt: [docs/command/dbt-commands.md](docs/command/dbt-commands.md)
- Snowflake: [docs/command/snowflake-commands.md](docs/command/snowflake-commands.md)
- Snowpark: [docs/command/snowpark-commands.md](docs/command/snowpark-commands.md)
- Airflow: [docs/command/airflow-commands.md](docs/command/airflow-commands.md)
- Airbyte: [docs/command/airbyte-commands.md](docs/command/airbyte-commands.md)
- Great Expectations: [docs/command/great-expectations-commands.md](docs/command/great-expectations-commands.md)
- Monte Carlo: [docs/command/monte-carlo-commands.md](docs/command/monte-carlo-commands.md)
- Streamlit: [docs/command/streamlit-commands.md](docs/command/streamlit-commands.md)
- GitHub Actions: [docs/command/github-actions-commands.md](docs/command/github-actions-commands.md)
- Python: [docs/command/python-commands.md](docs/command/python-commands.md)
- Docker: [docs/command/docker-commands.md](docs/command/docker-commands.md)

## Issues Encountered
- Index: [docs/issues-encountered/README.md](docs/issues-encountered/README.md)
- Phase 0: [docs/issues-encountered/phase-0-issues.md](docs/issues-encountered/phase-0-issues.md)
- Phase I: [docs/issues-encountered/phase-1-issues.md](docs/issues-encountered/phase-1-issues.md)
- Phase II: [docs/issues-encountered/phase-2-issues.md](docs/issues-encountered/phase-2-issues.md)
- Phase III: [docs/issues-encountered/phase-3-issues.md](docs/issues-encountered/phase-3-issues.md)
- Phase IV: [docs/issues-encountered/phase-4-issues.md](docs/issues-encountered/phase-4-issues.md)
- Phase V: [docs/issues-encountered/phase-5-issues.md](docs/issues-encountered/phase-5-issues.md)
- Phase VI: [docs/issues-encountered/phase-6-issues.md](docs/issues-encountered/phase-6-issues.md)

## Deliverables Index
- Beginner tutorial: [docs/beginner-tutorial.md](docs/beginner-tutorial.md)
- Thesis defense brief: [docs/thesis-defense-brief.md](docs/thesis-defense-brief.md)
- Standard MSc thesis report: [docs/msc-thesis-report.md](docs/msc-thesis-report.md)
- Project presentation (technical): [docs/project-presentation-technical.md](docs/project-presentation-technical.md)
- Project presentation (non-technical): [docs/project-presentation-nontechnical.md](docs/project-presentation-nontechnical.md)
- Project walkthrough: [docs/project-walkthrough.md](docs/project-walkthrough.md)
- Project runbook: [docs/project-runbook.md](docs/project-runbook.md)

## Quick-Start Commands
```bash
# show changed files and status
git status --short

# view core planning artifacts
sed -n '1,120p' docs/implementation-roadmap.md
sed -n '1,120p' docs/execution-tracker.md

# open command logs directory
ls -la docs/command
```
