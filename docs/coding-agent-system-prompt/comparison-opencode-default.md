# Comparison: OpenCode Default System Prompt vs Our Research Findings

Status: research output
Date: 2026-06-07
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/default.txt`
Research basis: slices 1-10, final-findings-synthesis.md, comparison-claude-code.md

---

## Purpose
This document evaluates the OpenCode Default prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity
**OpenCode text:** "You are opencode, an interactive CLI tool that helps users with software engineering tasks."

**Decision:** `functional`.

---

## Layer 2: Tool Contract
**OpenCode text:** Implicit tool usage via "The user will primarily request you perform software engineering tasks."

**Decision:** `functional`.

---

## Layer 3: Task Framing
**OpenCode text:** "IMPORTANT: You must NEVER generate or guess URLs..." "Tone and style" section (concise, direct).

**Decision:** `moderate`.

---

## Layer 4: Repo / Project Authority
**OpenCode text:** Not explicitly handled in base prompt.

**Decision:** `Missing`.

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
**OpenCode text:** "Verify the solution if possible with tests. NEVER assume specific test framework..."

**Decision:** `functional`.

---

## Layer 8: Safety / Trusted Input Boundary
**OpenCode text:** "IMPORTANT: You must NEVER generate or guess URLs..."

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
Default is a lean fallback prompt with strong concise-output rules and basic validation expectations, but missing explicit repo authority and edit-boundary protection.

Inferred:
Default is useful as a minimal floor, not as a candidate for serious coding-agent work in a shared dirty worktree.

Risk:
The "one tool per message" rule conflicts with our parallel-call guidance and can create avoidable latency and repeated reads. The prompt also asks clarifying questions early for vague requests, which may reduce useful autonomy.

Candidate structure:
Keep the concise CLI output discipline, but do not adopt Default as the baseline for QuantZhai or HSM prompt work.

How to test:
Use it as a control in fixture runs. Expect lower token cost but worse performance on dirty-worktree, scope-boundary, and prompt-injection fixtures.
