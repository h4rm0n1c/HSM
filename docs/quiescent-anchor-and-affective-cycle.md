# Quiescent Anchor and Affective Cycle

This document defines the HSM model for resting state, stabilising anchors, trigger activation, and delayed reasoning.

## Core idea

A human-like state system is not just memory plus current input.

It needs a model of the state the subject tends to return toward when not actively disturbed. That is the quiescent state.

The quiescent state is not empty. It contains baseline activation, preferred stability anchors, avoidance patterns, recovery habits, and latent affective memory clusters.

## Quiescent state

The quiescent state answers:

- What does stable operation look like?
- What does the subject reach for when stability is threatened?
- What kinds of cues disturb baseline operation?
- How long does recovery usually take?
- What memories or patterns are normally not foregrounded, but become active under stress?

Draft fields:

```yaml
quiescent_state:
  baseline:
    mood: unknown
    activation: unknown
    threat_level: unknown
    cognitive_style: unknown
  preferred_anchors: []
  stabilising_actions: []
  destabilising_cues: []
  avoidance_patterns: []
  recovery_patterns: []
  recovery_time_profile:
    fast: seconds_to_minutes
    medium: hours
    long: days_or_more
  notes: []
```

## Anchors

An anchor is a stabilising point the subject can grasp when the environment or internal state becomes chaotic.

Anchor categories:

- person
- role
- routine
- place
- project
- machine/tool
- sensory environment
- moral rule
- narrative identity
- technical task
- archive/evidence trail

An anchor record should capture:

```yaml
anchor:
  id: anchor.project.example
  type: project | person | routine | role | place | tool | value | sensory | narrative
  description: "plain description"
  stabilises_by:
    - continuity
    - control
    - meaning
    - familiarity
  failure_mode_if_lost: unknown
  evidence_refs: []
  confidence: low | medium | high
```

## Affective-trigger memory

Some memory is not normally foregrounded in calm state, but remains highly available to cue matching.

For HSM purposes, avoid turning this into a vague claim that memory is simply buried or recovered. Use a more mechanical definition:

- not usually active in baseline state
- not always available as clean narrative recall
- can activate quickly through emotional, sensory, social, or threat similarity
- may first appear as body state, expectation, anger, dread, shutdown, or urgency
- may only later become a clear explanation

## Trigger cycle

A useful HSM cycle:

```text
quiescent state
  -> incident or cue
  -> fast affective reaction
  -> partial memory/pattern activation
  -> behaviour or output
  -> delayed reasoning aftershock
  -> narrative explanation
  -> state update, recovery, or renewed destabilisation
  -> return toward baseline
```

This cycle may run over seconds, minutes, hours, or days.

## Reaction versus explanation

HSM must distinguish these states:

- immediate reaction
- partial memory activation
- later explanation
- durable belief
- hypothesis
- evidence-backed memory

A later explanation is not fake merely because it arrived after the reaction. It may be the higher-reasoning layer catching up after the affective system already acted.

At the same time, a later explanation is not automatically truth. It should be stored as explanation, hypothesis, or durable state depending on evidence and integrity checks.

## Runtime relevance

The runtime packet should include anchor/trigger state only when relevant.

Example fields:

```json
{
  "anchor_status": "stable | weakened | lost | restored | unknown",
  "active_trigger_candidates": [],
  "reaction_phase": "baseline | immediate | aftershock | integration | recovery | unknown",
  "reasoning_delay_expected": "seconds | minutes | hours | days | unknown",
  "explanation_confidence": "low | medium | high | unknown"
}
```

## Failure modes

### Treating reaction as whole identity

Bad:

```text
The subject reacted angrily, therefore anger is the trait.
```

Better:

```text
The subject entered a triggered or defensive state under specific cue conditions. Record the cue, reaction, context, later explanation, and confidence.
```

### Treating later explanation as automatic truth

Bad:

```text
The later narrative sounded coherent, therefore it is durable memory.
```

Better:

```text
Store the narrative as an explanation candidate, then check source support and contradictions.
```

### Ignoring anchors

Bad:

```text
Only model facts and preferences.
```

Better:

```text
Model what restores stability, what threatens stability, and how the subject recovers.
```

## Engineering implication

The state compiler should not only select facts. It should select the current operating mode.

Useful state modes:

- baseline
- focused work
- anchor-seeking
- destabilised
- defensive
- shutdown
- aftershock/reasoning
- integration
- recovery

These are not diagnoses. They are operational state labels for the emulator.

## Minimal v0 task

Create three records:

1. `quiescent_state.yml`
2. `anchors.yml`
3. `affective_patterns.yml`

Keep them sparse at first. Prefer explicit unknowns over forced completion.
