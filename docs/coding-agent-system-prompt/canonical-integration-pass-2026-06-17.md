# Canonical Integration Pass: Slice-by-Slice Plan

Status: active integration plan  
Date: 2026-06-17  
Scope: integrating Slice 12 and the project smell audit into the coding-agent prompt research corpus without tacking notes onto the end or rewriting every layer at once

---

## Why This Exists

The previous work discovered a foundational correction:

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

**Files**:

- `canonical-integration-pass-2026-06-17.md`
- `README.md` / `RESEARCH_STATUS.md` only if needed to point future agents here

**Done when**:

- The integration order is explicit.
- Candidate prompt drafting remains paused.
- The next slice is clearly named.

### Slice I1 — Research-layer consolidation

**Status**: done as I1A + I1B.

**Goal**: Make the research layer internally coherent before touching canonical candidate structures.

**Inputs**:

- `slice-12-evidence-gated-action.md`
- `project-smell-audit-2026-06-17.md`
- `i1a-arxiv-backing-orientation-evidence-gating.md`
- Slice 12 sidecars
- relevant user/DeepSeek feedback already captured in Slice 12

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

**Done when**:

- No Slice 12 research-sidecar file still presents a noun-list as the core rule.
- Concrete examples are explicitly framed as non-exhaustive fixtures.
- The next layer can cite the research layer without ambiguity.

### Slice I2 — Candidate-structures canonical merge

**Status**: done.

**Goal**: Integrate Slice 12 and the smell-audit abstraction pass into `candidate-structures.md`.

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

**Done when**:

- Candidate structures no longer depend on list-shaped rules.
- C27-C42 form one coherent scaffold rather than Slice 11 plus appended Slice 12.

### Slice I3 — Failure-mode catalog canonical merge

**Status**: next.

**Goal**: Integrate FM12 and update relationships between FM3, FM7, FM11, and FM12.

**Files to update**:

- `research-failure-mode-catalog.md`

**Required changes**:

- Status/source updated through Slice 12.
- Add FM12.
- Update FM6 atom preservation abstraction if needed.
- Update FM11 wording so orientation and evidence-promotion are distinct.
- Update summary table to FM1-FM12.

**Done when**:

- FM12 is a first-class failure mode, not a side note.
- The catalog distinguishes fake investigation, narrow investigation, assumption cascade, and action without evidence promotion.

### Slice I4 — Evaluation checklist canonical merge

**Status**: pending.

**Goal**: Add EF12 and prevent fixture-to-rule leakage.

**Files to update**:

- `prompt-evaluation-checklist.md`

**Required changes**:

- Status/source updated through Slice 12.
- Add evaluation preface: examples are probes, not prompt wording.
- Add C36-C42 checks.
- Add FM12 to coverage table.
- Add EF12.1-EF12.6.
- Update quick check and token-budget sections.

**Done when**:

- Eval fixtures test invariants, not exact prompt nouns.
- v0/v1 comparison can measure EF11 and EF12 separately.

### Slice I5 — Final synthesis rewrite

**Status**: pending.

**Goal**: Rewrite `final-findings-synthesis.md` so the new foundation flows through the practical report.

**Files to update**:

- `final-findings-synthesis.md`

**Required changes**:

- Status/source updated through Slice 12 and smell audit.
- Core thesis updated from `safely curious` alone to `safely curious + evidence-gated action`.
- Replace list-first orientation/compaction/project-surface sections with principle-first wording.
- Integrate FM12 and C36-C42 into architecture, not as an appendix.
- Preserve practical report usefulness for future prompt drafting.

**Done when**:

- The synthesis can be read alongside the directory as the concentrated practical report.
- It no longer says the next step is only EF11 or only Slice 11 work.

### Slice I6 — Status and index update

**Status**: pending.

**Goal**: Make navigation reflect the new canonical state.

**Files to update**:

- `RESEARCH_STATUS.md`
- `docs/coding-agent-system-prompt/README.md`
- `docs/README.md`

**Required changes**:

- Remove stale `through Slice 11` statements where no longer true.
- Point readers to the integration pass and updated synthesis.
- Keep candidate prompt drafting paused unless explicitly resumed.

**Done when**:

- Future agents can enter from either README and get the right current layer order.

### Slice I7 — Evaluation preparation

**Status**: pending.

**Goal**: Prepare the behavioural A/B pass without drafting v1 yet.

**Files to update**:

- possibly `prompt-evaluation-checklist.md`
- possibly fixture docs / issue tracker

**Required changes**:

- Define how to test `hsm-build-v0.md` against EF11 and EF12.
- Define what a future v1 must beat.
- Preserve critical non-regression fixtures.

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
I3 next
```

Do not skip directly to I4-I8.

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
  -> stop or ask for next slice
```
