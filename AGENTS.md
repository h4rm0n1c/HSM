# AGENTS.md

This file is the operating harness for agents working in this repository.

## Authority

`h4rm0n1c/HSM` is the write target for Human State Machine work.

Other repositories may be read as source material, but do not write HSM material into them unless the user explicitly says to.

Read-only source repos by default:

- `h4rm0n1c/ech0-kn1ght`
- `h4rm0n1c/quantzhai`
- `h4rm0n1c/NetTTS`

## GitHub workflow rule

Prefer fewer, larger commits over many tiny writes. Work inside the current context window, prepare coherent file contents, then write the resulting files in batches. GitHub API pressure is expected; avoid noisy commit spam.

Before changing this repo:

1. Read this file.
2. Check the relevant docs under `docs/`.
3. Start with `docs/README.md` when browsing or adding documentation.
4. Keep source boundaries clear.
5. Put durable HSM decisions in this repo, not only in chat.
6. Mark uncertainty instead of silently guessing.
7. Add any new Markdown document to `docs/README.md` in the same change.
8. Apply the anti-agreement harness for serious reasoning, state updates, and project-theory work.

## Core frame

HSM models a human subject as structured, inspectable state grounded in evidence.

A language model is an execution engine over that state. It can extract, compare, compress, reason, and render. It is not automatically the source of truth.

Separate these layers:

- raw evidence
- extracted claims
- provenance
- confidence
- current state
- baseline/quiescent state
- affective and trigger state
- runtime packet
- generated output
- verified updates

Generated text does not become durable state by default. It must be classified and checked first.

## Anti-agreement harness

Do not optimize for agreement, reassurance, or theory-preservation.

Use the full harness in `docs/anti-agreement-harness.md` when evaluating claims, proposals, memories, interpretations, runtime packets, schemas, or durable HSM updates.

Required discipline:

- evidence before inference
- correction before rapport
- uncertainty before false confidence
- source boundaries before smooth narrative
- contradiction preservation before coherence theatre
- falsifiability before theory-protection

Classify claims when useful:

```text
supported
plausible_but_unproven
useful_design_fiction
emotionally_coherent_but_evidentially_weak
contradicted_by_current_material
unknown
needs_source_check
needs_schema_or_test_before_durable
```

For serious HSM work, separate:

```text
Evidence:
What has been checked or can be pointed to.

Inference:
What appears to follow from the evidence.

Uncertainty:
What has not been checked, is unavailable, or remains ambiguous.

Risk:
Where the model may be over-smoothing, agreeing, hallucinating, or preserving the theory.

Next useful move:
The concrete file, schema, test, inspection, or rejection step.
```

A useful answer may be warm or aligned with the user's goals. It must not become supportive at the expense of accuracy.

## Source priority

1. Direct records and primary artifacts.
2. Versioned project artifacts and repository history.
3. Third-party observations.
4. User testimony.
5. Model inference.

Model inference is allowed, but label it as inference.

## Coherence target

Useful coherence means low contradiction, low state drift, and low behavioural surprise over human-meaningful timespans.

It must stay grounded in evidence, uncertainty, and update discipline.

## Current document map

Start with `docs/README.md` for the browsable index.

- `README.md` — project overview.
- `docs/README.md` — documentation index and task-oriented entry points.
- `docs/hsm-master-report-2026-05-01.md` — consolidated report from current work.
- `docs/runtime-and-integrity.md` — runtime packet, provenance, and update loop.
- `docs/quiescent-anchor-and-affective-cycle.md` — stabilising anchor and delayed explanation loop.
- `docs/source-map-and-roadmap.md` — source repo map and implementation path.
- `docs/active-state-harness-lessons-2026-05-02.md` — hosted-runtime state harness lessons relevant to HSM.
- `docs/human-analogy-and-memory-research-seed-2026-05-02.md` — seed for human-human memory, trust, state repair, and social integrity research.
- `docs/anti-agreement-harness.md` — anti-agreement, claim-classification, uncertainty, and falsification discipline.

## Style for future agents

Be explicit. Preserve uncertainty. Do not flatten the subject into a generic profile. Do not let generated text silently become truth. Do not agree by default when source checks, classification, or challenge are needed.
