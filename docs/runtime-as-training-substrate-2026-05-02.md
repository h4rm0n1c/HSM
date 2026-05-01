# Runtime as Training Substrate — 2026-05-02

## Core idea

The HSM runtime is not only an interface for using a language model.

It can become a training and improvement substrate: a structured environment that teaches or tunes models toward the intended behaviour by surrounding them with explicit facts, provenance, constraints, relationships, state packets, feedback loops, and evaluation traces.

This is potentially bigger than one human-emulation project. It is an AI-tooling pattern.

## Why this matters

General-purpose LLM behaviour is broad, fluent, and often underconstrained.

HSM pushes the model into a more disciplined operating mode:

- facts are separated from inference
- source boundaries are explicit
- claims carry provenance
- state is compiled rather than guessed
- memory updates are gated
- behaviour is evaluated across time
- contradictions are preserved rather than smoothed away
- complex relationships are represented as structured state

That runtime pressure can generate high-value training material.

## Training signal from runtime

Every useful HSM run can produce examples of:

- task input
- active runtime packet
- retrieved evidence
- model output
- extracted claims
- accepted/rejected updates
- confidence labels
- contradiction findings
- human corrections
- final durable state changes

This is much richer than ordinary chat logs.

A plain chat transcript says what was said.

An HSM runtime trace says:

```text
what evidence existed
what state was active
what the model inferred
what was accepted
what was rejected
why it was rejected
what changed afterward
```

That is high-value alignment and behaviour data.

## Possible model-improvement loops

### 1. Behaviour tuning

Train models to obey HSM operating rules:

- label uncertainty
- do not promote inference to fact
- preserve source boundaries
- ask for evidence when needed
- separate reaction from later explanation
- keep active state coherent

### 2. Extraction tuning

Train smaller or specialised models to extract:

- evidence records
- claim records
- timeline events
- preferences
- anchors
- contradictions
- affective patterns
- project histories

### 3. Runtime packet use

Train models to consume compact runtime packets correctly.

Target behaviours:

- use current state without overusing irrelevant memory
- respect write boundaries
- notice stale or missing evidence
- preserve open loops
- adapt answer style to task and state

### 4. Integrity-tendency tuning

If integrity is emergent, train the model to contribute to that emergence:

- be conservative with durable claims
- expose uncertainty
- identify unsupported bridges
- preserve contradictions
- recommend review rather than invent certainty

### 5. Retrieval evaluation

Use runtime traces to evaluate retrieval stacks:

- lexical search
- embedding search
- graph search
- PageRank-style salience
- hybrid ranking

The question is not only "did search find text?" but "did retrieval bring the right evidence into the runtime packet?"

## Why this is high-value to an LLM

HSM-style data contains constrained, complex behavioural relationships across subjects, evidence, time, and state.

That is valuable because it teaches models to operate under conditions closer to real human reasoning:

- incomplete evidence
- conflicting sources
- delayed explanation
- changing state
- relationships between facts
- uncertainty that must remain visible
- updates that must be justified

This is much denser than generic instruction-following examples.

## Tooling implication

The HSM runtime should eventually log structured traces suitable for:

- audit
- replay
- benchmark evaluation
- supervised fine-tuning
- preference tuning
- rejection datasets
- retrieval benchmark corpora
- state-compiler regression tests

Suggested future trace shape:

```json
{
  "task": {},
  "runtime_packet": {},
  "retrieval": [],
  "model_output": {},
  "claim_extraction": [],
  "integrity_review": {},
  "accepted_updates": [],
  "rejected_updates": [],
  "human_feedback": [],
  "final_state_delta": {}
}
```

## Caution

Do not train on raw generated output as if it were truth.

The valuable training material is the whole trace, especially the distinction between:

- proposed claims
- rejected claims
- accepted claims
- evidence support
- correction notes

The rejection and correction data may be more valuable than the successful prose.

## Working thesis

HSM may be a revolution in AI tooling because it turns runtime use into structured behavioural training data.

Instead of asking a general model to behave correctly by prompt alone, the system creates a high-discipline environment that can repeatedly generate examples of the intended behaviour, evaluate them, and eventually train models to match that behaviour more naturally.
