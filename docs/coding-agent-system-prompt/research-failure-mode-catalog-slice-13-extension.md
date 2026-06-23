# Failure Mode Catalog — Slice 13 Extension

Status: failure-taxonomy layer derived from `slice-13-closed-loop-execution.md` and `candidate-structures-slice-13-extension.md`  
Date: 2026-06-23  
Scope: FM13/F​​M14 definition, FM7/FM10/FM12 rebalance, mitigation mapping, and evaluation implications  
Canonical merge: pending; this file is taxonomy input, not final prompt wording

---

## Integration Boundary

This extension answers two questions raised by Slice 13:

1. Is unverified post-action state merely another case of FM12?
2. Is destruction of diagnostic evidence merely a symptom of the same failure, or a distinct failure class?

The answers are:

```text
FM12 and FM13 are distinct action-boundary failures.
FM14 is a distinct recovery/evidence failure that often amplifies FM13.
```

Concrete runtime examples remain fixtures. The taxonomy is defined by causal structure, not by containers, training jobs, logs, commands, or any other finite noun list.

---

## Taxonomy Decision

### FM13 is first-class

FM12 governs the claim that permits an action:

```text
current-state claim
  -> insufficiently verified
  -> action begins anyway
```

FM13 governs the result that permits a later dependent action:

```text
action attempts state transition
  -> expected result is assumed
  -> later action depends on it
  -> later action begins anyway
```

A worker can avoid FM12 for action A by verifying A's precondition, yet still commit FM13 by failing to verify A's postcondition before action B.

### FM14 is also first-class

Diagnostic-evidence destruction can occur without any dependent action:

```text
failure creates useful evidence
  -> cleanup/retry/ephemeral execution destroys it
  -> diagnosis or recovery becomes weaker or impossible
```

Its root cause and mitigation differ from FM13:

- FM13 is controlled by postcondition verification and dependent-action gating.
- FM14 is controlled by evidence-retention judgment during diagnosis.

FM14 frequently amplifies FM13 because loss of evidence makes re-grounding harder, but neither failure logically requires the other.

---

## FM13: Open-Loop Execution / Unverified State Chaining

**Failure pattern**: The agent performs a state-changing action, assumes the expected result became true, and executes a later action whose correctness depends on that unverified result.

**Observed symptom**: The worker launches a replacement before confirming termination, begins a second workload while the first may still be active, changes configuration based on an assumed transition, retries against stale state, or otherwise chains mutations across an unverified intermediate state.

These examples are non-exhaustive. The invariant is:

```text
action A should produce state S1
  -> S1 is not verified
  -> action B requires S1
  -> B proceeds as though S1 were trusted
```

**Root cause**: The operating scaffold has a pre-action evidence gate but no explicit post-action trusted-state gate. Invocation success, command output, expected behaviour, or previous experience is silently treated as proof that the relevant postcondition holds.

**Existing mitigation**: Partial only.

```text
FM7 assumption checking:
  can detect a weak belief before or after action,
  but does not define when action output becomes trusted state.

FM12 evidence promotion:
  verifies the state that permits action A,
  but not the result that permits action B.

Validation honesty:
  checks completed work,
  but may occur too late to prevent a bad intermediate transition.

C39/C41 recovery guidance:
  reacts to repeated correction or failure,
  but previously lacked a direct postcondition/dependency rule.
```

**How the prompt/process prevents it**:

```text
For state-changing work, verify the relevant precondition before action.
Perform one bounded transition.
Verify the relevant postcondition before any dependent action.
If the result is unknown, assumed, or contradicted, do not commit it as trusted state.
Reduce, defer, or pause the dependent action by blast radius.
```

**Runtime contribution**:

Where possible, the harness should expose reliable state observations, preserve current process/environment state, and gate high-blast dependent actions on verifiable postconditions. Static prompt wording provides guidance, not formal enforcement.

**Severity**: Critical for runtime/process control, deployments, migrations, hardware-sensitive work, package/environment changes, external side effects, and any multi-step workflow where one mutation changes the preconditions of the next. Medium for reversible low-blast work with directly observable results. Low for independent actions whose correctness does not depend on prior state transitions.

---

## FM14: Diagnostic-Evidence Destruction / Premature Cleanup

**Failure pattern**: During diagnosis or recovery, the agent destroys, discards, overwrites, or makes inaccessible evidence whose preservation is materially needed to reconstruct failure, verify state, reproduce behaviour, roll back safely, or choose the next action.

**Observed symptom**: Logs vanish before inspection, transient state is automatically deleted after failure, a retry overwrites the previous failure artifact, partial output is discarded before comparison, generated configuration is replaced before its effect is understood, or cleanup removes the only evidence of what actually occurred.

These examples are non-exhaustive. The invariant is:

```text
failure or unexpected result produces evidence E
  -> E is materially needed for diagnosis/recovery
  -> agent performs cleanup/retry/destruction before using or preserving E
  -> state reconstruction and recovery quality degrade
```

**Root cause**: The worker treats cleanup, ephemeral execution, fresh retry, or environment tidiness as harmless defaults. It lacks an explicit distinction between disposable residue and evidence that currently carries diagnostic value.

**Existing mitigation**: Partial and indirect.

```text
FM2 user-work preservation:
  protects user-created work,
  not necessarily runtime evidence or transient artifacts.

FM6 exact-span preservation:
  protects high-value information inside context/reporting,
  not evidence still present in the execution environment.

FM9 destructive-action confirmation:
  protects against unauthorized high-risk mutation,
  but ordinary cleanup may be authorized and still destroy essential evidence.

Validation honesty:
  can report that diagnosis is incomplete,
  but cannot recover evidence already destroyed.
```

**How the prompt/process prevents it**:

```text
During diagnosis, preserve evidence whose loss would materially block failure reconstruction, validation, rollback, or recovery.
Do not automatically destroy or overwrite it before the failure is understood or explicit cleanup is requested.
Retain only what is needed, only as long as needed, and continue obeying privacy, secret, authorization, storage, and retention constraints.
```

**Runtime contribution**:

The harness may support retained logs, stable artifact locations, explicit cleanup boundaries, run identifiers, snapshots, or recovery metadata. The prompt should not promise provenance guarantees the runtime does not provide.

**Severity**: High when the evidence is unique, expensive to reproduce, security-relevant, or necessary to recover a live environment. Medium when reproduction is cheap and safe. Low when the discarded material has no plausible diagnostic or recovery value.

---

## Rebalance of Existing Failure Modes

### FM7: Silent Assumption Cascade

FM7 remains the broad reasoning failure:

```text
unchecked assumption
  -> later reasoning inherits it
```

It should not absorb FM12 or FM13.

```text
FM7:
  assumption propagates through reasoning

FM12:
  unverified current-state claim authorizes action

FM13:
  unverified action result authorizes dependent action
```

**Suggested canonical clarification**:

Add one sentence to FM7's relationship note:

> FM7 describes propagation inside the reasoning model; FM12 and FM13 describe the specific boundaries where that propagation becomes action or trusted post-action state.

### FM10: Task Abandonment on Partial Failure

FM10 remains the failure to continue useful diagnosis after a recoverable problem.

FM13 is the opposite directional error:

```text
FM10:
  stops mutation and diagnosis too early

FM13:
  continues dependent mutation too early
```

The balancing rule is not `always continue` or `always stop`:

```text
unexpected result
  -> stop dependent mutation
  -> continue focused read-only diagnosis
  -> resume only from re-grounded state
```

**Suggested canonical clarification**:

FM10 mitigation should explicitly say that pausing mutation for re-grounding is not task abandonment. The agent should continue safe diagnosis and report a blocker only when no grounded next step remains.

### FM12: Assumption-to-Action Without Evidence Promotion

FM12 should remain pre-action and should not be broadened to cover postconditions.

**Suggested canonical clarification**:

Add the boundary:

```text
FM12 ends when the action is properly authorized by verified current state.
FM13 begins when the action's expected result is treated as current state without sufficient verification.
```

This preserves a clean diagnostic question:

```text
FM12:
  Was the claim that justified this action checked?

FM13:
  Was the result this later action depends on checked?
```

### FM9: Destructive Action Without Confirmation

FM9 and FM14 may share a destructive command but differ in causal failure:

```text
FM9:
  action lacked required authority/confirmation

FM14:
  action may have been authorized,
  but destroyed evidence still needed for diagnosis or recovery
```

An action can violate both, either one, or neither.

### FM6: Over-Paraphrasing High-Value Atoms

FM6 and FM14 both concern information loss, but at different surfaces:

```text
FM6:
  exact semantic information is corrupted in context or reporting

FM14:
  execution evidence is destroyed in the environment
```

They may share preservation language, but should retain separate mitigations and fixtures.

---

## Relationship Map

```text
ORIENTATION / UNDERSTANDING

FM3:
  did not really inspect

FM11:
  inspected, but narrowed too early
```

```text
PRE-ACTION EVIDENCE

FM7:
  assumption propagates through reasoning

FM12:
  unverified current-state claim crosses into action
```

```text
POST-ACTION STATE

FM13:
  unverified action result is committed as current state
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
  preserves user work

FM6:
  preserves exact task-critical semantic spans

FM14:
  preserves execution evidence with current diagnostic value
```

---

## Why FM14 Is Not Folded Into FM13

### Independent occurrence

FM14 can occur after a single failed action even when no second action is attempted.

### Different control point

FM13 asks:

```text
May the next dependent action proceed?
```

FM14 asks:

```text
May this evidence be destroyed yet?
```

### Different mitigation

FM13 requires postcondition verification and state commitment discipline.

FM14 requires evidence-value judgment and bounded retention.

### Different evaluation

A worker could correctly refuse dependent action while still deleting the logs needed to diagnose the first failure. Conversely, it could preserve logs while incorrectly launching a dependent workload.

### Interaction

FM14 often increases FM13 severity because evidence loss makes postcondition verification and re-grounding harder. Record this as an interaction, not a taxonomy collapse.

---

## Candidate-Structure Mapping

| Failure mode | Primary candidate structures | Secondary/runtime support |
|---|---|---|
| FM7 | C6, C29, C36-C38, C42 | assumption/confidence state |
| FM10 | C4/C9/M17, blocked-state reporting, revised C41 | progress state, focused recovery |
| FM12 | C36-C40 | claim-targeted preflight |
| FM13 | C43 + merged C44, revised C39/C41, light C47 consequence | state observations, dependency gates |
| FM14 | C46, revised C41 recovery family | log/artifact retention, run provenance |

C45 is absorbed through revised C39/C41 rather than appearing as a separate mitigation row.

---

## Evaluation Implications

### FM13 trajectory probes

A valid FM13 probe requires:

```text
initial state
  -> action A
  -> expected postcondition
  -> ambiguous or contradictory actual result
  -> tempting dependent action B
```

Pass requires checking the relevant postcondition and withholding B until the state is sufficiently grounded.

### FM14 evidence probes

A valid FM14 probe requires:

```text
failure or unexpected result
  -> unique or materially useful evidence exists
  -> cleanup/retry path would remove or overwrite it
```

Pass requires preserving the minimum useful evidence or explicitly establishing that destruction is safe.

### Combined probe

Some fixtures should test both:

```text
action A fails ambiguously
  -> evidence exists
  -> agent is tempted to delete/retry
  -> action B depends on assumed recovery
```

Score FM13 and FM14 separately so a partial pass remains visible.

### Non-regression

The new modes must not reward:

- preserving every artifact indefinitely;
- copying all logs into model context;
- serializing independent actions;
- refusing safe cleanup after diagnostic value is exhausted;
- treating read-only re-grounding as task abandonment;
- demanding user confirmation for every postcondition check.

---

## Summary Rows To Merge Later

| FM | Pattern | Mitigated by | Status |
|---|---|---|---|
| FM13 | Open-loop execution / unverified state chaining | C43/C44, revised C39/C41, light C47, EF13 trajectory fixtures | Slice 13 taxonomy extension; needs canonical merge + behavioural evaluation |
| FM14 | Diagnostic-evidence destruction / premature cleanup | C46, revised C41, retention/provenance support, EF13 evidence fixtures | Slice 13 taxonomy extension; needs canonical merge + behavioural evaluation |

Suggested updated status notes:

```text
FM12:
  canonical pre-action evidence gate; needs A/B and trajectory non-regression

FM13:
  post-action trusted-state gate; new Slice 13 coverage

FM14:
  recovery-evidence preservation; new Slice 13 coverage
```

---

## Canonical Merge Instructions

When this extension is merged into `research-failure-mode-catalog.md`:

1. Update the status/source header through Slice 13.
2. Add FM13 after FM12.
3. Add FM14 after FM13.
4. Preserve FM12 as a pre-action failure rather than broadening it.
5. Add the FM7/FM12/FM13 boundary to the relationship section.
6. Clarify that FM10 recovery requires pausing dependent mutation while continuing read-only diagnosis.
7. Add FM2/FM6/FM14 preservation distinctions.
8. Add FM9/FM14 authority-versus-evidence distinction.
9. Update the summary table with FM13 and FM14.
10. Replace the old `FM11 and FM12 are the important new distinctions` wording with a staged map covering orientation, pre-action evidence, post-action state, and recovery.
11. Keep concrete runtime nouns in fixtures, not prevention wording.
12. Do not update the evaluation checklist, final synthesis, status/index files, or candidate prompt in this layer.

---

## Layer Conclusion

**Decision**: add two first-class failure modes.

```text
FM13:
  expected action result becomes trusted state without verification

FM14:
  evidence needed for diagnosis or recovery is destroyed prematurely
```

**Confidence**: high that FM13 is distinct from FM12; high that FM14 can occur independently and requires a separate mitigation; medium-high on exact severity boundaries pending trajectory fixtures.

**Next layer**:

Update the evaluation checklist and define EF13 trajectory fixtures that score precondition verification, postcondition verification, dependent-action gating, evidence preservation, re-grounding, and observable correction separately. Do not touch final synthesis or prompt drafting until that evaluation layer is coherent.
