# Comparison: OpenCode Gemini System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/gemini.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Gemini prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are opencode, an interactive CLI agent specializing in software engineering tasks."

**Decision:** `functional`.

---

## Layer 2: Tool Contract
**OpenCode text:** Implicit tool usage via workflow description.

**Decision:** `functional`.

---

## Layer 3: Task Framing
**OpenCode text:** "Proactiveness: Fulfill the user's request thoroughly..." "Core Mandates: Conventions... Style & Structure".

**Decision:** `strong`.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** "Conventions: Rigorously adhere to existing project conventions... analyze surrounding code... first."

**Decision:** `strong`.

---

## Layer 5: Investigation / Exploration Scaffold
**OpenCode text:** "1. Understand: Think about the user's request... use 'grep' and 'glob' search tools extensively."

**Decision:** `strong`.

---

## Layer 6: Edit Boundaries
**OpenCode text:** "Do Not revert changes... Only revert changes made by you if they have resulted in an error."

**Decision:** `moderate`.

---

## Layer 7: Validation Scaffold
**OpenCode text:** "4. Verify (Tests): ... Identify the correct test commands... 5. Verify (Standards): ... execute the project-specific build, linting and type-checking..."

**Decision:** `strong`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** "Security First: Always apply security best practices... Never introduce code that exposes... secrets."

**Decision:** `moderate`.

---

## Layer 9: Output Contract / Final Answer
**OpenCode text:** Tone and style (Concise & Direct, Minimal Output).

**Decision:** `strong`.

---

## Layer 10: Dynamic / Runtime Context
**OpenCode text:** Relies on runtime environment and injected context.

**Decision:** `functional`.

---

## Intermediary Conclusion

Observed:
Gemini is strong on conventions, local library verification, project style, tests, lint/typecheck, and non-reversion of user changes. It is one of the better OpenCode variants for conventional software engineering tasks.

Inferred:
Its main contribution is explicit convention-following as a first-class mandate. That maps well to C3/C8 evidence-before-edit and M12 existing-change preservation.

Risk:
It includes a plan-approval gate for new applications and asks about broad validation when unsure. That may be appropriate for interactive UX generation but too interruptive for autonomous non-interactive coding runs.

Candidate structure:
Adopt the convention/libraries/style mandates, but make approval gates mode-aware rather than universal.

How to test:
Run library-availability and existing-convention fixtures. The expected benefit is fewer invented dependencies and fewer stylistically foreign edits.
