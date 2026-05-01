# Human State Machine (HSM)

Human State Machine is a research and engineering project for building an evidence-backed, stateful human-emulation architecture.

The core idea is simple:

```text
human artifacts + testimony + records
  -> extraction
  -> provenance and confidence
  -> structured state
  -> runtime packet
  -> model reasoning/rendering
  -> integrity checks
  -> controlled state update
```

The model is not the person. The model is an execution engine over state.

## What this repo is for

This repository is the dedicated write target for HSM work:

- architecture
- schemas
- state models
- runtime harness design
- evidence and provenance rules
- extraction plans
- integrity checks
- human-emulation theory
- implementation roadmap

Other repositories may supply source material, but HSM work should land here.

## Current source repos

- `h4rm0n1c/ech0-kn1ght` — evidence/archive/provenance project.
- `h4rm0n1c/quantzhai` — local agent runtime, prompt compression, state injection, Grug/caveman harness work.
- `h4rm0n1c/NetTTS` — deterministic token classification, segmentation, and prosody prior art.

Treat those as read-only unless explicitly told otherwise.

## Core thesis

A useful AI human-state system is not just a chatbot with more memory.

It needs:

- evidence-backed memory
- versioned state
- provenance and confidence scoring
- contradiction detection
- quiescent/resting-state modelling
- affective trigger modelling
- runtime state packets
- output audit and update discipline

The target is not perfect consistency. Humans are not perfectly consistent.

The target is coherent continuity: low contradiction, low state drift, and low behavioural surprise over human-meaningful timespans.

## High-level architecture

```text
Evidence Archive
  -> Extraction Layer
  -> Provenance Layer
  -> State Layer
  -> Runtime Packet Compiler
  -> LLM Execution Layer
  -> Integrity / Drift Check
  -> State Update Gate
```

Each layer must be inspectable. Each durable claim should be traceable back to source material or labelled as inference.

## Important distinction

Do not confuse these:

- raw evidence
- extracted fact
- inferred pattern
- active state
- generated explanation
- durable memory update

A generated explanation may be useful. It is not automatically true.

## Current docs

- `AGENTS.md` — operating harness for future agents.
- `docs/hsm-master-report-2026-05-01.md` — consolidated HSM report.
- `docs/runtime-and-integrity.md` — runtime packet, provenance, and integrity loop.
- `docs/quiescent-anchor-and-affective-cycle.md` — baseline/anchor/trigger/reasoning-aftershock model.
- `docs/source-map-and-roadmap.md` — source map and build path.

## Working standard

When adding to this repo:

1. Keep it grounded.
2. Label uncertainty.
3. Preserve source boundaries.
4. Prefer schemas and explicit state over vibes.
5. Do not flatten the subject into a generic character card.
