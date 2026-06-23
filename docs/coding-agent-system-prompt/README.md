# Coding Agent System Prompt Subproject

Status: active research workspace; Slice 13 closed-loop execution research and synthesis are complete  
Parent project: Human State Machine  
Related source project: `h4rm0n1c/quantzhai`

Note that should be taken very seriously by humans and agents:
system prompt awakening and improvement research, you tell an agent to read all of this, get up to speed, take some effort to do it, and only respond briefly when it's done learning what we're doing and how we want to do it. then you feed it a system prompt and ask it to analyse based on the findings of the research, strengths, weaknesses, areas for improvement. it will crunch for a while and come up with a plan, then ask for a draft of a replacement that accounts for what we found. the results will be a notable improvement, discuss semantic compression as well if you need to adjust length, making a fat prototype/draft of 12k to 15k bytes is not a disaster, it's an opportunity for semantic compression revisions of that version and this should be considered.

## Purpose

This directory is a dedicated HSM-side workspace for developing coding-agent system prompt structures.

The goal is not to force a single model-internal reasoning style. It is to provide external structure that improves software-development work:

- clearer task framing;
- safely curious orientation before premature narrowing;
- evidence promotion before action;
- closed-loop execution after action;
- safer edit and runtime boundaries;
- evidence-preserving recovery;
- better validation choices;
- cleaner confidence-aware reporting;
- more durable project memory.

The current worker model is:

```text
user intent + repo/runtime state + tool contract + workflow scaffold
  -> orientation / territory mapping
  -> bounded investigation
  -> precondition / evidence-promotion gate
  -> one bounded state transition
  -> postcondition / dependent-action gate
  -> trusted-state update or recovery
  -> final validation
  -> concise report
  -> durable project memory when warranted
```

## Current research position

Slices 0-12 remain the integrated base. Slice 13 adds the missing back half of evidence-gated action:

```text
verify the state that permits action
  -> act once
  -> verify the state produced before dependent action
  -> if reality differs, preserve needed evidence and re-ground
```

The key distinction is:

```text
FM12:
  unverified current-state claim authorizes action

FM13:
  unverified action result authorizes dependent action

FM14:
  diagnostic evidence is destroyed before it can support recovery
```

The dedicated EF13 fixture-design layer was skipped by user direction. This does not block synthesis or the next prompt-engineering pass.

Read [`RESEARCH_STATUS.md`](RESEARCH_STATUS.md) for the current status matrix and next action.

## Current source-of-truth stack

The original monolithic canonical files remain the Slice 0-12 base. Slice 13 is an authoritative overlay until a later monolithic rewrite is useful.

Read in this order:

1. [`final-findings-synthesis.md`](final-findings-synthesis.md) — canonical synthesis through Slice 12.
2. [`final-findings-synthesis-amendment-2026-06-23.md`](final-findings-synthesis-amendment-2026-06-23.md) — authoritative Slice 13 correction to the worker loop and synthesis.
3. [`slice-13-closed-loop-execution.md`](slice-13-closed-loop-execution.md) — primary research source.
4. [`candidate-structures-slice-13-extension.md`](candidate-structures-slice-13-extension.md) — C43-C47 disposition and C39/C41 revision.
5. [`research-failure-mode-catalog-slice-13-extension.md`](research-failure-mode-catalog-slice-13-extension.md) — FM13/FM14 taxonomy and relationships.
6. [`prompt-evaluation-checklist-slice-13-extension.md`](prompt-evaluation-checklist-slice-13-extension.md) — structural-versus-behavioural evaluation implications.
7. [`candidate-structures.md`](candidate-structures.md), [`research-failure-mode-catalog.md`](research-failure-mode-catalog.md), and [`prompt-evaluation-checklist.md`](prompt-evaluation-checklist.md) — canonical Slice 0-12 bases.

## Why this belongs here

QuantZhai is the runtime and prior-art source for local coding-agent behaviour, prompt compression, state injection, and harness experiments.

HSM is the better home for the methodology because this research concerns:

- task scaffolding for software-development reasoning;
- role and authority boundaries;
- evidence-first task structure;
- precondition and postcondition control;
- prompt compilation and semantic compression;
- instruction layering;
- trusted-state and recovery discipline;
- human/assistant/coding-agent arbitration;
- safely curious execution without broad unsafe autonomy.

QuantZhai should stay focused on running the thing. This directory designs the structures that make the thing work better.

## Directory map

### Core protocol and status

```text
README.md
  This file. Scope, current research position, and entry point.

AGENTS.md
  Local instructions for agents working inside this subproject.

research-plan.md
  Research protocol: sliced research with verification, adversarial review, correction, and confidence.

RESEARCH_STATUS.md
  Current status, authoritative artifacts, active failure boundaries, next action, and risk register.

canonical-integration-pass-2026-06-17.md
  Historical controller for the Slice 12 integration pass.
```

### Current research and synthesis

```text
slice-11-investigation-imperative.md
  Safely curious orientation before narrowing; C27-C35 and FM11.

slice-12-evidence-gated-action.md
  Action-critical current-state claims and evidence promotion before action; C36-C42 and FM12.

slice-13-closed-loop-execution.md
  Postcondition verification, trusted-state commitment, dependent-action gating, recovery, and evidence preservation.

candidate-structures-slice-13-extension.md
  C43-C47 disposition; C39/C41 correction; prompt/runtime placement and compression.

research-failure-mode-catalog-slice-13-extension.md
  FM13 Open-Loop Execution and FM14 Diagnostic-Evidence Destruction.

prompt-evaluation-checklist-slice-13-extension.md
  Structural-versus-behavioural evaluation, intermediate state control, and recovery implications.

final-findings-synthesis.md
  Canonical synthesis through Slice 12.

final-findings-synthesis-amendment-2026-06-23.md
  Authoritative Slice 13 amendment and corrected worker architecture.
```

### Canonical base files

```text
candidate-structures.md
  Canonical Slice 0-12 candidate structures C1-C42.

research-failure-mode-catalog.md
  Canonical Slice 0-12 failure catalog FM1-FM12.

prompt-evaluation-checklist.md
  Canonical Slice 0-12 checklist and EF11/EF12 material.

evaluation-plan-ef11-ef12.md
  Existing behavioural A/B plan. EF13 expansion is not required for the current research sequence.
```

### Earlier research and provenance

```text
slice-1-arbitration-loop.md
slice-2-anti-agreement-self-critique.md
slice-3-context-position-middle-loss.md
slice-4-promptware-lifecycle.md
slice-5-identity-role-and-executor-boundaries.md
slice-6-safety-untrusted-instructions.md
slice-7-tool-stream-state-feedback.md
slice-8-compaction-preservation.md
project-smell-audit-2026-06-17.md
i1a-arxiv-backing-orientation-evidence-gating.md
candidate-structures-slice-11-extension.md
research-failure-mode-catalog-slice-11-extension.md
prompt-evaluation-checklist-slice-11-extension.md
candidate-structures-slice-12-extension.md
research-failure-mode-catalog-slice-12-extension.md
prompt-evaluation-checklist-slice-12-extension.md
final-findings-synthesis-amendment-2026-06-17.md
```

These remain provenance and supporting evidence. The 2026-06-23 synthesis amendment supersedes the affected worker-loop conclusions.

### Comparison and OpenCode material

```text
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
```

Slice 13 preserves the OpenCode resynthesis but changes the interpretation of persistence: continue through grounded recovery, not through unverified state.

## Research protocol

Start with [`research-plan.md`](research-plan.md) before broad new research.

Each research conclusion should include:

```text
research
  -> verification
  -> adversarial review
  -> correction if needed
  -> conclusion with confidence
```

Record:

- evidence for;
- evidence against;
- risk or uncertainty;
- whether the result belongs in prompt text, runtime/tooling, docs/process, evaluation, or nowhere;
- a local verification idea where useful.

Adversarial review remains mandatory. A conclusion that only argues for itself is unfinished.

## Current seed thesis

The best coding-agent prompt is neither a pile of rules nor a prescribed hidden reasoning ritual.

It should provide a compact durable scaffold:

```text
executor identity
  -> active investigator stance
  -> authority and trusted-input boundary
  -> tool contract
  -> orientation / territory mapping
  -> assumption and evidence-promotion scaffold
  -> bounded state transition
  -> postcondition / dependent-action scaffold
  -> recovery and diagnostic-evidence preservation
  -> edit and safety boundaries
  -> final validation
  -> confidence-aware final report
  -> optional style/compression layer
```

Observable goals include:

- fewer fake plans and guessed action targets;
- better mapping before narrowing;
- fewer wrong-path or inactive-config edits;
- better use of existing project surfaces;
- verified state transitions before dependent action;
- less blind retry and duplicate/conflicting work;
- preservation of evidence required to diagnose failure;
- correction that changes the next observable action;
- recovery without task abandonment;
- better preservation of user work and authority boundaries;
- honest final validation and uncertainty reporting.

## Immediate working rule

Build from evidence, not prompt fashion.

Use the QuantZhai packaged prompt as the local baseline and the complete HSM research stack as design input. External prompt dumps and agent frameworks are research evidence, not authority.

Do not blindly merge all sources. Extract balanced structures, preserve temporal semantics during compression, and keep only what improves real coding-agent behaviour.

The next prompt candidate should be rebuilt from the revised synthesis. The earlier chat-produced v2 is a design probe, not the source of truth.
