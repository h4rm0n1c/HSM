# Candidate Prompt Structures — Slice 12 Extension

Status: research-layer extension pending canonical merge  
Date: 2026-06-17  
Sources: `slice-12-evidence-gated-action.md`; `project-smell-audit-2026-06-17.md`; `i1a-arxiv-backing-orientation-evidence-gating.md`  
Use: merge into `candidate-structures.md` during I2 before drafting `hsm-build-v1.md`

---

## Integration Boundary

This file is not the canonical candidate-structure file yet.

It provides the Slice 12 structures that I2 must merge into `candidate-structures.md` after the research layer is coherent.

Concrete examples in this file are non-exhaustive anchors or fixtures. They are not the rule boundary and should not be pasted into compact baseline prompt wording.

---

## Slice 12 Thesis

Slice 11 says the worker must be safely curious before narrowing.

Slice 12 adds the missing final gate:

```text
curiosity produces clues
clues are not facts
facts require evidence before action
```

The abstraction is not `API/path/model/config/hardware/etc.`. Those are examples. The abstraction is:

```text
action depends on a claim about current reality
  -> identify that action-critical claim
  -> prove or falsify it with the cheapest safe check
  -> only then act at full blast radius
```

If the check cannot be run safely, the claim remains assumed and action must be reduced, deferred, or stopped according to blast radius.

---

## Research Backing

I1A gives these structures external support:

- ReAct: action should be grounded in observations, not internal reasoning alone.
- Chain-of-Verification: verification checks should be generated from the claim being checked.
- Self-RAG: inspection/retrieval is useful only when it establishes relevance, support, or completeness for the claim.
- Reflexion: feedback can improve later agent behaviour, but HSM requires observable next-action change.
- STORM: complex grounded work benefits from bounded pre-action orientation before output/action.
- SWE-agent: coding-agent success depends on interface/runtime affordances, not static prompt text alone.
- CheckList: fixtures should test behavioural invariants rather than become exhaustive example lists.

Boundary: these papers support the structure and placement decisions. They do not prove exact v1 wording.

---

## New Candidate Structures

### C36: Action-critical claim gate (adopt)

```text
Before action, identify the action-critical world-state claim: the claim about current reality that must be true for the action to be correct. Do not promote that claim from clue to fact until it has been verified by the cheapest safe evidence source the action depends on.
```

**Source**: Slice 12 v0 failure analysis; I1A ReAct / CoVe / Self-RAG backing  
**Token cost**: ~45 before compression  
**Test**: EF12 fixtures.

### C37: Clue-is-not-proof rule (adopt)

```text
Treat conventions, names, nearby source, memory, user suspicion, previous state, and plausible patterns as clues. A clue can guide investigation; it cannot justify action until the action-critical claim is checked.
```

**Source**: Slice 12; I1A verification/retrieval/critique backing  
**Token cost**: ~40, merge with C36  
**Test**: EF12.1 inferred API endpoint trap; EF12.6 confident wrong report trap.

### C38: Cheapest falsifier preflight (adopt)

```text
Before a costly, risky, or failure-prone action, run the cheapest safe check that would prove or falsify the action-critical claim. The check must target the claim the action depends on, not random reassurance.
```

**Source**: Slice 12; CoVe claim-specific verification; Self-RAG relevance/support critique  
**Token cost**: ~35  
**Test**: EF12.2 stale model ID trap; EF12.3 hardware preflight trap; EF12.4 config-before-edit trap.

### C39: Feedback integration checkpoint (test)

```text
When the user or environment identifies a repeated behaviour failure, convert the correction into the operating rule for the next action, then apply that rule before taking the next tool/action step.
```

**Source**: Slice 12; Reflexion feedback-integration backing  
**Token cost**: ~35 if included; can be process-level to avoid user-facing ritual  
**Test**: EF12.5 repeated-correction trap.

### C40: Action precondition line (adopt lightly)

```text
For non-trivial actions, know the action-critical claim you are relying on and how it was checked. If it was not checked, mark it as assumed and reduce, defer, or stop action by blast radius.
```

**Source**: Slice 12  
**Token cost**: ~30, merge into C29/C6  
**Test**: EF12 fixtures.

### C41: Assumption budget escalation (process / harness)

```text
If two consecutive actions fail because unverified action-critical claims were false, pause mutation and switch to read-only diagnosis until the relevant claims are re-grounded.
```

**Source**: Slice 12; Reflexion/SWE-agent placement support  
**Decision**: better as runtime/process rule than baseline static prose.  
**Test**: multi-step failed setup fixture.

### C42: Confidence source labelling (adopt in final report)

```text
Separate observed, inferred, assumed, and unchecked claims when reporting uncertain technical work. Never phrase inferred or unchecked claims as confirmed facts.
```

**Source**: Slice 12 + Slice 2 anti-agreement lineage; CoVe verification framing  
**Token cost**: ~35, merge with C11  
**Test**: EF12.6 confident wrong report trap.

---

## Compression Merge Targets

Do not append C36-C42 as a standalone sermon.

Merge them into existing structures:

| Existing structure | Slice 12 merge |
|---|---|
| C29 assumption ledger | C36 action-critical claim gate + C40 action precondition line |
| C3/C8 evidence-before-edit | C37 clue-is-not-proof distinction |
| C28 orientation pass | C38 cheapest falsifier preflight after orientation finds likely clues |
| C6 adversarial check | C40 checked preconditions |
| C11 final report | C42 observed/inferred/assumed/unchecked labelling |
| runtime/process rules | C41 repeated wrong-assumption pause |

Likely compressed prompt wording:

```text
Before action, identify the action-critical claim about current reality. A clue is not proof. Promote the claim with the cheapest safe check that can prove or falsify it. If unchecked, mark it as assumed and reduce, defer, or stop action by blast radius.
```

---

## Recommendation Summary Row Additions

| # | Rule | Cost | Priority |
|---|---|---:|---|
| C36 | Action-critical claim gate | ~45, compress with C29 | critical |
| C37 | Clue-is-not-proof | ~40, compress with C36/C3 | high |
| C38 | Cheapest falsifier preflight | ~35 | critical |
| C39 | Feedback integration checkpoint | ~35 or process | test |
| C40 | Action precondition line | ~30, merge with C6 | high |
| C41 | Wrong-assumption pause | process/runtime | medium |
| C42 | Confidence source labelling | ~35, merge with C11 | high |

---

## Updated Token Budget Note

Slice 12 should add one compact evidence-promotion sentence to the worker prompt, not hundreds of tokens.

Do not compress away:

```text
orientation before narrowing
action-critical claim gate
clue-is-not-proof rule
assumption check
trusted-input boundary
existing-change preservation
git/destructive-action safety
validation honesty
surface-signal classification
```

---

## I2 Merge Notes

When merging into `candidate-structures.md`:

1. Update status/source through Slice 12 and I1A.
2. Keep C36-C42 as structures, but merge their prompt text into existing sections rather than appending a new sermon.
3. Rewrite C28 orientation principle-first:

```text
map the project surfaces that determine authority, ownership, execution, validation, and existing convention
```

4. Rewrite C30 established-way discovery principle-first:

```text
before introducing a new project surface, look for the established project way
```

5. Rewrite atom-preservation wording principle-first:

```text
preserve exact spans whose corruption would change task semantics, reproducibility, authority, or user intent
```

6. Preserve concrete examples only as non-exhaustive anchors or fixture references.
7. Do not draft `hsm-build-v1.md` during I2.
