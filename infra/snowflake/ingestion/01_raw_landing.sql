-- Phase I / Batch I.1A / Chunk I.1.1 + I.1.3
-- Define raw landing assets for governed Airbyte ingestion.

USE ROLE ACCOUNTADMIN;

-- Internal stages used by landing jobs.
CREATE STAGE IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.AIRBYTE_JSON_STAGE;
CREATE STAGE IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.AIRBYTE_CSV_STAGE;

-- File formats for source payloads.
CREATE FILE FORMAT IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.JSON_EVENT_FF
  TYPE = JSON
  STRIP_OUTER_ARRAY = TRUE;

CREATE FILE FORMAT IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.TRANSACTION_CSV_FF
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL');

-- JSON raw landing table with lineage metadata.
CREATE TABLE IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.RAW_WEB_EVENTS_JSON (
  event_payload VARIANT NOT NULL,
  _ingest_ts TIMESTAMP_NTZ NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  _source_file STRING NOT NULL,
  _load_id STRING NOT NULL
);

-- CSV raw landing table with lineage metadata.
CREATE TABLE IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.RAW_TRANSACTIONS_CSV (
  transaction_id STRING,
  user_id STRING,
  transaction_ts TIMESTAMP_NTZ,
  amount NUMBER(18,2),
  currency STRING,
  channel STRING,
  region STRING,
  coupon_code STRING,
  _ingest_ts TIMESTAMP_NTZ NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  _source_file STRING NOT NULL,
  _load_id STRING NOT NULL
);

-- Optional quarantine table for records failing contract checks.
CREATE TABLE IF NOT EXISTS <ORG_PREFIX>_DEV.RAW.RAW_INGEST_QUARANTINE (
  _load_id STRING NOT NULL,
  _source_file STRING NOT NULL,
  _error_reason STRING NOT NULL,
  _rejected_at TIMESTAMP_NTZ NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  rejected_record VARIANT
);
