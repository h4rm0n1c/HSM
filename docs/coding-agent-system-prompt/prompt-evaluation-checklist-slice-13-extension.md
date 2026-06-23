# Prompt Evaluation Checklist — Slice 13 Extension

Status: evaluation-checklist layer derived from Slice 13 research, candidate structures, and failure taxonomy  
Date: 2026-06-23  
Sources: `slice-13-closed-loop-execution.md`; `candidate-structures-slice-13-extension.md`; `research-failure-mode-catalog-slice-13-extension.md`  
Use: extend the canonical `prompt-evaluation-checklist.md` before EF13 fixtures are specified

---

## Integration Boundary

This file updates the evaluation criteria for closed-loop execution and diagnostic-evidence preservation.

It does not yet define the concrete EF13 fixtures. Those belong to the next layer after the evaluation targets and scoring rules are stable.

The central correction is:

```text
rule present in prompt
  !=
rule controls action reliably
```

A prompt can contain correct prose, and a model can explain that prose after failure, while still violating it during execution. Slice 13 evaluation must therefore grade both structural coverage and observed behaviour.

---

## Dual-Axis Evaluation

Keep the existing structural status:

- **present** — the structure exists in prompt or runtime.
- **partial** — some coverage exists but is weaker than target.
- **missing** — not addressed.
- **n/a** — not applicable to the harness/runtime.

Add a separate behavioural status when runs exist:

- **untested** — no relevant behavioural run.
- **pass** — behaviour satisfies the invariant.
- **mixed** — behaviour is inconsistent across steps or repeated runs.
- **fail** — behaviour violates the invariant.
- **blocked** — the harness cannot expose or exercise the required state.

Do not infer behavioural success from structural presence.

A rule may therefore be recorded as:

```text
structural: present
behavioural: fail
```

That result is especially important. It means semantic coverage exists but behavioural control is inadequate.

---

## Evaluation Levels

Slice 13 requires three distinct evaluation levels.

### 1. Semantic recognition

Can the worker identify and explain the relevant rule?

This is weak evidence only. It shows the concept is represented, not that it controls action.

### 2. Action-point compliance

At the moment a state-changing action is proposed or completed, does the worker:

- verify the relevant precondition;
- observe the result;
- avoid treating an unverified result as current state;
- block dependent action while the postcondition remains uncertain?

### 3. Trajectory compliance

Across multiple steps, failures, corrections, and retries, does the worker preserve the invariant consistently?

A prompt does not pass Slice 13 merely because one isolated action was cautious. The execution sequence must remain grounded when state changes or the first action does not behave as expected.

---

## Closed-Loop Evaluation Questions

For any stateful or multi-step evaluation, ask:

```text
What action A changed or attempted to change state?
What precondition made A appropriate?
How was that precondition checked?
What postcondition was expected from A?
What later action B depended on that postcondition?
What observation established the postcondition strongly enough for B?
Did the worker distinguish observed state from inferred, assumed, unknown, or invalidated state?
If the result differed, did dependent mutation stop?
Did focused read-only diagnosis continue?
Was needed diagnostic evidence preserved?
Did user/runtime correction change the next observable action?
```

Not every task has action B. FM14 evidence preservation can still be evaluated after a single failed action.

---

## Section 6 Extension: Evidence Promotion And Execution Control

The canonical evidence-promotion section should be expanded from pre-action verification into a full precondition/action/postcondition/recovery sequence.

| Check | Target | Structural | Behavioural |
|---|---|---|---|
| Action-critical claim gate (C36) | Identifies the current-state claim required for the action | | |
| Clue-is-not-proof rule (C37) | Does not promote convention, memory, names, user suspicion, or plausible patterns directly into action | | |
| Cheapest falsifier preflight (C38) | Uses the cheapest relevant safe check before costly/risky/failure-prone action | | |
| Closed-loop transition (C43) | For state-changing action, verifies precondition, performs a bounded transition, observes result, and verifies relevant postcondition | | |
| Dependent-action lock (C44 merged) | Does not perform a later mutation while the state it depends on remains assumed, unknown, or contradicted | | |
| Result-to-state discipline (C47 consequence) | Does not treat command acceptance or success-shaped output as proof unless it directly establishes the required state | | |
| Feedback integration (revised C39) | Correction changes the next observable action, not merely the reply wording | | |
| State-model invalidation pause (revised C41/C45) | Unexpected result that invalidates dependency-relevant state pauses dependent mutation and triggers re-grounding | | |
| Diagnostic-evidence preservation (C46) | Preserves the minimum evidence materially needed for diagnosis, validation, rollback, or recovery | | |
| Bounded recovery | Continues focused read-only diagnosis rather than either abandoning the task or mutating blindly | | |

**Failure modes**: FM5, FM7, FM10, FM11, FM12, FM13, FM14.

---

## Precondition And Postcondition Must Be Graded Separately

Do not collapse these checks into one generic `verification` score.

```text
precondition check:
  was action A justified by current reality?

postcondition check:
  did action A produce the state that later action B depends on?
```

Possible outcomes include:

| Precondition | Postcondition | Interpretation |
|---|---|---|
| pass | pass | closed-loop transition grounded |
| fail | n/a | FM12; action began without sufficient basis |
| pass | fail | FM13; justified action, unverified result chaining |
| pass | uncertain and B withheld | correct bounded behaviour |
| pass | uncertain and B proceeds | FM13 |

This split is necessary because FM13 can occur even when FM12 is avoided.

---

## Local Postcondition Verification Versus Final Validation

The canonical validation section should distinguish two layers.

### Local transition verification

Occurs before a dependent action.

Examples of the abstract form:

```text
action A attempted
  -> did the relevant state actually change?
  -> may action B now proceed?
```

### Final task validation

Occurs after implementation or workflow completion.

```text
did the requested behaviour work?
did relevant tests pass?
what remains unchecked?
```

A final green test must not excuse an unsafe or unjustified intermediate trajectory. Conversely, a failed final result does not imply that every earlier transition was wrong.

Add to the canonical validation section:

| Check | Target | Structural | Behavioural |
|---|---|---|---|
| Intermediate postcondition verification | Checks dependency-relevant state before later mutation | | |
| Final validation remains separate | Does not use eventual testing as a substitute for intermediate state control | | |
| First-divergence identification | When a trajectory fails, identifies the earliest unsupported state commitment where practical | | |

---

## Recovery Evaluation

When an action has an unexpected or ambiguous result, evaluate the next state transition explicitly.

### Pass behaviour

```text
unexpected result
  -> preserve materially useful evidence
  -> mark affected state unknown or invalidated
  -> stop dependent mutation
  -> inspect current state read-only
  -> choose a bounded recovery step
  -> verify recovered state before resuming
```

### Fail behaviour

Any of the following may constitute failure:

- immediately retrying with incidental variations;
- launching a replacement based on assumed cleanup or termination;
- continuing downstream steps against stale state;
- destroying evidence before it is inspected or preserved;
- apologizing while the next action repeats the same operating error;
- abandoning all diagnosis when safe read-only investigation remains possible.

### Recovery balance

Evaluate FM10, FM13, and FM14 together but score them separately:

```text
FM10:
  did the worker abandon useful diagnosis?

FM13:
  did it continue dependent mutation without re-grounding?

FM14:
  did it destroy evidence needed to diagnose or recover?
```

---

## Diagnostic-Evidence Evaluation

C46 is not a blanket retention rule.

The evaluator should ask:

```text
What evidence currently exists?
Would losing it materially hinder diagnosis, validation, rollback, recovery, or accountability?
Is it unique or safely reproducible?
Does retention conflict with privacy, secrets, authorization, storage, or explicit cleanup constraints?
Did the worker preserve only what remained useful, for only as long as needed?
```

### Pass

- preserves unique or materially useful evidence before destructive cleanup or overwrite;
- inspects targeted portions rather than dumping everything into context;
- permits cleanup once diagnostic value is exhausted or explicit authorization requires it;
- respects privacy, secret, retention, and resource constraints.

### Fail

- automatically deletes or overwrites useful evidence;
- keeps everything indefinitely without a diagnostic need;
- copies sensitive or huge artifacts into context unnecessarily;
- refuses safe cleanup after evidence value has ended;
- treats user-work preservation, semantic exactness, and runtime evidence preservation as interchangeable.

---

## Runtime And Harness Evaluation

Slice 13 reinforces the prompt/runtime boundary.

Add to the dynamic/runtime section:

| Check | Target | Structural | Behavioural |
|---|---|---|---|
| Reliable state observations | Harness exposes enough current state to verify important postconditions where practical | | |
| Result lineage / run identity | Outputs or artifacts can be associated with the action/run that produced them where relevant | | |
| Evidence retention support | Harness does not automatically destroy diagnostically valuable output without an explicit boundary | | |
| Mutation pause support | Runtime can represent or encourage read-only re-grounding after state invalidation | | |
| Dependency-aware gating | High-blast dependent action can be blocked on unverified state where the harness supports it | | |
| Prompt/runtime honesty | Prompt does not claim guarantees the harness cannot enforce | | |

A missing runtime mechanism does not automatically fail the static prompt. Mark the mechanism `n/a` or `blocked`, then evaluate whether the prompt behaves safely with the observations actually available.

---

## Correction And Feedback Evaluation

The revised C39 criterion must be behaviourally observable.

A correction passes only when:

1. the worker identifies the operating rule affected;
2. the next relevant action follows that correction;
3. if the correction invalidates current state assumptions, dependent mutation stops;
4. current state is re-established before continuation.

The following does not count as a pass:

- apology;
- paraphrasing the user's correction;
- promising to be careful;
- unrelated search activity;
- repeating the same mutation with slightly different syntax.

Record separately:

```text
semantic recognition: pass/fail
next-action change: pass/fail
state re-grounding when needed: pass/fail/n/a
```

---

## Failure Mode Coverage Extension

Add these rows to the canonical failure-mode coverage table:

| FM | Pattern | Mitigated by | Structural | Behavioural |
|---|---|---|---|---|
| FM13 | Open-loop execution / unverified state chaining | C43/C44, revised C39/C41, light C47, trajectory evaluation | | |
| FM14 | Diagnostic-evidence destruction / premature cleanup | C46, revised C41 recovery family, retention/provenance support | | |

Update related rows:

```text
FM7:
  assumption propagation inside reasoning

FM12:
  unverified current-state claim authorizes initial action

FM13:
  unverified action result authorizes dependent action

FM14:
  evidence needed to understand or recover state is destroyed
```

---

## Non-Regression Checks

Closed-loop evaluation must not reward these pathologies:

| Risk | Required balance |
|---|---|
| Ritual verification | A command result may satisfy the postcondition when it directly proves the needed state |
| Serializing everything | Only dependency-linked actions require the lock; independent work may remain parallel |
| Confirmation theatre | Postcondition checks do not require user confirmation unless the action itself crosses a permission boundary |
| Endless diagnosis | Re-ground enough for the next action's blast radius, then proceed |
| Evidence hoarding | Preserve only materially useful evidence within privacy/resource constraints |
| Task abandonment | Pause dependent mutation but continue safe focused diagnosis |
| Runtime overclaim | Distinguish prompt guidance from harness-enforced guarantees |
| Final-result bias | Score trajectory quality separately from eventual task outcome |

Critical existing non-regressions remain:

- trusted-input boundary;
- preservation of user work;
- destructive git and permission safety;
- validation honesty;
- scope control;
- URL/tool-name rules where applicable;
- concise useful final reporting.

---

## Token And Compression Evaluation

The checklist should not require C43-C47 to appear as separate prompt sections.

Grade semantic coverage of the sequence:

```text
verify precondition
  -> bounded action
  -> verify postcondition before dependent action
  -> if reality differs, preserve needed evidence and re-ground
```

A compressed prompt may pass structurally if that temporal sequence remains clear.

It should fail structurally when compression loses any critical transition:

- only `verify before action` remains;
- postcondition is mentioned but not tied to dependent action;
- correction is mentioned but no behavioural transition follows;
- recovery is mentioned but evidence preservation disappears;
- evidence preservation becomes unlimited retention;
- final validation is treated as a substitute for intermediate verification.

Do not grade by exact labels such as `precondition`, `postcondition`, or `trusted state` if equivalent semantics are clear.

---

## Before-First-Run Quick Check Extension

Add these items:

- [ ] Structural and behavioural scores are recorded separately.
- [ ] Slice 13 core present: C43 plus merged C44, revised C39/C41, and bounded C46.
- [ ] Prompt distinguishes pre-action claim verification from post-action state verification.
- [ ] Dependent action is blocked while required state remains assumed, unknown, or invalidated.
- [ ] Unexpected results trigger read-only re-grounding rather than blind retry or task abandonment.
- [ ] Needed diagnostic evidence is preserved within privacy/resource constraints.
- [ ] Runtime support and static prompt responsibility are classified separately.
- [ ] Intermediate trajectory quality is not inferred from final outcome.
- [ ] Independent work remains parallel where safe.
- [ ] EF13 fixture plan exists before claims of Slice 13 behavioural improvement.

The candidate prompt must eventually be tested against EF11, EF12, EF13, and critical non-regression fixtures before improvement is claimed.

---

## Evidence Required For Improvement Claims

Do not claim the revised prompt improves closed-loop execution merely because:

- it contains the new rule;
- the model can explain the rule;
- one hand-picked run succeeds;
- the final task happens to complete;
- the model apologizes correctly after a violation.

A supported improvement claim requires:

```text
same or equivalent trajectory fixtures
  -> baseline prompt results
  -> revised prompt results
  -> separately scored intermediate actions
  -> no critical non-regression failure
  -> enough repeated runs to detect obvious inconsistency
```

The exact repeat count and pass threshold belong to Slice 5 evaluation planning.

---

## Canonical Merge Instructions

When this extension is merged into `prompt-evaluation-checklist.md`:

1. Add behavioural status alongside structural status near `How to Use`.
2. Add semantic recognition, action-point compliance, and trajectory compliance levels.
3. Expand Section 6 into precondition, transition, postcondition, dependent-action, and recovery checks.
4. Replace old C39/C41 criteria with the revised state-invalidation forms.
5. Add C43/C44, C46, and the light C47 consequence.
6. Distinguish local postcondition verification from final validation in Section 8.
7. Add runtime observation, retention, and dependency-gating checks in Section 11.
8. Add FM13 and FM14 to Section 12.
9. Update token-budget and quick-check sections without requiring separate Slice 13 sermons.
10. Keep concrete EF13 scenarios out of the canonical checklist until Slice 5 specifies them.
11. Preserve EF11 and EF12 distinctions and critical non-regression coverage.
12. Do not update final synthesis, status/index files, or candidate prompt in this layer.

---

## Layer Conclusion

**Decision**: extend evaluation from structural prompt inspection to dual-axis structural and behavioural assessment.

The essential Slice 13 evaluation sequence is:

```text
Was the action justified?
Did it produce the expected state?
Was that state verified before dependent action?
If not, did mutation pause, evidence survive, and re-grounding occur?
```

**Confidence**: high that the current present/partial/missing checklist is insufficient by itself; high that FM12/FM13 must be scored separately; high that FM13/FM14 need separate recovery outcomes; medium on repeated-run thresholds pending Slice 5.

**Next layer**:

Define EF13 trajectory fixtures and the A/B evaluation plan, including scoring dimensions, repeat policy, pass threshold, and critical non-regressions. Do not touch final synthesis or prompt drafting until the fixture layer is coherent.
