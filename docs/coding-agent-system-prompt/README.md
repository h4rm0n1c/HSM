# Coding Agent System Prompt Subproject

Status: seed workspace  
Parent project: Human State Machine  
Related source project: `h4rm0n1c/quantzhai`

## Purpose

This directory is a dedicated HSM-side workspace for developing a strong coding-agent system prompt.

It is separate from the main HSM subject-state work, but related. HSM is interested in how models become reliable execution engines over structured state. A coding agent prompt is a narrower version of the same problem:

```text
user intent + repo state + tool contract + workflow discipline
  -> bounded investigation
  -> implementation slice
  -> validation
  -> concise report
  -> durable project memory
```

This subproject captures the prompt, workflow, and research material needed to build that coding-agent layer deliberately.

## Why this belongs here

QuantZhai is the runtime and prior-art source for local coding-agent behaviour, prompt compression, state injection, and harness experiments.

HSM is the better home for the broader methodology work because this prompt research is about:

- stateful agent behaviour
- role and authority boundaries
- evidence-first reasoning
- prompt compilation
- instruction layering
- durable memory discipline
- human/assistant/coding-agent arbitration

QuantZhai should stay focused on running the thing. This directory exists to design the thing.

## Directory map

```text
README.md
  This file. Scope, purpose, and entry point.

AGENTS.md
  Local instructions for agents working inside this subproject.

workflow-patterns.md
  Captured working pattern from successful QuantZhai and coding-agent development loops.

reference-quantzhai-codex-core-qwenified.md
  Snapshot copy of the current packaged QuantZhai coding-agent system prompt.

research-references.md
  External prompt sources and articles queued for later research. Links only; do not copy large external corpora here.
```

## Current seed thesis

The best coding-agent prompt should not be just a pile of rules.

It needs clear layers:

```text
executor identity
  -> tool contract
  -> repo authority rules
  -> investigation discipline
  -> edit discipline
  -> validation discipline
  -> safety/risk handling
  -> final answer contract
  -> optional style/compression layer
```

Each layer should be testable.

If a layer cannot be tested directly, it should at least produce observable behaviour:

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

Use the QuantZhai packaged prompt as the current local baseline. Compare it later against Claude Code, Codex Max, ChatGPT prompt collections, Qwen-specific prompting notes, and observed local QuantZhai behaviour.

Do not blindly merge all prompt sources. Extract shapes, test them, and keep only what improves coding-agent behaviour.
