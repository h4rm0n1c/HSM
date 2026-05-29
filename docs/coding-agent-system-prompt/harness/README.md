Harness scaffold — minimal A/B experiment runner

Purpose
-------
This directory contains a minimal harness scaffold to run small, reproducible A/B experiments
for prompt changes (e.g., adding an executor header). It is intentionally small and conservative:

- does not require modifying baseline prompt files
- runs experiments in temporary clones of small fixtures
- supports a manual or automated agent runner (AGENT_RUNNER_CMD)
- records validation results and preserves run artifacts for inspection

What is included
----------------

- assemble_prompt.sh — helper to produce an assembled prompt (header + environment context + git state + baseline)
- run_trial.sh — top-level orchestrator for one trial (uses assemble_prompt.sh)
- apply_patch_to_repo.sh — helper to apply an agent-provided patch (supports agent_patch.patch or agent_patch.py)
- executor_header.txt — example executor header (candidate)
- fixtures/task-1/ — basic bug fix: add function returns a-b instead of a+b
- fixtures/task-1-dummy/ — same as task-1 with pre-written agent_patch.py for dry-run harness testing
- fixtures/scope-creep/ — bug fix with strict non-goals (don't touch helpers.py, no refactoring, no new files)
- fixtures/dirty-worktree/ — bug fix with uncommitted user changes the agent must preserve
- fixtures/prompt-injection/ — basic prompt injection: docstrings, base64, README, and comments
- fixtures/adversarial-prompt-injection/ — advanced prompt injection: zero-width spaces (U+200B), Unicode confusables, delayed invocation, HTML comment injection
- fixtures/fake-investigation/ — FM3: agent must read both files to find which has the bug (no guessing)
- fixtures/destructive-git/ — FM9: agent must avoid destructive git commands and preserve dirty user state
- fixtures/assumption-cascade/ — FM7: agent must verify assumptions before editing confusing but correct code
- fixtures/premature-commitment/ — FM5: agent must read enough of the call chain before fixing
- fixtures/over-paraphrasing/ — FM6: agent must preserve exact config path, not paraphrase it
- fixtures/context-overload/ — FM8: six modules, agent must find the one with the bug
- fixtures/task-abandonment/ — FM10: two bugs, agent must not give up after fixing the first

How to use (manual quick-start)
------------------------------

1. Pick a fixture: harness/fixtures/task-1 is an example.
2. Choose the baseline prompt file you want to test with (e.g. docs/coding-agent-system-prompt/reference-quantzhai-codex-core-qwenified.md).
3. Run a trial (local, no model) to exercise harness with the sample patch:

   bash harness/run_trial.sh task-1 executor <baseline-prompt-path> harness/executor_header.txt

   Notes:
   - The script will create a temp run directory and initialize a git repo for the fixture.
   - By default the script expects AGENT_RUNNER_CMD to be set to a command that reads a prompt from stdin
     and writes agent output to stdout. If AGENT_RUNNER_CMD is not set, the harness will pause and
     instruct you how to run your agent manually.
   - For a quick local test (no model) the run dir already contains harness/fixtures/task-1/agent_patch.py
     which will be detected and applied automatically by apply_patch_to_repo.sh.

Design notes
------------

- The harness purposely does NOT parse arbitrary agent output. Instead, it expects the agent to
  produce an explicit patch in one of two formats placed into the run directory:
  - agent_patch.patch — a git-style patch that `git apply` can consume, or
  - agent_patch.py — a small Python helper that applies deterministic edits (useful for local testing)

  This keeps the harness simple to integrate while supporting real agent outputs if you can
  configure the runner to produce an appropriate patch file.

Safety
------

- All runs are isolated to a temporary directory (no pushes).
- The harness will not perform network actions by default. If your agent requests escalation,
  the harness will record the request and stop.

Next steps
----------

- If you want, I can (1) polish the harness scripts to parse common agent patch shapes, or
  (2) add a short example that shows how to run a local QuantZhai runner with AGENT_RUNNER_CMD.

(End of file)
