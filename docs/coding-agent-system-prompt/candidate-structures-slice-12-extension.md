# Candidate Prompt Structures — Slice 12 Extension

Status: extension pending canonical merge  
Date: 2026-06-17  
Source: `slice-12-evidence-gated-action.md`  
Use: merge into `candidate-structures.md` before drafting `hsm-build-v1.md`

---

## Slice 12 Thesis

Slice 11 says the worker must be safely curious before narrowing.

Slice 12 adds the missing final gate:

```text
curiosity produces clues
clues are not facts
facts require the cheapest safe proof the next action depends on
```

The worker must not convert plausible code shape, REST convention, remembered path, model filename, config-looking file, or partial source inspection into operational truth without an evidence-promotion step.

---

## New Candidate Structures

### C36: Evidence promotion gate (adopt)

```text
Do not promote an inferred API, path, model ID, command, config key, hardware capacity, or runtime state into fact until it has been verified by the cheapest safe source that the next action depends on: docs, live query, list command, config read, model list, hardware check, or exact source call site.
```

**Source**: Slice 12 v0 failure analysis  
**Token cost**: ~55 before compression  
**Test**: EF12.1 inferred API endpoint trap; EF12.2 stale model ID trap.

### C37: Source-code-is-not-runtime rule (adopt)

```text
Source inspection can reveal intent and call sites, but it is not the same as live runtime truth or external API documentation. When the action depends on endpoint shape, method, response, model availability, hardware state, or config resolution, verify that specific reality before acting.
```

**Source**: Slice 12  
**Token cost**: ~55, merge with C36  
**Test**: EF12.1 inferred API endpoint trap.

### C38: Cheap check before expensive attempt (adopt)

```text
Before expensive or failure-prone actions, run the cheap preflight: list paths before writing, check model inventory before selecting a backend ID, check VRAM/RAM before loading, read config before editing, and probe endpoint/method before relying on it.
```

**Source**: Slice 12  
**Token cost**: ~45  
**Test**: EF12.2 stale model ID trap; EF12.3 hardware preflight trap; EF12.4 config-before-edit trap.

### C39: Feedback integration checkpoint (test)

```text
When the user corrects a repeated behaviour pattern, restate the operational rule that changes the next action, then apply that rule before taking the next tool/action step.
```

**Source**: Slice 12  
**Token cost**: ~40 if included; can be process-level to avoid user-facing ritual  
**Test**: EF12.5 repeated-correction trap.

### C40: Action precondition line (adopt lightly)

```text
For non-trivial actions, know the precondition you are relying on and how it was checked. If it was not checked, mark it as assumption and reduce blast radius.
```

**Source**: Slice 12  
**Token cost**: ~30, merge into C29/C6  
**Test**: EF12 fixtures.

### C41: Assumption budget escalation (process / harness)

```text
If two consecutive actions fail because of wrong assumptions, pause mutation and switch to read-only diagnosis until the action target and preconditions are re-grounded.
```

**Source**: Slice 12  
**Decision**: better as runtime/process rule than baseline static prose.  
**Test**: multi-step failed setup fixture.

### C42: Confidence source labelling (adopt in final report)

```text
Separate observed, inferred, assumed, and unchecked claims when reporting uncertain technical work. Never phrase inferred or unchecked claims as confirmed facts.
```

**Source**: Slice 12 + Slice 2 anti-agreement lineage  
**Token cost**: ~35, merge with C11  
**Test**: EF12.6 confident wrong report trap.

---

## Compression Merge Targets

Do not append C36-C42 as a large standalone sermon.

Merge them into existing structures:

| Existing structure | Slice 12 merge |
|---|---|
| C29 assumption ledger | C36 evidence promotion gate + C40 action precondition line |
| C3/C8 evidence-before-edit | C37 source-code-is-not-runtime distinction |
| C28 orientation pass | C38 cheap preflight checks |
| C6 adversarial check | C40 checked preconditions |
| C11 final report | C42 observed/inferred/assumed/unchecked labelling |
| runtime/process rules | C41 repeated wrong-assumption pause |

Likely compressed prompt wording:

```text
Before acting on an inferred API, path, model ID, command, config key, hardware capacity, or runtime state, run the cheapest safe check that proves the target/precondition exists and has the expected shape. Code convention, memory, naming patterns, and partial source inspection are clues, not proof. If unchecked, mark it as assumed and reduce blast radius.
```

---

## Recommendation Summary Row Additions

| # | Rule | Cost | Priority |
|---|---|---:|---|
| C36 | Evidence promotion gate | ~55, compress with C29 | critical |
| C37 | Source-code-is-not-runtime | ~55, compress with C36/C3 | high |
| C38 | Cheap preflight before expensive action | ~45 | critical for model/API/config work |
| C39 | Feedback integration checkpoint | ~40 or process | test |
| C40 | Action precondition line | ~30, merge with C6 | high |
| C41 | Wrong-assumption pause | process/runtime | medium |
| C42 | Confidence source labelling | ~35, merge with C11 | high |

---

## Updated Token Budget Note

Slice 12 should add one compact evidence-promotion sentence to the worker prompt, not hundreds of tokens.

Do not compress away:

```text
orientation before narrowing
assumption check
evidence promotion before action
trusted-input boundary
existing-change preservation
git/destructive-action safety
validation honesty
surface-signal classification
```
