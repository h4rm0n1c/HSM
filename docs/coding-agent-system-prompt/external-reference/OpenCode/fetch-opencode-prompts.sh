#!/bin/sh
set -eu

BASE_URL="https://raw.githubusercontent.com/anomalyco/opencode/dev"
OUT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

fetch_one() {
  src="$1"
  dest="$OUT_DIR/$2"
  mkdir -p "$(dirname -- "$dest")"
  curl -fsSL "$BASE_URL/$src" -o "$dest"
}

fetch_one "packages/opencode/src/session/system.ts" "source/packages/opencode/src/session/system.ts"
fetch_one "packages/opencode/src/session/llm/request.ts" "source/packages/opencode/src/session/llm/request.ts"
fetch_one "packages/opencode/src/session/prompt/default.txt" "source/packages/opencode/src/session/prompt/default.txt"
fetch_one "packages/opencode/src/session/prompt/anthropic.txt" "source/packages/opencode/src/session/prompt/anthropic.txt"
fetch_one "packages/opencode/src/session/prompt/beast.txt" "source/packages/opencode/src/session/prompt/beast.txt"
fetch_one "packages/opencode/src/session/prompt/gemini.txt" "source/packages/opencode/src/session/prompt/gemini.txt"
fetch_one "packages/opencode/src/session/prompt/gpt.txt" "source/packages/opencode/src/session/prompt/gpt.txt"
fetch_one "packages/opencode/src/session/prompt/kimi.txt" "source/packages/opencode/src/session/prompt/kimi.txt"
fetch_one "packages/opencode/src/session/prompt/codex.txt" "source/packages/opencode/src/session/prompt/codex.txt"
fetch_one "packages/opencode/src/session/prompt/trinity.txt" "source/packages/opencode/src/session/prompt/trinity.txt"
fetch_one "packages/opencode/src/session/prompt/max-steps.txt" "source/packages/opencode/src/session/prompt/max-steps.txt"
fetch_one "packages/opencode/src/agent/agent.ts" "source/packages/opencode/src/agent/agent.ts"
fetch_one "packages/opencode/src/agent/generate.txt" "source/packages/opencode/src/agent/generate.txt"
fetch_one "packages/opencode/src/agent/prompt/explore.txt" "source/packages/opencode/src/agent/prompt/explore.txt"
fetch_one "packages/opencode/src/agent/prompt/compaction.txt" "source/packages/opencode/src/agent/prompt/compaction.txt"
fetch_one "packages/opencode/src/agent/prompt/title.txt" "source/packages/opencode/src/agent/prompt/title.txt"
fetch_one "packages/opencode/src/agent/prompt/summary.txt" "source/packages/opencode/src/agent/prompt/summary.txt"
fetch_one "packages/opencode/src/command/index.ts" "source/packages/opencode/src/command/index.ts"
fetch_one "packages/opencode/src/command/template/initialize.txt" "source/packages/opencode/src/command/template/initialize.txt"
fetch_one "packages/opencode/src/command/template/review.txt" "source/packages/opencode/src/command/template/review.txt"
fetch_one "packages/opencode/src/tool/task.ts" "source/packages/opencode/src/tool/task.ts"
fetch_one "packages/opencode/src/tool/task.txt" "source/packages/opencode/src/tool/task.txt"
fetch_one "packages/opencode/src/tool/shell/prompt.ts" "source/packages/opencode/src/tool/shell/prompt.ts"
fetch_one "packages/opencode/src/tool/shell/shell.txt" "source/packages/opencode/src/tool/shell/shell.txt"

cat > "$OUT_DIR/source/UPSTREAM.txt" <<'EOF'
Repository: anomalyco/opencode
Branch/ref: dev
Captured by: docs/coding-agent-system-prompt/external-reference/OpenCode/fetch-opencode-prompts.sh
Purpose: source snapshot for HSM coding-agent system prompt research
EOF

find "$OUT_DIR/source" -type f | LC_ALL=C sort
