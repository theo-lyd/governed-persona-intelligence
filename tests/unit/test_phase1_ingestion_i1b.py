from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def test_airbyte_templates_are_valid_json() -> None:
    template_dir = ROOT / "src/ingestion/airbyte/config"
    template_files = list(template_dir.glob("*.template.json"))
    assert template_files, "No Airbyte template files found"

    for template_path in template_files:
        payload = json.loads(template_path.read_text(encoding="utf-8"))
        assert "name" in payload, f"name missing in {template_path.name}"


def test_reconciliation_query_contains_tolerance_gate() -> None:
    sql_path = ROOT / "src/ingestion/airbyte/sql/01_reconciliation_checks.sql"
    sql = sql_path.read_text(encoding="utf-8")

    assert "<TOLERANCE_PCT>" in sql
    assert "reconciliation_status" in sql
    assert "relative_diff" in sql


def test_drift_policy_demo_script_runs_successfully() -> None:
    script_path = ROOT / "scripts/ingestion/airbyte/validate_drift_policy.py"
    proc = subprocess.run(
        [sys.executable, str(script_path)],
        check=False,
        capture_output=True,
        text=True,
    )
    assert proc.returncode == 0, proc.stderr
    assert "PASS" in proc.stdout
