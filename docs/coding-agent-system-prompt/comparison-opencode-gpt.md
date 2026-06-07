# Comparison: OpenCode GPT System Prompt vs Our Research Findings

Status: research output  
Date: 2026-06-07  
Source: `anomalyco/opencode` — `packages/opencode/src/session/prompt/gpt.txt`  
Research basis: slices 1-10, `final-findings-synthesis.md`, `comparison-claude-code.md`, `comparison-codex-cli-max.md`

---

## Purpose

This document evaluates the OpenCode `gpt.txt` base prompt against our 10-slice research output.

Important boundary: this is a base-prompt comparison, not a complete OpenCode runtime audit. OpenCode also injects environment context, skills, tool descriptions, command templates, and agent prompts.

---

## Layer 1: Executor Identity

**OpenCode text:** "You are OpenCode, You and the user share the same workspace and collaborate to achieve the user's goals."

**Our research validates:**
- Functional executor identity is explicit without relying only on persona.
- "Shared workspace" correctly frames the agent as an executor operating over repo state.

**Our research challenges:**
- The first sentence has small grammatical noise, which matters because identity lines are high-salience prompt positions.

**Decision:** `strong`.

---

## Layer 2: Tool Contract

**OpenCode text:** Prefer Glob/Grep, parallelize tool calls through `multi_tool_use.parallel`, avoid noisy chained shell commands.

**Our research validates:**
- Directly matches M2/S7-1 parallel-call guidance.
- Tool ergonomics are framed as user-experience and efficiency constraints, not only model preference.

**Decision:** `strong`.

---

## Layer 3: Task Framing

**OpenCode text:** Smallest correct change, autonomy and persistence, implement when user intent implies implementation.

**Our research validates:**
- Strong match with C2/M4 scope discipline and Codex-style ambition-vs-precision.
- Good distinction between implementation requests and planning/brainstorming requests.

**Decision:** `strong`.

---

## Layer 4: Repo / Project Authority

**OpenCode text:** Build context by examining the codebase first; follow existing project patterns.

**Our research validates:**
- Good local-convention discipline.

**Our research challenges:**
- No explicit AGENTS.md/CLAUDE.md scope and precedence semantics in this base prompt.

**Decision:** `moderate`.

---

## Layer 5: Investigation / Exploration Scaffold

**OpenCode text:** Examine codebase first, use review mindset when asked for review, diagnose pasted bug reports.

**Our research validates:**
- Supports C3/C8 evidence-before-edit.
- Review mode has a stronger output contract than most OpenCode variants.

**Decision:** `strong`.

---

## Layer 6: Edit Boundaries

**OpenCode text:** Use apply_patch for manual edits; preserve dirty worktree; never revert user changes; avoid destructive git; prefer non-interactive commands.

**Our research validates:**
- Strong coverage of M12, M14, and edit-tool discipline.
- Better than most OpenCode base variants for shared-worktree safety.

**Decision:** `strong`.

---

## Layer 7: Validation Scaffold

**OpenCode text:** Persist through implementation, verification, and clear explanation.

**Our research validates:**
- Good end-to-end completion contract.

**Our research challenges:**
- Validation state taxonomy is absent. It does not require explicit `not_run | focused_pass | full_pass | blocked` reporting.

**Decision:** `functional`.

---

## Layer 8: Safety / Trusted Input Boundary

**OpenCode text:** Destructive git guard, dirty-worktree guard, frontend and review constraints.

**Our research validates:**
- Operational safety is strong for repo editing.

**Our research challenges:**
- No explicit untrusted-input boundary for file contents, tool outputs, web pages, issue text, or prompt-injection strings.

**Decision:** `moderate`.

---

## Layer 9: Output Contract / Final Answer

**OpenCode text:** Separate commentary and final channels; final answer style rules; review answer format.

**Our research validates:**
- Strong communication-channel clarity, concise final report discipline, and review-mode finding-first contract.

**Decision:** `strong`.

---

## Layer 10: Dynamic / Runtime Context

**OpenCode text:** The base prompt expects runtime environment, tool, and channel context from the harness.

**Our research validates:**
- Follows Rule Zero: runtime data is injected outside the static prompt.

**Decision:** `functional`.

---

## Intermediary Conclusion

Observed:
OpenCode `gpt.txt` is the closest OpenCode variant to our current Codex/Coding Agent prompt shape: shared workspace, pragmatic engineer identity, explicit edit discipline, parallel tool use, dirty-worktree preservation, concise progress updates, and final-answer constraints.

Inferred:
This variant is a stronger candidate source for QuantZhai-style coding-agent prompt evolution than `default`, `anthropic`, or `beast`, because it keeps autonomy and rigor without forcing universal web research or exhaustive planning.

Risk:
The base prompt still lacks explicit trusted-input boundaries, AGENTS.md precedence semantics, and validation-state reporting. Those gaps may be covered elsewhere in OpenCode's runtime, but this file alone does not prove it.

Candidate structure:
Adopt the `gpt.txt` combination of shared-workspace identity, smallest-correct-change rule, parallel-call guidance, dirty-worktree preservation, and commentary/final channel contract as a compact baseline cluster.

How to test:
Run the existing fixtures for dirty worktree, scope creep, fake investigation, prompt injection, and task abandonment against this variant. Add a comparison run against `codex.txt` and QuantZhai `codex-core-qwenified` to isolate whether `gpt.txt` gives better shared-worktree and final-report behavior at similar token cost.
