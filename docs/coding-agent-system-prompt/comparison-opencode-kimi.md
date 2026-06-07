# Comparison: OpenCode Kimi System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/kimi.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Kimi prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are opencode, an interactive CLI tool..."

**Decision:** `functional`.

---

## Layer 2: Tool Contract
**OpenCode text:** Implicit.

**Decision:** `functional`.

---

## Layer 3: Task Framing
**OpenCode text:** Concise, direct, minimal output requirement.

**Decision:** `strong`.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** "When making changes to files, first understand the file's code conventions."

**Decision:** `moderate`.

---

## Layer 5: Investigation / Exploration Scaffold
**OpenCode text:** "Use the available search tools... use one tool per message."

**Decision:** `moderate`.

---

## Layer 6: Edit Boundaries
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

---

## Layer 7: Validation Scaffold
**OpenCode text:** "Verify the solution if possible with tests... run the lint and typecheck commands..."

**Decision:** `strong`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** "Always follow security best practices."

**Decision:** `moderate`.

---

## Layer 9: Output Contract / Final Answer
**OpenCode text:** Explicit sections on Tone and Style. Concise, direct, minimal output requirement.

**Decision:** `strong`.

---

## Layer 10: Dynamic / Runtime Context
**OpenCode text:** Relies on runtime environment and injected context.

**Decision:** `functional`.

---

## Intermediary Conclusion

Observed:
Kimi is compact and direct. It has useful validation wording and a basic convention-following rule, but lacks explicit edit-boundary and repo-authority detail.

Inferred:
Kimi is a concise-output reference, not a strong safety or shared-worktree reference.

Risk:
The prompt's compactness hides important missing structures: AGENTS.md hierarchy, dirty-worktree preservation, destructive git guard, trusted-input boundary, and validation-state honesty.

Candidate structure:
Keep Kimi's concise final-answer pressure only if paired with richer editing and authority scaffolds from GPT/Codex/Trinity.

How to test:
Run Kimi-like wording against over-paraphrasing and final-answer verbosity tests, while expecting failures on dirty-worktree and prompt-injection cases unless extra scaffolds are added.
