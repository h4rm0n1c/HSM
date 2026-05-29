#!/usr/bin/env bash
# Assemble prompt from header and baseline file.
# Usage: assemble_prompt.sh <header-file-or-"-"> <baseline-prompt-file>

set -eu

HEADER_FILE="$1"
BASELINE_FILE="$2"

if [ "$HEADER_FILE" = "-" ]; then
  cat "$BASELINE_FILE"
  exit 0
fi

if [ ! -f "$BASELINE_FILE" ]; then
  echo "Baseline prompt not found: $BASELINE_FILE" >&2
  exit 2
fi

if [ -f "$HEADER_FILE" ]; then
  cat "$HEADER_FILE"
  echo
else
  echo "# (no header)" >&2
fi

cat "$BASELINE_FILE"
