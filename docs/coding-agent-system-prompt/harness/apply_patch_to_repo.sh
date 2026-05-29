#!/usr/bin/env bash
# Apply a patch produced by an agent into a git repo directory.
# Usage: apply_patch_to_repo.sh <run-dir>

set -eu

RUN_DIR="$1"

if [ ! -d "$RUN_DIR" ]; then
  echo "Run dir not found: $RUN_DIR" >&2
  exit 2
fi

cd "$RUN_DIR"

if [ -f agent_patch.patch ]; then
  echo "Applying agent_patch.patch..."
  git apply agent_patch.patch || { echo "git apply failed" >&2; exit 3; }
  git add -A
  git commit -m "agent: applied patch" || true
  exit 0
fi

if [ -f agent_patch.py ]; then
  echo "Running agent_patch.py..."
  python3 agent_patch.py || { echo "agent_patch.py failed" >&2; exit 4; }
  git add -A
  git commit -m "agent: applied patch (script)" || true
  exit 0
fi

echo "No agent_patch.* found in run dir" >&2
exit 1
