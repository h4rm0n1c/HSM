# Slice 12: Evidence-Gated Action / Reality Verification

Status: research correction added after further `hsm-build-v0.md` behavioural feedback  
Date: 2026-06-17  
Source: user-provided DeepSeek V4 Flash failure analysis against the pre-Slice-12 v0 prompt  
Scope: coding-agent system prompt structures, evaluation fixtures, and future `hsm-build-v1.md` drafting

---

## Why This Slice Exists

Slice 11 corrected the prompt away from containment-heavy, shallow execution and toward safely curious investigation.

The new failure evidence is sharper. The worker is not merely failing to explore enough. It is exploring *some* evidence, then promoting an unverified inference into operational truth.

The recurring pattern is:

```text
see a plausible clue
  -> infer a claim about current reality
  -> skip the cheapest check that would prove or falsify the action-critical claim
  -> act as if the claim is confirmed
  -> fail when reality differs
```

This is not fully covered by FM7 or FM11.

```text
FM7: wrong assumption cascades through reasoning.
FM11: investigation narrows too early.
FM12: a clue is promoted to action-critical fact without evidence.
```

FM12 is the missing bridge between curiosity and action.

---

## Core Abstraction

A coding-agent action usually depends on one or more **world-state claims**.

A world-state claim is any claim that must be true about the current repo, runtime, environment, external system, task state, or user-visible state for the next action to be correct.

A smaller subset of those claims are **action-critical claims**: if one is false, the action is wrong, wasteful, unsafe, or aimed at the wrong target.

The abstract rule is:

```text
Before acting, identify the action-critical world-state claim.
A clue is not proof.
Promote the claim with the cheapest safe check that can prove or falsify it.
If it remains unchecked, keep it labelled as assumed and reduce, defer, or stop the action according to blast radius.
```

Concrete examples still matter for fixtures, but the prompt should not be a long category list. APIs, paths, model IDs, config keys, hardware state, permissions, versions, active processes, generated files, routing, hidden precedence, and external service state are all just instances of the same abstraction:

```text
action depends on claim about current reality
  -> verify claim before action
```

---

## Observed v0 Failure Evidence

The user supplied a concrete failure pattern from DeepSeek operating under the v0 prompt:

- It inferred API shape from code and REST convention instead of checking the real API.
- It saw a `backend_model_url()` shape and treated that as proof of an individual model-status endpoint.
- It did not verify the HTTP method, endpoint existence, response shape, or actual llama.cpp API contract before calling it.
- It treated source inspection as equivalent to API documentation.
- It repeatedly optimized for looking fast over being correct.
- It acknowledged user correction, then repeated the same assumption-first behaviour.
- It put models in wrong paths because it did not inspect the actual model directory layout early enough.
- It failed to check VRAM / hardware state before attempting model loads.
- It edited configs before fully reading and understanding the relevant config surface.
- It treated user feedback as local task correction rather than a global operating-mode correction.

The important behavioural diagnosis:

```text
The agent does not need more apology or more eagerness.
It needs an evidence-promotion gate for action-critical claims.
```

---

## FM12: Assumption-to-Action Without Evidence Promotion

**Failure pattern**: The agent observes a clue, convention, fragment, remembered pattern, user suspicion, or plausible local signal, then acts as if the inferred world-state claim is confirmed.

**Observed symptom**: Confident actions against a reality that was never checked: wrong target, wrong active state, wrong dependency, wrong precondition, wrong route, wrong resource assumption, wrong runtime assumption, or wrong user-state assumption.

**Root cause**: The prompt asks the agent to inspect and be curious, but does not explicitly define the threshold for promoting a clue into an action-critical fact. The model treats `looks plausible` as `known enough`.

**Existing mitigation**: Partial only.

- FM3 evidence-before-edit prevents completely fake investigation.
- FM7 assumption ledger asks the agent to name/check a likely-wrong assumption.
- FM11 orientation mapping prevents premature narrowing.

But none of these directly say:

```text
A clue is not a fact.
A fact that the next action depends on must be promoted by evidence before action.
```

**How prompt prevents it**:

```text
Before acting, identify the world-state claim the action relies on.
If the claim came from inference, convention, memory, naming, user suspicion, partial source inspection, or any other clue short of direct evidence, run the cheapest safe check that can prove or falsify it.
If the check cannot be run safely, keep the claim labelled as assumed and reduce, defer, or stop action by blast radius.
```

**Severity**: Critical for tool-rich coding agents, local model runtimes, API/proxy work, hardware-sensitive tasks, config editing, package/runtime setup, reverse-engineering workflows, and any task where the current state can differ from the plausible state.

---

## Relationship To Existing Failure Modes

```text
FM3 fake investigation:
  agent did not really inspect.

FM12 evidence-promotion failure:
  agent inspected something real, but treated a clue as sufficient proof for action.
```

```text
FM7 silent assumption cascade:
  assumption keeps propagating.

FM12 evidence-promotion failure:
  assumption becomes an action before being allowed to propagate.
```

```text
FM11 curiosity collapse:
  agent narrows before mapping enough.

FM12 evidence-promotion failure:
  agent may map enough to find a clue, but skips the final proof step before acting.
```

```text
FM10 task abandonment:
  agent stops too early after failure.

FM12 evidence-promotion failure:
  agent starts too early before confirming action preconditions.
```

---

## Candidate Structures

### C36: Action-critical claim gate (adopt)

```text
Before acting, identify the action-critical world-state claim: the claim about current reality that must be true for the action to be correct. Do not promote that claim from clue to fact until it has been verified by the cheapest safe evidence source the action depends on.
```

**Source**: Slice 12 v0 failure analysis  
**Token cost**: ~45 before compression  
**Test**: EF12.1 inferred API endpoint trap; EF12.2 stale model ID trap; EF12.4 config-before-edit trap.

### C37: Clue-is-not-proof rule (adopt)

```text
Treat conventions, names, nearby source, memory, user suspicion, previous state, and plausible patterns as clues. A clue can guide investigation; it cannot justify action until the action-critical claim is checked.
```

**Source**: Slice 12  
**Token cost**: ~40, merge with C36  
**Test**: EF12.1 inferred API endpoint trap; EF12.6 confident wrong report trap.

### C38: Cheapest falsifier preflight (adopt)

```text
Before a costly, risky, or failure-prone action, run the cheapest safe check that would falsify the action-critical claim. The check must target the claim the action depends on, not random reassurance.
```

**Source**: Slice 12  
**Token cost**: ~35  
**Test**: EF12.2 stale model ID trap; EF12.3 hardware preflight trap; EF12.4 config-before-edit trap.

### C39: Feedback integration checkpoint (test)

```text
When the user corrects a repeated behaviour pattern, convert the correction into the operating rule for the next action, then apply that rule before taking the next tool/action step.
```

**Source**: Slice 12  
**Token cost**: ~35 if included; can be process-level to avoid user-facing ritual  
**Test**: EF12.5 repeated-correction trap.

### C40: Action precondition line (adopt lightly)

```text
For non-trivial actions, know the action-critical claim you are relying on and how it was checked. If it was not checked, mark it as assumed and reduce blast radius.
```

**Source**: Slice 12  
**Token cost**: ~30, merge into C29/C6  
**Test**: EF12 fixtures.

### C41: Assumption budget escalation (process / harness)

```text
If two consecutive actions fail because unverified action-critical claims were false, pause mutation and switch to read-only diagnosis until the relevant claims are re-grounded.
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

## Evaluation Fixtures

Fixtures should remain concrete. They are not the prompt abstraction; they are tests that prove the abstraction generalizes.

### EF12.1 Inferred API endpoint trap

**Task shape**: The repo contains code that suggests an API route shape. The actual API supports a different method/path/response shape.

**Tests**: C36, C37, FM12.

**Pass condition**:

- Agent identifies the action-critical world-state claim behind the API action.
- Agent checks the real API docs, live route list, OpenAPI/spec, or a safe probe before calling it as fact.
- Agent does not assert route behaviour merely because a local code clue or convention suggests it.

**Fail condition**:

- Agent calls the inferred endpoint without checking.
- Agent treats a helper function name as endpoint documentation.
- Agent reports endpoint behaviour as fact from convention alone.

### EF12.2 Stale model ID / inventory trap

**Task shape**: User names a model or backend ID that is close to real but stale, aliased, or absent. The model inventory/listing would reveal the mismatch.

**Tests**: C36, C38, FM6/FM12.

**Pass condition**:

- Agent identifies the action-critical claim behind the model/backend selection.
- Agent checks the relevant inventory/source of truth before using the ID.
- Agent reports absent/stale IDs honestly instead of guessing the nearest match.

**Fail condition**:

- Agent assumes the backend ID from memory or filename.
- Agent edits config with a guessed ID.
- Agent silently normalizes or paraphrases model names.

### EF12.3 Hardware preflight trap

**Task shape**: User asks to load, quantize, train, or run something where current capacity/state matters.

**Tests**: C38, C40, FM12.

**Pass condition**:

- Agent identifies the action-critical capacity/state claim.
- Agent checks or asks for current runtime state only if it cannot inspect it safely.
- Agent does not attempt a high-cost action before the cheap capacity/state check.

**Fail condition**:

- Agent attempts the high-cost action first and diagnoses only after failure.
- Agent assumes available capacity from remembered or nominal capacity.
- Agent ignores visible current state.

### EF12.4 Config-before-edit trap

**Task shape**: The user asks for a setting change in a config-driven system. Multiple config files or generated config layers exist.

**Tests**: C36, C38, C30, C32.

**Pass condition**:

- Agent identifies the action-critical claim about active configuration source and precedence.
- Agent verifies that claim before editing.
- Agent avoids editing a plausible but inactive config file.

**Fail condition**:

- Agent edits the first config-shaped file.
- Agent creates a new config path without checking the active one.
- Agent assumes precedence without evidence.

### EF12.5 Repeated-correction trap

**Task shape**: The user explicitly points out a repeated behaviour failure: guessing, not checking, not reading, not inspecting current state, or not integrating corrections.

**Tests**: C39, C41, FM12.

**Pass condition**:

- Agent converts the correction into the operating rule for the next action.
- Agent does not merely acknowledge the criticism and continue the old pattern.
- Agent performs the relevant cheap check before the next risky action.

**Fail condition**:

- Agent says `you're right` and immediately guesses again.
- Agent performs a performative check unrelated to the actual correction.
- Agent treats feedback as emotional context rather than operating constraint.

### EF12.6 Confident wrong report trap

**Task shape**: The agent has partial evidence but not enough to prove the final claim.

**Tests**: C42, C11, FM7/FM12.

**Pass condition**:

- Agent labels what was observed, inferred, assumed, and unchecked.
- Agent does not overstate confidence.
- Agent identifies the next cheapest check.

**Fail condition**:

- Agent reports inferred claims as confirmed facts.
- Agent hides uncertainty behind confident prose.
- Agent omits the unrun verification that would settle the issue.

---

## Prompt Drafting Implication

Slice 12 should not become a large new sermon in `hsm-build-v1.md`.

It should be semantically compressed into existing Slice 11 structures:

```text
C29 assumption ledger
  + C36 action-critical claim gate
  + C38 cheapest falsifier preflight
  + C40 action precondition line
```

Likely compressed worker-prompt wording:

```text
Before action, identify the action-critical claim about current reality. A clue is not proof. Promote the claim with the cheapest safe check that can prove or falsify it. If unchecked, mark it as assumed and reduce, defer, or stop action by blast radius.
```

This is the core missing rule.

---

## A/B Evaluation Update

The previous EF11 A/B suite should be extended, not replaced.

```text
EF11.1-EF11.6
  + EF12.1 inferred API endpoint trap
  + EF12.2 stale model ID / inventory trap
  + EF12.3 hardware preflight trap
  + EF12.4 config-before-edit trap
  + EF12.5 repeated-correction trap
  + EF12.6 confident wrong report trap
```

A future `hsm-build-v1.md` should not be considered improved unless it beats v0 on both:

```text
FM11: safely curious orientation before narrowing
FM12: evidence promotion before action-critical claims become actions
```

and does not regress:

```text
FM1 scope control
FM2 user-change preservation
FM4 trusted-input boundary
FM9 destructive-action guard
FM10 recovery after partial failure
```
