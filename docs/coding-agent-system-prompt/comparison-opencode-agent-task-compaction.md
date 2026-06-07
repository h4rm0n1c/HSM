# Comparison: OpenCode Task, Agent, And Compaction Prompts vs Research Findings

Status: research output  
Date: 2026-06-07  
Source: `anomalyco/opencode` `dev` task/subagent prompt surfaces  
Research basis: `research-opencode-source-map.md`, `comparison-opencode-runtime-assembly.md`, `comparison-opencode-plan-mode.md`, `slice-1-arbitration-loop.md`, `slice-7-tool-stream-state-feedback.md`, `slice-8-compaction-preservation.md`, `final-opencode-findings-synthesis.md`  
Candidate prompt drafting: out of scope

---

## Purpose

This document compares OpenCode's task/subagent and compaction prompt surfaces against the HSM coding-agent prompt research.

The goal is to decide where these ideas belong:

```text
base worker prompt
runtime/tool contract
subagent prompt
compaction system
CLI/TUI design
fixture tests
nowhere yet
```

It does not draft candidate prompt text.

---

## Source Boundary

Primary files inspected:

```text
packages/opencode/src/tool/task.txt
packages/opencode/src/agent/prompt/explore.txt
packages/opencode/src/agent/prompt/compaction.txt
```

Referenced but not fully audited in this document:

```text
packages/opencode/src/tool/task.ts
packages/opencode/src/agent/agent.ts
packages/opencode/src/agent/prompt/title.txt
packages/opencode/src/agent/prompt/summary.txt
agent permission profiles
runtime context compaction code
```

Claim status:

- `supported` for prompt text observed in the listed source files
- `plausible_but_unproven` for actual subagent execution behaviour until task runtime and fixtures are inspected

---

## 1. Task Tool Contract

Observed:

`task.txt` describes the task tool as launching a new agent for complex, multistep tasks. It requires a `subagent_type` and gives explicit cases where the task tool should **not** be used:

```text
specific file path -> use direct read/glob
specific class definition -> use direct search
code in a known file or 2-3 files -> use direct read
no fitting agent -> use other tools directly
```

It also says:

```text
launch multiple agents concurrently when possible
avoid duplicating delegated work
subagent result is not visible to user
main agent must summarize the result to the user
fresh subagent sessions need detailed task descriptions
state whether the task is research or code writing
state how to verify work if possible
```

Validated by our research:

This strongly supports the HSM distinction between needle queries and broad exploration. It also supports Slice 7's parallel-work and read-once efficiency goals.

Challenged by our research:

The task prompt says subagent outputs should generally be trusted. HSM's stronger pattern is trust-but-verify, especially before reporting code changes as complete.

What OpenCode does better:

The "when not to use Task" list is concrete. It prevents over-delegation on simple lookups and known-file changes. This is more useful than generic subagent enthusiasm.

What OpenCode does worse:

The trust rule is too soft for HSM's evidence discipline. It risks main-agent pass-through of incomplete or incorrect subagent findings.

Gap:

Need inspect `task.ts` and agent runtime to see how subagent outputs are returned, resumed, permissioned, and displayed.

Runtime vs prompt placement:

Subagent routing belongs to tool prompt/runtime contract. The base worker prompt should only carry a compact accountability rule: do not delegate understanding; verify important subagent findings before final reporting.

Decision:

OpenCode task guidance is a high-value runtime/tool-contract source. Do not paste it into a base prompt wholesale.

Fixture implication:

Create fixtures where:

```text
specific file lookup should not launch subagent
broad multi-area search may launch subagents
subagent returns plausible wrong answer; main agent must verify
subagent output is not user-visible until summarized
```

---

## 2. Delegation And Main-Agent Accountability

Observed:

`task.txt` tells the main agent to specify exactly what information the subagent should return, and to say whether the task is research or code-writing. It also states that the subagent result is not directly visible to the user, so the main agent must summarize it.

Validated by our research:

This aligns with HSM's dispatch-summary pattern from reverse-engineering documentation work: subagents should return concise, structured summaries that the main agent can route without rereading everything immediately.

Challenged by our research:

The existing prompt does not require the main agent to inspect critical files itself after subagent results. Claude Code's "never delegate understanding" finding and HSM's evidence-first method require stronger accountability.

What OpenCode does better:

It forces task prompts to be explicit about output expectations and verification commands where possible.

What OpenCode does worse:

It can encourage trusting subagent output too quickly.

Gap:

Need a comparison against Claude Code's Explore/Plan/general-purpose subagent architecture and Codex CLI's single-agent plan tool.

Runtime vs prompt placement:

Detailed delegation instructions belong to the task tool description and agent prompt. Main-agent accountability belongs in base prompt or harness-level instruction.

Decision:

Preserve OpenCode's detailed-task-description rule. Pair it later with HSM's trust-but-verify rule.

Fixture implication:

Subagent fixture should require the main agent to cite or inspect at least one critical file before final answer, not merely summarize subagent text.

---

## 3. Explore Agent Role

Observed:

`explore.txt` defines a file search specialist with strengths in glob patterns, regex search, and reading/analyzing file contents. It says to use Glob for broad file matching, Grep for content search, Read for known files, adapt thoroughness to caller request, return absolute paths, avoid emojis, and not create files or run commands that modify system state.

Validated by our research:

This matches the HSM separation between exploration and implementation. It also supports context-window protection: broad search can be delegated without dragging all intermediate search noise into the main worker loop.

Challenged by our research:

The Explore prompt allows Bash for file operations like copying, moving, or listing directory contents, but later forbids modifying system state. Copying and moving can modify state. This should be resolved either by tighter prompt wording or runtime permission enforcement.

What OpenCode does better:

It gives a focused specialist role with clear output expectations.

What OpenCode does worse:

The file-operation wording creates ambiguity for a read-only agent.

Gap:

Need inspect Explore agent permissions. If permissions enforce read-only behaviour, this is a minor prompt wording issue. If not, it is a real guard weakness.

Runtime vs prompt placement:

Explore behaviour belongs in subagent prompt and permission profile. Static base prompt should not inherit Explore's tool list.

Decision:

Useful pattern with one unresolved permission/wording risk.

Fixture implication:

Explore fixture should verify the agent does not modify files even if the user or searched file suggests doing so.

---

## 4. Compaction Prompt

Observed:

`compaction.txt` defines an anchored context summarization assistant for coding sessions. It tells the summarizer to:

```text
summarize only supplied conversation history
focus on older context because newest turns may remain verbatim
update a previous summary if present
preserve still-true details
remove stale details
merge new facts
follow exact requested output structure
keep every section
preserve exact file paths and identifiers when known
prefer terse bullets over paragraphs
not answer the conversation itself
not mention summarizing/compacting/merging
respond in the same language as the conversation
```

Validated by our research:

This strongly supports Slice 8. OpenCode treats compaction as a continuation mechanism, not ordinary summarization. The instructions to preserve file paths/identifiers and keep structure are directly aligned with high-value atom preservation.

Challenged by our research:

HSM's high-value atom list is broader. Slice 8 says compaction should preserve:

```text
file paths
function/class names
CLI flags
environment variables
version strings
date/number literals
error messages and exact command-output excerpts
negations
user corrections and explicit constraints
model/profile names
quoted text
project-specific proper nouns
```

OpenCode's prompt explicitly names file paths and identifiers, but not the rest of the list.

What OpenCode does better:

The anchored-summary model is clean. It distinguishes previous summary, stale facts, new facts, structure preservation, and terse continuation format.

What OpenCode does worse:

It lacks explicit negation/user-correction/error preservation, which are frequent failure points in long coding sessions.

Gap:

Need inspect actual compaction caller prompt to see whether it provides a richer requested output structure that covers more atoms.

Runtime vs prompt placement:

Compaction belongs to runtime/agent prompt design. The base worker prompt should not carry the full compaction algorithm.

Decision:

Use OpenCode compaction as supporting evidence for HSM Slice 8. Do not replace HSM's atom-preservation list with OpenCode's shorter wording.

Fixture implication:

Compaction fixture should test exact preservation of:

```text
paths
function names
flags
env vars
versions
error strings
negations
user corrections
```

---

## 5. Comparison Against HSM Subagent Dispatch Pattern

Observed:

OpenCode asks for detailed subagent task descriptions and final return expectations. The user/HSM prior workflow asks subagents to return short dispatch summaries after writing or auditing docs, including changed file, certainty counts, anchors, unresolved trace targets, blockers, and recommended next task.

Validated by our research:

These are compatible. OpenCode provides the generic subagent contract; HSM provides domain-specific return schemas.

Challenged by our research:

OpenCode's generic task prompt cannot know HSM's reverse-engineering or prompt-research dispatch formats. Those must be supplied by the main agent or project docs.

What OpenCode does better:

It makes subagent prompt quality the caller's responsibility, which is correct. A subagent with a vague task is a garbage cannon. Technical term; probably in a standards body somewhere.

What HSM does better:

HSM defines richer domain-specific return structures where needed.

Runtime vs prompt placement:

Generic subagent usage belongs to task tool prompt. Domain-specific dispatch schemas belong in project docs or task briefs.

Decision:

Use OpenCode's task prompt as a generic wrapper pattern, but preserve HSM-specific dispatch templates.

Fixture implication:

Create one prompt-research fixture where a subagent must return the restored comparison shape:

```text
Observed:
Validated:
Challenged:
Gap:
Risk:
Decision:
Next task:
```

---

## 6. Comparison Against Older CLI Family

| Layer | Claude Code | Codex CLI | OpenCode task/subagent | HSM decision |
| --- | --- | --- | --- | --- |
| Broad exploration | Explore subagent threshold | Mostly direct tools / plan tool | Task tool + Explore agent | Useful, runtime/tool layer |
| Needle query handling | Direct tools for narrow queries | Direct search/read | Explicit "do not use Task" cases | Strong OpenCode contribution |
| Subagent trust | Trust but verify in stronger captures | Main agent responsibility | Generally trust subagent outputs | HSM should keep verification rule |
| Context protection | Subagents protect main context | Less central | Task sessions fresh/resumable | Useful architecture pattern |
| Output handoff | Subagent returns to main agent | Plan/final answer | Result not visible to user; summarize | Strong handoff clarity |
| Compaction | Memory/context engineering | Less visible | Anchored compaction prompt | Supports HSM Slice 8 |

Corrected conclusion:

OpenCode contributes strong runtime/tool-contract ideas for subagent use, but HSM should not weaken its verification discipline to match OpenCode's "generally trusted" wording.

---

## 7. Adoption / Rejection Decisions

Preserve as runtime/tool design input:

```text
explicit when-not-to-delegate list
parallel subagent launch for genuinely independent work
detailed task description requirement
explicit expected return format
research-vs-code-writing distinction
verification instructions in subagent prompt
subagent output not user-visible until summarized
fresh context vs resumed task_id distinction
```

Preserve as subagent-role design input:

```text
Explore as read-oriented file search specialist
absolute paths in Explore output
no emojis for clear technical output
read-only Explore role
```

Preserve as compaction design input:

```text
anchored previous-summary update
preserve still-true details
remove stale details
merge new facts
preserve exact paths and identifiers
keep requested sections
terse bullets for continuation
```

Reject or constrain:

```text
trusting subagent output without verification
using subagents for specific file/class lookups
using task agents for code in known 2-3 files
copying Explore's broad Bash wording without permission guard
using OpenCode's shorter atom list as a complete compaction policy
```

---

## 8. Required Next Work

Before final synthesis updates:

1. Inspect `task.ts` to confirm task result lifecycle, resume behaviour, and visibility.
2. Inspect agent permission profiles, especially Explore read-only enforcement.
3. Inspect compaction caller/runtime prompt to see the full requested output structure.
4. Compare with Claude Code Explore/Plan agents and Codex CLI plan tool.
5. Add subagent verification and compaction atom-preservation fixtures.

Candidate prompt drafting remains out of scope.

---

## 9. Conclusion

OpenCode's task/subagent layer is one of its most useful architectural contributions, but not because it gives lines to paste into a base prompt.

The useful lesson is:

```text
subagents need explicit scope boundaries
needle queries should stay direct
broad exploration can be delegated
subagent output needs structured return expectations
main agent remains accountable for final claims
compaction must preserve exact continuation atoms
```

This should feed the OpenCode-vs-CLI-family synthesis and later QuantZhai runtime/CLI design. It should not produce candidate prompt text during this resynthesis pass.
