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

if [[ ! -d "$template_dir" ]]; then
  echo "Template directory not found: $template_dir" >&2
  exit 1
fi

# Collect required placeholders from templates and fail if any env var is missing.
mapfile -t required_vars < <(
  grep -rho '\${[A-Z0-9_][A-Z0-9_]*}' "$template_dir"/*.template.json \
    | sed -E 's/^\$\{([A-Z0-9_]+)\}$/\1/' \
    | sort -u
)

missing_vars=()
for var_name in "${required_vars[@]}"; do
  if [[ -z "${!var_name:-}" ]]; then
    missing_vars+=("$var_name")
  fi
done

if [[ ${#missing_vars[@]} -gt 0 ]]; then
  echo "Missing required environment variables:" >&2
  printf ' - %s\n' "${missing_vars[@]}" >&2
  exit 1
fi

mkdir -p "$output_dir"

for template in "$template_dir"/*.template.json; do
  out_file="$output_dir/$(basename "${template/.template.json/.json}")"
  envsubst <"$template" >"$out_file"
  echo "rendered $out_file"
done
