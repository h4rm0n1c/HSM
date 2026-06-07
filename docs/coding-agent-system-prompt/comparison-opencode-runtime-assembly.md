# Comparison: OpenCode Runtime Assembly vs Research Findings

Status: research output  
Date: 2026-06-07  
Source: `anomalyco/opencode` `dev` runtime prompt assembly surfaces  
Research basis: `research-opencode-source-map.md`, `final-opencode-findings-synthesis.md`, `comparison-quantzhai-codex-core-qwenified.md`, `comparison-codex-cli-max.md`, `comparison-claude-code.md`, `research-external-prompt-comparison.md`  
Candidate prompt drafting: out of scope

---

## Purpose

This document compares OpenCode's runtime prompt assembly with the HSM coding-agent prompt research.

The question is not "which prompt text should we copy?"

The question is:

```text
Which OpenCode behaviours belong to static prompt text,
which belong to runtime injection,
which belong to CLI/TUI state,
and which are unresolved until fixture testing?
```

This restores the same comparison discipline used by the older QuantZhai, Codex CLI, Claude Code, and external prompt reports.

---

## Source Boundary

Primary source files inspected:

```text
packages/opencode/src/session/system.ts
packages/opencode/src/session/reminders.ts
packages/opencode/src/session/prompt/plan.txt
packages/opencode/src/session/prompt/plan-mode.txt
packages/opencode/src/session/prompt/build-switch.txt
packages/opencode/src/tool/task.txt
packages/opencode/src/agent/prompt/explore.txt
packages/opencode/src/agent/prompt/compaction.txt
```

Existing OpenCode base-prompt comparison files remain relevant, but this document focuses on runtime assembly.

Not fully audited yet:

```text
plugin transforms
permission implementation details
command template invocation rules
complete tool schema payloads
TUI state implementation
agent configuration override paths
```

Claim status:

- `supported` for directly observed source behaviour in files listed above
- `plausible_but_unproven` for runtime consequences not yet fixture-tested
- `user-observed` for TUI behaviours not source-confirmed in this pass

---

## 1. Runtime Assembly Model

Observed:

OpenCode assembles behaviour from multiple layers:

```text
base prompt selected by provider/model ID
runtime environment block
skills block if skill permission is enabled
session reminders for plan/build transitions
instruction/reference file expansion
command templates
tool descriptions and schemas
task/subagent prompts
plugins and permissions
```

Validated by our research:

This strongly confirms Rule Zero:

```text
Do not confuse the static prompt with the operating system around it.
```

OpenCode's useful behaviour cannot be judged from `gpt.txt` or `default.txt` alone. Static prompt text is only one layer.

Challenged by our research:

The previous OpenCode synthesis treated the base prompt family as the main source and only footnoted runtime assembly. That was insufficient compared with the older Claude Code comparison, which explicitly considered subagents, memory, tool schemas, environment injection, and git safety architecture.

What OpenCode does better:

OpenCode's runtime assembly is modular and readable. `system.ts` cleanly separates provider prompt selection, environment block generation, and skills block generation.

What OpenCode does worse:

The visible source map is distributed. There is no single static full prompt file to compare. This makes shallow prompt dumps misleading.

Gap:

HSM still needs a full "what actually gets sent" trace for a real model/session, especially for `opencode-go/deepseek-v4-flash`.

Runtime vs prompt placement:

Runtime assembly belongs in harness design. Static prompt text should stay compact and only carry durable behavioural rules.

Decision:

Treat OpenCode runtime assembly as a first-class comparison layer. Do not update candidate structures from OpenCode base prompt files alone.

Fixture implication:

Add one fixture/check that records assembled prompt surfaces for a representative OpenCode session, without relying only on file names.

---

## 2. Provider / Base Prompt Selection

Observed:

`system.ts` selects base prompt text from model ID matching:

```text
gpt-4 / o1 / o3       -> beast.txt
gpt + codex           -> codex.txt
other gpt             -> gpt.txt
gemini-*              -> gemini.txt
claude                -> anthropic.txt
trinity               -> trinity.txt
kimi                  -> kimi.txt
everything else       -> default.txt
```

Validated by our research:

This explains why OpenCode must be analysed as a family. Different models can receive materially different base prompt policies.

Challenged by our research:

Provider-string routing can create inconsistent behaviour. A strong model with an unrecognised ID may receive `default.txt`, while GPT-4/o1/o3 receive `beast.txt`, which the current resynthesis treats as a stress source rather than a baseline.

What OpenCode does better:

Provider-specific prompt selection allows different model families to receive tuned instructions.

What OpenCode does worse:

String matching is brittle as a research target. It can hide the real prompt for a given provider/model unless the exact model ID is known.

Gap:

We have not yet traced provider or agent overrides that may alter this selection.

Runtime vs prompt placement:

Prompt-family selection is runtime configuration. It should be documented in source maps, not copied into a baseline prompt.

Decision:

Use provider routing as evidence that OpenCode is not one prompt. Do not assume `gpt.txt` applies to DeepSeek/OpenCode Go.

Fixture implication:

Create a source-check fixture or script that prints selected base prompt for a model ID list.

---

## 3. Environment Injection

Observed:

`system.ts` injects a model/environment block containing:

```text
model name
provider/model ID
working directory
workspace root folder
whether the directory is a git repo
platform
today's date
```

Validated by our research:

This matches Slice 7 and the final synthesis: dynamic facts belong in runtime context. It also aligns with Claude Code and other CLI-family systems that inject environment facts separately from base prompt wording.

Challenged by our research:

OpenCode's git state is thin. It reports whether the directory is a git repo, but not branch, dirty files, staged files, untracked files, or overlap with files the agent may edit.

What OpenCode does better:

The `<env>` block is compact, model-readable, and clearly separated from the base prompt.

What OpenCode does worse:

It does not provide enough worktree detail to enforce dirty-worktree preservation by itself.

Gap:

QuantZhai/HSM wants categorized git state and validation command hints. OpenCode source inspected here does not prove those are injected.

Runtime vs prompt placement:

Environment data should be runtime-injected. Dirty-worktree safety still needs both runtime data and prompt-level behavioural rules.

Decision:

Adopt the environment-block pattern as validated architecture. Preserve richer QuantZhai/HSM git-state requirements.

Fixture implication:

Compare behaviour with: no env block, OpenCode env block, and rich HSM git-state block.

---

## 4. Skills Injection

Observed:

`system.ts` can inject skills guidance when the agent has skill permission. It says skills provide specialized instructions/workflows and tells the agent to use the skill tool when a task matches a skill description. It also deliberately presents a verbose skill list in the prompt block.

Validated by our research:

This is runtime capability discovery, not static prompt design. It matches the broader pattern that tool and skill catalogues should be injected when relevant.

Challenged by our research:

Verbose skill listing can consume context. HSM's proportional-compactness rule says such material must earn token budget through task relevance.

What OpenCode does better:

It keeps skill availability conditional on permission state and agent configuration.

What OpenCode does worse:

The source comment says agents ingest verbose skill descriptions better in this location, but this is an implementation observation, not a general prompt-law. It needs local verification before copying.

Gap:

No HSM-side skill injection policy exists yet for QuantZhai CLI.

Runtime vs prompt placement:

Skills belong in runtime/context injection. Static baseline should only know how to respect relevant injected capabilities.

Decision:

Record skill injection as a runtime architecture pattern. Do not add skill-specific material to candidate prompt structures yet.

Fixture implication:

Later test whether verbose skill descriptions improve tool selection enough to justify their context cost.

---

## 5. Reminder Injection / Mode State

Observed:

`reminders.ts` mutates the last user message with synthetic text parts when plan/build mode conditions apply.

Non-experimental path:

```text
if current agent is plan:
  inject plan.txt

if previous assistant agent was plan and current agent is build:
  inject build-switch.txt
```

Experimental path:

```text
if switching from plan to non-plan:
  inject build-switch.txt and optional plan-file path

if current agent is plan:
  inject plan-mode.txt with concrete plan-file instruction
```

Validated by our research:

This is a clean example of runtime mode reminders. It matches HSM's separation between upstream planning/arbitration and coding-agent worker execution.

Challenged by our research:

The earlier OpenCode synthesis under-weighted this layer. Plan/build mode is not just a prompt idea; it is runtime state plus injected reminders plus UI workflow.

What OpenCode does better:

It treats mode transitions explicitly. The build switch removes read-only constraints when execution resumes.

What OpenCode does worse:

The split between non-experimental `plan.txt` and experimental `plan-mode.txt` means there are two planning behaviours to compare. The current docs must not blend them.

Gap:

The TUI trigger and user-visible mode state are not source-confirmed in this file. User observation says Tab toggles plan mode with strong colour/state signalling, but that remains a CLI UX note until TUI source is inspected.

Runtime vs prompt placement:

Mode reminders belong to runtime injection. Static base prompt should only obey the active mode state.

Decision:

Create a dedicated plan-mode comparison. Do not merge plan-mode details into the final synthesis yet.

Fixture implication:

Use mode-specific fixtures: plan mode must avoid edits; build mode may edit after switch; plan file exception must be respected.

---

## 6. Task / Subagent Tool Prompt

Observed:

`task.txt` gives clear subagent-use boundaries:

```text
use direct tools for specific file reads
use direct search for specific class definitions
use direct file reads for code in known 2-3 files
use subagents for complex, multistep work
launch multiple agents concurrently where possible
provide detailed task descriptions and expected return format
state whether code writing or research is expected
state how to verify work if possible
```

Validated by our research:

This strongly supports the distinction between needle queries and broad exploration. It also matches the research finding that subagents should not replace the main agent's understanding.

Challenged by our research:

`task.txt` says subagent outputs should generally be trusted. HSM's stronger rule is trust-but-verify before reporting completion, especially for code changes.

What OpenCode does better:

It gives practical operational boundaries for when not to use a subagent. This is more concrete than generic "delegate where useful" advice.

What OpenCode does worse:

It may over-trust subagent outputs unless paired with a verification rule.

Gap:

Need compare task prompt with Explore and Plan agent prompts as a set.

Runtime vs prompt placement:

Subagent prompt contracts belong to tool/runtime definitions. The main prompt should carry only compact accountability rules.

Decision:

Create `comparison-opencode-agent-task-compaction.md` before changing final synthesis.

Fixture implication:

Add or reuse fixtures where a subagent returns plausible but incomplete findings; main agent must verify before reporting.

---

## 7. Explore Agent Prompt

Observed:

`explore.txt` defines a file search specialist. It prioritizes glob/search/read operations, returns absolute paths, avoids emojis, and must not create files or run commands that modify system state.

Validated by our research:

This aligns with plan-mode Phase 1: explore agents are for read-only understanding, not implementation.

Challenged by our research:

The prompt permits Bash for file operations like copying, moving, or listing, but later says not to modify system state. That wording should be reviewed because copying/moving can be state-modifying.

What OpenCode does better:

It keeps exploration role-bounded and output-specific.

Gap:

Need check whether tool permissions prevent mutation for Explore agents, or whether the prompt text is the only guard.

Runtime vs prompt placement:

Explore-agent behaviour belongs in agent-specific prompt/tool permissions, not the base worker prompt.

Decision:

Treat Explore as a useful specialised-agent pattern with one wording/permission ambiguity.

Fixture implication:

Explore-agent fixture should attempt a tempting write/modification and verify it stays read-only.

---

## 8. Compaction Prompt

Observed:

`compaction.txt` defines an anchored context summarizer for coding sessions. It tells the summarizer to focus on older context, update existing summaries, preserve exact file paths and identifiers when known, keep requested sections, use terse bullets, and avoid speaking as if answering the conversation.

Validated by our research:

This is directly relevant to Slice 8 high-value atom preservation. It supports the HSM view that compaction is not generic summarization; it is preservation of continuation-critical atoms.

Challenged by our research:

OpenCode's compaction prompt preserves file paths and identifiers, but HSM's atom list is broader: CLI flags, environment variables, versions, exact error text, negations, explicit user corrections, model names, and project-specific proper nouns.

What OpenCode does better:

The anchored-summary behaviour is compact and practical. It has a clear previous-summary update model.

What OpenCode does worse:

It does not explicitly classify stale facts or exact negations with the same rigor as HSM's Slice 8 target.

Runtime vs prompt placement:

Compaction belongs to runtime/agent prompt design, not static coding-agent baseline text.

Decision:

Use OpenCode compaction as supporting evidence for Slice 8, not as a replacement.

Fixture implication:

Run compaction fixtures with paths, flags, errors, negations, and user corrections; compare OpenCode-style compaction against HSM high-value atom preservation.

---

## 9. Runtime Assembly Decision Table

| Finding | Placement | Decision |
| --- | --- | --- |
| Provider prompt routing | Runtime config | Document and test; do not copy into prompt |
| `<env>` block | Runtime injection | Keep pattern; enrich for HSM/QuantZhai |
| Skills list | Runtime injection | Conditional; evaluate token cost |
| Plan/build reminders | Runtime mode injection | Dedicated plan-mode comparison required |
| Task/subagent prompt | Tool/runtime contract | Dedicated subagent comparison required |
| Explore prompt | Agent-specific prompt + permissions | Useful pattern; verify read-only enforcement |
| Compaction prompt | Runtime compaction agent | Supports Slice 8; expand atom preservation for HSM |
| UI diff/rollback/todo/plan colour | CLI/TUI design | Not prompt text; track separately |

---

## 10. Conclusion

OpenCode's runtime assembly strongly supports the HSM rule that a coding agent is not defined by a single system prompt file.

The useful OpenCode lesson is architectural:

```text
base prompt text should stay compact
runtime injects live state
mode reminders enforce current workflow
subagent prompts specialize bounded tasks
TUI state makes mode and recovery visible
```

Current status:

```text
Runtime assembly comparison complete enough for source-map purposes.
Plan mode and subagent/compaction still need dedicated comparison docs.
Candidate prompt drafting remains out of scope.
```
