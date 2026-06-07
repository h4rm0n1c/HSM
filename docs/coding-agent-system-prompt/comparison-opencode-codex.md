# Comparison: OpenCode Codex System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/codex.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Codex prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are OpenCode, the best coding agent on the planet." "Interactive CLI tool."

**Our research validates:**
- **Role Identity**: Clear role and job scope.

**Our research challenges:**
- **Persona contamination**: "Best coding agent on the planet" is slight persona/boastful framing.

**Decision:** `functional`.

---

## Layer 2: Tool Contract
**OpenCode text:** Detailed instructions for TodoWrite, WebFetch, Task tools.

**Our research validates:**
- **Tool-Split Upfront**: Defines usage of tools clearly.

**Decision:** `strong`.

---

## Layer 3: Task Framing
**OpenCode text:** "IMPORTANT: You must NEVER generate or guess URLs..." "Professional objectivity" section.

**Our research validates:**
- **Anti-agreement**: Strong "Professional Objectivity" section prioritizes truth over user agreement.

**Decision:** `strong`.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

---

## Layer 5: Investigation / Exploration Scaffold
**OpenCode text:** Detailed tool-use policies (Task tool, WebFetch).

**Decision:** `strong`.

---

## Layer 6: Edit Boundaries
**OpenCode text:** "NEVER create files unless they're absolutely necessary... ALWAYS prefer editing an existing file."

**Our research validates:**
- **Edit discipline**: Strong edit/create boundary.

**Decision:** `strong`.

---

## Layer 7: Validation Scaffold
**OpenCode text:** TodoWrite tool used for tracking.

**Decision:** `functional`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** "IMPORTANT: You must NEVER generate or guess URLs... except for helping... programming."

**Our research challenges:**
- **Lack of trusted boundary**: Does not distinguish data from instructions.

**Decision:** `moderate`.

---

## Layer 9: Output Contract / Final Answer
**OpenCode text:** Explicit sections on Tone and Style. Channel clarity (output outside tool use).

**Decision:** `strong`.

---

## Layer 10: Dynamic / Runtime Context
**OpenCode text:** Relies on runtime environment and injected context.

**Decision:** `functional`. Follows Rule Zero.

---

## Intermediary Conclusion

Observed:
The Codex variant is unusually strong on professional objectivity, parallel tool use, dirty-worktree preservation, file creation restraint, and user-facing output style. It also contains explicit guidance that text outside tool use is visible to the user.

Inferred:
This variant is the clearest OpenCode source for anti-agreement wording. It operationalizes the HSM anti-agreement harness in a coding-agent register without requiring a heavy claim-classification table.

Risk:
The "best coding agent on the planet" identity line conflicts slightly with professional objectivity. Repo authority is also incomplete: the base prompt does not define AGENTS.md scope, nested precedence, or source-boundary rules.

Candidate structure:
Adopt "professional objectivity" as a core prompt section, but pair it with a non-boastful executor identity and explicit AGENTS.md/trusted-input hierarchy.

How to test:
Use a fixture where the user asserts a plausible but wrong diagnosis. Compare whether Codex-style professional objectivity reduces agreement-driven edits relative to a neutral baseline.
