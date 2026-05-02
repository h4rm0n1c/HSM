# HSM documentation index

This is the front door for the Human State Machine repo.

Use it to find the current architecture notes, runtime/state design, source boundaries, and research seeds without treating `docs/` like a sock drawer with filenames.

## Start here

1. [Project README](../README.md) — repo purpose, core thesis, architecture, and source boundaries.
2. [Agent harness](../AGENTS.md) — rules for agents working in this repo.
3. [HSM master report](hsm-master-report-2026-05-01.md) — consolidated project definition and design frame.
4. [Runtime state and integrity loop](runtime-and-integrity.md) — runtime packet, model boundary, update gate, and truth discipline.
5. [Source map and roadmap](source-map-and-roadmap.md) — nearby repositories, implementation phases, and next files.

## Documentation by area

| Area | Document | Use it for |
| --- | --- | --- |
| Project overview | [README](../README.md) | What HSM is, what belongs in this repo, source repos, architecture, and working standard. |
| Agent workflow | [AGENTS](../AGENTS.md) | Operating rules for agents: repo authority, source boundaries, confidence, provenance, and write discipline. |
| Core architecture | [HSM master report](hsm-master-report-2026-05-01.md) | The main HSM concept: evidence, extraction, provenance, state, runtime packet, integrity loop, and failure modes. |
| Runtime design | [Runtime state and integrity loop](runtime-and-integrity.md) | Runtime packet structure, update gate, provenance rules, packet levels, and coherence metrics. |
| Human state model | [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md) | Baseline state, anchors, destabilising cues, affective trigger cycle, delayed explanation, and operating modes. |
| Source planning | [Source map and roadmap](source-map-and-roadmap.md) | How `ech0-kn1ght`, `quantzhai`, and `NetTTS` relate to HSM; implementation roadmap and near-next files. |
| Harness lessons | [Active state harness lessons](active-state-harness-lessons-2026-05-02.md) | Lessons from hosted AI runtime state injection and what HSM should make explicit, inspectable, and update-gated. |
| Research seed | [Human analogy and memory research seed](human-analogy-and-memory-research-seed-2026-05-02.md) | Seed notes for human-human state maintenance, trust, memory, exhaustion, hyperfocus, and social integrity. |

## Task-oriented entry points

### I want to understand the HSM concept

Read:

- [HSM master report](hsm-master-report-2026-05-01.md)
- [Runtime state and integrity loop](runtime-and-integrity.md)
- [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md)

Key frame:

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

### I want to work on runtime packets

Read:

- [Runtime state and integrity loop](runtime-and-integrity.md)
- [Active state harness lessons](active-state-harness-lessons-2026-05-02.md)
- [Source map and roadmap](source-map-and-roadmap.md)

Focus on:

- task-relevant state selection
- readable packet first
- provenance and confidence labels
- update gate after generation
- no generated-memory contamination

### I want to work on quiescent/anchor/trigger state

Read:

- [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md)
- [HSM master report](hsm-master-report-2026-05-01.md#quiescent-state-and-anchor-model)
- [Human analogy and memory research seed](human-analogy-and-memory-research-seed-2026-05-02.md)

Focus on:

- baseline/quiescent state
- stabilising anchors
- destabilising cues
- reaction versus later explanation
- state modes such as baseline, focused work, defensive, aftershock, integration, and recovery

### I want to work on evidence/provenance/extraction

Read:

- [HSM master report](hsm-master-report-2026-05-01.md#architecture-layers)
- [Runtime state and integrity loop](runtime-and-integrity.md#integrity-loop)
- [Source map and roadmap](source-map-and-roadmap.md)

Source priority:

1. Direct records and primary artifacts.
2. Versioned project artifacts and repository history.
3. Third-party observations.
4. User testimony.
5. Model inference.

Model inference is allowed. Label it as inference.

### I want to know what belongs in which repo

Read:

- [README: Current source repos](../README.md#current-source-repos)
- [AGENTS: Authority](../AGENTS.md#authority)
- [Source map and roadmap](source-map-and-roadmap.md)

Working rule:

- Write HSM architecture/state/schema/runtime work here.
- Treat `h4rm0n1c/ech0-kn1ght` as evidence/provenance input.
- Treat `h4rm0n1c/quantzhai` as runtime/compression/harness prior art.
- Treat `h4rm0n1c/NetTTS` as deterministic token weighting/segmentation prior art.

## Current document inventory

```text
README.md
AGENTS.md
docs/README.md
docs/active-state-harness-lessons-2026-05-02.md
docs/hsm-master-report-2026-05-01.md
docs/human-analogy-and-memory-research-seed-2026-05-02.md
docs/quiescent-anchor-and-affective-cycle.md
docs/runtime-and-integrity.md
docs/source-map-and-roadmap.md
```

## Maintenance rule

When adding a Markdown document, add it to this index in the same change.

A document without an index link is not documentation. It is archaeology.
