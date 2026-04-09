-- Phase 0 / Batch 0.1 validation script
-- Runtime placeholders are rendered by scripts/security/run_access_matrix_checks.sh.

SELECT CURRENT_ACCOUNT() AS account_name,
	   CURRENT_USER() AS user_name,
	   CURRENT_ROLE() AS role_name,
	   CURRENT_WAREHOUSE() AS warehouse_name,
	   CURRENT_DATABASE() AS database_name,
	   CURRENT_SCHEMA() AS schema_name;

-- Prefix-level inventory checks
SHOW ROLES LIKE '<ROLE_PREFIX_PATTERN>';
SHOW DATABASES LIKE '<ROLE_PREFIX_PATTERN>';
SHOW WAREHOUSES LIKE '<ROLE_PREFIX_PATTERN>';

-- Active principal grant checks
SHOW GRANTS TO USER <SNOWFLAKE_USER_IDENTIFIER>;
SHOW GRANTS TO ROLE <SNOWFLAKE_ROLE_IDENTIFIER>;
SHOW GRANTS ON WAREHOUSE <SNOWFLAKE_WAREHOUSE_IDENTIFIER>;
SHOW GRANTS ON DATABASE <SNOWFLAKE_DATABASE_IDENTIFIER>;
