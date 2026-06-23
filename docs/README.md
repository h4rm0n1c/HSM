# HSM Documentation Index

This is the front door for the Human State Machine repository.

## Start Here

1. [Project README](../README.md) — purpose, architecture, source boundaries.
2. [Agent harness](../AGENTS.md) — operating rules for agents in this repository.
3. [Anti-agreement harness](anti-agreement-harness.md) — claim classification, uncertainty, challenge, and falsification.
4. [HSM master report](hsm-master-report-2026-05-01.md) — consolidated project definition.
5. [Runtime state and integrity loop](runtime-and-integrity.md) — runtime packet, update gate, and truth discipline.
6. [Identity-as-data contract](identity-as-data-contract.md) — executor/subject separation.
7. [Source map and roadmap](source-map-and-roadmap.md) — related repositories and implementation direction.
8. [Coding-agent prompt subproject](coding-agent-system-prompt/README.md) — coding-agent prompt methodology consolidated through Slice 13.

## Documentation By Area

| Area | Document | Use |
|---|---|---|
| Project overview | [README](../README.md) | Core purpose, architecture, source repositories, and working standard |
| Agent workflow | [AGENTS](../AGENTS.md) | Authority, provenance, write discipline, anti-agreement requirements |
| Truth discipline | [Anti-agreement harness](anti-agreement-harness.md) | Claim classification, uncertainty, contradiction, falsification |
| Core architecture | [HSM master report](hsm-master-report-2026-05-01.md) | Evidence, extraction, state, runtime packet, integrity loop |
| Runtime design | [Runtime state and integrity loop](runtime-and-integrity.md) | Runtime packet, update gates, confidence, provenance |
| Runtime design | [Identity-as-data contract](identity-as-data-contract.md) | Preventing executor/subject collapse |
| Human-state model | [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md) | Baseline, anchors, triggers, modes, delayed explanation |
| Source planning | [Source map and roadmap](source-map-and-roadmap.md) | Repository relationships and roadmap |
| Harness lessons | [Active state harness lessons](active-state-harness-lessons-2026-05-02.md) | Lessons from live state injection and update control |
| Research seed | [Human analogy and memory research seed](human-analogy-and-memory-research-seed-2026-05-02.md) | Human-human state maintenance and memory research seed |
| Coding-agent research | [Subproject README](coding-agent-system-prompt/README.md) | Current entry point and source-of-truth map |
| Coding-agent research | [Research status](coding-agent-system-prompt/RESEARCH_STATUS.md) | Current state, next phase, risk register |
| Coding-agent research | [Candidate structures](coding-agent-system-prompt/candidate-structures.md) | Canonical structures through C47 |
| Coding-agent research | [Failure catalogue](coding-agent-system-prompt/research-failure-mode-catalog.md) | Canonical failure modes through FM14 |
| Coding-agent research | [Evaluation checklist](coding-agent-system-prompt/prompt-evaluation-checklist.md) | Canonical structural/behavioural checklist through Slice 13 |
| Coding-agent research | [Final synthesis](coding-agent-system-prompt/final-findings-synthesis.md) | Complete current synthesis through Slice 13 |
| Coding-agent research | [Research plan](coding-agent-system-prompt/research-plan.md) | Canonical methodology including action-boundary analysis |
| Coding-agent research | [Research references](coding-agent-system-prompt/research-references.md) | Canonical source registry including inspected Slice 13 papers |
| Coding-agent research | [OpenCode synthesis](coding-agent-system-prompt/final-opencode-findings-synthesis.md) | OpenCode system comparison with Slice 13 correction |
| Coding-agent research | [EF11/EF12 plan](coding-agent-system-prompt/evaluation-plan-ef11-ef12.md) | Retained Slice 11/12 plan; not complete Slice 13 coverage |
| Coding-agent provenance | [Slice 13 research](coding-agent-system-prompt/slice-13-closed-loop-execution.md) | Detailed derivation of closed-loop execution findings |
| Coding-agent provenance | [Slice 13 consolidation record](coding-agent-system-prompt/slice-13-consolidation-pass-2026-06-24.md) | Sidecar-to-canonical fold-in audit |

## Coding-Agent Research: Current Frame

The canonical worker model is:

```text
orient
  -> verify precondition
  -> perform one bounded transition
  -> verify postcondition before dependent action
  -> continue or preserve evidence and re-ground
  -> final validation
  -> confidence-aware report
```

Key failure boundary:

```text
FM12:
  unverified current-state claim authorizes action

FM13:
  unverified action result authorizes dependent action

FM14:
  evidence needed for diagnosis or recovery is destroyed prematurely
```

The Slice 13 sidecars and amendment are provenance only. Current doctrine is folded into the canonical structures, catalogue, checklist, and synthesis.

## Task-Oriented Entry Points

### Understand HSM

Read:

- [HSM master report](hsm-master-report-2026-05-01.md)
- [Runtime state and integrity loop](runtime-and-integrity.md)
- [Quiescent anchor and affective cycle](quiescent-anchor-and-affective-cycle.md)

### Work On Runtime Packets

Read:

- [Runtime state and integrity loop](runtime-and-integrity.md)
- [Identity-as-data contract](identity-as-data-contract.md)
- [Active state harness lessons](active-state-harness-lessons-2026-05-02.md)
- [Anti-agreement harness](anti-agreement-harness.md)

Focus on task-relevant state, provenance, confidence, executor/subject separation, update gates, and preserving uncertainty under compression.

### Work On Coding-Agent Prompt Development

Read:

- [Subproject README](coding-agent-system-prompt/README.md)
- [Subproject instructions](coding-agent-system-prompt/AGENTS.md)
- [Research status](coding-agent-system-prompt/RESEARCH_STATUS.md)
- [Candidate structures](coding-agent-system-prompt/candidate-structures.md)
- [Failure catalogue](coding-agent-system-prompt/research-failure-mode-catalog.md)
- [Evaluation checklist](coding-agent-system-prompt/prompt-evaluation-checklist.md)
- [Final synthesis](coding-agent-system-prompt/final-findings-synthesis.md)
- [Research plan](coding-agent-system-prompt/research-plan.md)
- [Research references](coding-agent-system-prompt/research-references.md)

Focus on:

- observed coding-agent behaviour rather than prompt fashion;
- static prompt versus runtime guarantees;
- orientation before narrowing;
- evidence promotion before action;
- postcondition verification before dependent action;
- evidence-preserving recovery;
- authority and user-work protection;
- temporal semantics during compression;
- honest validation and confidence reporting.

### Work On Evidence / Provenance / Extraction

Read:

- [HSM master report](hsm-master-report-2026-05-01.md#architecture-layers)
- [Runtime state and integrity loop](runtime-and-integrity.md#integrity-loop)
- [Anti-agreement harness](anti-agreement-harness.md)
- [Source map and roadmap](source-map-and-roadmap.md)

Source priority:

1. direct records and primary artifacts;
2. versioned project artifacts and repository history;
3. third-party observations;
4. user testimony;
5. model inference.

Model inference is allowed when labelled as inference.

### Avoid Agreement-Machine Drift

Working rule:

```text
Do not optimize for agreement.
Classify claims.
Preserve uncertainty.
Challenge overreach.
Keep emotional coherence separate from evidence.
Do not let generated explanation become durable state without checks.
```

## Repository Roles

- HSM: architecture, state, schema, methodology, failure analysis.
- `h4rm0n1c/ech0-kn1ght`: evidence/provenance input.
- `h4rm0n1c/quantzhai`: runtime, compression, harness, and prompt-assembly prior art.
- `h4rm0n1c/NetTTS`: deterministic weighting/segmentation prior art.
- `docs/coding-agent-system-prompt/`: coding-agent prompt research and methodology.

## Current Inventory

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