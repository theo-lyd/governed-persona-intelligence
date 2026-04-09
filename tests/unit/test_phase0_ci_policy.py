from __future__ import annotations

import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]


def run_command(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        args,
        cwd=ROOT,
        text=True,
        capture_output=True,
        check=False,
    )


def test_pr_clone_plan_emits_zero_copy_clone_sql() -> None:
    result = run_command(
        "bash",
        "scripts/ci/pr_clone_plan.sh",
        "--pr-number",
        "42",
        "--source-database",
        "GPI_DEV",
        "--source-schema",
        "RAW",
    )

    assert result.returncode == 0, result.stderr
    assert "PR_42_GPI_DEV" in result.stdout
    assert "CREATE OR REPLACE TRANSIENT DATABASE PR_42_GPI_DEV CLONE GPI_DEV;" in result.stdout
    assert "CREATE OR REPLACE TRANSIENT SCHEMA PR_42_GPI_DEV.RAW CLONE GPI_DEV.RAW;" in result.stdout


def test_release_tag_validator_accepts_batch_and_semantic_tags() -> None:
    batch_result = run_command("bash", "scripts/ci/check_release_tag.sh", "phase0-b0.2-20260409")
    release_result = run_command("bash", "scripts/ci/check_release_tag.sh", "v0.2.0-rc.1")

    assert batch_result.returncode == 0, batch_result.stderr
    assert release_result.returncode == 0, release_result.stderr


def test_release_tag_validator_rejects_invalid_tags() -> None:
    result = run_command("bash", "scripts/ci/check_release_tag.sh", "phase0-beta")

    assert result.returncode != 0
    assert "invalid release tag" in result.stderr
