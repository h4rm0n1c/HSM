# Extended Prompt Surface — Research Plan (No Implementation)

Goal:
- Extend our existing prompt research (system prompt only) to cover the full prompt surface
  relevant to a coding agent like QuantZhai.
- For each area: research and generate a report. No code changes yet.
- Respect the QuantZhai design principle: less is more. Every addition must justify its
  token cost by directly reducing a concrete failure mode or improving reliability.

Scope:
- System prompt
- Compaction prompt
- Reasoning effort strings (inserted per-effort level)
- Cross-cutting interactions and token budget

Each item is: "research and generate report" only.

---

## 1. System Prompt

Task:
- Research best practices for coding-agent system prompts; generate a report that:
  - Summarizes current state-of-the-art patterns (Claude Code, Codex CLI, Cursor, etc.).
  - Highlights structures that reduce specific failure modes (e.g., over-engineering, task abandonment, destructive actions, hallucinated validation).
  - Evaluates trade-offs under a "less is more" constraint: which rules are high-leverage vs. noise.
  - Proposes a concise, token-efficient candidate structure aligned with QuantZhai’s style.

Output:
- A focused markdown report.

---

## 2. Compaction Prompt

Task:
- Research how context compaction prompts should be designed for long-running coding agent sessions; generate a report that:
  - Explains why naive summarization breaks agent behavior (e.g., losing constraints, exact paths, version strings, negations, user corrections).
  - Identifies patterns that help the model preserve critical information when compressed.
  - Considers survival-weighted or token-aware compaction strategies (e.g., keep high-value spans verbatim, summarize filler).
  - Evaluates how compact the compaction prompt itself can be while still being effective.
  - Aligns with "less is more": avoid heavy meta-instructions; keep it lean and directive.

Output:
- A focused markdown report.

---

## 3. Reasoning Effort Strings

Task:
- Research how to design reasoning-effort steering strings inserted into the prompt (e.g., low / medium / high / xhigh); generate a report that:
  - Analyzes how different wording changes model behavior: speed vs. depth vs. overthinking.
  - Compares common patterns (short directives vs. richer instructions) and their effects.
  - Ensures each level:
    - Clearly constrains or expands reasoning depth.
    - Avoids unnecessary verbosity.
    - Does not conflict with the system prompt or compaction prompt.
  - Respects "less is more": each string should be very short, precise, and non-redundant.

Output:
- A focused markdown report.

---

## 4. Cross-Cutting: Interactions, Conflicts, and Token Budget

Task:
- Research and report on how these three components interact as a unified prompt surface; cover:
  - Conflicts: where the system prompt, compaction prompt, or reasoning effort strings might contradict or override each other.
  - Redundancy: areas where instructions are repeated across components and can be centralized or removed.
  - Token budget: high-level guidance on how to keep the total surface (system + compaction + reasoning strings) lean while still robust.
  - Practical recommendations for QuantZhai’s prompt engineering posture under "less is more."

Output:
- A focused markdown report.

---

Notes:
- No changes to QuantZhai codebase or configuration in this phase.
- All outputs are research reports intended to inform future prompt design decisions.
