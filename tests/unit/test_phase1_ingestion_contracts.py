from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def _load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def test_contracts_define_required_optional_and_drift_policy() -> None:
    contract_paths = [
        ROOT / "src/ingestion/airbyte/contracts/web_events_json_v1.contract.json",
        ROOT / "src/ingestion/airbyte/contracts/transactions_csv_v1.contract.json",
    ]

    for path in contract_paths:
        payload = _load_json(path)
        assert payload["required_fields"], f"required_fields missing in {path.name}"
        assert "optional_fields" in payload, f"optional_fields missing in {path.name}"
        assert "drift_policy" in payload, f"drift_policy missing in {path.name}"
        for field in payload["required_fields"]:
            assert "name" in field and "type" in field


def test_raw_landing_sql_contains_lineage_metadata_columns() -> None:
    sql_path = ROOT / "infra/snowflake/ingestion/01_raw_landing.sql"
    sql = sql_path.read_text(encoding="utf-8")

    assert "_ingest_ts" in sql
    assert "_source_file" in sql
    assert "_load_id" in sql
    assert "RAW_WEB_EVENTS_JSON" in sql
    assert "RAW_TRANSACTIONS_CSV" in sql
