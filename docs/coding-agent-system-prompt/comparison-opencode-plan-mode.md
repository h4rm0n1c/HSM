# Comparison: OpenCode Plan Mode vs Research Findings

Status: research output  
Date: 2026-06-07  
Source: `anomalyco/opencode` `dev` plan/build reminder surfaces  
Research basis: `research-opencode-source-map.md`, `comparison-opencode-runtime-assembly.md`, `slice-1-arbitration-loop.md`, `slice-2-anti-agreement-self-critique.md`, `slice-3-context-position-middle-loss.md`, `final-opencode-findings-synthesis.md`  
Candidate prompt drafting: out of scope

---

## Purpose

This document compares OpenCode plan mode with HSM's arbitration-loop and coding-agent prompt research.

The central correction:

```text
OpenCode plan mode is not a base-prompt style.
It is a runtime mode with injected reminders, plan-file rules,
subagent orchestration, and user-visible workflow state.
```

Therefore, plan-mode findings belong primarily to runtime / CLI design and upstream arbitration, not candidate prompt text.

---

## Source Boundary

Primary files:

```text
packages/opencode/src/session/reminders.ts
packages/opencode/src/session/prompt/plan.txt
packages/opencode/src/session/prompt/plan-mode.txt
packages/opencode/src/session/prompt/build-switch.txt
packages/opencode/src/tool/task.txt
packages/opencode/src/agent/prompt/explore.txt
```

User-observed behaviour, not source-confirmed in this pass:

```text
Tab toggles plan mode
whole terminal clearly changes colour/state when plan mode is active
plan mode is useful in practice
```

Not yet audited:

```text
TUI implementation of plan mode
plan_exit implementation
question tool implementation
agent config for plan/build modes
permission enforcement behind read-only mode
```

Claim status:

- `supported` for reminder text and source-level injection flow
- `user-observed` for plan-mode toggle and UI state
- `plausible_but_unproven` for behavioural gains until fixtures run

---

## 1. Runtime Injection Flow

Observed:

`reminders.ts` injects plan/build reminder text into the last user message as synthetic parts.

Non-experimental flow:

```text
current agent == plan
  -> inject plan.txt

previous assistant agent == plan and current agent == build
  -> inject build-switch.txt
```

Experimental flow:

```text
switching out of plan mode
  -> inject build-switch.txt
  -> if plan file exists, add plan-file execution note

current agent == plan and previous assistant was not plan
  -> inject plan-mode.txt
  -> substitute concrete plan-file instruction
```

Validated by our research:

This cleanly separates planning and building. It maps to the older three-loop architecture:

```text
upstream arbitration / planning loop
coding-agent worker loop
runtime integrity loop
```

Challenged by our research:

The previous OpenCode synthesis treated planning as a candidate prompt option. That is the wrong abstraction. Plan mode is runtime state plus injected reminder text.

What OpenCode does better:

Mode state is explicit. The agent receives different instructions depending on whether it is planning or building.

What OpenCode does worse:

The source currently shows two plan-mode reminder paths (`plan.txt` and `plan-mode.txt`). They need to be compared separately because they imply different workflows.

Runtime vs prompt placement:

Plan/build boundaries belong to runtime mode injection. Static worker prompts should only respect the active mode.

Decision:

Plan mode should inform QuantZhai CLI/harness design before prompt drafting resumes.

Fixture implication:

Add fixtures for:

```text
plan mode refuses edits
plan mode allows only plan-file edits when explicitly configured
build switch permits execution after plan approval
plan-file path survives handoff to build mode
```

---

## 2. Legacy / Simple Plan Reminder

Observed:

`plan.txt` declares plan mode active, says the agent is in a read-only phase, forbids file edits/modifications/system changes, restricts commands to read/inspect only, and says the current responsibility is to read, search, think, and delegate explore agents to construct a concise but effective plan.

Validated by our research:

This aligns with HSM's upstream arbitration loop. Planning should happen before implementation when the task is non-trivial or ambiguous.

Challenged by our research:

The rule is extremely absolute. That is good for safety, but it relies on runtime/tool enforcement to be robust. Prompt text alone is not enough.

What OpenCode does better:

It makes read-only planning unambiguous. There is no fuzzy "maybe don't edit" language.

What OpenCode does worse:

A fully read-only planning pass can become ceremony for small changes if mode selection is careless.

Gap:

Need verify whether non-read-only tools are actually blocked by permissions, or only discouraged by reminder text.

Runtime vs prompt placement:

This belongs as a mode reminder, not permanent prompt text.

Decision:

Keep as evidence for hard plan-mode boundaries. Do not merge into baseline worker prompt.

Fixture implication:

Run a plan-mode fixture where the user explicitly asks for an edit; the agent must still refuse to edit while in plan mode.

---

## 3. Experimental Plan Mode Workflow

Observed:

`plan-mode.txt` defines a full workflow:

```text
Phase 1: understand request and read related code
Phase 1: launch up to 3 explore agents in parallel when useful
Phase 1: ask clarifying questions up front
Phase 2: launch up to 1 design/general agent for implementation approach
Phase 3: review plans and critical files
Phase 4: write concise final plan to plan file
Phase 5: call plan_exit or ask a question
```

It also states:

```text
only the plan file may be edited
other actions must be read-only
use 1 explore agent for known/small tasks
use multiple explore agents for uncertain/multi-area tasks
quality over quantity
skip plan/design agents only for truly trivial tasks
```

Validated by our research:

This is close to the HSM arbitration loop:

```text
pain / suspicion
  -> exact desired behaviour
  -> asset inventory
  -> donor scan or source scan
  -> constrained implementation brief
  -> coding-agent patch
  -> review/hardening
  -> validation
  -> durable note
```

OpenCode's plan mode converts part of that loop into a runtime mode.

Challenged by our research:

HSM concluded the coding agent should not own the whole arbitration loop. OpenCode plan mode partially gives the agent that responsibility. That can work if the mode is explicitly user-selected, but it should not become default behaviour for every task.

What OpenCode does better:

It gives concrete agent-count heuristics:

```text
1 explore agent for isolated / known-file / small targeted work
multiple explore agents for uncertain scope or multiple areas
3 explore agents maximum
1 design agent maximum
```

These are more operational than generic "plan when useful" wording.

What OpenCode does worse:

It can over-use agents for planning if the default to a Plan agent is applied too broadly. It can also hide too much reasoning in generated plan files if the user just needed a quick answer.

Gap:

Need compare against actual TUI behaviour and plan-file lifecycle.

Runtime vs prompt placement:

The phase workflow belongs to plan-mode reminder text and CLI state. Static prompt text should not carry the full workflow.

Decision:

Adopt plan mode as a runtime design reference, not a candidate prompt section.

Fixture implication:

Create plan-mode tasks in three sizes:

```text
trivial typo: no subagent, no heavy plan
known-file fix: one explore or direct read
uncertain multi-area change: multiple explore agents allowed
```

---

## 4. Build Switch

Observed:

`build-switch.txt` tells the agent its operational mode has changed from plan to build, read-only mode is over, and it may make file changes and run commands.

Validated by our research:

This is important because constraints must be updated near the action point. It matches Slice 3's finding that critical constraints should appear close to the action they govern.

Challenged by our research:

The build switch is short. If the plan file contains constraints or non-goals, the build-phase injection must ensure those survive into execution.

What OpenCode does better:

It explicitly clears the read-only constraint, avoiding ambiguity after planning.

What OpenCode does worse:

The build switch by itself does not restate validation criteria, non-goals, dirty-worktree rules, or trusted-input boundaries.

Gap:

Need inspect whether build-mode receives the plan file, project rules, and runtime state in a sufficiently local/actionable form.

Runtime vs prompt placement:

Mode switch belongs to runtime reminder injection.

Decision:

Good pattern, but incomplete without plan-file and validation handoff evidence.

Fixture implication:

After plan-to-build transition, verify that the agent follows the plan file and does not lose non-goals or validation criteria.

---

## 5. Explore Agents In Plan Mode

Observed:

Plan mode tells the agent to use Explore agents during initial understanding. `explore.txt` defines the Explore agent as a file search specialist that uses glob/search/read, returns absolute paths, avoids emojis, and must not create files or run commands that modify system state.

Validated by our research:

This cleanly separates exploration from implementation. It also protects main context by delegating broad source discovery.

Challenged by our research:

The Explore prompt includes Bash for file operations like copying/moving/listing, but also forbids modifying system state. This should be checked against actual tool permissions because copying/moving are state-modifying.

What OpenCode does better:

It makes exploration a specialised read-oriented role instead of asking the main worker to do everything.

What OpenCode does worse:

Subagent results can be over-trusted unless the main agent verifies critical files and conclusions before implementation.

Gap:

Need inspect agent permission profiles for Explore.

Runtime vs prompt placement:

Explore role belongs to subagent prompt plus tool permissions. Main prompt should only carry a trust-but-verify rule.

Decision:

Useful pattern, but verify enforcement before adopting as a strong conclusion.

Fixture implication:

Create an Explore-agent fixture where the obvious search result is misleading; build-phase agent must still inspect critical files before editing.

---

## 6. Question / Plan Exit Boundary

Observed:

`plan-mode.txt` says the planning turn should end only by asking a user question or calling `plan_exit`. It explicitly says not to use the question tool to ask whether the plan is okay; `plan_exit` is for requesting plan approval.

Validated by our research:

This is a strong mode-completion contract. It avoids vague endings like "here is a plan" without an explicit transition.

Challenged by our research:

The source for `plan_exit` itself was not audited in this pass. The text shows intended behaviour, not implementation details.

What OpenCode does better:

It separates clarification from approval. That is useful: clarification questions resolve uncertainty; plan exit requests transition/approval.

What OpenCode does worse:

If overused, it may force plan approval ceremony even when the user did not need it.

Runtime vs prompt placement:

Question/plan-exit boundary belongs to plan-mode tooling and UI state.

Decision:

Strong runtime-mode design finding. Needs implementation source audit before final synthesis.

Fixture implication:

Plan-mode fixture should ensure the turn ends with either a real clarification question or plan-exit signal, not a vague final paragraph.

---

## 7. Comparison Against Older Systems

| Dimension | Codex CLI | Claude Code | OpenCode plan mode | HSM interpretation |
| --- | --- | --- | --- | --- |
| Planning trigger | Plan tool for non-trivial tasks; skip easy tasks | Subagents and planning architecture | Explicit plan mode / plan agent state | Planning is mode/task dependent |
| Read-only planning | Not central in base comparison | Present through subagent roles and permissions | Strong explicit read-only reminder | Runtime mode, not baseline prompt |
| Subagent exploration | Not central | Explore agent threshold | Up to 3 explore agents in plan mode | Useful for broad scope; avoid for needle queries |
| Plan artifact | Plan tool / TODO-like state | Plan subagent / memory architecture | Plan file with handoff | Plan artifacts belong upstream/runtime |
| Transition to build | Less explicit | Mode/agent dependent | Build switch reminder | Strong pattern if constraints survive handoff |
| User approval | Plan updates and user interaction | Varies | `plan_exit` vs question distinction | Useful UI boundary |

Corrected conclusion:

OpenCode plan mode is closest to a runtime implementation of HSM's upstream arbitration loop. It should shape CLI/harness design before it shapes prompt text.

---

## 8. Adoption / Rejection Decisions

Adopt as runtime design evidence:

```text
explicit plan/build mode separation
read-only planning mode
plan-file handoff concept
mode-specific reminders near action point
parallel explore agents for uncertain scope
minimum necessary agent count
question vs approval distinction
clear user-visible mode state
```

Adopt only with constraints:

```text
plan files: useful for non-trivial work, process sludge for tiny edits
subagent planning: useful for uncertain/multi-area work, overkill for needle queries
plan approval: useful when user explicitly wants a plan or task is risky
```

Reject as static prompt text:

```text
full five-phase plan-mode workflow in every worker prompt
mandatory plan files for normal edits
always launching planning agents
always asking questions before implementation
```

Unresolved:

```text
whether tool permissions enforce read-only mode
whether build mode reliably receives plan constraints
whether TUI mode state can be reproduced in QuantZhai CLI
whether plan mode improves fixture outcomes enough to justify overhead
```

---

## 9. Required Next Work

Before integrating plan-mode findings into `final-findings-synthesis.md`:

1. Inspect TUI/source implementation for plan-mode toggle and visible state.
2. Inspect `plan_exit` implementation and plan-file lifecycle.
3. Inspect permissions for plan/explore agents.
4. Add plan-mode fixtures for read-only enforcement, trivial-task overhead, multi-agent exploration, and build handoff.
5. Compare against Codex CLI planning and Claude Code Explore/Plan subagent architecture.

Candidate prompt drafting remains out of scope.

---

## 10. Conclusion

OpenCode plan mode is a useful runtime architecture finding, not a prompt-copying finding.

The main lesson is:

```text
make planning a visible, enforceable mode
keep implementation out of read-only planning
handoff a concise plan into build mode
use subagents only when scope justifies them
make the mode transition explicit
```

This should feed the OpenCode-vs-CLI-family synthesis and QuantZhai CLI design notes. It should not yet produce candidate prompt text.
