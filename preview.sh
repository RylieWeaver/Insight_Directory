#!/bin/sh
set -eu
cd "$(dirname "$0")"
export INSIGHT_DASHBOARD_DOCS_DIR="$PWD"
preview_dir=$(mktemp -d "${TMPDIR:-/tmp}/insight-dashboard-preview.XXXXXX")
trap 'rm -rf "$preview_dir"' EXIT
cp mkdocs.yml "$preview_dir/mkdocs.yml"
uv tool run --from 'mkdocs==1.6.1' mkdocs serve \
  --config-file "$preview_dir/mkdocs.yml" \
  --dev-addr 127.0.0.1:8000 --open "$@"
