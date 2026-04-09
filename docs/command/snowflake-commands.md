# Snowflake Commands Log

## Entry Format
- Command:
- Purpose:
- Expected output:
- Actual result:
- Notes:

## Entries
1.
- Command: `snow sql --temporary-connection --account "$SNOWFLAKE_ACCOUNT" --host "$SNOWFLAKE_HOST" --user "$SNOWFLAKE_USER" --authenticator "$SNOWFLAKE_AUTHENTICATOR" --token "$SNOWFLAKE_TOKEN" --query "select current_user(), current_account(), current_role();"`
- Purpose: Validate PAT-based Snowflake CLI authentication path before running batch evidence script.
- Expected output: Returns current user/account/role without authentication errors.
- Actual result: Success (`THEO`, `FC43105`, `SECURITYADMIN`).
- Notes: PAT flow required due to unsupported MFA method for password-based programmatic auth.

2.
- Command: `bash scripts/security/run_access_matrix_and_capture.sh artifacts/security`
- Purpose: Execute batch access matrix checks and copy tracked evidence file.
- Expected output: Writes runtime report and tracked evidence report.
- Actual result: Success.
- Notes: Final run context used `SNOWFLAKE_ROLE=GPI_DEV_ADMIN`, `SNOWFLAKE_WAREHOUSE=GPI_DEV_XS_WH`, `SNOWFLAKE_DATABASE=GPI_DEV`, `SNOWFLAKE_SCHEMA=RAW`.

3.
- Command: `sed -n '1,120p' artifacts/security/access-matrix.txt`
- Purpose: Verify runtime artifact content.
- Expected output: Shows current account/user/role/warehouse/database/schema and grant listings.
- Actual result: Success.
- Notes: Confirmed runtime values `FC43105`, `THEO`, `GPI_DEV_ADMIN`, `GPI_DEV_XS_WH`, `GPI_DEV`, `RAW`.

4.
- Command: `sed -n '1,120p' docs/phases/phase0/evidence/access-matrix-run.txt`
- Purpose: Verify tracked evidence file captured from runtime output.
- Expected output: Same report content as runtime artifact.
- Actual result: Success.
- Notes: Batch 0.1B closure evidence present in repo-tracked path.
