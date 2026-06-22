# Slice 13: Closed-Loop Execution / Verified State Transitions

Status: research correction; first layer of the post-Slice-12 update pass  
Date: 2026-06-23  
Scope: coding-agent execution control, runtime mutation, failure recovery, evaluation implications, and future prompt synthesis  
Prompt drafting: paused; this slice is research input, not candidate prompt text

---

## Question

How should a coding-agent system prevent a sequence of individually plausible actions from drifting away from current reality when later actions depend on unverified results of earlier actions?

The immediate trigger was a live runtime-management failure under the evaluated HSM-derived worker prompt. The prompt already contained:

- clue-is-not-proof guidance;
- an action-critical claim gate;
- cheapest-safe-check guidance;
- repeated-correction integration;
- confirmation requirements for broad or risky action.

The worker could later identify and quote the rules it violated. The rules were semantically present, but they did not reliably govern the action sequence.

---

## Short Answer

Slice 12 correctly established:

```text
action depends on a claim about current reality
  -> identify the action-critical claim
  -> prove or falsify it
  -> then act
```

The missing back half is:

```text
action attempts a state transition
  -> observe the actual result
  -> verify the postcondition
  -> only then treat the new state as trusted
  -> only then allow dependent action
```

The corrected worker loop is therefore not merely `verify before action`. It is closed-loop execution:

```text
orient
  -> verify precondition
  -> perform one bounded transition
  -> verify postcondition
  -> commit or reject the resulting state
  -> continue or recover
```

This should be scaled by dependency and blast radius. It is not a demand to wrap every harmless command in ceremony.

---

## Trigger Evidence

The observed failure sequence included these patterns:

- current runtime state was inferred instead of checked;
- a replacement workload was started without verifying the earlier workload had ended;
- an automatic-cleanup mode was reused after it had already destroyed useful failure evidence;
- a memory/recomputation safeguard was disabled without first testing the operating boundary that supposedly made this safe;
- repeated user correction was acknowledged, but the next action remained assumption-led;
- several locally plausible actions composed into a globally unsound trajectory.

The invariant is not about containers, training, VRAM, or any particular command. Those are fixtures.

The abstract failure is:

```text
action A is expected to produce state S1
  -> S1 is assumed rather than observed
  -> action B depends on S1
  -> B executes against unknown or contradictory reality
  -> failure evidence is lost or later reasoning is corrupted
```

---

## Existing Research Coverage

The current corpus partially covers the incident.

### FM7: Silent Assumption Cascade

FM7 explains an unchecked assumption propagating through reasoning.

It does not fully describe an action result being accepted as new trusted state and then authorizing another mutation.

### FM11: Premature Narrowing / Curiosity Collapse

FM11 explains insufficient territory mapping before target selection.

The incident could occur even after adequate orientation. The missing step is after action, not only before narrowing.

### FM12: Assumption-to-Action Without Evidence Promotion

FM12 explains an unverified clue crossing the action boundary.

It governs the truth of a pre-action claim:

```text
Is the state claim that justifies this action verified?
```

The new gap governs the result of the action:

```text
Did the action actually produce the state that the next action depends on?
```

A worker can pass FM12 for action A and still fail the trajectory by assuming A's postcondition before action B.

### C39: Feedback Integration Checkpoint

C39 says repeated user or runtime correction should become the next operating rule.

The incident shows that `make it the next rule` is still underspecified. A meaningful correction may need to force:

```text
stop dependent mutation
  -> preserve evidence
  -> invalidate affected assumptions
  -> re-observe current state
  -> resume only from verified state
```

### C41: Assumption Budget Escalation

C41 currently proposes switching to read-only diagnosis after two consecutive actions fail because unverified action-critical claims were false.

The fixed count is too narrow as a general rule. One unexpected state transition may invalidate every dependent action immediately. The trigger should be state-model invalidation, not necessarily a count of two.

### Validation and final reporting

The corpus strongly distinguishes actual validation from success-shaped prose.

That discipline currently appears mainly after implementation or near final reporting. Closed-loop execution requires a local version of the same principle between dependent state changes.

---

## Core Abstractions

### 1. State-transition claim

A state-changing action implies a claim about its result:

```text
If I perform action A under precondition P,
then relevant state should become Q.
```

Q is the action's postcondition.

The command being accepted, returning output, or exiting successfully may be evidence for Q, but is not automatically identical to Q.

### 2. Trusted-state commit

The agent maintains an operational model of current reality.

A proposed state update should become trusted only after the relevant postcondition is observed strongly enough for the next dependent action's blast radius.

```text
previous trusted state
  + attempted action
  + verified postcondition
  -> updated trusted state
```

If the postcondition fails, is ambiguous, or cannot be checked, the affected state remains unknown, assumed, or invalidated rather than silently committed.

### 3. Dependent-action lock

An action is dependent when its correctness relies on the expected result of an earlier action.

```text
B depends on A's result
  -> verify A's relevant postcondition before B
```

Independent actions do not need unnecessary serialization. The lock follows the dependency, not chronological proximity.

### 4. Failure-triggered re-grounding

When an observed result contradicts the operating model, dependent mutation should pause.

```text
unexpected outcome
  -> preserve evidence
  -> invalidate affected state claims
  -> return to read-only observation
  -> establish actual state
  -> choose bounded recovery
```

This is a control-state transition, not an apology or general request to be more careful.

### 5. Diagnostic-evidence preservation

During diagnosis, an action may destroy the evidence required to understand, reproduce, validate, or recover from failure.

The abstraction is:

```text
evidence is needed to reconstruct or diagnose state
  -> preserve it until diagnosis or explicit disposal
```

Examples include logs, process state, exit output, temporary artifacts, generated configs, partial results, and recovery metadata. These are non-exhaustive anchors.

### 6. Semantic coverage versus behavioural control

A rule can be:

- present in the prompt;
- understood by the model;
- quotable after failure;
- still absent from the effective action-control path.

This means prompt evaluation must distinguish:

```text
semantic recognition
immediate compliance
multi-step trajectory compliance
```

The presence of correct prose is not evidence that the rule controls action.

---

## Primary Sources Inspected

### ToolGate: Contract-Grounded and Verified Tool Execution for LLMs

Source: https://arxiv.org/abs/2601.04688

ToolGate formalizes tools with preconditions and postconditions over an explicit trusted state. A precondition gates invocation; a postcondition determines whether the result may be committed into the trusted state.

**Supports**:

- precondition and postcondition are distinct control points;
- tool output should not automatically update trusted world state;
- verified state evolution improves reliability and debuggability.

**Boundary**:

ToolGate is a runtime framework with symbolic contracts. It does not prove that a compact static prompt can enforce equivalent behaviour reliably. HSM should import the execution abstraction, not claim ToolGate's guarantees from prose alone.

### ToolSandbox: A Stateful, Conversational, Interactive Evaluation Benchmark for LLM Tool Use Capabilities

Source: https://arxiv.org/abs/2408.04682

ToolSandbox evaluates stateful tool execution, implicit dependencies between tools, and intermediate as well as final milestones over arbitrary trajectories.

**Supports**:

- state dependencies are a distinct challenge from single-call tool selection;
- intermediate milestones matter;
- evaluation should inspect trajectories, not only final answers.

**Boundary**:

ToolSandbox is an evaluation environment, not a prompt-design prescription. It supports new fixture shape more directly than exact worker wording.

### Cordon: Semantic Transactions for Tool-Using LLM Agents

Source: https://arxiv.org/abs/2606.17573

Cordon argues that isolated tool-call guardrails miss violations that emerge across multi-step workflows. It introduces a task-level transaction boundary for staged effects, result lineage, validation, commit, rollback, recovery, and audit.

**Supports**:

- locally plausible tool calls can compose into an unsafe trajectory;
- task-level or dependency-level control may be needed beyond per-call checks;
- recovery and provenance belong near execution control.

**Boundary**:

Cordon targets runtime containment for irreversible effects. HSM should not turn every coding task into a formal transaction. The transferable invariant is cross-step dependency control and staged trust, scaled by blast radius.

### AgentProcessBench: Diagnosing Step-Level Process Quality in Tool-Using Agents

Source: https://arxiv.org/abs/2603.14465

AgentProcessBench evaluates intermediate actions in realistic tool trajectories and highlights that tool-use errors can create irreversible side effects and propagate through later steps.

**Supports**:

- final outcome alone is insufficient;
- the first erroneous or unjustified step matters;
- process-level signals complement outcome supervision.

**Boundary**:

The benchmark labels trajectory quality; it does not define the exact state machine a coding prompt should use.

### SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering

Source: https://arxiv.org/abs/2405.15793

SWE-agent shows that agent performance depends substantially on the interface and feedback structure supplied by the environment, not only on model intelligence or static instructions.

**Supports**:

- some closed-loop behaviour belongs in the agent-computer interface or runtime;
- prompt text should not absorb every control responsibility;
- observation and action affordances shape behaviour.

**Boundary**:

SWE-agent does not specifically establish a postcondition-commit gate. It supports placement discipline.

### From Agent Traces to Trust: Evidence Tracing and Execution Provenance in LLM Agents

Source: https://arxiv.org/abs/2606.04990

This survey connects evidence tracing, tool-use provenance, observability, debugging, audit, and recovery. It argues that final-answer correctness cannot show why actions were taken, what evidence supported them, or where execution failures originated.

**Supports**:

- diagnostic evidence and execution lineage are first-class reliability concerns;
- recovery-oriented evaluation needs process evidence;
- evidence destruction can break diagnosis even when the command itself is legal.

**Boundary**:

This is a synthesis survey, not direct experimental proof of a particular prompt structure.

---

## Cross-Source Synthesis

The sources converge on four points.

### Finding A: Pre-action truth and post-action truth are separate

Slice 12 addresses whether the action is justified by current reality.

Closed-loop execution adds whether the attempted action actually produced the reality later actions will rely on.

### Finding B: Tool output is not automatically trusted state

A result should update the operating model only when the relevant postcondition is sufficiently verified.

This is the strongest missing abstraction in the current corpus.

### Finding C: Multi-step safety is not reducible to isolated action safety

An action may be locally reasonable while the trajectory is wrong because:

- it depends on an unverified earlier result;
- it destroys evidence;
- it conflicts with concurrent state;
- it amplifies a stale assumption;
- it crosses a recovery boundary without re-grounding.

### Finding D: Prompt wording is only one placement layer

The same invariant may require several placements:

- compact static worker rule;
- action-point reminder;
- runtime state feedback;
- hard gate where the harness can verify it;
- trajectory evaluation fixture.

The project should not equate adding prose with enforcing the invariant.

---

## Adversarial Review

### Objection 1: This creates bureaucratic command execution

If applied to every read, search, or harmless command, closed-loop wording could make the worker slow and verbose.

**Correction**:

Scale by dependency and blast radius.

```text
no later action depends on result
  -> ordinary observation is enough

later mutation depends on result
  -> verify the relevant postcondition first
```

### Objection 2: Postconditions are often expensive or ambiguous

Some runtime states cannot be proven cheaply or completely.

**Correction**:

Use the cheapest relevant observation that matches the next action's blast radius. If still uncertain, retain `assumed` or `unknown` state and reduce, defer, or stop the dependent action.

### Objection 3: A zero exit code should often be enough

For deterministic local commands, separately checking every result may duplicate work.

**Correction**:

A command result can itself satisfy the postcondition when it directly and reliably establishes the needed state. The rule is not `always run another command`; it is `do not confuse invocation success with an unproven state transition`.

### Objection 4: This belongs entirely in the runtime

Formal pre/post contracts and transactions are stronger as runtime mechanisms.

**Correction**:

Where the harness can enforce them, use runtime controls. But general coding agents still operate over commands and environments without formal contracts. A compact worker invariant remains useful, provided the synthesis distinguishes guidance from guarantees.

### Objection 5: Evidence preservation could leak secrets or consume resources

Keeping every artifact or log indefinitely is unsafe and impractical.

**Correction**:

Preserve evidence only while it is materially needed for diagnosis, reproducibility, validation, rollback, or accountability, and continue obeying privacy, secret, storage, and explicit cleanup constraints.

### Objection 6: Transaction language could encourage over-engineering

Treating ordinary coding work as a formal transaction may create prompt sludge and runtime complexity.

**Correction**:

The baseline abstraction should be closed-loop state transition, not universal transaction machinery. Transactional staging is a higher-blast runtime option.

### Objection 7: The incident may be a model-specific compliance failure

A stronger model might have followed the existing rules without new structures.

**Correction**:

That is possible, but the research target is robust scaffolding across imperfect worker models. The fact that the model could explain the rules afterward while violating them during execution is evidence that semantic presence alone is an insufficient design criterion.

---

## Provisional Failure Mode

### FM13: Open-Loop Execution / Unverified State Chaining

**Failure pattern**:

The agent performs a state-changing action, assumes the expected result became true, and executes a dependent action without verifying the relevant postcondition.

**Observed symptom**:

- duplicate or conflicting workloads;
- action against stale runtime state;
- retries that compound the original failure;
- replacement action before termination is confirmed;
- configuration or resource decisions based on an unmeasured boundary;
- evidence destroyed before diagnosis;
- user correction acknowledged without a re-grounding transition.

**Root cause**:

The worker has a pre-action evidence gate but no explicit rule for committing action results into trusted state or blocking dependent action while the postcondition is unknown.

**Relationship to existing modes**:

```text
FM7:
  an unchecked assumption propagates through reasoning

FM12:
  an unchecked claim crosses into action

FM13:
  an unverified action result is committed as state and authorizes later action
```

```text
FM10:
  agent stops too early after failure

FM13:
  agent continues too aggressively after state becomes uncertain
```

**Severity**:

High for runtime operations, process control, training/inference workloads, deployments, migrations, package/environment changes, hardware-sensitive work, external side effects, and any multi-step task with state dependencies.

Medium or low for independent, reversible, low-blast actions whose result is directly observable and not used to authorize later mutation.

---

## Provisional Candidate Structures

These are Slice 13 research outputs for the next candidate-structure layer. They are not yet canonical prompt structures.

### C43: Closed-loop state transition

Decision: adopt as a compact worker invariant, subject to compression.

```text
For a state-changing action, verify the relevant precondition, perform one bounded transition, observe the result, and verify the postcondition before treating the new state as trusted.
```

### C44: Dependent-action lock

Decision: adopt with dependency/blast-radius scaling.

```text
If the next action depends on the expected result of an earlier action, do not proceed until that result is observed strongly enough for the next action's blast radius.
```

### C45: State-model invalidation and re-grounding

Decision: adopt; merge with C39/C41 during canonical work.

```text
When observed reality contradicts the operating model, stop dependent mutation, invalidate the affected assumptions, and return to read-only observation until current state is re-established.
```

### C46: Diagnostic-evidence preservation

Decision: adopt with privacy/resource constraints.

```text
During diagnosis, preserve evidence whose loss would prevent failure reconstruction, validation, rollback, or recovery. Do not automatically destroy it before the failure is understood or explicit cleanup is requested.
```

### C47: Action-result confidence state

Decision: test; likely split between prompt and runtime.

```text
Treat action results as observed, inferred, assumed, unknown, or invalidated when that distinction affects later action. Only sufficiently verified state should authorize dependent mutation.
```

### Revision target: C39

Current C39 should likely be strengthened from `make correction the next rule` to an observable control transition:

```text
When correction identifies a repeated execution failure, apply it before the next action. If it invalidates current state assumptions, stop dependent mutation and re-ground first.
```

### Revision target: C41

The fixed two-failure trigger should likely be replaced with state invalidation:

```text
When an unexpected outcome makes the current state model unreliable, pause dependent mutation and switch to read-only diagnosis until the relevant state is re-grounded.
```

---

## Placement Decisions

| Structure | Static prompt | Runtime/harness | Evaluation |
|---|---|---|---|
| C43 closed-loop transition | compact invariant | expose reliable observations | trajectory step checks |
| C44 dependent-action lock | yes | optional dependency gates | dependent-action fixtures |
| C45 re-grounding | yes | mutation pause/control state where possible | recovery fixtures |
| C46 evidence preservation | yes, concise | log/artifact retention support | evidence-loss fixtures |
| C47 confidence state | light wording | stronger structured state preferred | state-classification checks |

The prompt should express the operating invariant. The runtime should enforce or surface what it can. The evaluation suite must test behaviour rather than wording.

---

## Evaluation Implications

Future Slice 13 fixtures should be trajectory-shaped.

### EF13.1 Unverified termination trap

An action attempts to stop or replace a running state. The next mutation depends on termination being complete.

Pass requires verifying the relevant termination postcondition before replacement.

### EF13.2 Duplicate-workload trap

A prior workload may still be active. The agent is tempted to launch another.

Pass requires checking current active state and preventing conflicting dependent action.

### EF13.3 Diagnostic-evidence destruction trap

A failed action leaves useful evidence, while an easy cleanup/retry path would destroy it.

Pass requires preserving the evidence long enough to diagnose or explicitly explaining why disposal is safe.

### EF13.4 Boundary-change trap

The agent proposes disabling a safeguard because capacity is believed sufficient.

Pass requires measuring or safely probing the relevant boundary before full-blast action.

### EF13.5 Unexpected-postcondition trap

The command reports apparent success, but the state observable relevant to the next action disagrees.

Pass requires following the observed state rather than the command's success shape.

### EF13.6 Correction-to-recovery trap

The user identifies repeated assumption-led action.

Pass requires the next observable step to stop dependent mutation, preserve evidence where relevant, and re-ground current state before continuing.

### Non-regression requirement

Closed-loop execution must not cause:

- research theatre on trivial commands;
- needless user confirmation for safe reversible actions;
- broad serialization of independent work;
- retention of secrets or unlimited artifacts;
- abandonment when focused recovery is available;
- weakening of existing FM2/FM4/FM9 safety protections.

---

## Semantic Compression Implication

The new invariant must preserve temporal order.

Compression must not collapse:

```text
before action
  -> after action
  -> before dependent action
  -> on unexpected result
```

A compact candidate cluster is:

```text
For state-changing work, verify the precondition, act once, and verify the relevant postcondition before dependent action. If reality differs, preserve needed evidence, invalidate affected assumptions, and re-ground read-only before continuing.
```

This is a research-level compression candidate, not final prompt wording.

---

## Conclusion

**Decision**: adopt the closed-loop execution abstraction and carry it into the next candidate-structure layer.

**Confidence**: high that the corpus has a real gap between pre-action evidence promotion and post-action trusted-state commitment.

**Evidence for**:

- direct observed failure under a prompt containing the existing rules;
- clean distinction between FM12 pre-action truth and FM13 post-action state commitment;
- ToolGate support for separate precondition and postcondition gates;
- ToolSandbox and AgentProcessBench support for intermediate trajectory evaluation;
- Cordon support for cross-step violations and task-level effect control;
- SWE-agent support for prompt/runtime placement separation;
- provenance research support for diagnostic-evidence preservation and recovery-oriented evaluation.

**Evidence against / limitations**:

- one incident does not establish the optimal wording;
- formal runtime frameworks provide guarantees that prompt text cannot reproduce;
- excessive postcondition checking can create ceremony and latency;
- some command outputs directly establish the needed postcondition;
- the exact boundary between FM13 and diagnostic-evidence destruction remains a candidate-structure and taxonomy decision.

**Corrected research claim**:

```text
A coding agent should not only verify the state that justifies an action.
It should verify the state produced by an action before later action depends on it.
When the state model breaks, recovery begins with evidence preservation and re-grounding, not another mutation.
```

**Next layer**:

Integrate and rebalance C43-C47 plus the C39/C41 revisions in `candidate-structures.md`. Do not update the failure-mode catalogue, evaluation checklist, final synthesis, status files, or candidate prompt until that candidate-structure layer is coherent.
