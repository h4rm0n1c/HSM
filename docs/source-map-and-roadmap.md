# Source Map and Roadmap

This document maps the nearby projects into HSM and defines the first implementation path.

## Repository boundary

HSM work should be written here.

Other repositories are source material unless explicitly promoted to implementation targets.

## Source repositories

### h4rm0n1c/ech0-kn1ght

Role: evidence and provenance layer.

Likely HSM use:

- archive captures
- public evidence trails
- historical aliases
- repo and forum traces
- artifact inventories
- testimony source trails
- provenance research

HSM should not become the raw archive. It should consume evidence summaries, source ids, and provenance records from this layer.

### h4rm0n1c/quantzhai

Role: local agent runtime and state-compression research.

Relevant ideas already present:

- compact runtime state injection
- context budget awareness
- tool budget awareness
- attention-grained runtime state
- benchmark-driven prompt compression
- Grug/caveman prompt profiles
- state-aware agent behaviour
- local web/search evidence packets

HSM use:

- runtime packet compiler design
- compact packet benchmark path
- agent harness discipline
- state visibility and self-regulation experiments

Important translation:

QuantZhai's runtime state is about the agent/session. HSM state is about the subject/person. They can share machinery, but their authority boundaries differ.

### h4rm0n1c/NetTTS

Role: deterministic token-weighting and segmentation prior art.

Relevant ideas:

- rule-based parsing
- token classification
- light/medium/heavy weighting
- linker handling
- break insertion
- preserving intelligibility under live constraints
- deterministic transforms instead of learned black-box behaviour

HSM use:

- state compression heuristics
- high-signal token preservation
- low-signal connective pruning
- readable deterministic transforms
- explainable prompt/state compilers

## Current HSM inputs from recent discussion

The current design seed includes:

- coherence/integrity as low contradiction and low state drift over useful human timespans
- active state packet as the live interface between model and state
- evidence archive as source of truth
- generated text not automatically becoming memory
- quiescent state as a first-class module
- stabilising anchors as operational state objects
- affective trigger cycle with delayed reasoning/explanation
- QuantZhai as runtime/compression/harness prior art
- NetTTS as deterministic weighting/segmentation prior art
- ech0-kn1ght as evidence/provenance prior art

## Roadmap

### Phase 0: Repo spine

- AGENTS harness
- README overview
- master report
- runtime/integrity doc
- quiescent-anchor doc
- source map and roadmap
- state schemas

Status: in progress.

### Phase 1: Readable schemas

Create sparse YAML/JSON schemas for:

- evidence record
- claim record
- source reference
- subject state
- quiescent state
- anchor
- affective pattern
- runtime packet
- integrity check result

Use explicit `unknown` rather than forced detail.

### Phase 2: Manual packet compiler

Build a simple script or documented procedure that turns selected state records into a readable runtime packet.

Do not optimise for compactness yet.

First target: correct, inspectable, and boring.

### Phase 3: Extraction notes

Define extraction passes:

- artifact inventory
- event extraction
- preference extraction
- project/skill extraction
- style extraction
- anchor extraction
- contradiction extraction
- uncertainty extraction

Every extraction pass must label evidence type and confidence.

### Phase 4: Integrity checklist

Create a repeatable checklist for accepting or rejecting model-generated updates.

Questions:

- Is this direct evidence, summary, inference, or hypothesis?
- What source supports it?
- What contradicts it?
- Is the date known?
- Is the confidence appropriate?
- Should it become durable state?

### Phase 5: State compiler v0

Prototype a state compiler that selects task-relevant records and emits a runtime packet.

Inputs:

- state files
- task description
- source refs
- uncertainty notes

Output:

- readable runtime packet
- evidence refs
- known caveats
- update instructions

### Phase 6: Benchmarks

Test whether the runtime packet improves:

- factual continuity
- preference continuity
- contradiction avoidance
- uncertainty handling
- anchor/reaction distinction
- update discipline

### Phase 7: Compact packets

Only after readable packets are reliable, add QuantZhai-style compression.

Possible ladder:

- L0 readable
- L1 dense field names
- L2 codebook
- L3 compact telemetry dialect

Do not use opaque encodings until benchmarks prove they are worth the debugging cost.

## Near next files

Suggested next files:

```text
schemas/evidence-record.schema.json
schemas/claim-record.schema.json
schemas/runtime-packet.schema.json
state/subject-state.example.yml
state/quiescent-state.example.yml
state/anchors.example.yml
checklists/integrity-check.md
checklists/extraction-pass.md
```

## Working bias

Be ambitious in architecture.

Be conservative in truth handling.

The system can speculate during design. It must not silently store speculation as fact.
