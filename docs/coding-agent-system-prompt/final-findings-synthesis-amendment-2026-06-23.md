# Final Findings Synthesis Amendment: Closed-Loop Execution

Status: authoritative amendment to `final-findings-synthesis.md` for Slice 13 findings  
Date: 2026-06-23  
Scope: research synthesis only; candidate prompt drafting remains downstream  
Sources: `slice-13-closed-loop-execution.md`; `candidate-structures-slice-13-extension.md`; `research-failure-mode-catalog-slice-13-extension.md`; `prompt-evaluation-checklist-slice-13-extension.md`

---

## 0. Amendment Boundary

This document updates the parts of `final-findings-synthesis.md` affected by the discovery that pre-action evidence gating does not complete the worker execution loop.

The existing synthesis remains authoritative where this amendment does not supersede it.

The affected claims are:

- the central synthesis claim;
- the coding-agent worker loop;
- the layered prompt stack;
- feedback integration and failure recovery;
- validation placement;
- runtime/harness responsibility;
- the failure-mode map;
- prompt compression and drafting implications.

Evaluation fixture design is intentionally skipped in this update. The findings are sufficiently supported to revise the research synthesis without first expanding the fixture suite.

---

## 1. Corrected Central Synthesis Claim

The prior synthesis correctly established:

```text
prompt design is not a pile of clever sentences
it is a layered operating system around a worker model
```

Slices 11 and 12 then established:

```text
orient before narrowing
clues are not facts
verify the current-state claim before action
```

Slice 13 adds the missing continuation:

```text
action attempts to change state
  -> observe the actual result
  -> verify the state later action depends on
  -> only then continue dependent mutation
```

The corrected central claim is therefore:

```text
a reliable coding-agent scaffold must control
both entry into action and propagation out of action
```

Pre-action evidence controls whether a state transition may be attempted.

Post-action verification controls whether the expected result may become trusted current state.

Recovery control determines what happens when observed reality differs from the operating model.

---

## 2. Semantic Coverage Is Not Behavioural Control

The triggering failure occurred under a worker prompt that already contained the relevant high-level ideas:

- suspicions and plausible patterns are clues, not facts;
- identify the action-critical claim;
- run the cheapest safe check;
- convert repeated correction into the next operating rule;
- obtain confirmation for broad or risky action.

The worker later identified and explained the rules it had violated.

This establishes a new research distinction:

```text
semantic coverage:
  the rule exists and can be understood or repeated

behavioural control:
  the rule reliably changes the action taken at the point where it matters
```

A prompt should not be judged complete merely because every desired principle appears somewhere in its prose.

The synthesis and later prompt-engineering pass must ask:

```text
What transition does this rule control?
At what action boundary does it become active?
What observable behaviour shows that it took effect?
```

This does not mean every rule needs formal machinery. It means prompt architecture must preserve control flow, not only conceptual coverage.

---

## 3. Corrected Coding-Agent Worker Loop

The previous canonical worker loop was:

```text
read scoped rules
  -> orient by blast radius
  -> identify assumptions and action-critical claims
  -> inspect evidence surfaces
  -> promote clues with cheapest safe proof/falsifier
  -> choose smallest correct slice
  -> edit or stop at real action boundary
  -> validate
  -> report
```

This remains correct for selecting and authorizing the first action, but it is open-loop once mutation begins.

The corrected worker loop is:

```text
read scoped rules
  -> orient by blast radius
  -> identify assumptions and action-critical claims
  -> inspect evidence surfaces
  -> verify the relevant precondition
  -> choose the smallest correct bounded transition
  -> act once
  -> observe the actual result
  -> verify the relevant postcondition
  -> commit the new state or invalidate the affected state model
  -> continue dependent action or enter recovery
  -> validate the completed task
  -> report observed / inferred / assumed / unchecked state honestly
```

Compressed conceptual form:

```text
ORIENT
  -> PREFLIGHT
  -> ACT
  -> VERIFY RESULT
  -> CONTINUE OR RECOVER
  -> VALIDATE
  -> REPORT
```

The new loop must remain blast-radius and dependency scaled.

It does not require a ceremonial post-check for every harmless deterministic command. It requires that later action not depend on a result that has not been established strongly enough for that later action's risk.

---

## 4. Trusted-State Commitment

Slice 12 introduced the action-critical current-state claim:

```text
What must already be true for this action to be correct?
```

Slice 13 adds the state-transition claim:

```text
What should become true if this action succeeds?
What later action will rely on that result?
```

An attempted action may produce:

- the expected state;
- a contradictory state;
- an ambiguous state;
- partial state;
- no meaningful state change;
- output that looks successful without proving the needed condition.

Therefore:

```text
tool or command returned
  !=
required postcondition established
```

The result may become trusted state when the command result directly proves the needed state or when a relevant observation verifies it.

If the result is inferred, assumed, unknown, or contradicted, the dependent action must be reduced, deferred, or paused by blast radius.

This is the post-action counterpart to the Slice 12 evidence-promotion gate.

---

## 5. Dependent Action, Not Universal Serialization

The worker should not serialize all activity.

The control applies where a dependency exists:

```text
action B requires the expected result of action A
  -> verify A's relevant postcondition before B
```

Independent reads, searches, observations, and safe actions may remain parallel where the harness allows it.

This preserves the existing tool-efficiency finding while preventing cross-step state drift.

The synthesis therefore rejects both extremes:

```text
open-loop autonomy:
  assume every action worked and continue

ritual control:
  repeatedly prove every trivial operation regardless of dependency
```

The target is dependency-aware closed-loop execution.

---

## 6. Corrected Failure And Recovery Loop

The prior synthesis treated failures mainly as evidence to inspect rather than reasons to abandon the task.

That remains correct but incomplete.

A failure or unexpected result changes the reliability of the operating state model. The worker must not immediately mutate again when later action depends on the now-uncertain state.

Corrected recovery loop:

```text
unexpected or ambiguous result
  -> preserve materially useful evidence
  -> mark affected state unknown or invalidated
  -> stop dependent mutation
  -> continue focused read-only diagnosis
  -> establish actual current state
  -> choose the smallest grounded recovery step
  -> verify recovered state before resuming
```

This balances three failure modes:

```text
FM10:
  abandon useful diagnosis too early

FM13:
  continue dependent mutation too early

FM14:
  destroy the evidence needed to diagnose or recover
```

Read-only re-grounding is not task abandonment. It is the safe continuation mode when mutation is temporarily unjustified.

---

## 7. Corrected Feedback Integration

The previous synthesis said:

```text
user correction
  -> convert correction into next operating rule
  -> apply before next action
```

This remains useful but was too abstract.

The revised synthesis is:

```text
user or runtime correction
  -> identify what part of the operating model changes
  -> apply the correction before the next relevant action
  -> if existing state assumptions are invalidated,
     stop dependent mutation and re-ground first
```

The success criterion is observable next-action change.

These are not evidence of successful integration:

- apology;
- agreement;
- repeating the correction;
- promising greater care;
- unrelated inspection;
- retrying the same mutation with slightly different syntax.

Correction becomes control only when it changes the trajectory.

---

## 8. Diagnostic Evidence As A Protected Runtime Surface

The existing synthesis protects:

- user work;
- exact task-critical spans;
- scoped project rules;
- validation truth.

Slice 13 adds a distinct protected surface:

```text
execution evidence with current diagnostic value
```

This may include logs, failure output, process state, temporary artifacts, partial results, generated configuration, run metadata, or comparable evidence.

The examples are anchors, not the rule boundary.

The invariant is:

```text
loss would materially block diagnosis, validation, rollback, or recovery
  -> preserve the minimum needed evidence until that need is resolved
```

This is not a keep-everything rule.

Preservation remains bounded by:

- privacy and secret handling;
- authorization;
- explicit cleanup instructions;
- storage and resource costs;
- retention policy;
- reproducibility and remaining diagnostic value.

Semantic-span preservation and execution-evidence preservation are related but distinct:

```text
FM6:
  information is corrupted in context or reporting

FM14:
  evidence is destroyed in the execution environment
```

---

## 9. Corrected Layered Prompt Stack

The durable worker scaffold should now be ordered roughly as:

```text
executor identity
  -> active investigator stance
  -> authority and trusted-input boundary
  -> orientation / territory mapping
  -> blast-radius-scaled exploration
  -> tool and capability probing
  -> assumption check and source audit
  -> precondition / evidence-promotion gate
  -> bounded state transition
  -> postcondition / dependent-action gate
  -> recovery and diagnostic-evidence preservation
  -> scoped edit and action boundaries
  -> final validation and baseline discipline
  -> safety / escalation / irreversible-action gates
  -> final answer with surface-signal and confidence-source classification
  -> optional style/compression layer
```

This is an architectural order, not a demand for thirteen visible prompt sections.

During prompt drafting, related structures should be semantically compressed:

```text
precondition + action + postcondition

correction + state invalidation + re-grounding

failure handling + evidence preservation
```

The temporal sequence must survive compression.

---

## 10. Validation Placement

The earlier synthesis treated validation mainly as the final proof layer after implementation.

Slice 13 distinguishes:

### Local transition verification

Occurs between dependent actions:

```text
action A attempted
  -> did the relevant state actually change?
  -> may dependent action B proceed?
```

### Final task validation

Occurs after the completed implementation or workflow:

```text
did the requested behaviour work?
what checks ran?
what remains uncertain?
```

Both are necessary where applicable.

A successful final result does not retroactively justify an unsafe or unsupported trajectory.

A failed final result does not imply that every earlier action was unjustified.

When diagnosing a failed trajectory, the useful question is:

```text
Where did the first unsupported state commitment occur?
```

---

## 11. Prompt And Runtime Responsibility

Rule Zero becomes more important, not less.

Formal guarantees for postconditions, state commitment, evidence lineage, rollback, and transaction boundaries belong primarily in runtime or harness mechanisms when available.

The static prompt should carry the compact operating invariant:

```text
verify the relevant precondition
  -> act once
  -> verify the relevant postcondition before dependent action
  -> preserve needed evidence and re-ground if reality differs
```

The runtime may strengthen this with:

- reliable state observations;
- process or run identity;
- retained logs and artifacts;
- explicit cleanup boundaries;
- mutation/read-only mode state;
- dependency-aware gates;
- rollback or compensating-action support;
- provenance linking outputs to actions.

The prompt must not claim guarantees the runtime cannot enforce.

The research therefore rejects the idea that every reliability failure should be solved with more static prose.

---

## 12. Corrected Failure-Mode Map

The new staged map is:

```text
ORIENTATION / UNDERSTANDING

FM3:
  does not really inspect

FM11:
  inspects, but narrows too early
```

```text
PRE-ACTION EVIDENCE

FM7:
  unchecked assumption propagates through reasoning

FM12:
  unverified current-state claim authorizes action
```

```text
POST-ACTION STATE

FM13:
  unverified action result becomes trusted state
  and authorizes dependent action
```

```text
FAILURE / RECOVERY

FM10:
  abandons useful diagnosis too early

FM13:
  continues dependent mutation too early

FM14:
  destroys evidence needed to diagnose or recover
```

```text
PRESERVATION

FM2:
  preserve user work

FM6:
  preserve exact task-critical semantic information

FM14:
  preserve execution evidence with current diagnostic value
```

### FM13: Open-Loop Execution / Unverified State Chaining

```text
action A should produce state S1
  -> S1 is not verified
  -> action B depends on S1
  -> B proceeds as though S1 were trusted
```

### FM14: Diagnostic-Evidence Destruction / Premature Cleanup

```text
failure produces evidence E
  -> E is needed for diagnosis or recovery
  -> cleanup, overwrite, or retry destroys E prematurely
```

FM14 is separate from FM13 because either can occur without the other and each requires a distinct control decision.

---

## 13. Revised Build Thesis

The earlier build thesis was:

```text
orient before narrowing
verify before acting
preserve user work
validate honestly
surface relevant signal without scope creep
label confidence sources
```

The revised thesis is:

```text
orient before narrowing
verify the state that permits action
act in a bounded step
verify the state produced before dependent action
if reality differs, preserve needed evidence and re-ground
preserve user work and authority boundaries
validate the final result honestly
surface relevant signal without scope creep
label confidence sources instead of smoothing uncertainty
```

This is the balanced output of Slices 11-13.

No one correction should dominate the prompt:

- orientation prevents shallow certainty;
- precondition verification prevents assumption-led entry into action;
- postcondition verification prevents open-loop state propagation;
- recovery prevents blind mutation and premature abandonment;
- evidence preservation keeps diagnosis possible;
- scope control prevents investigation from becoming unrelated action;
- safety preserves permission and destructive-action boundaries;
- validation and reporting prevent success-shaped fiction.

---

## 14. Prompt Compression Implication

The new findings should not be appended as an `Action Lock` sermon or a long state-machine checklist.

Likely compressed worker cluster:

```text
For non-trivial state-changing work, verify the current-state claim the action depends on, perform one bounded transition, and verify the relevant result before dependent action. If reality differs or correction invalidates the state model, preserve needed evidence and re-ground read-only before continuing.
```

This cluster should be integrated across:

- investigation and preflight;
- runtime action handling;
- failure/recovery;
- validation;
- final confidence reporting.

Compression must preserve temporal operators:

```text
before action
after action
before dependent action
when reality differs
before resuming
```

A shorter sentence that loses these transitions is not semantically equivalent.

---

## 15. OpenCode Implication

The existing OpenCode resynthesis remains broadly correct, but Slice 13 changes the interpretation of several strengths and gaps.

### Bounded persistence

OpenCode's strong completion bias is useful only when paired with state-grounded continuation.

Corrected interpretation:

```text
persistence through failure
  !=
continue mutating through uncertain state
```

The worker should persist by diagnosing and re-grounding, not by chaining attempts against assumed runtime state.

### Runtime and TUI value

OpenCode's visible mode state, todo state, diff rendering, rollback affordances, and runtime environment injection become more important under Slice 13 because closed-loop execution depends on state visibility and recoverability.

These are harness contributions, not text to paste into the baseline prompt.

### Remaining gap

The prior OpenCode comparison did not establish that the runtime provides:

- explicit postcondition checks;
- reliable process/run identity;
- retained diagnostic evidence;
- dependency-aware action gates;
- state invalidation and read-only recovery mode.

These remain runtime questions rather than assumed OpenCode capabilities.

---

## 16. Research Backing Boundary

Slice 13 adds support from current agent-systems research for the architecture:

- ToolGate supports distinct precondition and postcondition gates over trusted state.
- ToolSandbox supports stateful trajectories and intermediate milestones.
- Cordon supports the finding that individually plausible tool calls can compose into cross-step violations.
- AgentProcessBench supports evaluating intermediate action quality and error propagation separately from final outcomes.
- SWE-agent continues to support the importance of environment/interface design.
- execution-provenance research supports treating evidence lineage and recoverability as first-class concerns.

Boundary:

These sources support the control architecture and placement decisions.

They do not prove exact prompt wording, guarantee model compliance, or imply that a static prompt can reproduce formal runtime contracts.

---

## 17. Superseded Statements In The Prior Synthesis

Read these prior statements as amended:

### Prior

```text
orient before narrowing
verify before acting
```

### Amended

```text
orient before narrowing
verify before acting
verify the result before dependent action
recover from observed state when reality differs
```

### Prior worker sequence

```text
promote clues
  -> choose slice
  -> edit
  -> validate
```

### Amended worker sequence

```text
verify precondition
  -> bounded transition
  -> verify postcondition
  -> continue or recover
  -> final validation
```

### Prior feedback integration

```text
correction becomes next operating rule
```

### Amended feedback integration

```text
correction changes the next observable action
and triggers re-grounding when current state assumptions are invalidated
```

### Prior repeated-failure trigger

```text
after two wrong-assumption failures, pause mutation
```

### Amended trigger

```text
when an unexpected result invalidates dependency-relevant state,
pause dependent mutation immediately and re-ground
```

The fixed count of two is no longer the preferred abstraction.

---

## 18. Current Research Position

The research chain now stands at:

```text
Slice 13 research finding                    COMPLETE
Slice 13 candidate-structure analysis       COMPLETE
Slice 13 failure-taxonomy analysis          COMPLETE
Slice 13 checklist implications             COMPLETE
EF13 fixture expansion                       SKIPPED BY USER DIRECTION
Slice 13 final synthesis amendment          COMPLETE
canonical status/index propagation           NEXT
candidate prompt engineering                 AFTER STATUS PROPAGATION
```

The research is sufficiently coherent to proceed without a dedicated EF13 fixture-design slice.

This does not mean behavioural evaluation is unimportant. It means fixture expansion is not required before the research findings are propagated into synthesis and used for the next prompt-engineering attempt.

---

## 19. Final Corrected Claim

```text
A coding agent must not only verify the reality that justifies an action.
It must verify the reality produced by that action before later action depends on it.
If the operating model breaks, it should preserve the evidence needed to recover,
stop dependent mutation, and re-ground from observation rather than assumption.
```

This closes the missing back half of the evidence-gated worker loop without replacing the rest of the HSM architecture.
