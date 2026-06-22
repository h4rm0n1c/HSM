# Candidate Prompt Structures — Slice 13 Extension

Status: candidate-structure layer derived from `slice-13-closed-loop-execution.md`  
Date: 2026-06-23  
Scope: C43-C47 disposition, C39/C41 correction, placement, compression, and interaction analysis  
Canonical merge: pending; this file is the reviewed Slice 13 candidate layer, not final prompt wording

---

## Purpose

Slice 13 found a gap after the Slice 12 action-critical claim gate:

```text
Slice 12:
  verify the state that justifies an action

Slice 13:
  verify the state produced by an action
  before dependent action relies on it
```

The research slice proposed C43-C47. This candidate layer decides which distinctions deserve independent structures, which should merge into existing structures, and which belong mainly in runtime or evaluation rather than static prompt text.

The goal is not to append five new rules. The goal is to extend the existing worker scaffold with the smallest durable closed-loop execution structure.

---

## Candidate-Layer Decision

The five research proposals reduce to three prompt-relevant behaviours and one runtime state concept:

```text
1. closed-loop transition and dependent-action gate
2. state-model invalidation and re-grounding
3. diagnostic-evidence preservation
4. action-result confidence state, preferably runtime-supported
```

C43 and C44 describe one control sequence and should be merged during prompt drafting.

C45 should not stand alone from C39/C41. Feedback integration, state invalidation, and re-grounding are one recovery family.

C47 is useful conceptually, but a full action-state taxonomy in static prose would duplicate C42 and create prompt sludge. Keep the distinction in runtime/process/evaluation and express only the operational consequence in the worker prompt.

---

## Layer 5 Extension: Investigation, Evidence Promotion, And Execution Control

### C43: Closed-loop state transition (adopt — critical)

```text
For a state-changing action, verify the relevant precondition, perform one bounded transition, observe the result, and verify the relevant postcondition before treating the new state as current.
```

**Source**: Slice 13; ToolGate precondition/postcondition distinction; ToolSandbox stateful trajectory evidence  
**Token cost**: ~35 before merging with C36/C40  
**Placement**: static worker invariant plus runtime observation support  
**Test**: EF13 trajectory fixtures

**Why this survives**:

C36-C40 govern the claim that permits action. C43 governs the result that permits later dependent action. Removing either side leaves the execution loop open.

**Boundary**:

The command result itself may satisfy the postcondition when it directly and reliably proves the needed state. C43 does not require a ritual second command after every operation.

### C44: Dependent-action lock (merge into C43)

```text
If the next mutation depends on the expected result of an earlier action, do not proceed until that result is observed strongly enough for the next action's blast radius.
```

**Source**: Slice 13; ToolSandbox and Cordon cross-step evidence  
**Token cost**: ~25 alone; near-zero when merged into C43  
**Placement**: static prompt, optional runtime dependency gate, trajectory evaluation  
**Test**: unverified termination, duplicate workload, and unexpected-postcondition fixtures

**Decision**:

The dependency relation is essential, but C44 should not become a separate baseline paragraph. It is the temporal consequence of C43:

```text
postcondition not verified
  -> dependent action remains locked
```

This wording also preserves parallelism. Independent observations or actions may still be batched where safe.

### C40 revision target: precondition-to-transition bridge

Current C40 is pre-action only. During canonical merge it should become the compact bridge between C36-C38 and C43:

```text
For non-trivial state-changing action, know the claim that permits it and the result later action will depend on. Verify the precondition before action and the relevant postcondition before dependent action.
```

**Decision**: merge C40, C43, and C44 during prompt drafting rather than preserving all three as repeated prose.

---

## Recovery-Family Revision

### C39: Feedback integration checkpoint (revise and adopt)

Current C39:

```text
When the user or environment identifies a repeated behaviour failure, convert the correction into the operating rule for the next action, then apply that rule before taking the next tool/action step.
```

Revised candidate:

```text
When user or runtime correction changes the operating model, apply it before the next action. If it invalidates current state assumptions, stop dependent mutation and re-ground before continuing.
```

**Source**: Slice 12 C39; Slice 13 observed correction failure  
**Token cost**: ~35 before merging with C45  
**Placement**: static worker prompt plus runtime control state where available  
**Test**: EF12.5 and EF13 correction-to-recovery fixtures

**Why revise**:

`Make it the next rule` can remain verbal. The revised form names the observable control transition required when the correction invalidates current state.

**Boundary**:

Not every correction requires a full recovery cycle. Re-ground only when the correction affects claims that later action depends on.

### C41: State-model invalidation pause (revise; process/runtime with compact prompt support)

Current C41 uses a fixed trigger:

```text
If two consecutive actions fail because unverified action-critical claims were false, pause mutation and switch to read-only diagnosis.
```

Revised candidate:

```text
When an unexpected result makes the relevant state model unreliable, pause dependent mutation and switch to read-only diagnosis until that state is re-established.
```

**Source**: Slice 12 C41; Slice 13 state-model analysis  
**Placement**: primarily runtime/process; compact recovery wording in static prompt  
**Test**: unexpected-postcondition and failed-recovery trajectories

**Why revise**:

The fixed count of two is arbitrary. One failed transition can invalidate every later action that depends on its expected result. Conversely, two unrelated low-blast failures need not trigger a global stop.

The correct trigger is dependency-relevant state invalidation.

### C45: State-model invalidation and re-grounding (merge into revised C39/C41)

Research wording:

```text
When observed reality contradicts the operating model, stop dependent mutation, invalidate affected assumptions, and return to read-only observation until current state is re-established.
```

**Decision**: adopt the behaviour, but do not retain C45 as an additional standalone prompt rule after C39/C41 are revised.

The canonical structure family should read as:

```text
correction or unexpected result
  -> does it invalidate dependency-relevant state?
      no  -> apply correction and continue safely
      yes -> stop dependent mutation
             preserve needed evidence
             re-ground read-only
             resume from verified state
```

---

## Diagnostic-Evidence Preservation

### C46: Diagnostic-evidence preservation (adopt with constraints)

```text
During diagnosis, preserve evidence whose loss would prevent failure reconstruction, validation, rollback, or recovery. Do not automatically destroy it before the failure is understood or explicit cleanup is requested.
```

**Source**: Slice 13 incident evidence; execution-provenance research  
**Token cost**: ~25-35 after compression  
**Placement**: static worker prompt, runtime log/artifact retention support, evaluation fixture  
**Test**: diagnostic-evidence destruction trap

**Why this survives independently**:

Postcondition checking does not prevent the agent from destroying the only evidence that would explain why the postcondition failed. C46 protects the recovery path itself.

**Constraints**:

Evidence preservation is bounded by:

- privacy and secret handling;
- explicit cleanup instructions;
- storage/resource cost;
- existing retention policy;
- whether the evidence remains materially useful.

The invariant is not `keep everything`. It is:

```text
loss would materially block diagnosis or recovery
  -> preserve until that need is resolved
```

**Merge target**:

C46 should sit near failure handling/runtime mutation, not in the general high-value semantic-atom section. Semantic exactness preserves information in context; C46 preserves execution evidence in the environment.

---

## Runtime State Classification

### C47: Action-result confidence state (process/runtime; light prompt merge)

Research wording:

```text
Treat action results as observed, inferred, assumed, unknown, or invalidated when that distinction affects later action. Only sufficiently verified state should authorize dependent mutation.
```

**Decision**: do not add the full taxonomy as standalone static prompt prose.

**Placement**:

- runtime/process: structured state classification where the harness can support it;
- static prompt: only the operational rule that unverified/invalidated state must not authorize dependent mutation;
- final report: C42 continues to label observed, inferred, assumed, and unchecked claims;
- evaluation: score whether the agent treated ambiguous state as trusted.

**Reason**:

C47 differs from C42 in timing:

```text
C47:
  confidence source controls whether another action may occur

C42:
  confidence source controls how the final report describes a claim
```

The distinction matters, but duplicating the full labels in multiple prompt sections is unnecessary. Merge the action consequence into C43/C44 and retain C42 for reporting.

---

## Consolidated Candidate Recommendation

| Structure | Candidate decision | Static prompt role | Runtime/process role | Merge target |
|---|---|---|---|---|
| C43 closed-loop transition | adopt — critical | compact execution invariant | expose/check postconditions | C36/C40/C44 |
| C44 dependent-action lock | merge | temporal clause in C43 | optional dependency gate | C43 |
| C39 feedback integration | revise and adopt | correction changes next action | control-state update | C45 |
| C41 state invalidation pause | revise | compact recovery trigger | primary enforcement/state | C45 |
| C45 re-grounding | adopt behaviour, merge structure | recovery clause | mutation pause/re-ground | C39/C41 |
| C46 evidence preservation | adopt with constraints | concise recovery invariant | retention support | failure handling |
| C47 action-result confidence | process/runtime; light merge | consequence only | structured state preferred | C43/C42 |

The candidate layer therefore adds only two genuinely new baseline meanings:

```text
1. verify the produced state before dependent action
2. preserve needed failure evidence and re-ground when the state model breaks
```

Everything else is integration and placement.

---

## Updated Build Thesis

The Slice 13 extension changes the durable worker scaffold from:

```text
orientation
  -> evidence promotion before action
  -> scoped action
  -> validation
```

to:

```text
orientation
  -> evidence promotion / precondition verification
  -> one bounded state transition
  -> postcondition verification
  -> trusted-state update or recovery
  -> validation and report
```

This is not a replacement for the existing structure. It closes the loop between action and later action.

---

## Prompt Compression Plan

Do not append C43-C47 as five new sections.

Compression order:

1. Merge C43/C44 into C36-C40 as one precondition/action/postcondition sequence.
2. Merge C45 into revised C39/C41 as one invalidation/re-grounding family.
3. Keep C46 as one short evidence-preservation clause near failure handling.
4. Keep C47 primarily runtime/process and reuse C42 labels in reporting.
5. Preserve temporal words: `before action`, `after action`, `before dependent action`, `when reality differs`.

Likely compressed cluster:

```text
For state-changing work, verify the precondition, act once, and verify the relevant postcondition before dependent action. If reality differs or correction invalidates the state model, preserve needed evidence and re-ground read-only before continuing.
```

Approximate incremental static cost after merging: 35-55 tokens, not the naive sum of C43-C47.

The previous 1400-1650 token target may rise slightly, but this structure should first displace duplicated preflight, correction, and recovery wording before the target is changed.

---

## Interaction Analysis

### C43/C44 vs C36-C40

No duplication if their boundaries remain explicit:

```text
C36-C40:
  may this action proceed from current reality?

C43/C44:
  may later action proceed from the result?
```

Merge into one temporal sequence during prompt drafting.

### C43/C44 vs C4 validation honesty

C43 is local transition verification between dependent actions. C4 is broader validation of the completed implementation or task result.

A worker may need both:

```text
local postcondition:
  process actually stopped

final validation:
  replacement workflow works correctly
```

Do not let final testing substitute for intermediate state control.

### C44 vs M2 parallelism

Only dependency-linked actions are serialized. Independent reads, searches, and safe observations may remain parallel.

### C45/C41 vs FM10 task abandonment

Re-grounding is not giving up. It pauses only dependent mutation and continues focused read-only diagnosis until a safe next action is grounded.

### C46 vs security/privacy

Evidence preservation never overrides secret, privacy, authorization, or explicit retention boundaries. Preserve the minimum evidence needed, for only as long as needed.

### C46 vs FM8 context overload

Environment evidence need not be copied wholesale into model context. Preserve artifacts externally and inspect targeted portions.

### C39/C45 vs apology theatre

Pass requires an observable next-action change. Verbal acknowledgement remains insufficient.

### C47 vs C42

C47 controls action authorization; C42 controls reporting confidence. Reuse labels but do not collapse the two moments.

### Closed-loop execution vs over-engineering

Use dependency and blast radius as the trigger. Do not create formal transactions, exhaustive state ledgers, or repeated probes for trivial deterministic operations.

---

## Candidate-Layer Non-Regression Requirements

The merged structures must not weaken:

- trusted-input boundaries;
- preservation of user changes;
- destructive-action confirmation;
- scope control;
- validation honesty;
- task persistence after recoverable failure.

They must not introduce:

- confirmation requests for ordinary safe actions;
- serial execution of independent work;
- repeated proof of unchanged state without reason;
- unlimited log/artifact retention;
- a rigid state taxonomy in user-facing output;
- transaction machinery as the baseline mental model for every task.

---

## Canonical Merge Instructions

When this extension is merged into `candidate-structures.md`:

1. Update the status/source header through Slice 13.
2. Add closed-loop execution to the current build thesis after evidence promotion.
3. Add C43 and merged C44 after C40.
4. Replace C39 wording with the correction/state-invalidation version.
5. Replace C41's two-failure trigger with dependency-relevant state invalidation.
6. Add C46 near failure handling/runtime feedback, not semantic-atom compaction.
7. Record C47 under process/runtime structures and distinguish it from C42.
8. Update the recommendation summary, token-budget section, interaction conflicts, and implementation batch order.
9. Preserve candidate prompt drafting as gated.

Do not update the failure-mode catalogue, evaluation checklist, final synthesis, or prompt candidate in this layer.

---

## Layer Conclusion

**Decision**: Slice 13 produces a compact extension to the existing candidate architecture rather than a new execution-policy block.

**Critical candidate meaning**:

```text
Verify the state that permits action.
Then verify the state produced by action before dependent action.
If the model of state breaks, preserve needed evidence and re-ground before mutation continues.
```

**Confidence**: high for C43/C44 and the C39/C41 correction; medium-high for C46 as static wording; medium for C47 runtime state classification.

**Next layer**:

Update the failure-mode taxonomy using the candidate-layer distinctions. Decide whether diagnostic-evidence destruction is part of FM13 or a separate failure mode, and rebalance FM7/FM10/FM12/FM13 relationships before touching evaluation or synthesis.
