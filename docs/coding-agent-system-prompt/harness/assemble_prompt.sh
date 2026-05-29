#!/usr/bin/env bash
# Assemble prompt from header, environment/git context, and baseline file.
# Usage: assemble_prompt.sh <header-file-or-"-"> <baseline-prompt-file>
#
# Environment info (S7-4) and git state (S7-5) are injected between
# the header and baseline if running inside a git repository.

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

# ---- Environment info (S7-4) ----
PLATFORM="$(uname -s)"
ARCH="$(uname -m)"
DATE="$(date +%Y-%m-%d)"
WORKDIR="$(pwd)"
SHELL_PATH="${SHELL:-unknown}"
MODEL="${MODEL_NAME:-unknown}"
echo "# Environment (S7-4)"
echo "Platform: ${PLATFORM} (${ARCH})"
echo "Date: ${DATE}"
echo "Working directory: ${WORKDIR}"
echo "Shell: ${SHELL_PATH}"
echo "Model: ${MODEL}"
echo

# ---- Git state (S7-5) ----
if git rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH="$(git branch --show-current 2>/dev/null || echo "detached")"
  echo "# Git state (S7-5)"
  echo "Branch: ${BRANCH}"
  GIT_MODIFIED="$(git diff --name-only 2>/dev/null || true)"
  GIT_UNTRACKED="$(git ls-files --others --exclude-standard 2>/dev/null || true)"
  if [ -n "${GIT_MODIFIED}" ]; then
    COUNT=$(echo "${GIT_MODIFIED}" | wc -l)
    echo "Modified files: ${COUNT}"
    echo "${GIT_MODIFIED}" | sed 's/^/  /'
  else
    echo "Modified files: none"
  fi
  if [ -n "${GIT_UNTRACKED}" ]; then
    COUNT=$(echo "${GIT_UNTRACKED}" | wc -l)
    echo "Untracked files: ${COUNT}"
    echo "${GIT_UNTRACKED}" | sed 's/^/  /'
  else
    echo "Untracked files: none"
  fi
  echo
fi

cat "$BASELINE_FILE"
