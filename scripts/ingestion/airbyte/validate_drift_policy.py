from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
CONTRACT_DIR = ROOT / "src/ingestion/airbyte/contracts"


@dataclass
class DriftValidationResult:
    additive_allowed: bool
    missing_required_rejected: bool


def load_contract(name: str) -> dict:
    return json.loads((CONTRACT_DIR / name).read_text(encoding="utf-8"))


def validate_record(contract: dict, record: dict) -> tuple[bool, str]:
    required = {field["name"] for field in contract["required_fields"]}
    missing = [field for field in required if field not in record or record[field] in (None, "")]
    if missing:
        return False, f"missing required field(s): {','.join(sorted(missing))}"

    known_fields = required | {field["name"] for field in contract["optional_fields"]}
    additive = [field for field in record if field not in known_fields]
    if additive:
        mode = contract["drift_policy"]["additive_fields"]
        if mode == "reject_until_contract_update":
            return False, f"unexpected additive field(s): {','.join(sorted(additive))}"
    return True, "accepted"


def run_demo_validation() -> DriftValidationResult:
    web_contract = load_contract("web_events_json_v1.contract.json")
    txn_contract = load_contract("transactions_csv_v1.contract.json")

    web_record_additive = {
        "event_id": "e-1",
        "event_type": "page_view",
        "event_ts": "2026-04-09T10:10:10",
        "user_id": "u-1",
        "session_id": "s-1",
        "new_field_from_source": "allowed-in-payload"
    }
    web_ok, _ = validate_record(web_contract, web_record_additive)

    txn_record_missing = {
        "transaction_id": "t-1",
        "user_id": "u-1",
        "transaction_ts": "2026-04-09T10:10:10",
        "currency": "EUR"
    }
    txn_ok, _ = validate_record(txn_contract, txn_record_missing)

    return DriftValidationResult(
        additive_allowed=web_ok,
        missing_required_rejected=not txn_ok,
    )


if __name__ == "__main__":
    result = run_demo_validation()
    if result.additive_allowed and result.missing_required_rejected:
        print("PASS: additive and missing-field drift policy behavior validated")
    else:
        raise SystemExit("FAIL: drift policy behavior did not match contract policy")
