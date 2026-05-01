# MoE Specialist Contracts and Layered Cognition — 2026-05-02

## Core idea

HSM may eventually use a mixture-of-experts style architecture where major cognitive roles become explicit contracts, training targets, routing policies, and evaluation traces.

This is not merely one model with a larger prompt. It is a runtime and training system that decomposes lifelike cognition into specialised functions that can be routed, evaluated, improved, and possibly packed into a single model or coordinated model stack.

## Layered cognition target

A rough runtime stack:

```text
input / situation
  -> preconscious salience and retrieval trigger
  -> compressed scratch representation
  -> deliberate reasoning and tool orchestration
  -> response planning
  -> final expression
  -> integrity/update review
```

The important change is that each layer can become a contract.

Example contracts:

- detect likely-needed context
- retrieve candidate evidence
- identify contradiction risk
- classify claims
- preserve uncertainty
- detect anchor/affective state relevance
- compress scratch state
- expand scratch state into formal reasoning
- render final response
- review state-update candidates

## Preconscious retrieval as specialist role

The preconscious retrieval layer can be treated as an expert/router function.

It receives the input and active state, then decides which context should be staged before deliberate reasoning proceeds.

Possible outputs:

```json
{
  "prefetch": [
    { "kind": "repo_search", "target": "HSM", "query": "runtime packet integrity" },
    { "kind": "state_lookup", "target": "anchors" },
    { "kind": "contradiction_scan", "scope": "active_project" }
  ],
  "scratch": "need source map + current open loop + possible contradiction risk",
  "confidence": "medium"
}
```

This mirrors the human-like pattern where useful memories or associations are already present before explicit reasoning fully begins.

## Caveman / Grug as early scratch language

A compressed caveman/Grug-like dialect may be useful for early internal scratch state.

Not final output. Not document style.

Role:

```text
fast low-cost scratch
  -> high-signal context
  -> fewer tokens
  -> less social filler
  -> human inspectable
```

Possible layer sequence:

```text
preconscious scratch: compact/caveman
  -> deliberate reasoning: fuller internal formal structure
  -> final output: proper English
```

This gives a bridge between opaque symbolic/vector representations and expensive polished prose.

## Tool-call choreography

A lifelike agent runtime may support a staged pattern:

```text
pre-reasoning retrieval/tool calls
  -> deliberate reasoning
  -> more targeted tool calls
  -> response
  -> update review
```

The key is that the first retrieval pass happens before the model has committed to a narrative.

That can reduce hallucinated bridges and improve evidence grounding.

## MoE packing hypothesis

Each major HSM role could become:

- a document-defined contract
- a dataset generator
- an evaluation benchmark
- a specialist expert
- a router target
- a trainable behaviour inside a larger model

Possible expert roles:

```text
retriever expert
claim extractor expert
contradiction expert
provenance expert
anchor/affective-state expert
state compiler expert
compression expert
response renderer expert
update reviewer expert
```

The long-term possibility is a single model or coordinated model stack with experts specialised around HSM contracts.

## Training implication

HSM runtime traces become valuable training data because they include:

- input
- active state
- preconscious retrieval decisions
- staged context
- scratch representation
- deliberate reasoning output
- tool calls
- final response
- extracted claims
- accepted/rejected updates
- human correction

This can train models to perform the intended cognitive choreography more naturally than prompt-only control.

## Hotter model hypothesis

Some specialist behaviours may benefit from running models or decoding settings that are more exploratory than normal assistant use.

Examples:

- association generation
- candidate retrieval planning
- hypothesis generation
- analogy discovery
- compression experiments

But hotter generation must be bounded by later layers:

- source checks
- contradiction scans
- confidence labels
- update gates

Exploration is useful upstream. Truth discipline belongs downstream.

## Why this matters

This reframes HSM from one prompt or one model into a full cognitive toolchain.

The runtime can already approximate the staged process:

```text
early compressed scratch + retrieval
  -> formal reasoning + targeted tools
  -> proper final expression
```

The future work is to make each stage explicit, benchmarked, and trainable.

## Design warning

Do not make hidden scratch text the authority.

Compressed scratch is a working layer, not truth.

The durable system still requires:

- evidence
- provenance
- confidence
- contradiction handling
- update discipline

MoE-style experts should improve the pipeline, not replace the pipeline with a more complicated black box.
