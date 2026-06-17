# Canonical Integration Pass: Slice-by-Slice Plan

Status: active integration plan; current position I7 next  
Date: 2026-06-17  
Scope: integrating Slice 12 and the project smell audit into the coding-agent prompt research corpus without tacking notes onto the end or rewriting every layer at once

---

## Why This Exists

The foundational correction is:

```text
action depends on a claim about current reality
  -> identify the action-critical claim
  -> prove or falsify it with the cheapest safe check
  -> only then act at full blast radius
```

The first attempt at integrating this almost repeated the failure pattern at project scale: a giant rewrite of a canonical file in one step.

That is wrong for this project.

The right method is layered integration:

```text
research layer
  -> candidate structures
  -> failure-mode catalog
  -> evaluation checklist
  -> final synthesis
  -> status / index docs
  -> future prompt draft
```

Each layer must fully absorb the previous layer before the next layer is edited.

---

## Working Rule

One integration slice at a time.

A slice is complete only when:

1. The slice has one clear purpose.
2. Its source inputs are named.
3. Its output files are limited and reviewable.
4. It uses abstraction-first wording where appropriate.
5. It does not leave contradictory current-state claims in the same layer.
6. It records what remains for the next slice.

Do not jump to `hsm-build-v1.md` until all integration slices below are complete and the EF11/EF12 evaluation plan has been updated.

---

## Integration Slices

### Slice I0 — Integration protocol

**Status**: done.

**Goal**: Stop the process from becoming one giant rewrite.

### Slice I1 — Research-layer consolidation

**Status**: done as I1A + I1B.

**Goal**: Make the research layer internally coherent before touching canonical candidate structures.

**Files updated**:

- `i1a-arxiv-backing-orientation-evidence-gating.md`
- `research-failure-mode-catalog-slice-12-extension.md`
- `prompt-evaluation-checklist-slice-12-extension.md`
- `candidate-structures-slice-12-extension.md`

**Must preserve**:

```text
world-state claim
action-critical claim
clue is not proof
cheapest safe proof/falsifier
blast-radius-scaled action
examples are fixtures, not prompt wording
```

### Slice I2 — Candidate-structures canonical merge

**Status**: done.

**Files updated**:

- `candidate-structures.md`

**Required changes completed**:

- Status/source updated through Slice 12 and I1A.
- Added C36-C42 using abstract wording.
- Rewrote C28 orientation principle-first.
- Rewrote C30 established-way discovery principle-first.
- Rewrote atom-preservation wording principle-first.
- Kept examples as non-exhaustive anchors.
- Did not draft `hsm-build-v1.md`.

### Slice I3 — Failure-mode catalog canonical merge

**Status**: done.

**Files updated**:

- `research-failure-mode-catalog.md`

**Required changes completed**:

- Status/source updated through Slice 12.
- Added FM12 as first-class.
- Updated FM6 atom preservation abstraction.
- Updated FM11 wording so orientation and evidence-promotion are distinct.
- Updated summary table to FM1-FM12.

### Slice I4 — Evaluation checklist canonical merge

**Status**: done.

**Files updated**:

- `prompt-evaluation-checklist.md`

**Required changes completed**:

- Status/source updated through Slice 12.
- Added evaluation preface: examples are probes, not prompt wording.
- Added C36-C42 checks.
- Added FM12 to coverage table.
- Added EF12.1-EF12.6.
- Updated quick check, token-budget sections, and v0/v1 A/B criteria.

### Slice I5 — Final synthesis rewrite

**Status**: done.

**Files updated**:

- `final-findings-synthesis.md`

**Required changes completed**:

- Status/source updated through Slice 12 and smell audit.
- Core thesis updated from `safely curious` alone to `safely curious + evidence-gated action`.
- Replaced list-first sections with principle-first wording where it affects prompt drafting.
- Integrated FM12 and C36-C42 into architecture, not as an appendix.
- Preserved practical report usefulness for future prompt drafting.
- Did not draft `hsm-build-v1.md`.

### Slice I6 — Status and index update

**Status**: done.

**Files updated**:

- `RESEARCH_STATUS.md`
- `docs/coding-agent-system-prompt/README.md`
- `docs/README.md`

**Required changes completed**:

- Removed stale `through Slice 11` entry points where no longer true.
- Pointed readers to the integration pass and updated synthesis.
- Kept candidate prompt drafting paused unless explicitly resumed.

### Slice I7 — Evaluation preparation

**Status**: next.

**Goal**: Prepare the behavioural A/B pass without drafting v1 yet.

**Files to update**:

- likely `prompt-evaluation-checklist.md`
- possibly a dedicated evaluation-plan or fixture-prep document if the checklist would become too large

**Required changes**:

- Define how to test `hsm-build-v0.md` against EF11 and EF12.
- Define what a future v1 must beat.
- Preserve critical non-regression fixtures.
- Separate v0 failure expectations from future v1 pass criteria.
- Do not draft a prompt.

**Done when**:

- We know exactly what v1 must prove before claiming improvement.

### Slice I8 — Candidate prompt drafting

**Status**: gated.

**Goal**: Draft `hsm-build-v1.md` or equivalent.

**Gate**: Only after I1-I7 are complete and the user explicitly resumes prompt drafting.

---

## Current Position

We are at:

```text
I0 complete
I1 complete
I2 complete
I3 complete
I4 complete
I5 complete
I6 complete
I7 next
```

Do not skip directly to I8.

---

## Anti-Pattern To Avoid

```text
read latest feedback
  -> rewrite final synthesis immediately
  -> sprinkle status updates
  -> leave sidecars stale
  -> candidate structures contradict research docs
  -> eval checklist tests old invariants
```

This produces archaeology, not integration.

---

## Correct Pattern

```text
one layer
  -> fully absorb correction
  -> verify no local contradiction
  -> record next layer
  -> stop or receive explicit continuation
```
