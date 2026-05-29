#!/usr/bin/env bash
# Print a shell export command that sets AGENT_RUNNER_CMD to use qz-codex.
# Usage:
#   eval "$(pwd)/docs/coding-agent-system-prompt/harness/print_qz_codex_export.sh [model]"
# or
#   ./docs/coding-agent-system-prompt/harness/print_qz_codex_export.sh [model]

QZ_CODEX_BIN="${QZ_CODEX_BIN:-/home/harri/turboquant/quantzhai/scripts/qz-codex}"
MODEL="${1:-prompt-compiler}"

if [ ! -x "$QZ_CODEX_BIN" ]; then
  echo "# qz-codex not found at $QZ_CODEX_BIN" >&2
  exit 2
fi

printf 'export AGENT_RUNNER_CMD="%s exec -m %s --json --ephemeral --skip-git-repo-check --ignore-rules -"\n' "$QZ_CODEX_BIN" "$MODEL"
