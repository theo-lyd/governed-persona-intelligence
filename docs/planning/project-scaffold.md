# Project Scaffold

## Purpose
This scaffold provides a production-oriented starting layout aligned to the roadmap phases and toolchain.

## Top-Level Structure
- `src/ingestion/airbyte`: connector specs and sync contracts
- `src/orchestration/airflow`: DAG definitions and orchestration helpers
- `dbt`: canonical dbt projects (for example `dbt/phase0`) with models, macros, snapshots, and tests
- `src/ml/snowpark`: feature engineering, model training, and registry integration
- `src/ai/cortex`: prompt templates and SQL-based narrative workflows
- `src/app/streamlit`: Persona Consultant app code and UI components
- `src/observability`: Great Expectations and Monte Carlo assets
- `infra/snowflake`: SQL setup scripts for RBAC and platform provisioning
- `infra/github-actions`: CI/CD workflow definitions
- `scripts`: reusable automation and utility scripts
- `tests`: unit, integration, data quality, and ML test packs

## Scaffold Initialization Checklist
- [ ] Fill environment configuration templates
- [ ] Add dbt project and profile wiring
- [ ] Add Airflow DAG bootstrap and schedules
- [ ] Add Snowpark model entrypoints
- [ ] Add Cortex prompts and output validation rules
- [ ] Add Streamlit app bootstrap
- [ ] Add observability monitors and expectation suites
