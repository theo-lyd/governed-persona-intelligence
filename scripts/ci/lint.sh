#!/usr/bin/env bash
set -euo pipefail

find scripts tests -type f -name '*.sh' -print0 | xargs -0 -r bash -n
python -m compileall scripts tests >/dev/null
