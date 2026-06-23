# HSM documentation index

This is the front door for the Human State Machine repo.

Use it to find the current architecture notes, runtime/state design, source boundaries, research seeds, and related prompt-development subprojects without treating `docs/` like a sock drawer with filenames.

## Start here

1. [Project README](../README.md) — repo purpose, core thesis, architecture, and source boundaries.
2. [Agent harness](../AGENTS.md) — rules for agents working in this repo.
3. [Anti-agreement harness](anti-agreement-harness.md) — claim classification, uncertainty, challenge, and falsification discipline.
4. [HSM master report](hsm-master-report-2026-05-01.md) — consolidated project definition and design frame.
5. [Runtime state and integrity loop](runtime-and-integrity.md) — runtime packet, model boundary, update gate, and truth discipline.
6. [Identity-as-data contract](identity-as-data-contract.md) — executor/subject separation; subject identity as state data, not model identity.
7. [Source map and roadmap](source-map-and-roadmap.md) — nearby repositories, implementation phases, and next files.
8. [Coding agent system prompt subproject](coding-agent-system-prompt/README.md) — separate-but-related workspace for coding-agent prompt development, now updated through Slice 13 closed-loop execution.

## Documentation by area

| Area | Document | Use it for |
|---|---|---|
| Project overview | [README](../README.md) | What HSM is, what belongs in this repo, source repos, architecture, and working standard. |
| Agent workflow | [AGENTS](../AGENTS.md) | Operating rules for agents: repo authority, source boundaries, confidence, provenance, write discipline, and anti-agreement requirement. |
| Truth discipline | [Anti-agreement harness](anti-agreement-harness.md) | Preventing agreement-machine drift; classifying claims; preserving uncertainty, contradictions, source boundaries, and falsification paths. |
| Core architecture | [HSM master report](hsm-master-report-2026-05-01.md) | The main HSM concept: evidence, extraction, provenance, state, runtime packet, integrity loop, and failure modes. |
| Runtime design | [Runtime state and integrity loop](runtime-and-integrity.md) | Runtime packet structure, update gate, provenance rules, packet levels, and coherence metrics. |
| Runtime design | [Identity-as-data contract](identity-as-data-contract.md) | Preventing executor/subject collapse; compiling `you are ...` identity prompts into subject-state declarations. |
| Human state model | [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md) | Baseline state, anchors, destabilising cues, affective trigger cycle, delayed explanation, and operating modes. |
| Source planning | [Source map and roadmap](source-map-and-roadmap.md) | How `ech0-kn1ght`, `quantzhai`, and `NetTTS` relate to HSM; implementation roadmap and near-next files. |
| Harness lessons | [Active state harness lessons](active-state-harness-lessons-2026-05-02.md) | Lessons from hosted AI runtime state injection and what HSM should make explicit, inspectable, and update-gated. |
| Research seed | [Human analogy and memory research seed](human-analogy-and-memory-research-seed-2026-05-02.md) | Seed notes for human-human state maintenance, trust, memory, exhaustion, hyperfocus, and social integrity. |
| Coding-agent prompt development | [Subproject README](coding-agent-system-prompt/README.md) | Current entry point, source-of-truth stack, Slice 13 status, and prompt-engineering direction. |
| Coding-agent prompt development | [Research status](coding-agent-system-prompt/RESEARCH_STATUS.md) | Current status matrix, active Slice 13 overlay, failure boundaries, next action, and risk register. |
| Coding-agent prompt development | [Final coding-agent prompt synthesis](coding-agent-system-prompt/final-findings-synthesis.md) | Canonical synthesis through Slice 12; read with the Slice 13 amendment. |
| Coding-agent prompt development | [Slice 13 synthesis amendment](coding-agent-system-prompt/final-findings-synthesis-amendment-2026-06-23.md) | Authoritative correction: closed-loop execution, trusted-state commitment, recovery, and diagnostic-evidence preservation. |
| Coding-agent prompt development | [Slice 13 research](coding-agent-system-prompt/slice-13-closed-loop-execution.md) | Primary research on postconditions, dependent-action gating, state invalidation, and recovery. |
| Coding-agent prompt development | [Slice 13 candidate structures](coding-agent-system-prompt/candidate-structures-slice-13-extension.md) | C43-C47 disposition, C39/C41 revision, placement, and semantic compression. |
| Coding-agent prompt development | [Slice 13 failure taxonomy](coding-agent-system-prompt/research-failure-mode-catalog-slice-13-extension.md) | FM13 Open-Loop Execution and FM14 Diagnostic-Evidence Destruction. |
| Coding-agent prompt development | [Slice 13 checklist extension](coding-agent-system-prompt/prompt-evaluation-checklist-slice-13-extension.md) | Structural-versus-behavioural evaluation implications. Dedicated EF13 fixture expansion was skipped. |
| Coding-agent prompt development | [Candidate prompt structures](coding-agent-system-prompt/candidate-structures.md) | Canonical C1-C42 Slice 0-12 base; read with the Slice 13 extension. |
| Coding-agent prompt development | [Failure-mode catalog](coding-agent-system-prompt/research-failure-mode-catalog.md) | Canonical FM1-FM12 Slice 0-12 base; read with the Slice 13 extension. |
| Coding-agent prompt development | [Prompt evaluation checklist](coding-agent-system-prompt/prompt-evaluation-checklist.md) | Canonical Slice 0-12 checklist; read with the Slice 13 checklist extension. |
| Coding-agent prompt development | [EF11 / EF12 evaluation plan](coding-agent-system-prompt/evaluation-plan-ef11-ef12.md) | Existing A/B plan. EF13 fixture design is not required for the current sequence. |
| Coding-agent prompt development | [Investigation imperative](coding-agent-system-prompt/slice-11-investigation-imperative.md) | Slice 11 source research: safely curious coding agents and orientation before narrowing. |
| Coding-agent prompt development | [Evidence-gated action](coding-agent-system-prompt/slice-12-evidence-gated-action.md) | Slice 12 source research: action-critical claims and evidence promotion before action. |

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
- [Identity-as-data contract](identity-as-data-contract.md)
- [Active state harness lessons](active-state-harness-lessons-2026-05-02.md)
- [Anti-agreement harness](anti-agreement-harness.md)
- [Source map and roadmap](source-map-and-roadmap.md)

Focus on:

- task-relevant state selection;
- readable packet first;
- provenance and confidence labels;
- executor/subject separation;
- subject identity as state data, not model identity;
- update gate after generation;
- no generated-memory contamination;
- preserving uncertainty and contradiction markers under compression.

### I want to work on coding-agent system prompt development

Read:

- [Subproject README](coding-agent-system-prompt/README.md)
- [Subproject instructions](coding-agent-system-prompt/AGENTS.md)
- [Research status](coding-agent-system-prompt/RESEARCH_STATUS.md)
- [Research plan](coding-agent-system-prompt/research-plan.md)
- [Final synthesis](coding-agent-system-prompt/final-findings-synthesis.md)
- [Slice 13 synthesis amendment](coding-agent-system-prompt/final-findings-synthesis-amendment-2026-06-23.md)
- [Slice 13 research](coding-agent-system-prompt/slice-13-closed-loop-execution.md)
- [Slice 13 candidate structures](coding-agent-system-prompt/candidate-structures-slice-13-extension.md)
- [Slice 13 failure taxonomy](coding-agent-system-prompt/research-failure-mode-catalog-slice-13-extension.md)
- [Slice 13 checklist implications](coding-agent-system-prompt/prompt-evaluation-checklist-slice-13-extension.md)
- [OpenCode prompt synthesis](coding-agent-system-prompt/final-opencode-findings-synthesis.md)

Focus on:

- building from observed coding-agent behaviour, not generic prompt fashion;
- keeping QuantZhai as runtime/prior art and HSM as the methodology workspace;
- separating static prompt guidance from runtime guarantees;
- orienting before narrowing;
- treating clues as leads, not proof, before action;
- verifying the state produced by an action before dependent action;
- preserving evidence needed for diagnosis and recovery;
- turning correction into changed next-action behaviour;
- pausing dependent mutation without abandoning useful diagnosis;
- preserving temporal semantics during prompt compression;
- balancing correctness, scope, safety, efficiency, and honest reporting.

Current corrected worker frame:

```text
orient
  -> verify precondition
  -> perform one bounded transition
  -> verify postcondition before dependent action
  -> continue or preserve evidence and re-ground
  -> final validation
  -> confidence-aware report
```

### I want to work on quiescent/anchor/trigger state

Read:

- [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md)
- [HSM master report](hsm-master-report-2026-05-01.md#quiescent-state-and-anchor-model)
- [Human analogy and memory research seed](human-analogy-and-memory-research-seed-2026-05-02.md)
- [Anti-agreement harness](anti-agreement-harness.md)

Focus on:

- baseline/quiescent state;
- stabilising anchors;
- destabilising cues;
- reaction versus later explanation;
- state modes such as baseline, focused work, defensive, aftershock, integration, and recovery;
- not treating later explanation as automatic truth.

### I want to work on evidence/provenance/extraction

Read:

- [HSM master report](hsm-master-report-2026-05-01.md#architecture-layers)
- [Runtime state and integrity loop](runtime-and-integrity.md#integrity-loop)
- [Anti-agreement harness](anti-agreement-harness.md)
- [Source map and roadmap](source-map-and-roadmap.md)

Source priority:

1. Direct records and primary artifacts.
2. Versioned project artifacts and repository history.
3. Third-party observations.
4. User testimony.
5. Model inference.

Model inference is allowed. Label it as inference.

### I want to avoid agreement-machine drift

Read:

- [Anti-agreement harness](anti-agreement-harness.md)
- [AGENTS: Anti-agreement harness](../AGENTS.md#anti-agreement-harness)
- [Runtime state and integrity loop](runtime-and-integrity.md#truth-discipline)

Working rule:

```text
Do not optimize for agreement.
Classify claims.
Preserve uncertainty.
Challenge overreach.
Keep emotional coherence separate from evidence.
Do not let generated explanation become durable state without checks.
```

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
- Treat `docs/coding-agent-system-prompt/` as the HSM subproject for coding-agent prompt methodology and research.

## Current document inventory

```text
README.md
AGENTS.md
docs/README.md
docs/active-state-harness-lessons-2026-05-02.md
docs/anti-agreement-harness.md
docs/coding-agent-system-prompt/**
docs/hsm-master-report-2026-05-01.md
docs/identity-as-data-contract.md
docs/quiescent-anchor-and-affective-cycle.md
docs/runtime-and-integrity.md
docs/source-map-and-roadmap.md
```
