# Novice Guide: Complete Snowflake Workspace Setup for This Project

## Purpose
This guide explains what a beginner should do inside Snowflake Workspace/Snowsight to prepare the project after signing in.

## What Can Be Done in Workspace
You can do almost everything needed for Phase 0 Batch 0.1 in Workspace:
- Create resource monitors
- Create databases and schemas
- Create warehouses
- Create roles and grants
- Create service users and role bindings
- Run verification queries
- Capture access evidence once credentials exist

## What Cannot Be Done Purely in Workspace
- Enabling MFA for your own user profile is done in your profile/security settings, not in SQL.
- Adding Codespaces or GitHub secrets is done outside Snowflake.
- Rotating passwords or private keys is done in an external secret manager or admin process.

## Prerequisites
- You can sign in as `THEO`.
- Your current role is `ACCOUNTADMIN` for setup only.
- You know your account identifier:
  - `PZYSXBX-SW14774`
- You have a worksheet ready in Workspace.

## Step 1: Create a worksheet
1. Open Workspace.
2. Create a new SQL file named `Phase0_Batch01_Setup`.
3. Paste SQL in small blocks.
4. Run each block and confirm success before moving on.

## Step 2: Create resource monitors
Run:

```sql
USE ROLE ACCOUNTADMIN;

CREATE RESOURCE MONITOR IF NOT EXISTS GPI_DEV_MONITOR
  WITH CREDIT_QUOTA = 500
  FREQUENCY = MONTHLY
  START_TIMESTAMP = IMMEDIATELY
  TRIGGERS ON 75 PERCENT DO NOTIFY
           ON 90 PERCENT DO NOTIFY
           ON 100 PERCENT DO SUSPEND;

CREATE RESOURCE MONITOR IF NOT EXISTS GPI_TEST_MONITOR
  WITH CREDIT_QUOTA = 700
  FREQUENCY = MONTHLY
  START_TIMESTAMP = IMMEDIATELY
  TRIGGERS ON 75 PERCENT DO NOTIFY
           ON 90 PERCENT DO NOTIFY
           ON 100 PERCENT DO SUSPEND;

CREATE RESOURCE MONITOR IF NOT EXISTS GPI_PROD_MONITOR
  WITH CREDIT_QUOTA = 1500
  FREQUENCY = MONTHLY
  START_TIMESTAMP = IMMEDIATELY
  TRIGGERS ON 75 PERCENT DO NOTIFY
           ON 90 PERCENT DO NOTIFY
           ON 100 PERCENT DO NOTIFY;
```

Verify:

```sql
SHOW RESOURCE MONITORS LIKE 'GPI_%';
```

## Step 3: Create databases and schemas
Run:

```sql
USE ROLE ACCOUNTADMIN;

CREATE DATABASE IF NOT EXISTS GPI_DEV;
CREATE DATABASE IF NOT EXISTS GPI_TEST;
CREATE DATABASE IF NOT EXISTS GPI_PROD;

CREATE SCHEMA IF NOT EXISTS GPI_DEV.RAW;
CREATE SCHEMA IF NOT EXISTS GPI_DEV.BRONZE;
CREATE SCHEMA IF NOT EXISTS GPI_DEV.SILVER;
CREATE SCHEMA IF NOT EXISTS GPI_DEV.GOLD;
CREATE SCHEMA IF NOT EXISTS GPI_DEV.FEATURES;
CREATE SCHEMA IF NOT EXISTS GPI_DEV.ML;
CREATE SCHEMA IF NOT EXISTS GPI_DEV.OBSERVABILITY;

CREATE SCHEMA IF NOT EXISTS GPI_TEST.RAW;
CREATE SCHEMA IF NOT EXISTS GPI_TEST.BRONZE;
CREATE SCHEMA IF NOT EXISTS GPI_TEST.SILVER;
CREATE SCHEMA IF NOT EXISTS GPI_TEST.GOLD;
CREATE SCHEMA IF NOT EXISTS GPI_TEST.FEATURES;
CREATE SCHEMA IF NOT EXISTS GPI_TEST.ML;
CREATE SCHEMA IF NOT EXISTS GPI_TEST.OBSERVABILITY;

CREATE SCHEMA IF NOT EXISTS GPI_PROD.RAW;
CREATE SCHEMA IF NOT EXISTS GPI_PROD.BRONZE;
CREATE SCHEMA IF NOT EXISTS GPI_PROD.SILVER;
CREATE SCHEMA IF NOT EXISTS GPI_PROD.GOLD;
CREATE SCHEMA IF NOT EXISTS GPI_PROD.FEATURES;
CREATE SCHEMA IF NOT EXISTS GPI_PROD.ML;
CREATE SCHEMA IF NOT EXISTS GPI_PROD.OBSERVABILITY;
```

Verify:

```sql
SHOW DATABASES LIKE 'GPI_%';
SHOW SCHEMAS IN DATABASE GPI_DEV;
SHOW SCHEMAS IN DATABASE GPI_TEST;
SHOW SCHEMAS IN DATABASE GPI_PROD;
```

## Step 4: Create warehouses
Run:

```sql
USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS GPI_DEV_XS_WH
  WITH WAREHOUSE_SIZE = XSMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  RESOURCE_MONITOR = GPI_DEV_MONITOR;

CREATE WAREHOUSE IF NOT EXISTS GPI_TEST_SM_WH
  WITH WAREHOUSE_SIZE = SMALL
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  RESOURCE_MONITOR = GPI_TEST_MONITOR;

CREATE WAREHOUSE IF NOT EXISTS GPI_PROD_MD_WH
  WITH WAREHOUSE_SIZE = MEDIUM
  AUTO_SUSPEND = 120
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE
  RESOURCE_MONITOR = GPI_PROD_MONITOR;
```

Verify:

```sql
SHOW WAREHOUSES LIKE 'GPI_%';
```

## Step 5: Create roles
Run:

```sql
USE ROLE SECURITYADMIN;

CREATE ROLE IF NOT EXISTS GPI_DEV_ADMIN;
CREATE ROLE IF NOT EXISTS GPI_TEST_ADMIN;
CREATE ROLE IF NOT EXISTS GPI_PROD_ADMIN;

CREATE ROLE IF NOT EXISTS GPI_AIRBYTE_ROLE;
CREATE ROLE IF NOT EXISTS GPI_AIRFLOW_ROLE;
CREATE ROLE IF NOT EXISTS GPI_DBT_ROLE;
CREATE ROLE IF NOT EXISTS GPI_SNOWPARK_ML_ROLE;
CREATE ROLE IF NOT EXISTS GPI_BI_READ_ROLE;

CREATE ROLE IF NOT EXISTS GPI_DEV_RW;
CREATE ROLE IF NOT EXISTS GPI_DEV_RO;
CREATE ROLE IF NOT EXISTS GPI_TEST_RW;
CREATE ROLE IF NOT EXISTS GPI_TEST_RO;
CREATE ROLE IF NOT EXISTS GPI_PROD_RW;
CREATE ROLE IF NOT EXISTS GPI_PROD_RO;
```

Verify:

```sql
SHOW ROLES LIKE 'GPI_%';
```

## Step 6: Apply role grants
Run the grants from:
- [infra/snowflake/roles/02_role_grants.sql](../../../infra/snowflake/roles/02_role_grants.sql)

If you prefer, paste the SQL manually into the worksheet and replace any placeholders with `GPI_...` names.

## Step 7: Create service users
Optional now, but recommended if you want the full baseline.

Use:
- [infra/snowflake/security/01_service_users.sql](../../../infra/snowflake/security/01_service_users.sql)
- [infra/snowflake/security/02_service_role_grants.sql](../../../infra/snowflake/security/02_service_role_grants.sql)

Recommended service users:
- `GPI_AIRBYTE_SVC`
- `GPI_AIRFLOW_SVC`
- `GPI_DBT_SVC`

## Step 8: Set your safe working role
After setup, do not stay on `ACCOUNTADMIN`.

Run:

```sql
USE ROLE SECURITYADMIN;
GRANT ROLE GPI_DEV_ADMIN TO USER THEO;
```

Then switch your worksheet role to `GPI_DEV_ADMIN` for normal work.

## Step 9: Validate the setup
Run:

```sql
USE ROLE ACCOUNTADMIN;
SHOW DATABASES LIKE 'GPI_%';
SHOW WAREHOUSES LIKE 'GPI_%';
SHOW ROLES LIKE 'GPI_%';
SHOW USERS LIKE 'GPI_%';
SHOW GRANTS TO USER THEO;
SHOW GRANTS TO ROLE GPI_DEV_RW;
SHOW GRANTS ON WAREHOUSE GPI_DEV_XS_WH;
```

If these queries return the expected objects and grants, the Snowflake setup is ready.

## Step 10: Local machine or Codespaces follow-up
Use the values in:
- [docs/security/snowflake-parameter-sheet.md](../snowflake-parameter-sheet.md)

Then from your project terminal run:

```bash
bash scripts/security/run_access_matrix_and_capture.sh artifacts/security
```

If it succeeds:
1. The output is copied to `docs/phases/phase0/evidence/access-matrix-run.txt`
2. Update the batch report
3. Update the issue log

## Step 11: What to do outside SQL
### Enabling MFA
1. Click your profile/avatar.
2. Open Profile or Security.
3. Add or verify MFA.
4. Keep `ACCOUNTADMIN` only for setup.

### Putting secrets into Codespaces or GitHub Secrets
1. Do not put secrets in `.env.example`.
2. In Codespaces, add secrets through the secrets/settings UI.
3. In GitHub, add repository or environment secrets.
4. Use the parameter sheet values as names, not plaintext in files.

### Rotating credentials in an external secret manager
1. Choose your secret system.
2. Replace the password or private key for each service user.
3. Update the secret version used by Codespaces, CI, or orchestration.
4. Re-run access validation after rotation.

## Common mistakes to avoid
1. Leaving your daily role as `ACCOUNTADMIN`.
2. Forgetting a warehouse or schema default.
3. Creating service users before roles exist.
4. Mixing dev and prod resources.
5. Putting passwords or keys in version-controlled files.
