# Coding Agent System Prompt Subproject

Status: active research workspace  
Parent project: Human State Machine  
Related source project: `h4rm0n1c/quantzhai`

Note that should be taken very seriously by humans and agents:
system prompt awakening and improvement research, you tell an agent to read all of this, get up to speed, take some effort to do it, and only respond briefly when it's done learning what we're doing and how we want to do it. then you feed it a system prompt and ask it to analyse based on the findings of the research, strengths, weaknesses, areas for improvement. it will crunch for a while and come up with a plan, then ask for a draft of a replacement that accounts for what we found. the results will be a notable improvement, discuss semantic compression as well if you need to adjust length, making a fat prototype/draft of 12k to 15k bytes is not a disaster, it's an opportunity for semantic compression revisions of that version and this should be considered.

## Purpose

This directory is a dedicated HSM-side workspace for developing coding-agent system prompt structures.

The goal is not to force a single model-internal reasoning style.

The goal is to provide external structure that helps a coding agent reason better over software-development tasks:

- clearer task framing
- better source inspection
- better handoff from suspicion to evidence
- safely curious orientation before premature narrowing
- evidence promotion before action
- safer edit boundaries
- better validation choices
- cleaner final reporting
- more durable project memory

It is separate from the main HSM subject-state work, but related. HSM is interested in how models operate over structured state and task packets. A coding agent prompt is a narrower version of that problem:

```text
user intent + repo state + tool contract + workflow scaffold
  -> orientation / territory mapping
  -> bounded investigation
  -> evidence-promotion gate
  -> implementation slice
  -> validation
  -> concise report
  -> durable project memory
```

This subproject captures the prompt structures, workflow scaffolds, and research material needed to build that coding-agent layer deliberately.

## Current boundary

Candidate prompt drafting is paused.

Do not produce `candidate-system-prompt-v0.md`, `hsm-build-v1.md`, or any replacement prompt until the user explicitly resumes candidate prompt work.

The research corpus is canonically integrated through Slice 11, with Slice 12 now added as an active correction:

```text
slices 0-10
  -> OpenCode resynthesis
  -> hsm-build-v0.md evaluation
  -> DeepSeek V4 Flash feedback
  -> Fable5 distilled prompt comparison
  -> CL4R1T4S Fable prompt architecture contrast
  -> Slice 11 investigation imperative
  -> canonical updates to final synthesis, candidate structures, failure catalog, eval checklist, and status
  -> Slice 12 evidence-gated action correction
  -> project smell audit / abstraction pass requirement
```

Remaining work is now three-stage:

```text
canonical abstraction pass over list-shaped rules
  -> canonically merge Slice 12 into the large consolidated files
  -> run behavioural A/B evaluation before any measured claim about a new prompt draft
```

## Why this belongs here

QuantZhai is the runtime and prior-art source for local coding-agent behaviour, prompt compression, state injection, and harness experiments.

HSM is the better home for the broader methodology work because this prompt research is about:

- task scaffolding for software-development reasoning
- role and authority boundaries
- evidence-first task structure
- evidence-promotion before action
- prompt compilation
- instruction layering
- durable memory discipline
- human/assistant/coding-agent arbitration
- safely curious execution without broad unsafe autonomy

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

slice-11-investigation-imperative.md
  Slice 11 research correction: safely curious coding agents, territory mapping before narrowing, surface-signal discipline, assumption ledger, and C27-C35 candidate structures.

slice-12-evidence-gated-action.md
  Slice 12 research correction: evidence promotion before action, action-critical world-state claims, clue-is-not-proof rule, FM12, C36-C42, and EF12 fixtures.

project-smell-audit-2026-06-17.md
  Audit of prompt-research bad smells discovered from v0 output/testing: category-list-as-rule, example leakage, fixture leakage, sidecar drift, prompt/runtime boundary blur, and required abstraction pass before v1.

candidate-structures.md
  Canonical candidate structures C1-C35, including Slice 11 C27-C35. Must be merged with Slice 12 before any serious v1 prompt draft.

research-failure-mode-catalog.md
  Canonical failure-mode catalog FM1-FM11, including FM11 Premature Narrowing / Curiosity Collapse. Must be merged with FM12 before any serious v1 prompt draft.

prompt-evaluation-checklist.md
  Canonical evaluation checklist, including EF11.1-EF11.6. Must be merged with EF12 before any serious v1 prompt draft.

final-findings-synthesis.md
  Canonical final synthesis through Slice 11. Must be amended with Slice 12 before any serious v1 prompt draft.

RESEARCH_STATUS.md
  One-page status matrix, artifact list, fixture coverage, next actions, and risk register.

candidate-structures-slice-11-extension.md
research-failure-mode-catalog-slice-11-extension.md
prompt-evaluation-checklist-slice-11-extension.md
  Provenance sidecars from the Slice 11 integration pass. These are retained for audit trail, but the canonical Slice 11 material is now in the main files above.

final-findings-synthesis-amendment-2026-06-17.md
  Provenance amendment used before the final synthesis was canonically updated.

comparison-quantzhai-codex-core-qwenified.md
comparison-codex-cli-max.md
comparison-claude-code.md
comparison-opencode-*.md
research-opencode-source-map.md
comparison-opencode-runtime-assembly.md
comparison-opencode-plan-mode.md
comparison-opencode-agent-task-compaction.md
research-opencode-vs-cli-family.md
final-opencode-findings-synthesis.md
  Comparison and OpenCode resynthesis documents.
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
  -> active investigator stance
  -> tool contract
  -> repo authority rules
  -> task-framing scaffold
  -> orientation / territory-mapping scaffold
  -> investigation scaffold
  -> evidence-promotion scaffold
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
- more reliable territory mapping before narrowing
- fewer wrong-path edits
- better surfacing of relevant adjacent signal
- fewer guessed API endpoints, model IDs, config paths, and hardware assumptions

## Immediate working rule

Build from evidence, not prompt-fashion.

Use the QuantZhai packaged prompt as the current local baseline. Compare it against Claude Code, Codex Max, ChatGPT prompt collections, Qwen-specific prompting notes, academic prompt/context-engineering papers, internal HSM/QuantZhai/NetTTS references, observed local QuantZhai behaviour, the repaired OpenCode prompt-system-family synthesis, the Fable5 distilled operating instructions, and the CL4R1T4S Fable prompt dump as an unverified architecture contrast.

Do not blindly merge all prompt sources. Extract useful structures, test them, and keep only what improves coding-agent behaviour on software-development tasks.

Do not draft candidate prompt text until the user explicitly resumes that stage.
