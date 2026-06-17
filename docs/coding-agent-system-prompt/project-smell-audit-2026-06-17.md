# Project Smell Audit: Prompt Research Corpus

Status: first audit pass after Slice 12 abstraction correction  
Date: 2026-06-17  
Scope: HSM-authored coding-agent prompt research corpus, candidate structures, failure modes, evaluation checklist, status/index docs, and fixture descriptions  
Out of scope: raw external prompt dumps under `external-reference/` except where HSM-authored synthesis quotes or adopts their structures

---

## Trigger

`hsm-build-v0.md` testing and user feedback exposed a broader prompt-design smell.

Slice 12 initially named a concrete list:

```text
API, path, model ID, command, config key, hardware capacity, runtime state
```

That list was a symptom. It described the same abstraction from multiple angles and would still miss the next weird case.

The corrected abstraction is:

```text
action depends on a claim about current reality
  -> identify that action-critical claim
  -> prove or falsify it with the cheapest safe check
  -> only then act at full blast radius
```

Audit conclusion: this is not isolated. The corpus contains other places where examples sit too close to prompt text and risk becoming brittle category lists.

---

## Audit Principle

A worker prompt should lead with **principles**.

Examples belong in:

- fixture descriptions
- explanatory notes
- non-exhaustive anchors after the principle
- research provenance

Examples should not masquerade as complete rules.

Correct layering:

```text
principle
  -> optional non-exhaustive examples
  -> concrete fixtures that test the principle
```

Bad layering:

```text
example list
  -> model treats list as boundary
  -> next unseen case falls through
```

---

## Smell Taxonomy

### SM1: Category-list-as-rule

A rule is expressed mostly as a list of nouns or cases. The abstraction is either missing or weaker than the list.

**Risk**: the agent overfits the listed cases and fails on the unlisted equivalent.

**Fix**: rewrite as principle-first, then keep examples only as non-exhaustive anchors or fixture cases.

### SM2: Example too close to prompt text

Examples are useful in research docs but dangerous if they are copied into compact baseline prompt wording without abstraction.

**Risk**: v1 inherits bulky lists and still behaves narrowly.

**Fix**: mark examples as examples, move them to fixture/eval sections, or compress into abstract labels.

### SM3: Fixture-to-rule leakage

A fixture is concrete by design, but later docs start treating fixture details as the general behavioural rule.

**Risk**: the prompt trains for the test rather than the failure mode.

**Fix**: keep fixture language concrete, but name the invariant each fixture tests.

### SM4: Sidecar / canonical drift

Extension docs, amendments, and canonical files diverge. A future agent may read the stale sidecar and reintroduce old wording.

**Risk**: integration pass looks complete but old wording remains in provenance files and gets copied into v1.

**Fix**: either update sidecars after conceptual corrections or mark them stale/provenance-only with a pointer to the canonical abstraction.

### SM5: Static-prompt / runtime-boundary blur

Runtime facts, UI behaviours, mode state, tool permissions, and harness feedback are described near static prompt rules.

**Risk**: v1 tries to solve runtime/CLI problems with prompt sludge.

**Fix**: classify every structure as static prompt, runtime injection, task packet, fixture, docs/process, or CLI/TUI design.

### SM6: Safety/example over-weighting

Safety examples are necessary, but if they dominate before the positive operating stance, the worker becomes passive and shallow.

**Risk**: containment beats curiosity; agent stops or narrows too early.

**Fix**: keep safety strict but place it around action/mutation/escalation boundaries.

### SM7: Atom-list absolutism

High-value atom lists are useful, but they should represent a broader principle: exact spans whose corruption changes task semantics.

**Risk**: the compactor/prompt preserves listed atom types while losing an unlisted exact value that mattered.

**Fix**: define the abstraction first, then examples.

---

## Findings By File / Area

### 1. `slice-12-evidence-gated-action.md`

**Old smell**: SM1 category-list-as-rule.

The first Slice 12 version made the core rule depend on an example list. This was corrected immediately.

**Current state**: substantially repaired.

The new abstraction is:

```text
world-state claim
  -> action-critical claim
  -> clue is not proof
  -> cheapest safe proof/falsifier before action
  -> if unchecked, reduce/defer/stop by blast radius
```

**Remaining risk**: EF12 fixtures still contain concrete cases. That is correct for tests, but future prompt drafting must not copy the fixture nouns into the worker prompt.

**Action**: during canonical merge, use the abstract C36/C37/C38 wording, not the old noun-list wording.

### 2. `candidate-structures-slice-12-extension.md`

**Old smell**: SM1 category-list-as-rule and SM2 example too close to prompt text.

**Current state**: repaired after abstraction pass.

The sidecar now states explicitly:

```text
The abstraction is not API/path/model/config/hardware/etc.
Those are examples.
```

**Remaining risk**: recommendation rows still mention EF12 example names. Acceptable because they point to fixtures, not prompt wording.

**Action**: canonical merge should preserve `action-critical world-state claim`, `clue-is-not-proof`, and `cheapest falsifier preflight` as the primary names.

### 3. `research-failure-mode-catalog-slice-12-extension.md`

**Smell**: SM4 sidecar/canonical drift.

This file was created before the abstraction correction. It likely still uses list-flavoured Slice 12 language.

**Risk**: future agents may read this file and copy stale noun-list wording back into canonical FM12.

**Action**: update this sidecar to match the abstract Slice 12 wording before canonical merge.

### 4. `prompt-evaluation-checklist-slice-12-extension.md`

**Smell**: mostly acceptable concrete fixtures, with SM3 fixture-to-rule leakage risk.

Evaluation fixtures should stay concrete:

```text
inferred API endpoint
stale model ID / inventory
hardware preflight
config-before-edit
repeated-correction
confident wrong report
```

The problem would be copying these fixture names into the worker prompt as a general rule.

**Action**: add a short preface saying EF12 examples are test cases for the action-critical-claim abstraction, not the prompt wording.

### 5. `candidate-structures.md`

**Smell**: several list-heavy structures remain in the canonical candidate file.

#### C28 Orientation pass

Current wording lists local rules, directory shape, manifests/configs, scripts, tests, existing helpers, and owning files.

**Classification**: useful examples, but principle should lead.

**Better abstraction**:

```text
Before narrowing, map the project surfaces that determine authority, ownership, execution, validation, and existing conventions. Scale depth by blast radius.
```

Then list local rules / tree / manifests / tests / helpers as non-exhaustive examples.

#### M3 / S7-2 / S8-1 high-value atoms

Current wording lists exact paths, symbols, commands, flags, errors, versions, and user corrections.

**Classification**: mostly good, but should abstract to semantic exactness.

**Better abstraction**:

```text
Under context pressure, preserve exact spans whose corruption would change task semantics, reproducibility, authority, or user intent.
```

Then keep path/flag/error/model examples.

#### C30 Established-way discovery

Current wording lists helper, config path, command, schema, workflow.

**Classification**: mild SM1.

**Better abstraction**:

```text
Before introducing a new project surface, look for the established project way and reuse or extend it unless evidence shows it is absent or broken.
```

Then examples can mention helpers/configs/commands/schemas/workflows.

#### C32 Path-to-action lock

Mostly fine. It is intentionally specific because path operations are a distinct mutation boundary. Keep.

#### S6-1 Trusted/untrusted input examples

Mostly fine. The abstraction is instruction/data separation; examples are necessary because prompt injection is concrete. Keep principle-first wording.

**Action**: run a canonical abstraction pass over `candidate-structures.md` before v1.

### 6. `final-findings-synthesis.md`

**Smell**: mixed.

This file is a synthesis document, so examples are expected. But it is also likely to be read by future agents as prompt source material.

Risk areas:

- Runtime environment injection lists platform/date/cwd/model/git/project rules/validation/context pressure. This is acceptable because it is classified as runtime, not static prompt.
- Repo authority section lists helpers/config paths/commands/schemas/workflows. Needs the project-surface abstraction.
- Orientation section lists local rules/tree/manifests/scripts/tests/helpers/owning files. Needs the authority/ownership/execution/validation/convention abstraction.
- Compaction section has a long atom list. Needs the semantic-exactness abstraction before the list.
- Subagent section lists negative cases. Acceptable as tool-contract examples, but should be framed as needle-query vs broad-exploration abstraction.

**Action**: add a Slice 12 addendum or canonical update that says examples in the synthesis are non-exhaustive anchors and v1 drafting must extract principles, not copy lists.

### 7. `prompt-evaluation-checklist.md`

**Smell**: mostly acceptable.

Evaluation checklists are allowed to be concrete, but they can leak into prompt text.

Risk areas:

- Investigation checklist lists concrete orientation targets.
- Dynamic/runtime context lists concrete injected fields.
- Failure-mode coverage table may encourage prompt drafters to paste all mitigations.

**Action**: add an evaluation preface:

```text
Checklist examples are observable probes, not necessarily prompt wording. A prompt passes by implementing the invariant, not by containing the fixture nouns.
```

### 8. `RESEARCH_STATUS.md`

**Smell**: status file is currently okay, but it now records Slice 12 as not canonically merged.

**Risk**: future agents may treat the current state as ready for v1 even though Slice 12 still needs canonical merge.

**Action**: keep the pending boundary explicit. No prompt drafting until canonical abstraction pass is complete.

### 9. `README.md`

**Smell**: mostly okay.

The README now includes `evidence promotion before action` in the purpose/architecture. That is abstract enough.

**Risk**: directory-map language says canonical files must be merged with Slice 12; good.

**Action**: add the smell-audit doc to the directory map after this pass.

### 10. Raw `external-reference/` prompt dumps

**Smell**: not audited for rewrite.

These are specimens, not HSM-authored rules. They may be list-heavy, policy-heavy, or product-specific. That is acceptable as long as HSM synthesis does not blindly import them.

**Action**: no rewrite. Only audit HSM-authored interpretation of external references.

---

## Corpus-Level Diagnosis

The project is not broken. It has a predictable research-corpus failure:

```text
research accumulates concrete examples
  -> examples get copied into candidate structures
  -> candidate structures approach prompt text
  -> prompt risks becoming example-overfit
```

This is exactly what Slice 12 revealed.

The fix is not to delete examples. The fix is to introduce a required **abstraction pass** before candidate prompt drafting.

---

## Required Abstraction Pass Before `hsm-build-v1.md`

Before drafting any v1 prompt, run this pass across canonical files:

1. Identify every rule that contains a noun list.
2. Ask: what single invariant does this list express?
3. Rewrite the rule as the invariant first.
4. Keep examples only if they are marked non-exhaustive.
5. Move test-specific examples into fixtures/eval docs.
6. Classify each structure as static prompt, runtime, task packet, fixture, docs/process, or CLI/TUI.
7. Re-check token budget after abstraction.

Pass condition:

```text
A future worker prompt should still behave correctly when the concrete object is not in the examples.
```

Failure condition:

```text
The worker prompt only protects APIs, paths, configs, models, or other listed nouns, but not the unseen equivalent.
```

---

## Priority Fix Queue

### P0 — Must fix before v1

1. Canonically merge Slice 12 using abstract action-critical-claim wording.
2. Update stale Slice 12 sidecars so old noun-list wording cannot be copied back.
3. Rewrite C28 orientation as principle-first.
4. Rewrite C30 established-way as project-surface-first.
5. Rewrite compaction atom preservation as semantic-exactness-first.
6. Add checklist warning that fixture nouns are not prompt wording.

### P1 — Should fix during v1 compression

1. Review final synthesis for principle/list ordering.
2. Ensure final prompt contains one compact Slice 12 rule, not EF12 example nouns.
3. Ensure EF11/EF12 tests measure invariants, not exact wording.
4. Add a drafting rule: examples may not be copied into baseline prompt unless the invariant survives without them.

### P2 — Later / process

1. Build a simple grep/audit script for noun-list smells.
2. Add a prompt-lint fixture that checks for category-list-as-rule wording.
3. Mark external-reference files as specimen-only in search/navigation docs.

---

## Proposed Prompt-Lint Rule

```text
If a candidate prompt rule contains a list of concrete nouns, it must also contain the abstract invariant that covers unseen cases.

Reject:
  Before acting on APIs, paths, model IDs, configs, hardware...

Accept:
  Before action, identify the action-critical claim about current reality. A clue is not proof. Promote it with the cheapest safe check, or keep it assumed and reduce blast radius.
```

---

## Current Decision

Do not draft `hsm-build-v1.md` yet.

The next correct project action is:

```text
canonical abstraction pass
  -> update candidate structures / failure catalog / eval checklist / final synthesis
  -> then run EF11 + EF12 A/B
  -> then draft v1
```
