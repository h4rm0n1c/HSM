# OpenCode Source Map For Resynthesis

Status: research source map  
Date: 2026-06-07  
Scope: `anomalyco/opencode` prompt and runtime prompt-assembly surfaces relevant to coding-agent prompt research  
Candidate prompt drafting: out of scope

---

## Purpose

This document maps the OpenCode prompt system before deeper comparison work.

The previous OpenCode pass compared the base prompt variants, but it did not fully map the runtime surfaces that assemble the actual prompt context. This map exists to restore the same source-discipline used by the QuantZhai, Codex CLI, Claude Code, and external CLI-family reports.

OpenCode should be treated as a prompt-system family:

```text
provider-selected base prompt
  + runtime environment block
  + skills prompt
  + instruction/reference files
  + command templates
  + task/subagent prompts
  + plan/build reminders
  + permission state
  + TUI workflow state
  + plugin transforms
```

Do not flatten those into one static candidate prompt.

---

## Authority Classes

| Class | Meaning |
| --- | --- |
| `source-confirmed` | Directly observed in OpenCode source files |
| `comparison-derived` | Derived from existing HSM comparison reports |
| `user-observed` | Observed by the user while using OpenCode; useful but not source-confirmed here |
| `inferred` | Reasonable conclusion from source shape; requires later fixture or source confirmation |
| `out-of-scope` | Useful for CLI design but not prompt text |

---

## Source Inventory

| Surface | Path | Evidence class | What it controls | Notes |
| --- | --- | --- | --- | --- |
| Provider prompt selection | `packages/opencode/src/session/system.ts` | source-confirmed | Chooses base prompt by model ID | Routes `gpt-4`/`o1`/`o3` to `beast`, `gpt` to `gpt` or `codex`, `gemini-*` to `gemini`, `claude` to `anthropic`, `trinity` to `trinity`, `kimi` to `kimi`, else `default` |
| Runtime environment block | `packages/opencode/src/session/system.ts` | source-confirmed | Injects model ID, provider/model ID, cwd, workspace root, git-repo boolean, platform, date | Confirms Rule Zero; live facts are runtime-injected, not static prompt text |
| Skills prompt | `packages/opencode/src/session/system.ts` | source-confirmed | Adds skill-loading instructions and verbose skill list when skill permission is enabled | Runtime capability catalogue, not baseline prompt rule |
| Base prompt: default | `packages/opencode/src/session/prompt/default.txt` | comparison-derived | Minimal fallback prompt | Useful compactness reference, weak baseline |
| Base prompt: gpt | `packages/opencode/src/session/prompt/gpt.txt` | comparison-derived | Shared-workspace pragmatic worker prompt | Strongest OpenCode base-prompt source so far |
| Base prompt: codex | `packages/opencode/src/session/prompt/codex.txt` | comparison-derived | Professional objectivity / coding-agent discipline | Strong objectivity source |
| Base prompt: trinity | `packages/opencode/src/session/prompt/trinity.txt` | comparison-derived | Compact project-aware prompt | Strong compact repo-authority source |
| Base prompt: gemini | `packages/opencode/src/session/prompt/gemini.txt` | comparison-derived | Local convention / library / style discipline | Strong convention source |
| Base prompt: kimi | `packages/opencode/src/session/prompt/kimi.txt` | comparison-derived | Concise task framing | Compactness/style reference only |
| Base prompt: anthropic | `packages/opencode/src/session/prompt/anthropic.txt` | comparison-derived | Persistence-heavy variant | Stress reference only |
| Base prompt: beast | `packages/opencode/src/session/prompt/beast.txt` | comparison-derived | Aggressive autonomous completion | Rejection/stress source, not baseline |
| Max steps prompt | `packages/opencode/src/session/prompt/max-steps.txt` | source listed, not yet analysed | Step-limit / continuation pressure | Needs later inspection if used in runtime assembly |
| Session reminders | `packages/opencode/src/session/reminders.ts` | source-confirmed | Injects plan/build reminder text into user message parts | Critical mode-boundary surface |
| Plan reminder | `packages/opencode/src/session/prompt/plan.txt` | source-confirmed | Legacy/simple plan mode: read-only, no modifications, plan responsibility | Runtime reminder, not base prompt |
| Experimental plan mode | `packages/opencode/src/session/prompt/plan-mode.txt` | source-confirmed | Read-only plan mode with plan file, explore agents, design/review/final plan, plan exit | Needs dedicated comparison |
| Build switch | `packages/opencode/src/session/prompt/build-switch.txt` | source-confirmed | Signals transition from plan to build mode | Runtime state transition, not static prompt rule |
| Task tool prompt | `packages/opencode/src/tool/task.txt` | source-confirmed | Tells main agent when to use subagents and what to provide them | Important for exploration and delegation discipline |
| Explore agent prompt | `packages/opencode/src/agent/prompt/explore.txt` | source-confirmed | Search-only specialist; no file creation or state modification | Supports plan-mode exploration and broad search |
| Compaction prompt | `packages/opencode/src/agent/prompt/compaction.txt` | source-confirmed | Anchored summarization; preserve exact file paths and identifiers | Directly relevant to Slice 8 high-value atom preservation |
| Title/summary prompts | `packages/opencode/src/agent/prompt/title.txt`, `summary.txt` | source listed, not yet analysed | Session metadata and summaries | Lower priority |
| Command templates | `packages/opencode/src/command/template/initialize.txt`, `review.txt` | source listed, not yet analysed | Slash/command workflow prompts | Needed for full runtime-assembly comparison |
| Shell prompt surfaces | `packages/opencode/src/tool/shell/shell.txt`, `prompt.ts` | source listed, not yet analysed | Shell execution guidance | Needed for tool-contract comparison |
| Permission state | permission modules / runtime | inferred | Governs allowed tools/actions | Source map notes existence; comparison needs source review |
| TUI plan toggle / colour state | TUI runtime | user-observed | Visible mode state | CLI UX design input, not static prompt text |
| TUI diff rendering | TUI runtime | user-observed | Side-by-side patch/diff display quality | CLI UX design input |
| TUI rollback | TUI runtime | user-observed | Undo-to-message / rollback through history | CLI UX design input, not prompt text |
| Todo list UI | TUI/runtime | user-observed | Agent task tracking display | Agentic feature / backend discussion input |

---

## Prompt Selection Findings

Observed:

`system.ts` selects a base prompt from model ID strings. The selector is coarse and provider-name dependent.

Inferred:

A model using a name that does not match the explicit branches falls through to `default.txt`. That matters for `opencode-go/deepseek-v4-flash`: unless the provider or agent config overrides the selected prompt elsewhere, it should receive the default base prompt.

Risk:

The source map has not yet checked agent-level overrides, provider transforms, or plugin transforms. Do not treat fallthrough as the full prompt until runtime assembly is audited.

Decision:

Create `comparison-opencode-runtime-assembly.md` before making claims about what full prompt a specific OpenCode run receives.

---

## Runtime Environment Findings

Observed:

`system.ts` injects:

```text
model name
provider/model ID
working directory
workspace root folder
whether directory is a git repo
platform
date
```

Validated by our research:

This confirms Rule Zero from the final synthesis: dynamic runtime facts belong outside the static base prompt.

Challenged by our research:

The injected git state is only a boolean. HSM/QuantZhai wants categorized dirty-worktree state, because dirty-worktree preservation is a high-severity failure-mode guard.

Decision:

OpenCode validates the environment-block pattern, but not the richer state model.

---

## Plan / Build Mode Findings

Observed:

`reminders.ts` injects plan/build reminders as synthetic user-message parts based on the active agent and `experimentalPlanMode` flag.

The non-experimental path:

```text
agent == plan -> inject plan.txt
previous assistant agent == plan and current agent == build -> inject build-switch.txt
```

The experimental path:

```text
current agent after plan -> inject build-switch plus plan-file note
current plan agent -> inject plan-mode.txt with concrete plan-file path
```

Validated by our research:

This is a runtime mode boundary, not a static prompt preference. It matches the three-loop architecture: planning/arbitration is upstream, build execution is separate.

Risk:

Plan mode can become process-heavy if used for trivial tasks. The prompt does include skip guidance for truly trivial tasks, but fixture work is needed.

Decision:

Create `comparison-opencode-plan-mode.md` before incorporating plan-mode findings into the final synthesis.

---

## Task / Subagent Findings

Observed:

`task.txt` says not to use a subagent for specific file reads, class definitions, or code within 2-3 known files. It recommends direct file/search tools for those cases.

It also says to launch multiple agents concurrently where possible, provide detailed task descriptions, specify what the subagent should return, and clearly tell the subagent whether code writing or research is expected.

Validated by our research:

This matches the needle-query threshold from Claude Code and the HSM rule that broad exploration and directed lookup are different tasks.

Challenged by our research:

The task prompt says subagent outputs should generally be trusted. HSM's stronger rule is trust-but-verify before reporting completion, especially for edits.

Decision:

Create `comparison-opencode-agent-task-compaction.md` to reconcile OpenCode's subagent guidance with HSM's accountability and verification rules.

---

## Compaction Findings

Observed:

`compaction.txt` frames compaction as anchored context summarization. It says to preserve exact file paths and identifiers when known, keep the requested output structure, and use terse bullets over paragraphs.

Validated by our research:

This strongly overlaps Slice 8: preserve high-value atoms during compaction. It is one of the best OpenCode runtime prompts for HSM context-preservation research.

Challenged by our research:

The prompt names file paths and identifiers, but not the full HSM high-value atom set: CLI flags, env vars, version strings, exact error strings, negations, user corrections, model names, and project-specific proper nouns.

Decision:

Use OpenCode compaction as supporting evidence, not a replacement for HSM Slice 8.

---

## User-Observed CLI Workflow Findings

Observed by user:

```text
OpenCode has strong side-by-side patch/diff terminal rendering.
OpenCode rollback is a TUI/OSC history selection behaviour, not necessarily a slash command.
OpenCode has a useful todo list function.
OpenCode has a useful Tab-toggled plan mode with obvious whole-terminal state colour.
OpenCode can be flickery and CPU-heavy.
OpenCode can have occasional permission-spam bugs.
```

Classification:

These are CLI/harness design findings. They should not be converted into static prompt rules.

Decision:

Track them in later QuantZhai CLI design work, especially UI state, diff rendering, rollback, permissions, and todo/task-state design.

---

## Required Follow-Up

1. Write `comparison-opencode-runtime-assembly.md`.
2. Write `comparison-opencode-plan-mode.md`.
3. Write `comparison-opencode-agent-task-compaction.md`.
4. Write `research-opencode-vs-cli-family.md` after the above.
5. Update `final-findings-synthesis.md` only after the resynthesis docs exist.
6. Do not draft `candidate-system-prompt-v0.md` during this pass.
