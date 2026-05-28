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

Use the QuantZhai packaged prompt as the current local baseline. Compare it later against Claude Code, Codex Max, ChatGPT prompt collections, Qwen-specific prompting notes, academic prompt/context-engineering papers, internal HSM/QuantZhai/NetTTS references, and observed local QuantZhai behaviour.

Do not blindly merge all prompt sources. Extract useful structures, test them, and keep only what improves coding-agent behaviour on software-development tasks.
