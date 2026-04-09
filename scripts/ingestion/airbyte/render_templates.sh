#!/usr/bin/env bash
set -euo pipefail

# Render Airbyte JSON templates by expanding ${VAR} placeholders.
# Requires envsubst (gettext-base).

if ! command -v envsubst >/dev/null 2>&1; then
  echo "envsubst is required. Install gettext-base and retry." >&2
  exit 1
fi

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <template_dir> <output_dir>" >&2
  exit 1
fi

template_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

for template in "$template_dir"/*.template.json; do
  out_file="$output_dir/$(basename "${template/.template.json/.json}")"
  envsubst <"$template" >"$out_file"
  echo "rendered $out_file"
done
