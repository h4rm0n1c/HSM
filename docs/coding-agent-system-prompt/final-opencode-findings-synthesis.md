# Resynthesis: OpenCode Coding-Agent Prompt System

Status: canonical OpenCode comparison synthesis with Slice 13 correction  
Date: 2026-06-24  
Scope: OpenCode prompt-system evidence, runtime placement, CLI/TUI implications, and relationship to the consolidated HSM coding-agent research  
Candidate prompt text: out of scope; this is comparison evidence

---

## 0. Source And Confidence Boundary

OpenCode is not one prompt file. It is a system assembled from:

```text
provider-selected base prompt
  + environment injection
  + skills prompt
  + command templates
  + agent/task prompts
  + plan/build reminders
  + permission state
  + TUI mode state
  + plugin transforms
```

The compared base-prompt family includes:

```text
gpt.txt
codex.txt
trinity.txt
gemini.txt
default.txt
kimi.txt
anthropic.txt
beast.txt
```

Runtime evidence is less complete than base-prompt evidence. Claims about uninspected runtime behaviour remain `plausible_but_unproven` unless source or observed traces support them.

Slice 13 adds an explicit boundary: current OpenCode evidence does **not** establish formal postcondition checks, trusted-state commitment, result lineage, evidence retention, dependency-aware mutation gates, or recovery-state enforcement.

---

## 1. Comparison Method

Each OpenCode finding should be judged as:

```text
Observed
Validated by HSM research
Challenged by HSM research
What OpenCode does better
What OpenCode does worse
Runtime vs prompt placement
Risk / uncertainty
Decision
```

This prevents attractive prompt wording, runtime features, TUI affordances, and stress-test variants from being flattened into one adoption list.

---

## 2. Prompt-Family Map

| Surface | Evidence status | Role | Main use in HSM comparison |
|---|---|---|---|
| `gpt.txt` | compared | pragmatic shared-workspace worker | strongest base-prompt source |
| `codex.txt` | compared | professional/objective variant | objectivity and edit discipline |
| `trinity.txt` | compared | compact project-aware variant | compact repo authority |
| `gemini.txt` | compared | convention/library/style discipline | local convention source |
| `default.txt` | compared | minimal fallback | compact negative baseline |
| `kimi.txt` | compared | concise task framing | compactness/style reference |
| `anthropic.txt` | compared | persistence-heavy variant | stress reference |
| `beast.txt` | compared | aggressive autonomy variant | rejection/stress source |
| `system.ts` | partially compared | routing and environment injection | runtime assembly evidence |
| plan/build reminders | partially compared | read-only planning and mode changes | runtime/mode evidence |
| task/subagent prompts | partially compared | exploration, tasking, compaction | orchestration evidence |
| TUI behaviours | observed but not fully sourced | plan state, diffs, rollback, todo | CLI product-design input |

---

## 3. Cross-Variant Conclusions

| Variant | Strongest contribution | Main weakness | Decision |
|---|---|---|---|
| `gpt` | shared workspace, smallest correct change, dirty-worktree discipline, parallel reads, concise reporting | incomplete trusted-input and project-rule semantics | primary base-prompt comparison source |
| `codex` | professional objectivity, edit safety, file-creation guard | weaker formal project authority | use for stance and edit boundaries |
| `trinity` | compact project awareness | incomplete nested authority semantics | compactness reference |
| `gemini` | libraries, style, local convention, verification | weaker worktree/edit-safety coverage | convention-discipline source |
| `default` | brevity | misses critical structures | negative compact baseline |
| `kimi` | concise task framing | misses critical boundaries | style reference only |
| `anthropic` | persistence pressure | can overvalue completion over state-grounded control | stress source |
| `beast` | exposes autonomy failure modes | universal research, perfect-solution language, automatic `.env`, large reads | rejection/stress source |

---

## 4. Layer Findings

### Executor identity

`gpt.txt` provides useful shared-workspace framing. HSM accepts harness/workspace identity and rejects grandiose persona or capability-boast framing.

Identity is boundary-setting and UX, not a magic reliability lever.

### Tool contract

OpenCode is strong on parallel independent reads, search-first behaviour, and avoiding noisy chained shell output.

HSM retains the stronger boundary that tool invocation success is not automatically proof of the state later action depends on.

### Task framing and planning

OpenCode has two distinct planning stories:

- base prompts discourage unnecessary plans and bias toward implementation;
- plan mode creates a read-only workflow with explicit mode reminders, plan-file exceptions, exploration, and synthesis.

Plan mode is a runtime/UI state, not merely text to paste into the worker prompt.

### Repository and project authority

`trinity` and `gemini` provide useful convention language. Codex CLI remains stronger for explicit scoped project-rule and nesting semantics.

### Investigation and orientation

OpenCode supports examining the codebase before conclusions and using parallel exploration in plan mode.

Slice 11 remains the stronger abstraction: orientation must map the surfaces that determine authority, ownership, execution, validation, and convention, scaled by blast radius.

### Edit boundaries

`gpt` and `codex` strongly support dirty-worktree preservation, destructive-git avoidance, and surgical edits. This is one of OpenCode's highest-confidence contributions.

### Validation and completion

OpenCode has strong end-to-end completion pressure but weaker explicit validation-state taxonomy.

HSM retains:

```text
not_run
focused_pass
full_pass
smoke_yellow
smoke_red
blocked_manual_terminal_action
blocked
```

Persistence without honest validation can become fake completion.

### Trusted input

OpenCode base prompts provide operational safety around edits and git but do not consistently establish HSM's full instruction/data boundary. Slice 6 remains authoritative for trusted input.

### Output contract and terminal UX

OpenCode provides practical final-report discipline and awareness of terminal rendering quality.

Its observed TUI strengths—visible plan mode, patch/diff presentation, rollback by conversation point, and todo state—are CLI/harness features, not baseline prompt prose.

### Dynamic runtime context

OpenCode's environment block cleanly injects model/provider, cwd, workspace, platform, git-repo status, and date.

HSM/QuantZhai still targets richer categorized git state, project-rule state, validation commands, and state/provenance support where practical.

---

## 5. Slice 13 Correction: Persistence Must Be State-Grounded

The previous OpenCode synthesis treated persistence mainly as protection against premature abandonment.

That remains useful but is incomplete.

```text
bounded persistence
  !=
continue mutating through uncertain state
```

Correct persistence is:

```text
failure or ambiguous result
  -> preserve needed evidence
  -> stop dependent mutation
  -> continue focused read-only diagnosis
  -> re-establish current state
  -> resume from a verified transition
```

This balances:

```text
FM10:
  abandon useful diagnosis too early

FM13:
  continue dependent mutation too early

FM14:
  destroy evidence needed to diagnose or recover
```

OpenCode's completion bias is useful only when paired with state-grounded continuation.

---

## 6. Slice 13 Runtime Questions

Current comparison evidence does not prove whether OpenCode provides:

- explicit precondition/postcondition contracts;
- a trusted-state commit gate;
- reliable process or run identity;
- output/result lineage;
- diagnostic evidence retention;
- cleanup boundaries;
- dependency-aware mutation blocking;
- state invalidation and read-only recovery mode;
- rollback semantics beyond UI conversation rollback.

These should remain questions, not inferred capabilities.

OpenCode's visible modes, rollback affordances, diff rendering, todo state, and environment injection become more important under Slice 13 because closed-loop execution depends on state visibility and recoverability. Their presence does not automatically create state-transition guarantees.

---

## 7. OpenCode Versus Older CLI Family

| Layer | QuantZhai/HSM target | Codex CLI | Claude Code | OpenCode |
|---|---|---|---|---|
| Compactness | semantic compression with preserved boundaries | moderate | often large | mixed by variant |
| Identity | executor/harness as data | strong CLI identity | minimal interactive identity | strongest in `gpt` |
| Tool efficiency | parallel precise tools | good search/patch | strong parallel/subagent | strong in `gpt` |
| Planning | budgeted planning plus explicit modes | strong conditions | strong subagent planning | split between base prompt and plan mode |
| Project authority | scoped rules plus convention | strongest AGENTS semantics | injected memory hierarchy | strong convention, weaker formal semantics |
| Edit safety | critical preservation boundaries | strong | strong | strong in `gpt`/`codex`, uneven family-wide |
| Validation | explicit states plus local postconditions | good, less formal | variable | completion bias strong, state taxonomy weak |
| Trusted input | HSM Slice 6 boundary | limited in base prompt | stronger security/disclosure | inconsistent in base prompts |
| Runtime context | rich state, lineage, recovery where possible | partial | rich | clean env block; advanced state controls unproven |
| CLI workflow UX | QuantZhai design target | functional | functional | strong plan/diff/rollback/todo ideas |
| Closed-loop execution | Slice 13 target | not established here | not established here | not established by current comparison |

---

## 8. High-Confidence Findings

- `gpt.txt` is the strongest OpenCode base-prompt source.
- `codex.txt` is strongest for professional objectivity and practical edit safety.
- `trinity.txt` and `gemini.txt` are strong compact sources for project awareness and local convention.
- `anthropic.txt` and `beast.txt` are stress references, not baseline sources.
- OpenCode validates shared-workspace framing, smallest-correct-change language, dirty-worktree preservation, parallel reads, and concise reporting.
- OpenCode demonstrates the value of runtime-injected environment and visible operating modes.
- OpenCode does not replace HSM's trusted-input, confidence, validation-state, or closed-loop execution models.

## 9. Medium-Confidence Findings

- OpenCode plan mode is relevant to QuantZhai mode design but should remain runtime/UI state.
- Task/subagent surfaces may contain useful exploration and compaction structures but require source-level comparison.
- OpenCode's CLI/TUI affordances may improve supervision and recovery, but exact implementation and reliability remain separate questions.

## 10. Unresolved Findings

- Whether provider-selected prompt routing causes materially inconsistent safety or execution behaviour.
- Whether OpenCode variants outperform the QuantZhai baseline on local tasks.
- Whether plan-mode ceremony improves enough complex tasks to justify its cost.
- Whether OpenCode preserves diagnostic evidence or exposes reliable postconditions in practice.
- How much observed UX strength comes from prompt architecture versus TUI implementation.

---

## 11. Preserve For Later Prompt Work

```text
professional objectivity
shared-workspace executor framing
smallest correct change
parallel independent reads
no noisy chained shell output
dirty-worktree preservation
file-creation guard
local convention/library/style discipline
state-grounded persistence
findings-first review mode
concise final report
runtime environment block pattern
```

## 12. Preserve For Runtime / CLI Design

```text
plan/build/read-only mode boundary
visible mode state
plan-file-only exception
parallel exploration in plan mode
interactive rollback
side-by-side diff/patch rendering
todo/progress UI
permission common-node handling
reliable state observations
run/result identity
diagnostic evidence retention
mutation pause and recovery state
```

## 13. Preserve As Rejection / Stress Input

```text
universal web research
perfect-solution language
automatic .env creation
fixed large-read rules
one-tool-per-message constraints where parallelism exists
boastful identity
unbounded persistence
mutation through uncertain state
```

---

## 14. Final Decision

OpenCode is most useful as evidence that prompt text, runtime reminders, permissions, mode state, task prompts, and TUI affordances work together.

It should not be flattened into a list of sentences for a candidate prompt.

The HSM synthesis should borrow OpenCode's practical workflow strengths while retaining stronger boundaries for:

- scoped authority;
- trusted input;
- user-work preservation;
- confidence and validation states;
- precondition and postcondition verification;
- dependent-action gating;
- evidence-preserving recovery.

Slice 13 therefore strengthens the runtime/CLI interpretation of OpenCode rather than claiming that OpenCode already solves closed-loop execution.