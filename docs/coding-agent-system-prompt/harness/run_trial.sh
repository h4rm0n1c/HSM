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

# copy fixture
cp -r "$FIXTURE_DIR"/* "$RUN_DIR"/
cd "$RUN_DIR"

# init git repo for diffs
git init -q
git add -A
git commit -m "fixture: initial state" >/dev/null 2>&1 || true

PROMPT_FILE="$(mktemp /tmp/assembled-prompt-XXXXXX)
"
"${ROOT_DIR}/harness/assemble_prompt.sh" "$HEADER_FILE" "$BASELINE_PROMPT_PATH" > "$PROMPT_FILE"

echo "Assembled prompt written to: $PROMPT_FILE"

# Auto-detect QuantZhai qz-codex wrapper for AGENT_RUNNER_CMD when requested.
# If AUTO_USE_QZ_CODEX=1 and the wrapper exists, set a sensible default command
# that reads the assembled prompt from stdin (trailing `-`). This keeps the
# harness non-invasive unless the user opts in.
if [ -z "${AGENT_RUNNER_CMD-}" ]; then
  QZ_CODEX_BIN="${QZ_CODEX_BIN:-/home/harri/turboquant/quantzhai/scripts/qz-codex}"
  if [ "${AUTO_USE_QZ_CODEX:-0}" = "1" ] && [ -x "$QZ_CODEX_BIN" ]; then
    AGENT_RUNNER_CMD="$QZ_CODEX_BIN exec -m prompt-compiler --json --ephemeral --skip-git-repo-check --ignore-rules -"
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

# The harness does not try to parse arbitrary output. Expect the agent to produce agent_patch.patch.
# The harness does not try to parse arbitrary output. Expect the agent to produce agent_patch.patch.
if [ -f agent_patch.patch -o -f agent_patch.py ]; then
  "$HARNESS_DIR/apply_patch_to_repo.sh" "$RUN_DIR"
else
  # Try to extract a patch from the agent output if possible.
  if [ -f agent_output.txt ] && [ -f "$HARNESS_DIR/extract_agent_patch.py" ]; then
    echo "No explicit agent_patch.* found — attempting to extract from agent_output.txt"
    python3 "$HARNESS_DIR/extract_agent_patch.py" agent_output.txt || true
  fi

  if [ -f agent_patch.patch -o -f agent_patch.py ]; then
    "$HARNESS_DIR/apply_patch_to_repo.sh" "$RUN_DIR"
  else
    echo "No agent_patch.* found after runner or extraction. Check $RUN_DIR/agent_output.txt" >&2
    exit 1
  fi
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
  "persona_leakage": "$PERSONA"
}
EOF

# Append to aggregate CSV in harness directory
AGG_CSV="$HARNESS_DIR/results.csv"
if [ ! -f "$AGG_CSV" ]; then
  echo "timestamp,fixture,variant,run_dir,changed_files_count,changed_files,inspection_before_edit,validation_state,patch_correctness,persona_leakage" > "$AGG_CSV"
fi
CHANGED_FILES_ESC=$(echo "$CHANGED_FILES" | tr '\n' '|' | sed 's/|$//')
echo "\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\",\"$FIXTURE_NAME\",\"$VARIANT_TAG\",\"$RUN_DIR\",$CHANGED_FILES_COUNT,\"$CHANGED_FILES_ESC\",\"$INSPECTION\",\"$VALIDATION\",\"$PATCH_CORRECT\",\"$PERSONA\"" >> "$AGG_CSV"

echo "Metrics written to $METRICS_JSON and aggregated to $AGG_CSV"
