# Secrets Management Baseline (Phase 0 Batch 0.1)

## Objective
Establish secure handling for Snowflake and service-account credentials used by Airbyte, Airflow, and dbt.

## Secret Classes
- Snowflake account and region metadata
- Service account usernames
- Private keys or passwords (never committed)
- Role and warehouse defaults

## Storage Policy
- Development: environment variables in Codespaces secrets.
- CI/CD: GitHub Actions encrypted secrets.
- Runtime orchestration: Airflow connections backed by secret backend.

## Prohibited Practices
- Do not store credentials in repository files.
- Do not print secrets in logs.
- Do not share keys between services.

## Rotation Policy
- Service credentials rotated every 90 days.
- Immediate rotation after suspected exposure.
- Rotation events logged in security change records.

## Required Environment Variables
- `SNOWFLAKE_ACCOUNT`
- `SNOWFLAKE_USER`
- `SNOWFLAKE_ROLE`
- `SNOWFLAKE_WAREHOUSE`
- `SNOWFLAKE_DATABASE`
- `SNOWFLAKE_SCHEMA`
- `SNOWFLAKE_AUTHENTICATOR`
- `SNOWFLAKE_PRIVATE_KEY_PATH` or password-based variable from secret manager
