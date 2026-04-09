# Snowflake Parameter Sheet for This Project

## Account Details Provided
- Cloud platform: AZURE
- Edition: Enterprise
- Account identifier: PZYSXBX-SW14774
- Organization name: PZYSXBX
- Account name: SW14774
- Account URL: PZYSXBX-SW14774.snowflakecomputing.com
- Login user: THEO
- Initial authenticator: externalbrowser

## 1) Local Development Parameters (Interactive)
Use this for local manual runs and first-time setup.

### DEV
- SNOWFLAKE_ACCOUNT=PZYSXBX-SW14774
- SNOWFLAKE_USER=THEO
- SNOWFLAKE_AUTHENTICATOR=externalbrowser
- SNOWFLAKE_ROLE=GPI_DEV_ADMIN
- SNOWFLAKE_WAREHOUSE=GPI_DEV_XS_WH
- SNOWFLAKE_DATABASE=GPI_DEV
- SNOWFLAKE_SCHEMA=RAW

### TEST
- SNOWFLAKE_ACCOUNT=PZYSXBX-SW14774
- SNOWFLAKE_USER=THEO
- SNOWFLAKE_AUTHENTICATOR=externalbrowser
- SNOWFLAKE_ROLE=GPI_TEST_ADMIN
- SNOWFLAKE_WAREHOUSE=GPI_TEST_SM_WH
- SNOWFLAKE_DATABASE=GPI_TEST
- SNOWFLAKE_SCHEMA=RAW

### PROD
- SNOWFLAKE_ACCOUNT=PZYSXBX-SW14774
- SNOWFLAKE_USER=THEO
- SNOWFLAKE_AUTHENTICATOR=externalbrowser
- SNOWFLAKE_ROLE=GPI_PROD_ADMIN
- SNOWFLAKE_WAREHOUSE=GPI_PROD_MD_WH
- SNOWFLAKE_DATABASE=GPI_PROD
- SNOWFLAKE_SCHEMA=RAW

## 2) CI/CD Parameters (Service Principal, Non-Interactive)
Use this for GitHub Actions or other unattended automation.

### Required CI Secrets
- SNOWFLAKE_ACCOUNT=PZYSXBX-SW14774
- SNOWFLAKE_USER=GPI_DBT_SVC
- SNOWFLAKE_ROLE=GPI_DBT_ROLE
- SNOWFLAKE_WAREHOUSE=GPI_TEST_SM_WH
- SNOWFLAKE_DATABASE=GPI_TEST
- SNOWFLAKE_SCHEMA=RAW
- SNOWFLAKE_AUTHENTICATOR=snowflake_jwt
- SNOWFLAKE_PRIVATE_KEY=<store in secret manager>
- SNOWFLAKE_PRIVATE_KEY_PASSPHRASE=<store in secret manager>

## 3) Service Account Matrix (Recommended)
- Airbyte service user: GPI_AIRBYTE_SVC
  - role: GPI_AIRBYTE_ROLE
  - default warehouse: GPI_DEV_XS_WH
  - default database: GPI_DEV
  - default schema: RAW

- Airflow service user: GPI_AIRFLOW_SVC
  - role: GPI_AIRFLOW_ROLE
  - default warehouse: GPI_DEV_XS_WH
  - default database: GPI_DEV
  - default schema: RAW

- dbt service user: GPI_DBT_SVC
  - role: GPI_DBT_ROLE
  - default warehouse: GPI_TEST_SM_WH
  - default database: GPI_TEST
  - default schema: RAW

## 4) Snowsight Connection Profile Example
This profile can be adapted into local config once the roles and objects are provisioned.

[connections.gpi_dev]
account = "PZYSXBX-SW14774"
user = "THEO"
authenticator = "externalbrowser"
role = "GPI_DEV_ADMIN"
warehouse = "GPI_DEV_XS_WH"
database = "GPI_DEV"
schema = "RAW"

## 5) Quick Validation Sequence
1. Provision roles, warehouses, databases, and schemas using scripts in infra/snowflake.
2. Set local environment variables for DEV profile.
3. Run access matrix check:
   bash scripts/security/run_access_matrix_checks.sh artifacts/security
4. Promote defaults to TEST and PROD only after least-privilege grants are verified.

## 6) Notes
- Avoid daily work with ACCOUNTADMIN once project roles are available.
- Keep private keys and passwords outside source control.
- Rotate service credentials every 90 days.
