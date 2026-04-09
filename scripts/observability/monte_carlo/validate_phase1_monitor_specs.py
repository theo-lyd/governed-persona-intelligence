from __future__ import annotations

from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[3]
SPEC_PATH = ROOT / "src/observability/monte_carlo/phase1/raw_ingestion_monitors.yaml"
REQUIRED_TYPES = {"freshness", "volume"}
REQUIRED_TABLES = {
    "GPI_DEV.RAW.RAW_WEB_EVENTS_JSON",
    "GPI_DEV.RAW.RAW_TRANSACTIONS_CSV",
}


def validate_spec() -> None:
    payload = yaml.safe_load(SPEC_PATH.read_text(encoding="utf-8"))
    monitors = payload.get("monitors", [])
    if not monitors:
        raise SystemExit("FAIL: no monitors defined")

    seen = {(m["table"], m["type"]) for m in monitors}
    for table in REQUIRED_TABLES:
        for monitor_type in REQUIRED_TYPES:
            if (table, monitor_type) not in seen:
                raise SystemExit(f"FAIL: missing {monitor_type} monitor for {table}")

    print("PASS: Phase I monitor specs include freshness and volume for both raw tables")


if __name__ == "__main__":
    validate_spec()
