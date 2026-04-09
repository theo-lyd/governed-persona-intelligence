-- Phase I / Batch I.1B
-- Reconciliation checks for source-vs-landing volume and freshness baselines.

-- Replace placeholders before execution:
-- <SOURCE_COUNT>, <SOURCE_SYSTEM>, <LOAD_ID>, <TOLERANCE_PCT>

WITH target_load AS (
  SELECT
    _load_id,
    COUNT(*) AS landed_count,
    MIN(_ingest_ts) AS first_ingest_ts,
    MAX(_ingest_ts) AS last_ingest_ts
  FROM <ORG_PREFIX>_DEV.RAW.RAW_WEB_EVENTS_JSON
  WHERE _load_id = '<LOAD_ID>'
  GROUP BY 1
),
source_reference AS (
  SELECT
    '<SOURCE_SYSTEM>' AS source_system,
    <SOURCE_COUNT> AS source_count
),
comparison AS (
  SELECT
    sr.source_system,
    sr.source_count,
    tl.landed_count,
    ABS(sr.source_count - tl.landed_count) AS absolute_diff,
    CASE
      WHEN sr.source_count = 0 THEN 0
      ELSE ABS(sr.source_count - tl.landed_count) / sr.source_count::FLOAT
    END AS relative_diff,
    tl.first_ingest_ts,
    tl.last_ingest_ts
  FROM source_reference sr
  CROSS JOIN target_load tl
)
SELECT
  source_system,
  source_count,
  landed_count,
  absolute_diff,
  relative_diff,
  first_ingest_ts,
  last_ingest_ts,
  CASE
    WHEN relative_diff <= <TOLERANCE_PCT> THEN 'PASS'
    ELSE 'FAIL'
  END AS reconciliation_status
FROM comparison;
