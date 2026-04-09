# Service Access Pattern and Least Privilege

## Objective
Define role assignments and default warehouse usage for service principals.

## Service Principals
- Airbyte: ingestion into raw/bronze layers.
- Airflow: orchestration and controlled execution.
- dbt: transformations and test execution.

## Role Assignment Pattern
- `<ORG_PREFIX>_AIRBYTE_SVC` -> `<ORG_PREFIX>_AIRBYTE_ROLE`
- `<ORG_PREFIX>_AIRFLOW_SVC` -> `<ORG_PREFIX>_AIRFLOW_ROLE`
- `<ORG_PREFIX>_DBT_SVC` -> `<ORG_PREFIX>_DBT_ROLE`

## Environment Boundaries
- DEV roles can read/write DEV only.
- TEST roles can read/write TEST only.
- PROD roles are tightly constrained to approved operations in PROD.

## Warehouse Defaults
- Service users default to environment-appropriate warehouse.
- Production workloads should not use development warehouse classes.

## Verification Expectations
- No service role inherits ACCOUNTADMIN.
- Service users have only required object privileges.
- Role grants are validated via access-matrix script outputs.
