from __future__ import annotations

import csv
import subprocess
import sys
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]


def test_monitor_spec_has_freshness_and_volume_for_each_raw_table() -> None:
    spec_path = ROOT / "src/observability/monte_carlo/phase1/raw_ingestion_monitors.yaml"
    payload = yaml.safe_load(spec_path.read_text(encoding="utf-8"))
    monitors = payload["monitors"]

    required = {
        ("GPI_DEV.RAW.RAW_WEB_EVENTS_JSON", "freshness"),
        ("GPI_DEV.RAW.RAW_WEB_EVENTS_JSON", "volume"),
        ("GPI_DEV.RAW.RAW_TRANSACTIONS_CSV", "freshness"),
        ("GPI_DEV.RAW.RAW_TRANSACTIONS_CSV", "volume"),
    }
    seen = {(m["table"], m["type"]) for m in monitors}
    assert required.issubset(seen)


def test_monitor_validation_script_runs_successfully() -> None:
    script = ROOT / "scripts/observability/monte_carlo/validate_phase1_monitor_specs.py"
    proc = subprocess.run([sys.executable, str(script)], check=False, capture_output=True, text=True)
    assert proc.returncode == 0, proc.stderr
    assert "PASS" in proc.stdout


def test_load_success_evaluator_reports_expected_metrics() -> None:
    evidence = ROOT / "docs/phases/phase1/evidence/i1c-load-success-runs.csv"
    rows = list(csv.DictReader(evidence.read_text(encoding="utf-8").splitlines()))
    assert rows
    assert {"run_id", "executed_at", "status", "source_records", "landed_records", "notes"}.issubset(rows[0].keys())

    script = ROOT / "scripts/ingestion/airbyte/evaluate_load_success.py"
    proc = subprocess.run([sys.executable, str(script)], check=False, capture_output=True, text=True)
    assert proc.returncode == 0, proc.stderr
    assert "success_rate=" in proc.stdout
