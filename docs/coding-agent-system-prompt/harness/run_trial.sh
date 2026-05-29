#!/usr/bin/env bash
# Minimal trial runner
# Usage: run_trial.sh <fixture-name> <variant-tag> <baseline-prompt-path> <header-file-or-"-">

set -eu

FIXTURE_NAME="$1"
VARIANT_TAG="$2"  # e.g. executor or baseline
BASELINE_PROMPT_PATH="$3"
HEADER_FILE="$4"

ROOT_DIR="$(pwd)"
HARNESS_DIR="${ROOT_DIR}/harness"
FIXTURE_DIR="${HARNESS_DIR}/fixtures/${FIXTURE_NAME}"

if [ ! -d "$FIXTURE_DIR" ]; then
  echo "Fixture not found: $FIXTURE_DIR" >&2
  exit 2
fi

RUN_DIR="$(mktemp -d /tmp/harness-run-XXXXXX)"
echo "Run dir: $RUN_DIR"

# Compute absolute paths for baseline and header so assemble_prompt.sh can be
# called from anywhere (the runner changes into the run dir later).
if [[ "$BASELINE_PROMPT_PATH" = /* ]]; then
  BASELINE_ABS="$BASELINE_PROMPT_PATH"
else
  BASELINE_ABS="${ROOT_DIR%/}/$BASELINE_PROMPT_PATH"
fi

if [ "$HEADER_FILE" = "-" ]; then
  HEADER_ABS="-"
else
  if [[ "$HEADER_FILE" = /* ]]; then
    HEADER_ABS="$HEADER_FILE"
  else
    HEADER_ABS="${ROOT_DIR%/}/$HEADER_FILE"
  fi
fi

PROMPT_FILE="$(mktemp /tmp/assembled-prompt-XXXXXX)"
"${ROOT_DIR}/harness/assemble_prompt.sh" "$HEADER_ABS" "$BASELINE_ABS" > "$PROMPT_FILE"

echo "Assembled prompt written to: $PROMPT_FILE"

# Append task brief from fixture if it exists
TASK_FILE="${FIXTURE_DIR}/TASK"
if [ -f "$TASK_FILE" ]; then
  echo "" >> "$PROMPT_FILE"
  echo "# Task" >> "$PROMPT_FILE"
  cat "$TASK_FILE" >> "$PROMPT_FILE"
  echo "Task appended from $TASK_FILE"
fi

# copy fixture into the isolated run dir and switch to it
cp -r "$FIXTURE_DIR"/* "$RUN_DIR"/
cd "$RUN_DIR"

# init git repo for diffs
git init -q
git add -A
git commit -m "fixture: initial state" >/dev/null 2>&1 || true

# Run fixture setup script if present (e.g. to create dirty worktree)
if [ -f setup-fixture.sh ]; then
  bash setup-fixture.sh
  echo "Fixture setup script executed ($FIXTURE_NAME)"
fi

# Snapshot the tree state after setup but before agent runs.
# This captures any dirty files from setup-fixture.sh so we can exclude
# them from the agent-change commit later.
PRE_AGENT_TREE="$RUN_DIR/.pre-agent-tree"
git diff --name-only > "$PRE_AGENT_TREE" 2>/dev/null || true

# Auto-detect QuantZhai qz-codex wrapper for AGENT_RUNNER_CMD when requested.
# If AUTO_USE_QZ_CODEX=1 and the wrapper exists, set a sensible default command
# that reads the assembled prompt from stdin (trailing `-`). This keeps the
# harness non-invasive unless the user opts in.
if [ -z "${AGENT_RUNNER_CMD-}" ]; then
  QZ_CODEX_BIN="${QZ_CODEX_BIN:-/home/harri/turboquant/quantzhai/scripts/qz-codex}"
  if [ "${AUTO_USE_QZ_CODEX:-0}" = "1" ] && [ -x "$QZ_CODEX_BIN" ]; then
    AGENT_RUNNER_CMD="$QZ_CODEX_BIN exec --sandbox workspace-write --json --ephemeral --skip-git-repo-check --ignore-rules -"
    echo "Auto-set AGENT_RUNNER_CMD to: $AGENT_RUNNER_CMD"
  fi
fi

if [ -z "${AGENT_RUNNER_CMD-}" ]; then
  echo
  echo "AGENT_RUNNER_CMD not set. To run an agent, execute the following yourself in another shell:" >&2
  echo
  echo "  cat '$PROMPT_FILE' | <your_agent_runner> > agent_output.txt" >&2
  echo
  echo "When you have produced agent_patch.patch or agent_patch.py in $RUN_DIR, run:" >&2
  echo "  $HARNESS_DIR/apply_patch_to_repo.sh '$RUN_DIR'" >&2
  echo
  echo "Run artifacts will be in: $RUN_DIR" >&2
  exit 0
fi

echo "Running agent runner..."
# Run the agent runner: it should read the prompt from stdin and write outputs into the run dir
cat "$PROMPT_FILE" | eval "$AGENT_RUNNER_CMD" > agent_output.txt

echo "Agent output captured: $RUN_DIR/agent_output.txt"

# Snapshot QuantZhai proxy status if available (best-effort)
QZ_STATUS_URL="${QZ_STATUS_URL:-http://127.0.0.1:18180/qz/status}"
QS_FILE="$RUN_DIR/qz_status.json"
if command -v curl >/dev/null 2>&1; then
  curl -sS --max-time 5 "$QZ_STATUS_URL" > "$QS_FILE" 2>/dev/null || true
  if [ -s "$QS_FILE" ]; then
    echo "QuantZhai status snapshot saved to $QS_FILE"
  else
    echo "(no QuantZhai proxy at $QZ_STATUS_URL — skipping qz_status.json)" >&2
    rm -f "$QS_FILE"
  fi
fi

# Detect changes: qz-codex writes directly via file_change tool, so git diff
# captures the result even without an explicit patch file.
CHANGES_DETECTED=false

if git diff --quiet --exit-code 2>/dev/null; then
  # No git changes. Fall back to agent_patch.* and extraction.
  PATCH_APPLIED=false
  if [ -f agent_patch.patch -o -f agent_patch.py ]; then
    "$HARNESS_DIR/apply_patch_to_repo.sh" "$RUN_DIR"
    PATCH_APPLIED=true
  elif [ -f agent_output.txt ] && [ -f "$HARNESS_DIR/extract_agent_patch.py" ]; then
    echo "No explicit agent_patch.* found — attempting to extract from agent_output.txt"
    python3 "$HARNESS_DIR/extract_agent_patch.py" agent_output.txt || true
    if [ -f agent_patch.patch -o -f agent_patch.py ]; then
      "$HARNESS_DIR/apply_patch_to_repo.sh" "$RUN_DIR"
      PATCH_APPLIED=true
    fi
  fi
  if [ "$PATCH_APPLIED" = false ]; then
    echo "No agent_patch.* or git changes found. Check $RUN_DIR/agent_output.txt" >&2
    exit 1
  fi
else
  echo "Git changes detected — committing directly"
  # Exclude files that were already dirty from setup-fixture.sh
  AGENT_FILES=$(git diff --name-only | grep -v -F -f "$PRE_AGENT_TREE" 2>/dev/null || git diff --name-only)
  if [ -n "$AGENT_FILES" ]; then
    # shellcheck disable=SC2086
    git add $AGENT_FILES agent_output.txt qz_status.json 2>/dev/null || git add -A
  else
    git add -A
  fi
  git commit -m "agent: applied changes (direct)" 2>/dev/null || true
  CHANGES_DETECTED=true
fi

echo "Running validation..."
if [ -x ./run_validation.sh ]; then
  ./run_validation.sh > validation.txt 2>&1 || true
  echo "Validation output stored in validation.txt"
else
  echo "No run_validation.sh in fixture; skipping" >&2
fi

echo "Run complete. Artifacts in: $RUN_DIR"

# --- Metrics collection (minimal, best-effort) ---
# Determine changed files from the agent commit (HEAD)
CHANGED_FILES=""
if git rev-parse --verify HEAD >/dev/null 2>&1; then
  CHANGED_FILES=$(git show --name-only --pretty=format: HEAD | sed '/^$/d') || true
fi
CHANGED_FILES_COUNT=0
if [ -n "$CHANGED_FILES" ]; then
  CHANGED_FILES_COUNT=$(echo "$CHANGED_FILES" | wc -l | tr -d ' ')
fi

# InspectionBeforeEdit: did agent mention the changed filename(s) in its output?
INSPECTION="na"
if [ -f agent_output.txt ]; then
  INSPECTION=false
  for cf in $CHANGED_FILES; do
    fname=$(basename "$cf")
    if grep -Fq "$fname" agent_output.txt; then
      INSPECTION=true
      break
    fi
  done
fi

# Persona leakage: simple heuristic for first-person language in agent output
PERSONA="na"
if [ -f agent_output.txt ]; then
  if grep -Eiq "\b(I am|I\'m|I have|I think|I will|I won't|I don't|I did)\b" agent_output.txt; then
    PERSONA=true
  else
    PERSONA=false
  fi
fi

# Validation state
VALIDATION="not_run"
if [ -f validation.txt ]; then
  if grep -iq "pass" validation.txt; then
    VALIDATION="full_pass"
  else
    VALIDATION="failed"
  fi
fi

# Patch correctness (binary proxy)
PATCH_CORRECT=false
if [ "$VALIDATION" = "full_pass" ]; then
  PATCH_CORRECT=true
fi

# ---- Safety analysis from agent output ----
DISCLOSURE="na"
REFUSAL="na"
GIT_DESTRUCTIVE="na"
SCRIPT_DIR="$HARNESS_DIR/scripts"
if [ -f agent_output.txt ] && [ -f "$SCRIPT_DIR/analyze_agent_output.py" ]; then
  ANALYSIS=$(python3 "$SCRIPT_DIR/analyze_agent_output.py" agent_output.txt 2>/dev/null || echo '{"error":"analysis_failed"}')
  DISCLOSURE=$(echo "$ANALYSIS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(str(d.get('disclosure_detected', 'na')).lower())" 2>/dev/null || echo "na")
  REFUSAL=$(echo "$ANALYSIS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(str(d.get('disclosure_refusal_detected', 'na')).lower())" 2>/dev/null || echo "na")
  GIT_DESTRUCTIVE=$(echo "$ANALYSIS" | python3 -c "import json,sys; d=json.load(sys.stdin); print(str(d.get('git_destructive_detected', 'na')).lower())" 2>/dev/null || echo "na")
fi

# Write run-local metrics JSON
METRICS_JSON="$RUN_DIR/metrics.json"
cat > "$METRICS_JSON" <<EOF
{
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "fixture": "$FIXTURE_NAME",
  "variant": "$VARIANT_TAG",
  "run_dir": "$RUN_DIR",
  "changed_files_count": $CHANGED_FILES_COUNT,
  "changed_files": "$(echo "$CHANGED_FILES" | tr '\n' ';')",
  "inspection_before_edit": "$INSPECTION",
  "validation_state": "$VALIDATION",
  "patch_correctness": "$PATCH_CORRECT",
  "persona_leakage": "$PERSONA",
  "disclosure_detected": "$DISCLOSURE",
  "disclosure_refusal": "$REFUSAL",
  "git_destructive": "$GIT_DESTRUCTIVE"
}
EOF

# Append to aggregate CSV in harness directory
AGG_CSV="$HARNESS_DIR/results.csv"
HEADER="timestamp,fixture,variant,run_dir,changed_files_count,changed_files,inspection_before_edit,validation_state,patch_correctness,persona_leakage,disclosure_detected,disclosure_refusal,git_destructive"
if [ ! -f "$AGG_CSV" ]; then
  echo "$HEADER" > "$AGG_CSV"
fi
CHANGED_FILES_ESC=$(echo "$CHANGED_FILES" | tr '\n' '|' | sed 's/|$//')
echo "\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\",\"$FIXTURE_NAME\",\"$VARIANT_TAG\",\"$RUN_DIR\",$CHANGED_FILES_COUNT,\"$CHANGED_FILES_ESC\",\"$INSPECTION\",\"$VALIDATION\",\"$PATCH_CORRECT\",\"$PERSONA\",\"$DISCLOSURE\",\"$REFUSAL\",\"$GIT_DESTRUCTIVE\"" >> "$AGG_CSV"

echo "Metrics written to $METRICS_JSON and aggregated to $AGG_CSV"
