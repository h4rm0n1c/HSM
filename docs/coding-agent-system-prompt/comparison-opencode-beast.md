# Comparison: OpenCode Beast System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/beast.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Beast prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are opencode, an agent..."

**Our research validates:**
- **Functional framing**.

**Decision:** `adequate`.

---

## Layer 2: Tool Contract
**OpenCode text:** Implicit in workflow descriptions (TodoWrite, WebFetch, Task).

**Decision:** `functional`.

---

## Layer 3: Task Framing
**OpenCode text:** "You MUST iterate and keep going until the problem is solved." "THE PROBLEM CAN NOT BE SOLVED WITHOUT EXTENSIVE INTERNET RESEARCH."

**Our research validates:**
- **High-bar task completion**: Even more prescriptive and imperative than `anthropic.txt`.

**Our research challenges:**
- **Over-engineering risk**: Explicitly mandates extensive internet research, which may be excessive for trivial tasks.

**Decision:** `aggressive`.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

---

## Layer 5: Investigation / Exploration Scaffold
**OpenCode text:** Highly prescriptive recursive research workflow.

**Decision:** `Strong`.

---

## Layer 6: Edit Boundaries
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

---

## Layer 7: Validation Scaffold
**OpenCode text:** Rigorous requirement for testing ("test your code rigorously... do it many times").

**Decision:** `strong`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `missing`.

---

## Layer 9: Output Contract / Final Answer
**OpenCode text:** Workflow-driven output.

**Decision:** `functional`.

---

## Layer 10: Dynamic / Runtime Context
**OpenCode text:** Relies on runtime environment and injected context.

**Decision:** `functional`.

---

## Intermediary Conclusion

Observed:
Beast maximizes persistence, recursive internet research, exhaustive planning, visible todo updates, and repeated testing. It is intentionally high-pressure and high-token.

Inferred:
Beast is a stress-test prompt, not a general coding-agent baseline. Its useful finding is that completion pressure can be made explicit, but the wording is too broad for routine local coding work.

Risk:
Universal external research, "perfect" solution language, automatic `.env` creation, and 2000-line read requirements can directly conflict with scope discipline, file-creation guardrails, and trusted-input minimization.

Candidate structure:
Reject the full Beast workflow. Extract only bounded task persistence and "actually make the tool call you said you would make" as narrow reliability rules.

How to test:
Use Beast as an upper-bound comparison for token cost and overreach. It should be evaluated especially against scope-creep, file-creation, and web-research-overuse fixtures.
