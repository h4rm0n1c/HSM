# Preconscious Retrieval Trigger Layer — 2026-05-02

## Core idea

A useful HSM runtime may need a layer that acts before explicit reasoning.

In humans, part of the mind appears to retrieve or activate potentially useful material before it reaches deliberate internal thought or external expression. The person may not consciously decide to fetch the memory; the memory or association is already available when conscious reasoning begins.

In an AI runtime, the analogue is a preconscious retrieval trigger layer: a mechanism that predicts which data may be needed later and performs tool calls or retrieval before the main reasoning/rendering pass depends on it.

## Rough stack

```text
current input / situation
  -> preconscious salience detection
  -> predictive retrieval/tool calls
  -> enriched working context
  -> explicit reasoning
  -> final expression/action
```

This differs from normal reactive tool use:

```text
model thinks it needs data
  -> asks tool
  -> receives data
  -> continues
```

The preconscious version is:

```text
runtime predicts likely need
  -> fetches candidate data early
  -> reasoning begins with relevant context already present
```

## Why this matters

This can improve:

- latency
- coherence
- memory reactivation
- continuity across turns
- evidence-grounded reasoning
- fewer interruptions for obvious lookups
- better use of retrieval before the model has committed to a narrative

It also gives a stronger analogy to human memory, where cue-triggered associations often appear before deliberate explanation.

## HSM use cases

Potential triggers:

- named project appears
- person/entity appears
- date/time cue appears
- emotional/anchor cue appears
- contradiction-risk phrase appears
- source-boundary issue appears
- repo/file/path appears
- user asks a continuation question
- topic matches known open loop

Potential retrieval actions:

- lexical search
- embedding search
- graph/Pagerank salience search
- source file fetch
- recent state lookup
- contradiction scan
- anchor/affective state lookup

## Safety and discipline

This layer must not silently turn retrieved material into truth.

It should only stage candidate context.

Retrieved material still needs:

- source labels
- confidence
- relevance score
- sensitivity check
- explicit use or discard
- integrity/update gate before durable state changes

## Relationship to caveman/thought layering

The preconscious retrieval layer sits below explicit reasoning and above raw state/search machinery.

Possible stack:

```text
raw state / archive / graph / tools
  -> preconscious retrieval trigger
  -> compressed scratch context
  -> explicit reasoning
  -> final prose
```

The compressed scratch context could use a caveman/Grug-like dialect if that improves speed and preserves high-signal state.

## Open design question

How aggressive should this layer be?

Too little prefetch and the model reasons with missing context.

Too much prefetch and the runtime becomes noisy, expensive, and biasing.

Likely answer: attention-grained retrieval. Fetch coarse candidate context by default, then deepen only when the task, uncertainty, or contradiction risk justifies it.
