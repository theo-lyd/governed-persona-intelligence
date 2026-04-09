from __future__ import annotations

import csv
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]
DEFAULT_RUN_FILE = ROOT / "docs/phases/phase1/evidence/i1c-load-success-runs.csv"


def evaluate(path: Path) -> tuple[int, int, float, bool]:
    rows = list(csv.DictReader(path.read_text(encoding="utf-8").splitlines()))
    if not rows:
        raise ValueError("No run records found")

    total = len(rows)
    passed = sum(1 for row in rows if row["status"].strip().upper() == "SUCCESS")
    rate = passed / total

    recent = rows[-5:]
    five_consecutive = len(recent) == 5 and all(
        row["status"].strip().upper() == "SUCCESS" for row in recent
    )
    return total, passed, rate, five_consecutive


def main() -> None:
    total, passed, rate, five_consecutive = evaluate(DEFAULT_RUN_FILE)
    print(f"total_runs={total}")
    print(f"passed_runs={passed}")
    print(f"success_rate={rate:.4f}")
    print(f"five_consecutive_success={str(five_consecutive).lower()}")


if __name__ == "__main__":
    main()
