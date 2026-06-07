# Comparison: OpenCode Trinity System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/trinity.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Trinity prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are OpenCode, an interactive general AI agent running on a user's computer."

**Decision:** `functional`.

---

## Layer 2: Tool Contract
**OpenCode text:** Implicit tool usage via workflow description.

**Decision:** `functional`.

---

## Layer 3: Task Framing
**OpenCode text:** "Proactiveness... Understand the user's requirements."

**Decision:** `strong`.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** "Markdown files named AGENTS.md usually contain the background... You should use this information."

**Decision:** `strong`.

---

## Layer 5: Investigation / Exploration Scaffold
**OpenCode text:** Extensive guidance on research, investigation, and planning.

**Decision:** `strong`.

---

## Layer 6: Edit Boundaries
**OpenCode text:** "Make MINIMAL changes... Follow the coding style of existing code."

**Decision:** `strong`.

---

## Layer 7: Validation Scaffold
**OpenCode text:** "Always use tools to implement your code changes... Test what you build, verify what you change."

**Decision:** `strong`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** "Security First... Never introduce code that exposes... secrets."

**Decision:** `moderate`.

---

## Layer 9: Output Contract / Final Answer
**OpenCode text:** Tone and style guidelines.

**Decision:** `strong`.

---

## Layer 10: Dynamic / Runtime Context
**OpenCode text:** Relies on runtime environment and injected context.

**Decision:** `functional`.

---

## Intermediary Conclusion

Observed:
Trinity has the best balanced base-prompt coverage among the shorter OpenCode variants: AGENTS.md awareness, investigation, minimal-change edit discipline, validation, and concise output are all represented.

Inferred:
Trinity is a useful compact reference for how much coding-agent behavior can be covered without becoming as verbose or aggressive as Beast/Anthropic.

Risk:
The trusted-input boundary remains only moderate. Security-first wording protects against leaking secrets, but it does not by itself classify file/web/tool text as untrusted data.

Candidate structure:
Use Trinity as a compact baseline for repo authority plus validation, then graft in S6-1 trusted-input boundary and C4/C9 validation-state reporting.

How to test:
Run prompt-injection and destructive-git fixtures against Trinity-like wording. The expected gap is that repo safety passes more often than untrusted-instruction handling.
