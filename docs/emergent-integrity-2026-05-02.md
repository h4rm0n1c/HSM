# Emergent Integrity Note — 2026-05-02

## Core idea

Integrity may not be a single explicit subsystem that can be engineered directly.

It may be an emergent property produced by the interaction of the other HSM layers:

- evidence quality
- provenance discipline
- claim classification
- confidence scoring
- contradiction tracking
- retrieval quality
- runtime packet quality
- quiescent/anchor modelling
- affective state modelling
- update gating
- human review
- repeated correction over time

In this framing, the integrity layer is not a magic judge. It is the visible boundary where the rest of the system's discipline becomes testable.

## Practical implication

Do not try to solve integrity first as a grand unified truth engine.

Instead, build surrounding parts so that integrity can emerge:

```text
better evidence -> better claims
better provenance -> better confidence
better retrieval -> fewer missing supports
better graph structure -> better contradiction discovery
better runtime packets -> less drift
better update gates -> less contamination
better review loops -> better correction over time
```

## Integrity v0

For now, integrity can remain a modest gate:

```text
generated output is not durable state by default
candidate claims must be labelled
source support must be recorded
uncertainty must remain visible
contradictions must not be smoothed away
```

That is enough to prevent the worst failure mode: generated prose becoming memory just because it was fluent.

## Emergent target

The goal is not one perfect verifier.

The goal is a system whose total behaviour tends toward:

- lower contradiction
- lower state drift
- better source grounding
- more accurate confidence labels
- better recovery from mistakes
- less unsupported invention
- more stable continuity over human timescales

Integrity is therefore both a gate and a measured outcome.

## Design warning

If integrity is treated as a black-box model that declares truth, HSM recreates the same problem it is trying to avoid.

If integrity is treated as an emergent property of many inspectable layers, the system can improve without pretending certainty it does not have.
