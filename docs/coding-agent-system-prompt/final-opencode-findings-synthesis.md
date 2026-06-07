# Resynthesis: OpenCode Coding-Agent Prompt System

Status: resynthesis output  
Date: 2026-06-07  
Scope: OpenCode prompt-system evidence only. Candidate prompt drafting is explicitly out of scope.

---

## 0. Correction To Previous OpenCode Pass

The earlier OpenCode synthesis was too shallow compared with the older QuantZhai, Codex CLI, Claude Code, and multi-vendor comparison reports.

The older reports did not merely list features. They used a repeatable comparison discipline:

```text
source boundary
  -> layer-by-layer comparison
  -> what our research validates
  -> what our research challenges
  -> gaps
  -> what the compared system does better
  -> risk / uncertainty
  -> decision
  -> fixture implication
```

The OpenCode pass compressed too much of that into an adoption cluster. That made the final synthesis feel bolted on rather than earned.

This document corrects that boundary. It does not produce `candidate-system-prompt-v0.md`, does not recommend drafting one yet, and does not treat OpenCode as fully integrated until the comparison layer is repaired.

---

## 1. Source Boundary

This resynthesis uses the existing OpenCode comparison files for these base prompt variants:

```text
comparison-opencode-gpt.md
comparison-opencode-codex.md
comparison-opencode-trinity.md
comparison-opencode-gemini.md
comparison-opencode-default.md
comparison-opencode-kimi.md
comparison-opencode-anthropic.md
comparison-opencode-beast.md
```

It also uses the older comparison layer as the quality bar:

```text
comparison-quantzhai-codex-core-qwenified.md
comparison-codex-cli-max.md
comparison-claude-code.md
research-external-prompt-comparison.md
```

Important limitation:

The current OpenCode comparison set is strongest on base prompt text and weaker on runtime assembly. OpenCode is not just eight `.txt` files. It is a prompt system assembled from:

```text
provider-selected base prompt
environment injection
skills prompt
command templates
agent prompts
task/subagent prompt surfaces
plan/build reminders
permission state
TUI mode state
plugin transforms
```

Therefore, current claims about OpenCode runtime behaviour are `plausible_but_unproven` unless a specific runtime source file or fixture result supports them.

---

## 2. Method Restored

For OpenCode, each finding should now be judged with the same discipline used for the older reports.

Required comparison shape:

```text
Observed:
Validated by our research:
Challenged by our research:
What OpenCode does better:
What OpenCode does worse:
Gap:
Risk / uncertainty:
Runtime vs prompt placement:
Decision:
Fixture implication:
```

This matters because OpenCode has several good ideas, but their location differs:

- static base-prompt ideas
- runtime injection ideas
- UI/TUI workflow ideas
- permission-state ideas
- subagent/task orchestration ideas
- stress-reference ideas that should not become baseline rules

Flattening those into one adoption list loses the useful distinction.

---

## 3. OpenCode Prompt-Family Map

| Surface | Evidence status | Role in system | Resynthesis note |
| --- | --- | --- | --- |
| `gpt.txt` | Compared | Main pragmatic shared-workspace worker prompt | Strongest direct base-prompt source |
| `codex.txt` | Compared | Professional/objective coding-agent variant | Strong objectivity source |
| `trinity.txt` | Compared | Compact all-around prompt with project awareness | Strong compact repo-authority reference |
| `gemini.txt` | Compared | Convention/library/style discipline | Strong local-convention source |
| `default.txt` | Compared | Minimal fallback prompt | Compactness reference only |
| `kimi.txt` | Compared | Concise prompt with moderate task discipline | Compactness/style reference only |
| `anthropic.txt` | Compared | Persistence-heavy prompt | Stress reference, not baseline |
| `beast.txt` | Compared | Aggressive autonomous completion prompt | Stress reference and rejection source |
| `system.ts` | Partially compared | Provider routing and environment injection | Needs dedicated runtime-assembly comparison |
| Plan/build reminders | Not fully integrated | Read-only planning mode and mode switch | Needs dedicated plan-mode comparison |
| Task/subagent prompts | Partially captured | Exploration, compaction, summary, title, task execution | Needs dedicated subagent comparison |
| TUI behaviours | Observed from user experience, not yet documented | Plan toggle, todo UI, rollback, diff rendering | Needs separate CLI/UX workflow note, not prompt text |

The important correction: OpenCode should be compared as a prompt-system family, not as isolated base prompt files.

---

## 4. Cross-Variant Matrix

| Variant | Strongest contribution | Main weakness | Use in resynthesis |
| --- | --- | --- | --- |
| `gpt` | Shared workspace framing, smallest correct change, dirty worktree discipline, progress/final channel rules | Lacks full trusted-input boundary and AGENTS precedence | Primary base-prompt comparison source |
| `codex` | Professional objectivity | Weaker project-rule authority in base prompt | Objectivity wording source |
| `trinity` | Compact AGENTS/project-awareness shape | Needs explicit nested scope/precedence semantics | Repo-authority compactness source |
| `gemini` | Local convention, library, style, verification discipline | Weaker dirty-worktree/edit-boundary coverage than `gpt` | Convention discipline source |
| `default` | Concision | Missing too many safety/edit/project structures | Negative/compact baseline reference |
| `kimi` | Concise task framing | Missing critical edit boundaries | Negative/compact baseline reference |
| `anthropic` | Persistence pressure | Overbroad completion framing and weak edit boundaries | Stress source only |
| `beast` | Exposes extreme autonomy failure modes | Universal web research, perfect-solution language, automatic `.env`, large reads | Rejection source and stress fixture source |

The previous synthesis correctly identified the stronger variants, but it did not sufficiently explain why the weak variants are still useful as stress references.

---

## 5. Layer Resynthesis

### 5.1 Executor Identity

Observed:

OpenCode variants range from compact functional identity to more aggressive capability framing. `gpt.txt` is the cleanest: it frames the agent and user as sharing the same workspace and working toward the user's goals.

Validated by our research:

This matches the older finding that useful identity is harness/workspace orientation, not grandiose persona. It also fits HSM's executor-as-data discipline: repo, user, and project state are data the agent works over, not identity to absorb.

Challenged by our research:

Some OpenCode variants drift toward capability-boast wording. That conflicts with the older rejection of grandiose identity and role confusion.

What OpenCode does better:

`gpt.txt` has a warmer and more operationally useful identity than a bare executor header. "Shared workspace" is a high-value phrase because it implies concurrent worktree safety and direct file access without saying too much.

Risk / uncertainty:

Identity wording has weak fixture evidence. Slice 5 found little measurable difference on simple tests. Treat identity as boundary-setting and UX, not a magic behaviour lever.

Decision:

Keep `gpt`-style shared-workspace framing as a research finding. Do not convert it into candidate prompt text yet.

---

### 5.2 Tool Contract

Observed:

OpenCode `gpt.txt` explicitly prefers search/file tools backed by `rg`, encourages parallel file reads, and discourages noisy chained shell output. This is stronger than Codex CLI on parallelism and close to Claude/Cursor guidance.

Validated by our research:

This supports S7-1: independent reads/searches should be parallelized, and repeated reads should be avoided where possible.

Challenged by our research:

The OpenCode base prompts are inconsistent about tool-name disclosure, result persistence, and tool/runtime boundaries. Some details may live in tool descriptions or runtime code rather than base prompt text.

What OpenCode does better:

It links tool discipline to terminal/UI readability, not just correctness. The "do not chain echo separators" rule is a rare example of prompt text acknowledging terminal rendering quality.

Runtime vs prompt placement:

Tool schemas, permission policy, and result persistence are runtime/tooling concerns. The static prompt should only carry compact behavioural guidance.

Decision:

OpenCode validates the tool-efficiency layer, but the runtime/tool boundary still needs a dedicated comparison before final integration.

---

### 5.3 Task Framing And Planning

Observed:

OpenCode has two different planning stories:

- base prompts such as `gpt.txt` discourage unnecessary planning and bias toward implementation when user intent implies action
- plan-mode reminders create a strict read-only planning workflow with plan-file-only editing, explore agents, design synthesis, and plan exit

Validated by our research:

This maps well to the old three-loop architecture:

```text
upstream arbitration / planning loop
coding-agent worker loop
runtime integrity loop
```

OpenCode's plan mode is not merely a prompt style. It is a mode boundary enforced by runtime reminders and UI state.

Challenged by our research:

The previous OpenCode synthesis treated todo/planning visibility as a simple adoption constraint. That is too shallow. Plan mode is a separate operating mode, not a line to paste into the worker prompt.

What OpenCode does better:

The Tab-toggle plan mode and visible terminal state, based on user observation, are workflow/UI strengths. They should inform QuantZhai CLI design and task-state modelling, not just prompt wording.

Runtime vs prompt placement:

Plan/build mode belongs primarily in runtime/UI state and injected reminders. The base worker prompt should only know how to respect the current mode.

Decision:

Do a dedicated OpenCode plan-mode comparison before updating final general synthesis. Do not draft candidate prompt text from plan-mode material yet.

---

### 5.4 Repo / Project Authority

Observed:

OpenCode base prompts vary. `trinity.txt` and `gemini.txt` carry the strongest project-awareness and convention-following language. `gpt.txt` is strong on examining codebase patterns but weak on explicit AGENTS.md scope and precedence.

Validated by our research:

This confirms the older two-part repo-authority model:

```text
project instruction hierarchy
local convention / library / style inspection
```

Challenged by our research:

OpenCode base prompts do not consistently match Codex CLI's explicit AGENTS.md scope/nesting/touched-file semantics. If OpenCode handles this elsewhere, the existing OpenCode comparison layer has not proved it yet.

What OpenCode does better:

`gemini.txt` appears especially useful for local convention discipline: inspect existing libraries, preserve style, and avoid importing foreign patterns.

Runtime vs prompt placement:

AGENTS/project-rule discovery can be runtime-injected. Precedence semantics should be documented either in the prompt or in the injected project-rule packet, but not left implicit.

Decision:

OpenCode contributes useful convention language, but Codex CLI remains the stronger source for formal AGENTS.md semantics.

---

### 5.5 Investigation / Exploration

Observed:

OpenCode `gpt.txt` tells the model to examine the codebase first and not jump to conclusions. Review mode has a finding-first contract. Plan mode can launch explore agents in parallel.

Validated by our research:

This supports C1/C3/C8: suspicion is a search heuristic, not proof; inspect before editing; do not delegate understanding.

Challenged by our research:

The base-prompt comparisons do not fully inspect task/subagent prompts. Therefore, claims about Explore/Task behaviour are incomplete.

What OpenCode does better:

Plan-mode's explicit "up to 3 explore agents in parallel" is a concrete exploration-scaling rule. It resembles Claude Code's Explore-agent threshold but is tied to a mode.

Runtime vs prompt placement:

Subagent selection belongs in runtime/tool/task guidance. The static prompt should preserve the accountability rule: the main agent must verify and understand before reporting.

Decision:

OpenCode strengthens the exploration layer, but a dedicated task/subagent comparison is needed before final adoption decisions.

---

### 5.6 Edit Boundaries

Observed:

`gpt.txt` and `codex.txt` are strong on dirty-worktree preservation, destructive git avoidance, and manual edit discipline. `codex.txt` adds file-creation guard material.

Validated by our research:

This strongly supports FM2/FM9 mitigations: never revert user changes, assume concurrent work, avoid destructive git, and prefer surgical edits.

Challenged by our research:

Not all OpenCode variants carry these rules equally. A provider-selected prompt family can be weaker than the best OpenCode prompt.

What OpenCode does better:

The `gpt.txt` dirty-worktree language is practical and grounded. It explicitly handles files touched recently, unrelated files, and direct conflicts.

Decision:

This is one of the strongest OpenCode contributions. Keep it as a high-confidence finding for later prompt work, but do not draft the candidate yet.

---

### 5.7 Validation And Completion

Observed:

OpenCode variants often require persistence through implementation, verification, and explanation. They are weaker on explicit validation-state taxonomy.

Validated by our research:

This supports the task-abandonment mitigation: do not stop after analysis or partial fixes if the user asked for implementation.

Challenged by our research:

Persistence without validation state can become fake completion. The older HSM finding remains stronger: report what was run, what was not run, and whether the state is `not_run`, `focused_pass`, `full_pass`, `smoke_yellow`, `smoke_red`, or `blocked`.

What OpenCode does better:

It has strong end-to-end bias and practical final-report pressure.

Decision:

Use OpenCode as support for bounded persistence, not as the primary validation model.

---

### 5.8 Trusted Input Boundary

Observed:

OpenCode base prompts have good operational safety around git/destructive edits. They are inconsistent or incomplete on file text, issue text, web text, and tool-output-as-data boundaries.

Validated by our research:

The gap confirms Slice 6 remains necessary. Operational edit safety is not the same as trusted-input safety.

Challenged by our research:

If OpenCode handles instruction-boundary material elsewhere, the existing base-prompt comparison does not prove it. Runtime source review is needed.

Decision:

OpenCode does not supersede HSM Slice 6. Keep Slice 6 as the primary source for trusted-input boundary design.

---

### 5.9 Output Contract And Terminal UX

Observed:

OpenCode `gpt.txt` has detailed final-answer and commentary-channel rules. It also encodes terminal-output concerns, such as avoiding ugly chained separator commands.

Validated by our research:

This supports the older output-contract layer: concise final report, channel clarity, findings-first review mode, no hidden-thought theatre.

Challenged by our research:

The repo docs do not yet integrate user-observed UI strengths:

```text
side-by-side patch/diff rendering quality
interactive rollback via TUI/OSC history selection
useful todo list function
clear plan-mode colour/state signal
```

These are not merely prompt details. They are CLI product behaviours that affect agent supervision and recovery.

Runtime vs prompt placement:

Diff rendering, todo UI, plan toggle, and rollback are CLI/harness features. They belong in QuantZhai CLI design notes, not baseline prompt text.

Decision:

Create a separate OpenCode CLI workflow/UX note before final CLI design synthesis. Do not merge UI behaviours into prompt candidate text.

---

### 5.10 Dynamic Runtime Context

Observed:

OpenCode `system.ts` injects model ID, provider/model ID, working directory, workspace root, git-repo boolean, platform, and date in an `<env>` block.

Validated by our research:

This confirms Rule Zero: live environment facts belong outside static prompt text.

Challenged by our research:

The OpenCode environment block is thinner than the QuantZhai/HSM target. It has a git-repo boolean, not categorized dirty-worktree state. It does not prove project-rule summaries or validation commands are injected.

What OpenCode does better:

It has a clean runtime-injection pattern that is easy for the model to parse.

Decision:

OpenCode validates the environment-block pattern, but HSM/QuantZhai should keep the richer categorized runtime-state design.

---

## 6. OpenCode vs Older CLI Family

| Layer | QuantZhai | Codex CLI | Claude Code | Cursor / external comparison | OpenCode resynthesis |
| --- | --- | --- | --- | --- | --- |
| Compactness | Strongest local baseline | Moderate | Weak / huge | Mixed | Mixed by variant |
| Executor identity | Exact local model/harness | Strong Codex CLI identity | Minimal interactive agent | Strong IDE/pair framing | Best in `gpt`, noisy in some variants |
| Tool efficiency | Strong parallel/tool preference | Good `rg`/patch, weaker parallel | Strong parallel/subagent | Strong parallel/tool rules | Strong in `gpt` |
| Planning | Compact action bias | Best planning conditions | Strong subagent planning architecture | Plan-first | Split: base prompts vs plan mode |
| Project authority | Needs additions | Best AGENTS.md semantics | Harness-injected memory hierarchy | Rule files/globs | Strong convention language, weaker formal semantics |
| Edit safety | Needs hardening | Strong destructive-git rules | Strong dirty-worktree/file-creation rules | Mixed | Strong in `gpt`/`codex`, uneven family-wide |
| Validation | Needs explicit states | Good but not state-taxonomy | Strong architecture, variable prompt text | Mixed | Completion bias strong, validation states missing |
| Trusted input | HSM Slice 6 strongest | Weak in base prompt | Stronger disclosure/security | Strong disclosure | Inconsistent in base prompts |
| Runtime context | Local target is rich injection | Partial | Very rich | IDE context | Clean env block but thin git state |
| CLI workflow UX | QuantZhai design target | Functional | Functional | IDE-native | Strong plan/diff/rollback/todo ideas, but CPU/flicker risks |

The corrected view:

OpenCode is not simply another vendor prompt. It is useful because it exposes how prompt text, runtime reminders, UI state, permissions, and TUI affordances can work together. That makes it especially relevant to QuantZhai CLI design, but it also means it must not be flattened into a candidate prompt list.

---

## 7. Resynthesis Decisions

### High-confidence findings

- `gpt.txt` is the strongest OpenCode base-prompt source.
- `codex.txt` is the strongest OpenCode source for professional objectivity.
- `trinity.txt` and `gemini.txt` are the strongest OpenCode sources for compact repo/project awareness and local convention discipline.
- `anthropic.txt` and `beast.txt` are stress references, not baseline sources.
- OpenCode validates shared-workspace identity, smallest-correct-change framing, dirty-worktree preservation, parallel reads, and concise output discipline.
- OpenCode does not replace HSM's trusted-input boundary or validation-state taxonomy.

### Medium-confidence findings

- OpenCode plan mode is likely highly relevant to QuantZhai CLI mode design, but it needs a dedicated comparison before integration.
- OpenCode task/subagent surfaces may contain useful exploration rules, but they need source-level comparison.
- OpenCode runtime environment injection supports Rule Zero, but the current comparison only partially audits runtime assembly.

### Low-confidence / unresolved findings

- Whether OpenCode's prompt family performs better than QuantZhai baseline on the existing fixture matrix.
- Whether OpenCode's provider-selected prompt routing causes inconsistent safety behaviour in practice.
- Whether plan mode's subagent-heavy workflow improves results enough to justify its ceremony.
- How much of OpenCode's observed UX strength is prompt-shaped versus TUI implementation-shaped.

---

## 8. What To Preserve For Later Prompt Work

Preserve as later input, not candidate prompt text now:

```text
professional objectivity
shared-workspace executor framing
smallest correct change
parallel independent reads
no noisy chained shell output
dirty-worktree preservation
file-creation guard
local convention/library/style discipline
bounded persistence
findings-first review mode
concise final report
runtime env block pattern
```

Preserve as runtime / CLI design input:

```text
plan/build mode boundary
read-only plan mode
plan-file-only edit exception
visible plan-mode UI state
parallel explore-agent planning
interactive rollback by conversation point
side-by-side diff/patch rendering
todo list UI
permission common-node handling
```

Preserve as rejection / stress-test input:

```text
universal web research
perfect-solution language
automatic .env creation
fixed 2000-line read rules
one-tool-per-message constraints where parallel calls are available
boastful identity claims
unbounded persistence
```

---

## 9. Required Follow-Up Docs Before Any Candidate Prompt

Do not draft `candidate-system-prompt-v0.md` yet.

The comparison layer needs these resynthesis documents first:

```text
research-opencode-source-map.md
  Map all OpenCode prompt/runtime surfaces and classify authority/evidence level.

comparison-opencode-runtime-assembly.md
  Compare provider selection, environment injection, skill injection, reminders,
  commands, tools, permissions, and plugin transforms against Rule Zero.

comparison-opencode-plan-mode.md
  Compare plan mode, build switch, read-only enforcement, plan files, explore
  agents, and mode-exit behaviour against the arbitration-loop research.

comparison-opencode-agent-task-compaction.md
  Compare task/subagent, explore, compaction, title, and summary prompts against
  the HSM/QuantZhai layers.

research-opencode-vs-cli-family.md
  Compare OpenCode as a whole prompt system against QuantZhai, Codex CLI,
  Claude Code, Cursor, and the existing external comparison matrix.
```

Only after those are done should `final-findings-synthesis.md` be updated again. Candidate prompt drafting remains blocked until then.

---

## 10. Current Resynthesis Conclusion

OpenCode is valuable, but the previous integration was premature.

The correct synthesis is:

```text
OpenCode provides strong evidence for shared-workspace execution,
small correct edits, dirty-worktree preservation, concise terminal UX,
plan/build mode separation, and runtime prompt assembly.

OpenCode does not yet provide enough integrated evidence to rewrite the
candidate prompt. Its findings must first be reconciled through the same
layered comparison discipline used for QuantZhai, Codex CLI, Claude Code,
and the earlier external prompt comparison.
```

Immediate next action:

```text
Repair OpenCode comparison/resynthesis docs only.
Do not draft candidate prompt text.
Do not update candidate prompt structures except to mark findings as pending
OpenCode resynthesis where necessary.
```
