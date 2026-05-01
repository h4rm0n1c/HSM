# Runtime State and Integrity Loop

This document defines the HSM runtime packet, model-execution boundary, provenance rules, and state-update discipline.

## Core rule

The model is not the state store.

The model receives a compiled packet, performs useful work, and returns output. That output is then checked before any durable state changes happen.

```text
state + task + tools
  -> runtime packet
  -> model execution
  -> generated output
  -> claim extraction
  -> integrity checks
  -> update gate
  -> durable state or rejected/transient output
```

Generated prose is never automatically memory.

## Why runtime packets matter

Current hosted AI systems already receive a layered context before answering. In broad shape this includes:

- system rules
- developer rules
- user profile
- persistent memories
- recent conversation
- tool definitions
- current message

That is a primitive runtime packet.

HSM should make this explicit, inspectable, scored, and update-controlled.

## HSM runtime packet goals

A runtime packet should provide the model with what it needs now, not the whole archive.

Good packets are:

- task-relevant
- compact
- evidence-aware
- uncertainty-aware
- source-labelled
- versioned
- cheap enough to regenerate
- safe to inspect

Bad packets are:

- enormous dumps
- stale summaries with no source trail
- vague trait lists
- unlabelled speculation
- generated explanations treated as fact
- flattened character-card personality mush

## Runtime packet structure

Draft readable shape:

```json
{
  "packet_version": "hsm-runtime-v0.1",
  "subject_id": "local-subject",
  "task": {
    "kind": "explain | extract | emulate | plan | compare | write | audit",
    "user_request": "current task summary",
    "success_criteria": [],
    "constraints": []
  },
  "authority": {
    "repo_write_target": "h4rm0n1c/HSM",
    "read_only_sources": [
      "h4rm0n1c/ech0-kn1ght",
      "h4rm0n1c/quantzhai",
      "h4rm0n1c/NetTTS"
    ],
    "source_priority": [
      "direct_record",
      "versioned_artifact",
      "third_party_observation",
      "self_report",
      "model_inference"
    ]
  },
  "active_state": {
    "current_projects": [],
    "open_loops": [],
    "known_constraints": [],
    "preferences": [],
    "skills": [],
    "relationships": [],
    "uncertainties": []
  },
  "quiescent_state": {
    "baseline": {},
    "anchors": [],
    "destabilisers": [],
    "recovery_patterns": []
  },
  "affective_state": {
    "active_load": "low | medium | high | unknown",
    "trigger_candidates": [],
    "reasoning_delay_expected": "seconds | minutes | hours | days | unknown",
    "explanation_confidence": "low | medium | high | unknown"
  },
  "evidence_refs": [],
  "tool_context": {
    "available_tools": [],
    "tool_budget": {},
    "must_verify_with_tools": []
  },
  "output_contract": {
    "style": "plain, grounded, useful",
    "must_label_uncertainty": true,
    "must_not_promote_inference_to_fact": true,
    "must_separate_reaction_from_later_explanation": true
  }
}
```

## Packet levels

Use a ladder.

### L0: readable packet

Use explicit field names and normal language. Best for first implementation.

### L1: dense packet

Short keys, stable vocabulary, still human-readable.

### L2: codebook packet

Requires a schema known to the model or harness. Useful after benchmarks prove reliability.

### L3: compact telemetry dialect

QuantZhai-style compact state, such as small date/context/tool/mode fields.

Do not start with opaque encodings. A packet that is hard to debug is a liability.

## Integrity loop

After model output, run an integrity pass.

### 1. Extract claims

Classify each claim in the output:

- direct evidence restatement
- derived summary
- inference
- hypothesis
- style rendering
- action proposal
- emotional interpretation
- memory/state update candidate

### 2. Check source support

For each durable candidate:

- What source supports it?
- Is the source direct, third-party, self-report, or inference?
- Is there contradictory material?
- Is the date known or approximate?
- Is the claim sensitive?
- Is the confidence appropriate?

### 3. Check state conflict

Look for:

- contradiction with known evidence
- contradiction with current state
- stale information
- drift from established preferences
- invented continuity bridges
- overconfident explanation
- flattening of contradictions

### 4. Decide update class

Possible outcomes:

```text
reject
keep as transient output
store as hypothesis
store as low-confidence observation
store as durable claim
store as preference update
store as state update
store as open uncertainty
```

### 5. Record provenance

Every durable entry needs:

- source id
- source type
- extraction method
- confidence
- timestamp or period
- sensitivity
- update reason
- contradiction links if any

## Truth discipline

Avoid these errors.

### Generated-memory contamination

Bad:

```text
The model wrote a convincing explanation, therefore it is now memory.
```

Good:

```text
The explanation is useful output. It becomes state only after evidence and update checks.
```

### Model-as-authority failure

Bad:

```text
The model says this pattern fits, so treat it as true.
```

Good:

```text
The model may propose the pattern. The system stores it as inference unless evidence supports it.
```

### Character flattening

Bad:

```text
Reduce the subject to fixed traits and tone.
```

Good:

```text
Represent traits, contradictions, context dependence, anchors, stress responses, skill domains, preferences, and uncertainty.
```

## Coherence metrics

HSM coherence should be measured across time, not only per-answer fluency.

Useful measures:

- contradiction rate
- unsupported-claim rate
- stale-state use rate
- preference violation rate
- source-boundary error rate
- inference-labelled-as-fact rate
- active-goal retention
- anchor-state continuity
- drift after compaction
- recovery after correction

## QuantZhai relationship

QuantZhai already explores compact runtime state and tool/context awareness. HSM should reuse the design idea, not necessarily the exact format.

Relevant concepts:

- attention-grained runtime state
- context budget as finite working memory
- tool budget as action capacity
- compact state blocks
- state-aware benchmarking
- Grug/caveman compression as a preservation problem: keep high-signal state, remove low-signal connective tissue

## Practical first implementation

Start boring and reliable:

1. JSON or YAML state files.
2. Markdown evidence notes.
3. Claim records with source ids.
4. A readable runtime packet generator.
5. Manual integrity checklists.
6. Later: automated extraction, validation, and compact packet generation.

The first working HSM does not need to be elegant. It needs to not lie to itself.
