#!/usr/bin/env bash
set -euo pipefail

tag="${1:-}"

if [[ -z "$tag" ]]; then
  echo "release tag is required" >&2
  exit 1
fi

if [[ "$tag" =~ ^phase[0-9]+-b[0-9]+\.[0-9]+-[0-9]{8}$ ]]; then
  echo "valid batch evidence tag: $tag"
  exit 0
fi

if [[ "$tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-rc\.[0-9]+)?$ ]]; then
  echo "valid semantic release tag: $tag"
  exit 0
fi

echo "invalid release tag: $tag" >&2
exit 1
