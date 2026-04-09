# Snowflake Infrastructure Scaffolding

This folder contains Phase 0 Batch 0.1 Snowflake provisioning assets.

## Purpose
- Provision environment-isolated databases and schemas.
- Provision workload-specific warehouses and resource monitors.
- Define least-privilege role model and grant hierarchy.
- Define service principal role bindings for Airflow, Airbyte, and dbt.

## Structure
- `databases/`: environment database creation scripts.
- `schemas/`: medallion and support schema creation scripts.
- `warehouses/`: workload warehouse creation scripts.
- `resource_monitors/`: warehouse credit governance scripts.
- `roles/`: role hierarchy and role-to-object grants.
- `security/`: service user creation and role grants.
- `ingestion/`: raw landing stages, file formats, and ingestion metadata tables.

## Execution Order
1. `resource_monitors/01_resource_monitors.sql`
2. `databases/01_databases.sql`
3. `schemas/01_schemas.sql`
4. `warehouses/01_warehouses.sql`
5. `roles/01_roles.sql`
6. `roles/02_role_grants.sql`
7. `security/01_service_users.sql`
8. `security/02_service_role_grants.sql`
9. `ingestion/01_raw_landing.sql`

## Notes
- Replace placeholder values in angle brackets (for example `<ORG_PREFIX>`).
- Keep service credentials out of source control.
- Run as a platform admin role in a controlled provisioning pipeline.
