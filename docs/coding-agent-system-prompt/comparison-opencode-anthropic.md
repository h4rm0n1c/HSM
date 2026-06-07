# Comparison: OpenCode Anthropic System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/anthropic.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Anthropic prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are opencode, an agent - please keep going until the user’s query is completely resolved..."

**Our research validates:**
- **Executor-as-Data/Action**: Not persona-based. Functional framing.

**Our research challenges:**
- **Weak identity**: Minimal framing compared to QuantZhai's role/model/harness naming.

**Gaps:**
- C26 (subject identity prohibition): Not explicitly defined, though functional framing helps.

**Decision:** `adequate`.

---

## Layer 2: Tool Contract
**OpenCode text:** Uses general "available tools" reference. No specific tool-use contract or parallel-call guidance in the base prompt.

**Our research validates:**
- Relies on external, runtime-injected tools.

**Our research challenges:**
- **Lack of explicit guidance**: Missing explicit parallel-call rules or tool-name disclosure limits.

**Gaps:**
- M2 (parallel guidance): Missing in base prompt.
- M1 (tool name non-disclosure): Missing.

**Decision:** `weak in base prompt`. Relies on external tool definitions.

---

## Layer 3: Task Framing
**OpenCode text:** "You MUST iterate and keep going until the problem is solved." "Take your time and think through every step..."

**Our research validates:**
- **High-bar task completion**: Rigorous, recursive definition of "done."

**Our research challenges:**
- **Over-engineering risk**: Encourages exhaustive investigation, potentially bypassing trivial/direct solutions.

**Gaps:**
- C2 (over-engineering guard): Missing.

**Decision:** `aggressive`. Very high bar for completion.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

---

## Layer 5: Investigation / Exploration Scaffold
**OpenCode text:** Extensive workflow for recursive web/code research.

**Decision:** `Strong`.

---

## Layer 6: Edit Boundaries
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

---

## Layer 7: Validation Scaffold
**OpenCode text:** Embedded in recursive workflow (Test frequently, iterate until root cause fixed).

**Decision:** `functional`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** Mentions internet research requirement, but lacks general data-vs-instruction boundary markers.

**Our research challenges:**
- **Lack of trusted boundary**: Does not distinguish data from instructions in repo/web inputs.

**Decision:** `missing`.

---

## Layer 9: Output Contract / Final Answer
**OpenCode text:** Workflow-driven output.

**Decision:** `functional`.

---

## Layer 10: Dynamic / Runtime Context
**OpenCode text:** Relies on runtime environment and injected context (reminders).

**Decision:** `functional`. Follows Rule Zero (what vs how).

---

## Intermediary Conclusion

Observed:
The Anthropic variant is dominated by persistence, recursive completion, web research, and TodoWrite/Task usage. It has strong "do not stop early" pressure but weak base-prompt coverage for edit boundaries, repo authority, and trusted-input handling.

Inferred:
Its useful contribution is not a full prompt shape; it is a high-bar completion slice for tasks where task abandonment is the dominant risk.

Risk:
The prompt overgeneralizes internet research and exhaustive iteration. For local coding tasks, that can cause token waste, scope creep, and unnecessary dependency on external sources.

Candidate structure:
Extract only a bounded persistence rule: keep going until the local task is implemented, validated, and reported, unless blocked. Do not adopt universal web-research requirements.

How to test:
Run task-abandonment and context-overload fixtures with and without the high-bar persistence wording. Track completion rate, token cost, and irrelevant research behavior.
