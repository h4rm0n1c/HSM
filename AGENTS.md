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
3. Keep source boundaries clear.
4. Put durable HSM decisions in this repo, not only in chat.
5. Mark uncertainty instead of silently guessing.

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

- `README.md` — project overview.
- `docs/hsm-master-report-2026-05-01.md` — consolidated report from current work.
- `docs/runtime-and-integrity.md` — runtime packet, provenance, and update loop.
- `docs/quiescent-anchor-and-affective-cycle.md` — stabilising anchor and delayed explanation loop.
- `docs/source-map-and-roadmap.md` — source repo map and implementation path.

## Style for future agents

Be explicit. Preserve uncertainty. Do not flatten the subject into a generic profile. Do not let generated text silently become truth.
