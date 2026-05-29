#!/usr/bin/env bash
# Move the duplicate print_qz_codex_export.sh into the harness directory and
# remove the extra nested docs path. Run this from the repo root.

set -eu

SRC="docs/coding-agent-system-prompt/docs/coding-agent-system-prompt/harness/print_qz_codex_export.sh"
DST_DIR="docs/coding-agent-system-prompt/harness"
DST="$DST_DIR/print_qz_codex_export.sh"

if [ ! -f "$SRC" ]; then
  echo "Source not found: $SRC" >&2
  exit 2
fi

mkdir -p "$DST_DIR"
mv "$SRC" "$DST"
chmod +x "$DST"
echo "Moved $SRC -> $DST"
