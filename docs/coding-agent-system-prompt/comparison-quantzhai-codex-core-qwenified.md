# Comparison: QuantZhai `codex-core-qwenified` vs Our Research Findings

Status: research output  
Date: 2026-05-30  
Source: `reference-quantzhai-codex-core-qwenified.md` (ref `2b2fe8b1`)  
Research basis: slices 1-10, final-findings-synthesis.md, candidate-structures.md,  
  research-external-prompt-comparison.md, research-missing-structures.md,  
  research-failure-mode-catalog.md, prompt-evaluation-checklist.md,  
  research-plan.md

---

## Purpose

This document takes the current QuantZhai packaged system prompt
(`codex-core-qwenified.md`) and evaluates each section against our 10-slice
research output. It is the first of three dedicated comparisons (QuantZhai,
Codex Max, Anthropic/Claude).

For each QuantZhai section, this document records:

- what our research **validates** (evidence the QuantZhai prompt already gets right)
- what our research **challenges** (findings that suggest modification)
- what **gaps** exist (structures our research recommends but QuantZhai lacks)
- what the QuantZhai prompt does **better** than our candidate set
- **risk/uncertainty** about each finding

Decision labels: `keep`, `modify`, `add`, `remove`, `no_research_coverage`.

---

## Design Constraint: Proportional Compactness

The QuantZhai `codex-core-qwenified` prompt is ~100 lines / ~650 tokens.
This is by design. Its spiritual antecedent is
[Caveman](https://github.com/juliusbrussee/caveman) — "why use many token when
few do trick." The prompt favours compact, dense rules over verbose explanation.
Every line carries weight; ceremony is avoided.

Expansion is justified when the value is proportional, but the ethos is:
**no doubling or tripling.** 650 → 1024 is defensible. 650 → 1300+ is not.

Concretely:

- additions must earn their token budget through direct failure-mode mitigation
- critical safety structures (S6-1, C2+M4) justify expansion — but at
  caveman-like terseness, not verbose explanation
- medium/low structures default to "absorb into existing rules or leave unfilled"
- use harness/runtime mechanisms instead of prompt text whenever possible
- compress existing sections to free budget for higher-value additions

All adoption recommendations below should be read through this lens.

---

## Section-by-Section Comparison

### 1. Identity Line

**QuantZhai text:**
```
You are Codex, powered by Qwen3.6-35B-A3B with Abliteration to remove refusal
params. You are running as a coding agent in the Codex CLI on a user's computer.
```

**Our research validates:**

- **Executor/harness naming** (C23, S5): QuantZhai names the executor ("Codex"),
  the model ("Qwen3.6-35B-A3B"), and the harness ("Codex CLI"). This is
  consistent with all three major vendors (Claude Code names SDK, Codex CLI
  names itself, Cursor names IDE).
- **No pair-programming frame** (rejected by S5): QuantZhai uses "coding agent"
  language, not pair programming. Matches our rejection of the Cursor-style
  pair frame.

**Our research challenges:**

- **Abliteration disclosure**: QuantZhai explicitly names "Abliteration to remove
  refusal params." None of the vendor prompts disclose safety/censorship
  modifications. This may be a transparency advantage for local models, but
  the Promptware Kill Chain (S6) suggests that revealing safety modifications
  could make injection attacks easier to calibrate. **Risk**: low for local
  closed-network use, higher if the prompt template is reused in shared
  environments.
- **Model naming**: QuantZhai names the exact model. Claude Code and Codex CLI
  both name model families, not exact model IDs. Cursor names "Claude 3.5
  Sonnet" (family+version). QuantZhai's exact naming may cause confusion if
  the model is ever changed without updating the prompt.

**Gaps relative to our research:**

- **No subject identity prohibition** (C26, S5): QuantZhai has no rule against
  adopting subjective identity or authorship. Our C26 adds "Do not adopt or
  claim a human identity, authorship, or personal opinions." However, the S5
  AB test showed zero persona leakage for either condition, so this is
  low-impact.
- **No harness boundary statement** (merged into S6-1): QuantZhai doesn't
  explicitly mark repo/project/user state as data. The identity line says the
  agent is "running on a user's computer" but doesn't establish the
  state-as-data discipline from S5.

**What QuantZhai does better:**

- QuantZhai's identity is more informative than our minimal C23 executor header
  (~30 tokens). QuantZhai uses ~25 tokens and conveys executor name, model,
  model modification, harness, and context. The AB test showed no behavioural
  difference, but the additional context may help debugging.

**Decision: `keep` with one optional modification.** Add a brief state-as-data
rule after the identity line. Optional: review abliteration disclosure policy.

---

### 2. General Section

**QuantZhai text:**
```
# General

- When searching text, prefer `rg`. When searching filenames, prefer `rg --files`.
  Fall back only if `rg` is unavailable.
- If a dedicated solver tool exists, use it instead of raw shell commands.
  Default to: `git`, `rg`, `read_file`, `list_dir`, `glob_file_search`,
  `apply_patch`, `todo_write/update_plan`. Use raw terminal only when no listed
  tool can perform the action.
- For independent reads, searches, and updates, use `multi_tool_use.parallel`.
  Never read files sequentially unless the next target depends on the previous
  result.
- Treat inline `Lxxx:` prefixes as line-number metadata, not code.
- Default expectation: deliver working code, not just a plan. Make reasonable
  assumptions and complete the feature unless truly blocked.
```

**Our research validates:**

- **Parallel-call guidance** (M2, S7): QuantZhai explicitly encourages parallel
  tool use. This matches our M2 recommendation (adopted from Claude Code and
  Cursor). QuantZhai's version is more specific (`multi_tool_use.parallel`) and
  includes a sequential-read exception.
- **Tool preference guidance**: QuantZhai lists preferred tools and fallback
  behaviour. This is consistent with the tool-contract layer (S7) and matches
  vendor patterns (Claude Code's dedicated "Using Your Tools" section).
- **Deliver working code** (S1 arbitration loop): Encourages action over plans.
  Consistent with our S1 finding that the full planning loop is upstream, and
  the coding agent should execute.

**Our research challenges:**

- **No tool-name disclosure prohibition** (M1/S6-3): QuantZhai names tools
  explicitly in the system prompt. This is fine for internal guidance, but
  there's no rule telling the agent not to repeat tool names to the user.
  Claude Code and Cursor both prohibit this. QuantZhai agents may say "I used
  the Read tool to look at foo.py" in output.
- **No tool-result persistence warning** (M3/S7-2): QuantZhai doesn't warn the
  agent that tool results may be cleared across turn boundaries or compaction.
  Claude Code explicitly warns about this. If QuantZhai's harness compacts or
  clears results, the agent needs this warning.

**Gaps:**

- **No tool efficiency warning about repeated reads** (S7-1): QuantZhai's
  parallel guidance encourages batching, but doesn't say "if you already read
  this file, use that information rather than reading again." Our M2+S7-1
  merged structure includes this.

**Decision: `keep` with additions.** Add tool-name non-disclosure rule
(M1/S6-3) and tool-result persistence warning (M3/S7-2). Strengthen parallel
guidance to include "read once, reuse" language.

---

### 3. Autonomy and Persistence

**QuantZhai text:**
```
# Autonomy And Persistence

- Act as an autonomous senior engineer: gather context, plan, implement, test,
  and refine without waiting for prompts at each step.
- Persist until the task is handled end-to-end within the current turn whenever
  feasible.
- Bias strongly to action. Do not end with clarifying questions unless blocked
  by missing information that cannot be safely assumed.
- Avoid loops and thrashing. If progress stalls after real investigation, stop
  and summarize the blocker clearly.
```

**Our research validates:**

- **Bias to action** (S1 arbitration loop): Consistent with our finding that the
  coding agent's job is execution, not upstream direction-setting.
- **Avoid loops and thrashing** (M6 planning budget heuristic): This is
  QuantZhai's version of the iteration-cap concept. It's phrased as a general
  behavioural rule rather than a specific budget, which may be more robust.

**Our research challenges:**

- **No over-engineering guard** (C2+M4, FM1): The most significant gap in this
  section. "Act as an autonomous senior engineer" may actively encourage scope
  creep — a senior engineer would improve code quality, fix adjacent issues,
  and refactor as they go. Without an explicit over-engineering prevention
  section, this framing may cause FM1 (scope creep). Claude Code's
  over-engineering section is one of its longest and most specific.
- **"Persist until handled" without bail conditions** (FM10): "Persist until...
  whenever feasible" gives no guidance on when to stop. Our C4/C9+M17
  validation-honesty contract provides structured failure reporting. The
  "summarize the blocker" rule at the end is good, but "persist" comes first
  and may encourage infinite loops.

**Gaps:**

- **No adversarial self-check** (C6): No "before finalizing, check X, Y, Z"
  structure.
- **No validation-honesty contract** (C4/C9+M17): No requirement to report what
  validation was and wasn't run.

**What QuantZhai does better:**

- The "avoid loops and thrashing" rule is concise and covers the iteration-limit
  concept without a fixed magical number (3-iteration caps from Cursor). This
  may be more generalisable.

**Decision: `modify`.** Add over-engineering prevention rules (C2+M4).
Consider adding a lightweight adversarial check (C6). The autonomy framing is
sound but needs guardrails.

---

### 4. Code Implementation

**QuantZhai text:**
```
# Code Implementation

- Optimize for correctness, clarity, reliability, and maintainability over speed.
- Fix root causes, not only symptoms. Wire changes through every relevant
  surface so behaviour stays consistent.
- Follow existing project conventions for naming, structure, helpers, formatting,
  tests, localization, and UX. State why if you must diverge.
- Preserve intended behaviour and UX. Gate or clearly flag intentional behaviour
  changes, and add tests when behaviour shifts.
- No broad catches, silent defaults, swallowed errors, or success-shaped
  fallbacks. Surface or propagate failures explicitly.
- Do not early-return on invalid input without logging or notification consistent
  with repo patterns.
- Keep type safety. Changes should pass build and type-check. Avoid `as any` and
  `as unknown as ...`; use proper guards and existing helpers.
- Search for prior art before adding helpers or logic. Reuse or extract shared
  code instead of duplicating.
- Batch coherent edits. Read enough context before changing files.
```

**Our research validates:**

- **Root cause fixing** (S1): Matches our arbitration loop's emphasis on
  constrained implementation.
- **Conventions, prior art, batch edits**: All consistent with S4 promptware
  lifecycle concepts (reuse, maintainability). No conflict with any slice.
- **No broad catches** (S6 safety): Aligns with the failure-explicitness
  philosophy from S6.

**Our research challenges:**

- **"Optimize for correctness, clarity, reliability, and maintainability over
  speed"** may conflict with the over-engineering guard (C2+M4). If the agent
  prioritises maintainability, it may refactor adjacent code to make the fix
  "more maintainable." This is a genuine tension. Claude Code resolves it by
  putting over-engineering prevention *after* quality guidance, making quality
  subordinate to scoping.

**Gaps:**

- **No pre-edit constraint checklist** (C12, S3): QuantZhai says "read enough
  context before changing files" but has no structured checklist before
  non-trivial edits.
- **No evidence-before-edit rule** (C3/C8, S1/S2): QuantZhai doesn't explicitly
  say "inspect the owning files before editing." It's implied by "batch
  coherent edits" but not enforced.
- **No high-value atom preservation** (S8-1): No rule about preserving exact
  paths, flags, versions, error messages.

**What QuantZhai does better:**

- Exceptionally thorough code quality section. Covers correctness, conventions,
  error handling, type safety, reuse, and batching. Our candidate structures
  don't have this level of code-quality detail. This section addresses FM6
  (over-paraphrasing atoms) indirectly through "follow project conventions"
  but could be stronger.

**Decision: `keep`** with two additions:
1. Insert over-engineering prevention (C2+M4) somewhere nearby as a caveat.
2. Add pre-edit checklist (C12) and evidence-before-edit (C3/C8).

---

### 5. Editing Constraints

**QuantZhai text:**
```
# Editing Constraints

- Default to ASCII unless Unicode is clearly justified or already used.
- Add comments only when they explain non-obvious logic.
- Prefer `apply_patch` for single-file edits. Do not use it for generated files,
  formatter output, package lock rewrites, or broad scripted replacements.
- The worktree may be dirty. Never revert unrelated user changes.
- If unrelated changes are in files you need to edit, read carefully and work
  around them.
- If unexpected changes appear in files you are editing, STOP IMMEDIATELY and
  ask how to proceed.
- Do not amend commits unless explicitly requested.
- NEVER use destructive commands like `git reset --hard`, `git checkout --`, or
  equivalents unless specifically requested or approved by the user.
```

**Our research validates:**

- **Existing-changes preservation** (M12, FM2): QuantZhai already has "Never
  revert unrelated user changes." This directly addresses FM2 (reverting user
  work). Our M12 recommendation is already covered.
- **Destructive command guard** (M14, FM9): QuantZhai already has "NEVER use
  destructive commands like `git reset --hard`." This covers our M14
  recommendation.
- **No-amend rule** (M15): Present. Covers our M15 recommendation.
- **Apply_patch tool preference** (S7): QuantZhai has a specific tool-use rule
  for `apply_patch`, consistent with our S7 findings.

**Our research challenges:**

- **No file creation guard** (M13, FM1): QuantZhai doesn't say "NEVER create new
  files unless absolutely necessary." Given the "act as an autonomous senior
  engineer" framing, the agent is likely to create new files when a modification
  would suffice. This is a significant gap for FM1 (scope creep).
- **"STOP IMMEDIATELY and ask"** may conflict with the "bias strongly to action"
  rule from Section 3. If unexpected changes appear, the agent is told to stop
  and ask, but Section 3 says "do not end with clarifying questions." This is
  an internal contradiction.

**Gaps:**

- **No priority semantics** (M9, S6-1): QuantZhai doesn't define what wins when
  instructions conflict. Our M9 defines: direct user > AGENTS.md > system
  prompt.
- **No AGENTS.md integration rule** (M8): QuantZhai doesn't tell the agent to
  read or obey AGENTS.md. The harness feeds it as context, but the prompt has
  no rule about it.

**Decision: `keep`** with additions. Add M13 (file creation guard), M8 (AGENTS.md
integration), M9 (priority semantics). Resolve the internal contradiction
between "stop and ask" and "bias to action."

---

### 6. Exploration Strategy

**QuantZhai text:**
```
# Exploration Strategy

- Think first. Decide the likely files and resources before calling tools.
- Batch all known independent reads/searches into one parallel call, including
  `cat`, `rg`, `sed`, `ls`, `git show`, `nl`, and `wc`-style reads when
  applicable.
- Workflow: plan needed reads -> batch read -> analyze -> plan the next
  discovered read set -> batch again. Use a sequential read only when one
  result determines the next target.
- Do not use shell scripting to fake parallelism when `multi_tool_use.parallel`
  is available.
```

**Our research validates:**

- **Batched investigation** (C1, C3/C8, S1): QuantZhai's exploration workflow
  (plan reads → batch → analyze → repeat) is a stronger version of our C1
  (suspicion-as-search-heuristic) and C3/C8 (evidence-before-edit). QuantZhai's
  version includes a concrete workflow loop.
- **Parallel-first philosophy** (M2, S7): Reinforces the parallel-call guidance
  from Section 2.

**Our research challenges:**

- **No needle-query threshold** (M10, deferred): QuantZhai doesn't distinguish
  between "go find out broadly" and "look up this specific thing." Our M10
  (deferred from prompt text for token budget) makes this distinction. The
  QuantZhai prompt doesn't need it given its current scope, but it's noted.
- **No distinction between exploration sub-agent vs direct tools**: QuantZhai
  doesn't have an explore sub-agent, so this doesn't apply. Our comparison
  noted Claude Code's needle-query threshold for Explore agent vs direct tools.

**Decision: `keep`.** QuantZhai's exploration strategy is stronger than our
candidate structures in this layer. No changes needed.

---

### 7. Plan Tool

**QuantZhai text:**
```
# Plan Tool

- Skip plans for trivial tasks.
- Do not create single-step plans.
- If you make a plan, update it after completing a shared step.
- Never end the interaction with only a plan. Plans guide edits; the
  deliverable is working code or a clear blocker.
- For plan updates, use the plan tool only. Do not message the user mid-turn
  just to describe plan progress.
- Before finishing, reconcile every plan item as Done, Blocked, or Cancelled.
  Do not end with pending or in-progress items.
- Do not promise tests, commits, or refactors unless doing them now. Otherwise
  mark them as optional next steps.
```

**Our research validates:**

- **Skip trivial plans** (M6 planning budget heuristic): "Skip plans for trivial
  tasks" directly matches our M6 recommendation. QuantZhai also adds "no
  single-step plans" — a useful refinement.
- **Plan reconciliation** (S1): "Reconcile every plan item as Done, Blocked, or
  Cancelled" is stronger than our candidate structures' plan guidance.
- **Don't end with only a plan** (S1 arbitration loop): Matches our findings
  that plans are guides, not deliverables.

**Our research challenges:**

- **No over-engineering guard** (C2+M4, FM1): The plan tool section doesn't
  prevent planning scope creep. A plan could include "refactor adjacent module"
  or "add tests for unrelated code." The plan reconciliation rule only catches
  incomplete items, not inappropriate ones.
- **No validation state taxonomy**: Plans don't require validation notes.
  Our C4/C9+M17 requires explicit validation states (not_run / focused_pass /
  full_pass / smoke). QuantZhai's Done/Blocked/Cancelled is simpler but
  doesn't capture validation quality.

**Gaps:**

- **No anti-agreement final answer template** (C11, S2): QuantZhai's plan
  reconciliation doesn't include uncertainty/assumption marking. Our C11 adds:
  "Checked / Did not check / Assumed / Uncertain."

**Decision: `keep`** with additions. Add over-engineering scope check to the
plan section. Consider adding lightweight validation-state reporting.

---

### 8. Special User Requests

**QuantZhai text:**
```
# Special User Requests

- For simple requests that require local state, run the relevant command and
  report the useful result.
- For review requests, use code-review mode: findings first, ordered by severity,
  focused on bugs, regressions, risks, and missing tests.
- If no findings are found, say so and mention residual risks, assumptions, or
  untested areas.
```

**Our research validates:**

- **Review mode** (S1 arbitration loop): Matches our upstream/downstream split.
  The review mode structure is consistent with the human/assistant/coding-agent
  loop.
- **"Mention residual risks, assumptions, or untested areas"** (C11, S2): This
  is QuantZhai's version of our anti-agreement final answer template. It's less
  structured but covers the same concept: don't claim certainty where there's
  uncertainty.

**Our research challenges:**

- None significant. This section is well-aligned with our findings.

**Gaps:**

- **No explicit uncertainty-marking template**: QuantZhai says "mention residual
  risks" but doesn't provide a template. Our C11 provides a lightweight
  structure: "Checked / Did not check / Assumed / Uncertain."

**Decision: `keep`.** Optional: add C11 anti-agreement template as a format
suggestion for review output.

---

### 9. Frontend Design

**QuantZhai text:**
```
# Frontend Design

- Avoid generic AI-looking layouts.
- Use intentional typography, colour, spacing, motion, and atmosphere:
  distinctive layout, deliberate whitespace, restrained accents, and a clear
  visual direction.
- Preserve an existing design system when one exists.
- Finish the website or app within the requested scope. It should work on
  desktop and mobile, not just exist as a skeleton.
```

**Our research:**

- **No research coverage**: None of our 10 research slices covered UI/frontend
  design guidance. This section is outside the scope of our research protocol.
- The final rule ("Finish within requested scope") is consistent with our
  over-engineering prevention philosophy (C2+M4) applied to frontend tasks.
- QuantZhai includes this because it handles full-stack tasks. Our research
  didn't model this because we focused on prompt structure methodology, not
  domain-specific task content.

**Decision: `keep`** (no research basis to change). If future research extends
to UI task structures, this section should be revisited.

---

### 10. Sandbox and Tool Failures

**QuantZhai text:**
```
# Sandbox and Tool Failures

- If a command fails with `Read-only file system` or another explicit sandbox
  boundary, do not retry the same unprivileged command. If the action is
  necessary, retry once with `sandbox_permissions: require_escalated` and a
  short justification. If escalation is rejected or unavailable, stop and report
  what was blocked and why.
- Do not treat plain `permission denied` alone as a sandbox boundary — that is a
  normal file-permission error. Only request escalation if the denial is clearly
  from the sandbox itself.
- If a command fails with connection refused, determine whether the target
  service should be running locally before concluding the proxy or backend is
  down.
- Never escalate silently. Make any escalation request explicit with a
  user-visible justification.
```

**Our research validates:**

- **Sandbox boundary distinction** (S6, S7): QuantZhai distinguishes sandbox
  errors from normal permission errors. This is more nuanced than our S6 safety
  structures, which treat untrusted input boundaries as the primary concern.
- **Explicit escalation** (S6 safety): "Never escalate silently" matches our S6
  recommendation for explicit user-visible justification.
- **Connection handling** (S7 tool feedback): QuantZhai includes guidance for
  connection failures that our S7 structures don't cover.

**Our research challenges:**

- **Sandbox-specific rules may not generalise**: The sandbox/permission rules are
  specific to QuantZhai's current tool surface. If the tool surface changes,
  these rules become stale. Our S6-1 trusted input boundary is more general and
  doesn't depend on specific tool names.

**Gaps:**

- **No trusted input boundary** (S6-1, critical): QuantZhai has no concept of
  trusted vs untrusted input channels. The sandbox section handles tool
  execution failures but doesn't address prompt injection through file
  contents, issues, web pages, or logs. This is the most critical gap in the
  entire QuantZhai prompt.
- **No URL/output guard** (S6-2): QuantZhai doesn't forbid generating fake URLs.
- **No security policy** (S6-4): No distinction between authorised and
  unauthorised security work. This may cause the agent to refuse legitimate
  CTF/pentest tasks.
- **No tool-name disclosure prohibition** (M1/S6-3): The sandbox section names
  tools (`sandbox_permissions: require_escalated`) and could leak harness
  internals.

**Decision: `keep` sandbox handling, `add` S6-1 trusted input boundary.**
The sandbox-specific rules are valuable for QuantZhai's current runtime.
They should be supplemented with S6-1 (critical), S6-2 (low priority), and
S6-3 (medium priority). Do not remove existing sandbox rules unless they
contradict the trusted input boundary.

---

### 11. Final Answer

**QuantZhai text:**
```
# Final Answer

- Be concise, factual, and collaborative.
- For code changes, lead with what changed and why.
- Group sections general -> specific -> supporting. Use 4-6 bullets per list,
  ordered by importance.
- Do not nest bullets or create deep hierarchies. No ANSI codes.
- Reference files with clickable inline paths like `src/app.ts`, optionally with
  `:line` or `:line:column`.
- Do not use URI-style file links.
- Do not dump large files; reference paths and summarize.
- Suggest only natural next steps, such as tests, builds, or commits.
```

**Our research validates:**

- **Code-reference format** (M23, S9): QuantZhai already includes "Reference
  files with clickable inline paths like `src/app.ts`, optionally with `:line`
  or `:line:column`." This matches our M23 recommendation (adopted from Claude
  Code).
- **Concise output** (S5, S9): "Be concise, factual, and collaborative" matches
  vendor patterns.
- **No nested bullets** (S9 external comparison): Matches Claude Code's style
  guidance.
- **"Suggest only natural next steps"** (S1): Consistent with the arbitration
  loop handoff.

**Our research challenges:**

- **No apology avoidance** (M7, S9): QuantZhai doesn't tell the agent not to
  apologise. Claude Code and Cursor both have explicit "refrain from
  apologising" rules.
- **No communication channel clarity** (M24, S9): QuantZhai doesn't explain what
  the user sees vs what is tool-internal. Claude Code explicitly states "Output
  text to communicate with the user; all text you output outside of tool use is
  displayed."

**Gaps:**

- **No anti-agreement final answer template** (C11, S2): QuantZhai has no
  structured uncertainty reporting. Our C11 adds "Checked / Did not check /
  Assumed / Uncertain."
- **No validation-state reporting** (C4/C9+M17, S1/S2): No requirement to report
  what validation commands were and were not run.

**Decision: `keep`** with additions. Add M7 (apology avoidance), M24
(communication channel clarity), C11 (anti-agreement template), and C4/C9+M17
(validation-state reporting). The existing output format guidance is solid.

---

## Cross-Cutting Findings

### What QuantZhai already does well (validated by research)

1. **Parallel tool guidance** — already has explicit `multi_tool_use.parallel`
   rule. Better than most vendors.
2. **Existing-changes preservation** — "Never revert unrelated user changes"
   directly addresses FM2. Strong.
3. **Destructive command guard** — "NEVER use git reset --hard" covers FM9.
4. **No-amend commit rule** — present.
5. **Skip trivial plans** — matches M6 planning budget heuristic.
6. **Plan reconciliation** — Done/Blocked/Cancelled output is stronger than
   many vendor prompts.
7. **Code-reference format** — path:line convention already present.
8. **Code quality, conventions, error handling** — thorough implementation
   section exceeding most vendor prompts.
9. **Batched exploration workflow** — stronger than our C1/C3/C8 candidates.
10. **Sandbox boundary distinction** — nuanced handling beyond what most
    prompts include.

### What QuantZhai is missing (critical)

1. **Trusted input boundary** (S6-1) — no prompt injection defence, no
   instruction-vs-data distinction, no disclosure prohibition. **Most critical
   gap.**
2. **Over-engineering prevention** (C2+M4) — the "autonomous senior engineer"
   framing actively encourages scope creep without guardrails (FM1).
3. **File creation guard** (M13) — no "NEVER create files" rule (FM1 variant).
4. **AGENTS.md integration** (M8) — no instruction to read project-level rules.
5. **Priority/override semantics** (M9) — no conflict resolution when
   instructions disagree.
6. **Validation-honesty contract** (C4/C9+M17) — no validation-state reporting
   requirement.
7. **Tool-name disclosure prohibition** (M1/S6-3) — agent may leak tool names
   in output.
8. **Communication channel clarity** (M24) — agent may not know what user sees.

### What QuantZhai is missing (medium priority)

1. URL guard (S6-2)
2. Apology avoidance (M7)
3. Adversarial check (C6)
4. Anti-agreement final answer template (C11)
5. Pre-edit constraint checklist (C12)
6. Evidence-before-edit rule (C3/C8)
7. Runtime environment injection (M25)
8. Git status snapshot (M26)
9. Runtime feedback acceptance (S7-3)
10. High-value atom preservation (S8-1)

### Internal contradictions found in QuantZhai

1. **"Stop immediately and ask" (Editing Constraints) vs "Bias strongly to
   action" (Autonomy)**: If unexpected changes appear, one section says stop
   and ask; the other says don't end with questions. These need reconciliation.
2. **"Persist until handled" (Autonomy) vs "Avoid loops and thrashing"
   (Autonomy)**: One pushes endless persistence, the other warns against it.
   The balance is unclear without structured iteration guidance.
3. **"Optimize for maintainability" (Code Implementation) vs implied scope
   containment**: If the agent optimises for maintainability, it will refactor
   adjacent code. No over-engineering guard restrains this.

---

## Layer Coverage Summary

Using the 11-layer taxonomy from candidate-structures.md:

| Layer | QuantZhai Coverage | Our Rec | Gap Severity |
|---|---|---|---|
| 1. Executor identity | Good: names executor, model, harness | Keep + optional C26 | Low |
| 2. Tool contract | Good: parallel, tool preferences | Add M1/S6-3, M3/S7-2 | Medium |
| 3. Task framing | Moderate: no over-engineering guard | Add C2+M4, C12 | High |
| 4. Repo/project authority | None: no AGENTS.md integration | Add M8, M9 | High |
| 5. Investigation | Strong: batched workflow, tool preference | Add C3/C8 | Low |
| 6. Edit boundaries | Strong: changes preservation, git safety | Add M13 | Medium |
| 7. Validation | Weak: no validation-state reporting | Add C4/C9+M17, C6, C11 | High |
| 8. Safety/trusted input | None: no input boundary, no disclosure prohibition | Add S6-1 | **Critical** |
| 9. Output contract | Moderate: format guidance, path:line refs | Add M7, M24, C11 | Medium |
| 10. Dynamic context | None: no env/git injection | Add M25, M26 (harness) | Medium |
| 11. Runtime awareness | Partial: sandbox/tool failures | Add S7-3, S8-1 | Medium |

---

## Adoption Priority for QuantZhai Changes

### Immediate (blocking)

1. **S6-1**: Trusted input boundary. Prompt injection defence. ~90 tokens.
2. **C2+M4**: Over-engineering prevention. FM1 mitigation. ~70 tokens.

### Next (high impact)

3. **C4/C9+M17**: Validation-honesty contract. FM10 mitigation. ~80 tokens.
4. **M8 + M9**: AGENTS.md integration + priority semantics. ~70 tokens.
5. **M13**: File creation guard. FM1 scope creep variant. ~15 tokens.
6. **M1/S6-3**: Tool-name non-disclosure. ~25 tokens.

### Soon (medium impact)

7. **C12**: Pre-edit constraint checklist. ~50 tokens.
8. **C3/C8**: Evidence-before-edit rule. ~40 tokens.
9. **C6**: Minimum adversarial check. ~50 tokens.
10. **C11**: Anti-agreement final answer template. ~30 tokens.
11. **M7**: Apology avoidance. ~20 tokens.
12. **M24**: Communication channel clarity. ~25 tokens.

### Infrastructure (harness changes)

13. **M25/S7-4**: Environment info block. ~20 tokens.
14. **M26/S7-5**: Git status snapshot. ~10-40 tokens.
15. **S7-3**: Runtime feedback acceptance. ~60 tokens.
16. **S8-1**: High-value atom preservation. ~80 tokens.

### Conflicts to resolve

- **Autonomy vs "stop and ask"**: Edit the "STOP IMMEDIATELY" rule to include
  a permission to ask when genuinely unable to proceed, but also a requirement
  to attempt a workaround first.
- **"Optimise for maintainability" vs over-engineering**: Add an explicit note:
  "Optimise for maintainability of the *changed code*. Do not refactor
  unrelated code in the name of maintainability."

---

## Risk / Uncertainty

1. **Token budget**: Adding all critical (S6-1, C2+M4) and high-priority
   (C4/C9+M17, M8, M9, M13) structures adds ~330 tokens. QuantZhai's current
   prompt is ~100 lines / ~650 tokens. The expanded version would be ~1000
   tokens. This is within the 1024-token target from our research, but compression
   may be needed.
2. **Behavioural regression**: Adding safety rules may increase tool calls
   (observed: 6→13 in dirty-worktree experiment from S5). The trusted input
   boundary (S6-1) could make the agent overly cautious about reading file
   contents. Test before shipping.
3. **Internal contradictions**: The three contradictions identified above need
   resolution. Our research didn't test whether models resolve these
   contradictions consistently.
4. **Frontend section not researched**: None of our 10 slices covered
   UI/frontend guidance. The Frontend Design section in QuantZhai is
   outside our research scope. Do not change based on this comparison.
5. **Sandbox-specific rules**: QuantZhai's sandbox rules (Section 10) are
   runtime-specific and may not apply if the harness evolves. They should be
   reviewed when the harness changes.
6. **Model-change fragility**: QuantZhai names "Qwen3.6-35B-A3B" in the
   identity line. If the model is updated, the prompt must also be updated.
   Consider using a model-family placeholder instead.
