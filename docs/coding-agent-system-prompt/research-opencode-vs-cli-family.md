# OpenCode vs CLI Family Resynthesis

Status: research synthesis output  
Date: 2026-06-07  
Scope: OpenCode compared as a prompt-system family against QuantZhai, Codex CLI, Claude Code, Cursor/external comparison, and HSM research slices  
Candidate prompt drafting: out of scope

---

## Purpose

This document performs the missing integration step: compare OpenCode as a whole prompt system against the older CLI/prompt reports.

The previous OpenCode work compared base prompt variants, but did not fully reconcile OpenCode with the older comparison family. This document closes that gap at the research/synthesis level only.

It does not produce candidate prompt text.

---

## Source Basis

Internal HSM/OpenCode resynthesis docs:

```text
research-opencode-source-map.md
comparison-opencode-runtime-assembly.md
comparison-opencode-plan-mode.md
comparison-opencode-agent-task-compaction.md
final-opencode-findings-synthesis.md
comparison-opencode-*.md
```

Older comparison family:

```text
comparison-quantzhai-codex-core-qwenified.md
comparison-codex-cli-max.md
comparison-claude-code.md
research-external-prompt-comparison.md
candidate-structures.md
prompt-evaluation-checklist.md
```

Claim status:

- `high confidence` for source-backed structural comparisons
- `medium confidence` for architecture placement decisions
- `low confidence` for behavioural performance until fixtures run

---

## 1. Corrected Family View

The older reports compared systems as layered products, not just prompt text. OpenCode must be treated the same way.

| System | Correct comparison unit | Notes |
| --- | --- | --- |
| QuantZhai | compact packaged prompt + local harness assumptions | Strong compactness; needs safety/runtime comparison structures |
| Codex CLI | base prompt + AGENTS.md rules + plan/tool policy | Strong formal AGENTS semantics and planning budget |
| Claude Code | runtime architecture: subagents, memory, environment, tools, safety | Strong architecture; token-heavy and not compact |
| Cursor / external matrix | IDE agent prompt plus rule files and tool state | Strong IDE/rule-file framing; less directly portable |
| OpenCode | provider prompt family + runtime injection + reminders + subagents + TUI state | Strong runtime/CLI workflow evidence; uneven base prompt family |

Corrected conclusion:

OpenCode is closest to Claude Code in architecture shape, but closer to QuantZhai/Codex in terminal-agent workflow. It is not just a prompt dump.

---

## 2. Layer Matrix

| Layer | QuantZhai | Codex CLI | Claude Code | Cursor / external matrix | OpenCode | HSM decision |
| --- | --- | --- | --- | --- | --- | --- |
| Compactness | Strong local baseline | Moderate | Weak / huge | Mixed | Mixed by variant | Keep proportional compactness as HSM constraint |
| Executor identity | Exact model/harness | Strong Codex CLI identity | Minimal interactive-agent identity | Strong IDE/pair frame | Best in `gpt`; noisy in some variants | Shared-workspace framing is useful but not magic |
| Runtime context | Local target: rich injection | Partial | Very rich | IDE-native | Clean env block, thin git state | Runtime facts belong outside static prompt |
| Project authority | Needs additions | Best AGENTS.md semantics | Harness-injected memory hierarchy | Rule files/globs | Strong convention language, weaker formal semantics | Codex remains authority source; OpenCode adds convention wording |
| Tool efficiency | Strong parallel guidance | Good `rg`/patch, weaker parallel | Strong parallel/subagent guidance | Strong parallel/tool rules | Strong in `gpt` and task prompt | OpenCode validates terminal-aware tool efficiency |
| Planning | Compact action bias | Best planning conditions | Strong subagent planning architecture | Plan-first | Runtime plan mode plus base action bias | Plan mode is runtime/CLI design, not baseline prompt text |
| Subagents | Not primary | Less central | Strong Explore/Plan/general agents | Agent/fork tools | Task tool + Explore agent | OpenCode contributes useful delegation boundaries |
| Edit safety | Needs hardening | Strong destructive-git rules | Strong dirty-worktree/file-creation rules | Mixed | Strong in `gpt`/`codex`, uneven family-wide | OpenCode supports dirty-worktree language |
| Validation | Needs explicit states | Good but not state taxonomy | Strong architecture, variable prompt wording | Mixed | Completion bias strong, validation states missing | HSM validation-state taxonomy remains stronger |
| Trusted input | HSM Slice 6 strongest | Weak in base prompt | Stronger disclosure/security | Strong disclosure | Inconsistent in base prompts | OpenCode does not replace Slice 6 |
| Compaction | HSM Slice 8 target | Less visible | Memory/context heavy | Less visible | Anchored compaction prompt | OpenCode supports Slice 8 but atom list is narrower |
| Output/UX | Prompt-focused | Functional terminal output | Functional | IDE-native | Strong terminal UX observations | Keep UI behaviours separate from prompt text |

---

## 3. What OpenCode Adds That The Older Reports Did Not Emphasize Enough

### 3.1 Runtime Mode As A First-Class Prompt Surface

Observed:

OpenCode plan/build reminders show that mode state can be injected as a current-turn instruction rather than permanently embedded in the base prompt.

Why it matters:

HSM's earlier loop separated upstream arbitration from worker execution. OpenCode gives a concrete runtime pattern for that separation.

Decision:

Preserve plan/build mode as CLI/harness design input.

Do not paste the full plan-mode workflow into the worker prompt.

---

### 3.2 Terminal UX Affects Agent Supervision

Observed from user experience:

```text
side-by-side patch/diff rendering is useful
interactive rollback by conversation point is useful
visible plan-mode colour/state is useful
todo list UI is useful
permission common-node handling is useful
```

Why it matters:

These are not model instructions. They are supervision and recovery affordances. They change how confidently a user can direct an agent and recover from bad turns.

Decision:

Track these as QuantZhai CLI design requirements, not static prompt rules.

---

### 3.3 Provider-Selected Prompt Families Can Be Uneven

Observed:

OpenCode routes base prompt by provider/model ID. Strong variants and weak variants can coexist.

Why it matters:

A user may evaluate OpenCode behaviour without knowing which prompt family the model actually received.

Decision:

Any future benchmark must record selected base prompt, runtime reminders, and active mode.

---

### 3.4 Task Tool Boundaries Are More Useful Than Generic Subagent Hype

Observed:

OpenCode `task.txt` explicitly says when not to use subagents: specific files, specific classes, or known 2-3 file scopes should use direct tools.

Why it matters:

This is a direct antidote to over-delegation and context-wasting broad sweeps.

Decision:

Preserve this as runtime/tool-contract design input. Pair with HSM trust-but-verify.

---

### 3.5 Compaction As Anchored Continuation

Observed:

OpenCode compaction updates prior summaries, preserves still-true details, removes stale ones, keeps requested structure, and preserves exact file paths/identifiers.

Why it matters:

This validates HSM Slice 8: compaction must preserve continuation-critical atoms.

Decision:

Use OpenCode compaction as supporting evidence. Keep the broader HSM high-value atom list.

---

## 4. Where OpenCode Is Weaker Than The Older Family

### 4.1 Formal Project Authority

Codex CLI remains the strongest source for AGENTS.md semantics:

```text
scope by directory tree
nested instructions override parent instructions
rules apply to files touched
current direct instructions outrank project files
```

OpenCode has useful AGENTS/project-awareness in some variants, but the base prompt family does not consistently define formal scope and precedence.

Decision:

Use Codex CLI for formal project authority; use OpenCode `gemini`/`trinity` for compact convention discipline.

---

### 4.2 Validation Honesty

HSM's validation-state vocabulary remains stronger:

```text
not_run
focused_pass
full_pass
smoke_yellow
smoke_red
blocked
```

OpenCode has persistence and end-to-end pressure, but not explicit validation state reporting.

Decision:

Use OpenCode as evidence for bounded persistence only. Keep HSM validation-state taxonomy.

---

### 4.3 Trusted Input Boundary

OpenCode base prompts are strong on operational edit safety in some variants, but inconsistent on trusted/untrusted source boundaries.

Decision:

Keep HSM Slice 6 as the primary source for instruction-boundary design.

---

### 4.4 Family Unevenness

OpenCode's strongest findings are not evenly distributed:

```text
best shared-workspace + dirty-worktree rules: gpt
best objectivity: codex
best compact project awareness: trinity
best local convention discipline: gemini
stress references: anthropic / beast
weak fallback: default / kimi
```

Decision:

Do not treat "OpenCode prompt" as singular. Record variant and runtime mode in every future comparison.

---

## 5. Integration Decisions

### High-confidence additions to the research synthesis

Preserve these as OpenCode-supported findings:

```text
shared-workspace executor framing is useful
smallest-correct-change wording is useful
terminal-output ergonomics matter
dirty-worktree preservation needs practical wording
mode-specific reminders are better than permanent mode sludge
subagent delegation needs explicit negative cases
compaction should be anchored and structure-preserving
OpenCode UI/TUI affordances are CLI design findings
```

### Medium-confidence additions

Preserve but test:

```text
plan/build mode handoff
plan-file-only edit exception
parallel Explore agents in planning mode
verbose skill-list injection
provider-specific prompt routing
```

### Findings not adopted from OpenCode

Do not carry forward as recommendations:

```text
universal web research as default
perfect-solution language
automatic .env creation
fixed 2000-line read rules
one-tool-per-message constraints when parallel calls exist
boastful identity claims
unverified subagent trust
mandatory plan files for ordinary edits
```

---

## 6. Fixture Implications

OpenCode-specific fixture extensions should record:

```text
selected base prompt / model route
active mode: plan or build
runtime env block presence
git-state richness
whether plan-file constraints survive build handoff
whether subagents are used only for broad work
whether main agent verifies subagent findings
whether compaction preserves the HSM atom list
whether final answer reports validation state honestly
```

New fixture ideas:

| Fixture | Tests |
| --- | --- |
| `opencode-provider-route` | Given model IDs, record selected base prompt |
| `opencode-plan-readonly` | Plan mode must not edit except allowed plan file |
| `opencode-build-handoff` | Build mode follows plan file constraints and validation criteria |
| `opencode-subagent-needle` | Specific file/class lookup should not spawn subagent |
| `opencode-subagent-broad` | Multi-area unknown task may spawn scoped explore agents |
| `opencode-subagent-wrong` | Main agent verifies plausible subagent result before final claim |
| `opencode-compaction-atoms` | Compaction preserves paths, identifiers, flags, env vars, negations, errors, user corrections |

---

## 7. Updated Synthesis Boundary

OpenCode findings are now integrated enough to update `final-findings-synthesis.md` at the research level, but still not enough to draft a candidate prompt.

The final synthesis update should say:

```text
OpenCode confirms Rule Zero more strongly than the earlier base-prompt-only pass:
its useful behaviour is assembled from base prompts, runtime environment injection,
mode reminders, task/subagent prompts, compaction prompts, permissions, and TUI state.

OpenCode contributes strong CLI/runtime design findings, especially plan/build mode,
subagent negative cases, terminal UX, dirty-worktree wording, and anchored compaction.

OpenCode does not supersede Codex CLI for formal AGENTS.md semantics, HSM Slice 6
for trusted-input boundaries, or HSM Slice 8 for full high-value atom preservation.
```

Candidate prompt work remains blocked until after final synthesis is updated and the user explicitly resumes candidate drafting.

---

## 8. Conclusion

The repaired synthesis is:

```text
QuantZhai remains the compact local baseline.
Codex CLI remains the best source for formal project authority and planning budget.
Claude Code remains the best source for large-runtime architecture comparison.
Cursor remains useful for IDE/rule-file contrast.
OpenCode is now the strongest source for terminal-agent runtime workflow:
  plan/build mode,
  visible mode state,
  subagent routing boundaries,
  patch/diff UX observations,
  rollback/todo supervision affordances,
  and anchored compaction.
```

OpenCode should influence the next final synthesis as a runtime/CLI architecture source, not as a pile of prompt lines to paste into `candidate-system-prompt-v0.md`.
