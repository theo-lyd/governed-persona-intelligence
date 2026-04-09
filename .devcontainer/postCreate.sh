#!/usr/bin/env bash
set -euo pipefail

python -m pip --version
python -m pip list --format=columns | grep -E "(snowflake|dbt)" || true

echo "Devcontainer dependencies installed."
