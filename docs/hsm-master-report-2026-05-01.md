# HSM Master Report — 2026-05-01

This document consolidates the current Human State Machine concept from recent discussion and related project context.

## One-line definition

A Human State Machine is an evidence-backed, stateful human-emulation architecture where a language model operates over structured human state instead of pretending to contain the person inside model weights.

## Core thesis

The model is not the person.

The model is the execution engine.

The durable system is the combination of:

- evidence
- extraction
- provenance
- confidence
- state
- update rules
- runtime packet
- reasoning/rendering model
- integrity checks

This matters because a single fine-tuned model can imitate patterns, but it cannot safely own truth. It will blur evidence, inference, tone, and invention unless the surrounding system forces those boundaries to remain explicit.

## Why existing AI harnesses matter

Modern hosted AI systems already receive layered active state before answering:

- system rules
- developer rules
- user profile
- persistent memory
- recent conversation
- tool availability
- current message

That is a primitive runtime state packet.

HSM takes that rough idea seriously and makes it explicit, versioned, inspectable, evidence-backed, and update-controlled.

Instead of hidden context glue, HSM needs a deliberate state compiler.

## Data flow

```text
Artifacts / testimony / records
  -> extraction
  -> scored claims and events
  -> provenance graph
  -> state compiler
  -> active runtime packet
  -> model reasoning/rendering
  -> integrity and drift check
  -> controlled state update
```

## Key distinction

Do not collapse these categories:

| Category | Meaning |
|---|---|
| Raw evidence | Original artifact, record, message, repo, file, report, testimony, screenshot, etc. |
| Extracted claim | A structured statement derived from evidence. |
| Inference | A model- or human-generated interpretation that may be useful but is not direct evidence. |
| Active state | The subset of known information relevant to current behaviour and reasoning. |
| Runtime packet | The compiled prompt-facing state handed to the model for a task. |
| Generated output | The model's rendered answer/action/explanation. |
| Durable update | A state change accepted after classification and verification. |

Generated output is not automatically durable state.

## Coherence and integrity

Coherence for HSM is not just low next-token perplexity.

Useful coherence means:

- low contradiction with known evidence
- low state drift over human-relevant time
- stable preference and value continuity
- recognisable behavioural continuity
- appropriate uncertainty
- grounded updates
- clear separation between memory, inference, and current reaction

Integrity means the system does not quietly mutate assumptions, invent bridges, or let plausible prose become truth.

## Architecture layers

### 1. Evidence archive

Stores raw material:

- life artifacts
- written work
- repos
- chat logs
- email/letters where supplied
- psychological/medical/observer reports where supplied
- public posts
- archive captures
- testimony

This layer should preserve originals and metadata. It should not rewrite history into a convenient story.

### 2. Extraction layer

Uses models and deterministic tools to turn raw material into structured records:

- event
- claim
- preference
- relationship
- project
- skill
- constraint
- style sample
- affective pattern
- stabilising anchor
- contradiction
- uncertainty

### 3. Provenance layer

Every durable claim should know:

- source
- date or estimated period
- source type
- confidence
- sensitivity
- whether it is direct record, third-party observation, self-report, or inference
- contradictory material if any

### 4. State layer

Maintains the current compiled model of the subject:

- identity and values
- current projects
- skills and constraints
- preferences
- relationships
- routines
- open loops
- emotional/affective patterns
- quiescent baseline
- stabilising anchors
- unresolved uncertainties

### 5. Runtime packet compiler

Selects the relevant active state for a given task.

This should not dump the entire archive. It should compile a precise packet containing what matters now.

### 6. Model execution layer

The LLM performs:

- reasoning
- summarisation
- comparison
- extraction
- hypothesis generation
- language rendering
- action planning
- tool orchestration

It does not own truth.

### 7. Integrity loop

After generation:

- classify new claims
- compare against evidence and state
- detect contradictions
- detect style/personality drift
- detect unsupported invention
- decide whether anything should become durable state

## Quiescent state and anchor model

A major missing piece in ordinary AI memory is resting-state regulation.

Humans are not just current input plus facts. They have a baseline mental state they tend to return toward when not actively disturbed.

HSM therefore needs a quiescent model:

- baseline mood and activation
- preferred stability anchors
- known destabilising cues
- recovery behaviours
- trigger-linked memory clusters
- delayed reasoning and explanation patterns

A person may not foreground old injury or distress during normal baseline operation, but related cues can rapidly activate emotional/subconscious responses. Later, seconds to days after the incident, higher reasoning may produce an explanation and surface the connected memories.

That cycle is not noise. It is part of the state machine.

## Affective trigger cycle

A useful model:

```text
quiescent state
  -> incident/cue
  -> fast affective reaction
  -> partial memory activation
  -> behaviour/output
  -> delayed reasoning aftershock
  -> narrative explanation
  -> state update or renewed destabilisation
  -> return toward baseline
```

The time constant varies by person and event. It can be seconds, minutes, hours, or days.

HSM must distinguish:

- immediate reaction
- later explanation
- durable belief
- hypothesis
- evidence-backed memory

## Anchor concept

An anchor is a stabilising object, role, routine, project, place, person, sensory environment, moral rule, or technical task that helps the subject preserve continuity under chaos.

Examples of anchor categories:

- project anchor
- tool/machine anchor
- role anchor
- moral/justice anchor
- routine anchor
- sensory/environmental anchor
- relationship anchor
- narrative identity anchor

The anchor model answers:

- what does the subject reach for when destabilised?
- what restores operational stability?
- what happens when an anchor is unavailable or threatened?
- what behaviours indicate an anchor-seeking state?

## Relationship to QuantZhai

QuantZhai contributes runtime-harness ideas:

- compact runtime state injection
- context budget awareness
- tool budget awareness
- prompt compression
- Grug/caveman compression experiments
- local agent observability
- state-aware behaviour benchmarks

This maps well to HSM runtime packets. HSM needs a state compiler; QuantZhai is already exploring compact state blocks and attention-grained runtime state.

## Relationship to NetTTS

NetTTS contributes deterministic rule prior art:

- token classification
- light/medium/heavy weighting
- linker handling
- segmentation boundaries
- low-overhead transformation
- preserving intelligibility under live constraints

The same kind of deterministic weighting can help HSM compression: preserve high-signal identity/state/action tokens while pruning low-information connective material.

## Relationship to ech0-kn1ght

The ech0-kn1ght project is the natural evidence/provenance side of HSM.

It supplies or points toward:

- public evidence
- archive captures
- online history
- project traces
- artifact provenance
- testimony and source trails

HSM should treat ech0-kn1ght as evidence input, not as the runtime state system itself.

## Failure modes

### Model-as-authority failure

Bad:

```text
The model says it sounds plausible, so store it as truth.
```

Good:

```text
The model proposes an interpretation, then evidence/state checks classify it.
```

### Character-card flattening

Bad:

```text
Reduce the person to a stable list of traits and a voice style.
```

Good:

```text
Represent traits, contradictions, contexts, stress responses, anchors, uncertainty, and change over time.
```

### Memory soup

Bad:

```text
Dump everything into context and hope a large model sorts it out.
```

Good:

```text
Compile task-relevant state with provenance and uncertainty.
```

### Generated-memory contamination

Bad:

```text
The model wrote a good explanation; now it is memory.
```

Good:

```text
The explanation is output until classified, checked, and accepted.
```

## Immediate engineering direction

1. Create schemas for evidence, claim, state, anchor, trigger, and runtime packet.
2. Build an extraction pipeline that labels direct evidence vs inference.
3. Build a state compiler that creates small runtime packets.
4. Build integrity checks for contradiction, provenance, uncertainty, and drift.
5. Use QuantZhai-style compact state only after the readable schema is stable.
6. Keep all HSM writes in this repo.

## Working standard

The system should be bold in architecture but conservative in truth handling.

Speculate freely in design notes. Do not silently promote speculation to fact.
