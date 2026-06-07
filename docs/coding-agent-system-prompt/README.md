# Coding Agent System Prompt Subproject

Status: seed workspace  
Parent project: Human State Machine  
Related source project: `h4rm0n1c/quantzhai`

## Purpose

This directory is a dedicated HSM-side workspace for developing coding-agent system prompt structures.

The goal is not to force a single model-internal reasoning style.

The goal is to provide external structure that helps a coding agent reason better over software-development tasks:

- clearer task framing
- better source inspection
- better handoff from suspicion to evidence
- safer edit boundaries
- better validation choices
- cleaner final reporting
- more durable project memory

It is separate from the main HSM subject-state work, but related. HSM is interested in how models operate over structured state and task packets. A coding agent prompt is a narrower version of that problem:

```text
user intent + repo state + tool contract + workflow scaffold
  -> bounded investigation
  -> implementation slice
  -> validation
  -> concise report
  -> durable project memory
```

This subproject captures the prompt structures, workflow scaffolds, and research material needed to build that coding-agent layer deliberately.

## Current boundary

Candidate prompt drafting is paused.

Do not produce `candidate-system-prompt-v0.md` until the user explicitly resumes candidate prompt work.

The current OpenCode resynthesis sequence is complete at research level:

```text
OpenCode source map
  -> OpenCode runtime assembly comparison
  -> OpenCode plan-mode comparison
  -> OpenCode task/subagent/compaction comparison
  -> OpenCode vs CLI-family synthesis
  -> final-findings-synthesis.md update
```

Remaining work is fixture/TUI/runtime verification, not candidate prompt drafting.

## Why this belongs here

QuantZhai is the runtime and prior-art source for local coding-agent behaviour, prompt compression, state injection, and harness experiments.

HSM is the better home for the broader methodology work because this prompt research is about:

- task scaffolding for software-development reasoning
- role and authority boundaries
- evidence-first task structure
- prompt compilation
- instruction layering
- durable memory discipline
- human/assistant/coding-agent arbitration

QuantZhai should stay focused on running the thing. This directory exists to design the structures that make the thing work better.

## Directory map

```text
README.md
  This file. Scope, purpose, and entry point.

AGENTS.md
  Local instructions for agents working inside this subproject.

research-plan.md
  Research protocol: sliced research tasks with verification, correction, and adversarial review gates.

workflow-patterns.md
  Captured working structures from successful QuantZhai and coding-agent development loops.

reference-quantzhai-codex-core-qwenified.md
  Snapshot copy of the current packaged QuantZhai coding-agent system prompt.

research-references.md
  External prompt sources, academic references, internal project references, and flaw observations queued for later research.

internal-project-references.md
  Slice 0 output: source matrix with authority classification, freshness, verification findings, and adversarial review.

slice-1-arbitration-loop.md
  Slice 1 output: arbitration loop analysis, external prompt comparison, coding-agent vs upstream placement decision, candidate structures C1-C5.

slice-2-anti-agreement-self-critique.md
  Slice 2 output: anti-agreement harness adaptation, external review-prompt comparison, minimum viable adversarial check, candidate structures C6-C11.

slice-3-context-position-middle-loss.md
  Slice 3 output: Lost in the Middle paper analysis, position-aware prompt ordering, pre-edit checklist, non-goals placement rule, candidate structures C12-C16.

slice-4-promptware-lifecycle.md
  Slice 4 output: Promptware Engineering paper analysis, Prompt Management in GitHub empirical study, QuantZhai prompt stack inspection, lifecycle tier system, metadata header schema, spellcheck gate, source-ref rule, candidate structures C17-C22.

slice-5-identity-role-and-executor-boundaries.md
  Slice 5 output: executor role header, harness boundary statement, project/repo state-as-data rule, subject identity prohibition (C23-C26). Includes A/B experiment results.

slice-6-safety-untrusted-instructions.md
  Slice 6 output: promptware kill chain analysis, trusted input boundary, disclosure prohibition, tool name non-disclosure, security policy. Sources: arXiv 2601.09625 (full paper), OWASP LLM Top 10 2025, QuantZhai issue #41.

slice-7-tool-stream-state-feedback.md
  Slice 7 output: parallel-call guidance, tool result persistence, runtime feedback acceptance, environment context injection, git state injection. Sources: QuantZhai issues #40, #41, #43, #44.

slice-8-compaction-preservation.md
  Slice 8 output: survival-weighted compaction (QuantZhai issue #8 RFC), high-value atom preservation rule, NetTTS prosody weighting transfer. Compaction safety acceptance criteria.

research-external-prompt-comparison.md
  Slice 9 output: 10-layer comparison of Claude Code, Codex CLI, and Cursor prompts with cross-cutting findings and adoption recommendations.

research-failure-mode-catalog.md
  Research output: 10 coding-agent failure modes mapped to missing prompt structures, with severity ratings and mitigation strategies per mode (FM1-FM10).

research-missing-structures.md
  Research output: cross-reference of 27 vendor prompt structures (M1-M27) against our C1-C26 candidate set, with gap analysis and adoption recommendations by prompt layer.

candidate-structures.md
  Slice 10 consolidation: all C1-C26 and M1-M27 merged, deduplicated, classified (adopt/test/defer/reject), with token cost estimates, test plans, and interaction conflict warnings.

prompt-evaluation-checklist.md
  Slice 10 eval framework: 14-section checklist covering all prompt layers, failure mode coverage matrix, token budget, and eval task ideas.

final-findings-synthesis.md
  Final consolidated synthesis, now updated with the repaired OpenCode prompt-system-family findings.

RESEARCH_STATUS.md
  One-page status matrix, artifact list, next actions, and risk register.

comparison-quantzhai-codex-core-qwenified.md
  Dedicated comparison: QuantZhai `codex-core-qwenified.md` against our 10-slice research findings.

comparison-codex-cli-max.md
  Dedicated comparison: OpenAI Codex CLI (Codex Max) system prompt against our 10-slice research findings.

comparison-claude-code.md
  Dedicated comparison: Claude Code v2.1.143 system prompt against our 10-slice research findings.

final-opencode-findings-synthesis.md
  Resynthesis boundary document for OpenCode. It marks the earlier OpenCode integration as too thin and blocks candidate prompt drafting until the OpenCode layer is repaired.

research-opencode-source-map.md
  Source map for OpenCode prompt/runtime surfaces: base prompts, runtime assembly, reminders, command/tool surfaces, task/subagent prompts, compaction, and user-observed TUI behaviours.

comparison-opencode-runtime-assembly.md
  OpenCode runtime assembly comparison: provider routing, environment injection, skills, reminders, task/subagent prompts, Explore, compaction, and CLI/TUI placement.

comparison-opencode-plan-mode.md
  OpenCode plan-mode comparison: read-only planning, plan-file exception, explore agents, build switch, question vs plan-exit boundary, and runtime placement.

comparison-opencode-agent-task-compaction.md
  OpenCode task/subagent/compaction comparison: when not to delegate, Explore role, main-agent accountability, and anchored compaction.

research-opencode-vs-cli-family.md
  Cross-family synthesis comparing OpenCode against QuantZhai, Codex CLI, Claude Code, Cursor/external matrix, and HSM slice findings.

comparison-opencode-template.md
  Template used for OpenCode base-prompt comparison reports.

comparison-opencode-gpt.md
  OpenCode `gpt.txt` comparison against the research findings. Shared-workspace executor, small correct change, edit-boundary, and concise CLI-output analysis.

comparison-opencode-codex.md
  OpenCode `codex.txt` comparison against the research findings. Professional objectivity, tool discipline, edit-boundary, and anti-agreement relevance.

comparison-opencode-trinity.md
  OpenCode `trinity.txt` comparison against the research findings. Compact all-around prompt, repo authority, validation, and AGENTS.md awareness.

comparison-opencode-gemini.md
  OpenCode `gemini.txt` comparison against the research findings. Local convention, library/style, verification, and repo-context discipline.

comparison-opencode-default.md
  OpenCode `default.txt` comparison against the research findings. Concise baseline with missing repo/edit-boundary structures.

comparison-opencode-kimi.md
  OpenCode `kimi.txt` comparison against the research findings. Compact task framing and validation with edit-boundary gaps.

comparison-opencode-anthropic.md
  OpenCode `anthropic.txt` comparison against the research findings. High-persistence wording treated as bounded adoption source, not baseline model.

comparison-opencode-beast.md
  OpenCode `beast.txt` comparison against the research findings. Stress-prompt analysis; useful for persistence risks and rejection decisions.
```

## Research protocol

Start with [`research-plan.md`](research-plan.md) before conducting broad prompt research.

Every research slice must include:

```text
research
  -> verification
  -> adversarial review
  -> correction if needed
  -> conclusion with confidence
```

Each conclusion must record:

- evidence for
- evidence against
- risk or uncertainty
- whether the result belongs in prompt text, runtime/tooling, docs/process, tests, or nowhere
- a local test or verification idea when possible

Adversarial review is mandatory. A conclusion that only argues for itself is not finished.

## Current seed thesis

The best coding-agent prompt should not be just a pile of rules, and it should not try to prescribe one true reasoning method.

It should offer useful task structures:

```text
executor identity
  -> tool contract
  -> repo authority rules
  -> task-framing scaffold
  -> investigation scaffold
  -> edit-boundary scaffold
  -> validation scaffold
  -> safety/risk handling
  -> final answer contract
  -> optional style/compression layer
```

Each structure should be testable.

If a structure cannot be tested directly, it should at least produce observable behaviour:

- fewer broad sweeps
- better use of `rg`
- cleaner patch boundaries
- fewer fake plans
- fewer needless questions
- better escalation behaviour
- better preservation of user changes
- more useful final summaries

## Immediate working rule

Build from evidence, not prompt-fashion.

Use the QuantZhai packaged prompt as the current local baseline. Compare it against Claude Code, Codex Max, ChatGPT prompt collections, Qwen-specific prompting notes, academic prompt/context-engineering papers, internal HSM/QuantZhai/NetTTS references, observed local QuantZhai behaviour, and now the repaired OpenCode prompt-system-family synthesis.

Do not blindly merge all prompt sources. Extract useful structures, test them, and keep only what improves coding-agent behaviour on software-development tasks.

Do not draft candidate prompt text until the user explicitly resumes that stage.
