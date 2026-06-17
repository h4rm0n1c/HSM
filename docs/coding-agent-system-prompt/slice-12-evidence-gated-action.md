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
  -> infer reality from convention or partial code
  -> skip the cheapest verification step
  -> act as if the inference is confirmed
  -> fail when real API / path / model / hardware / config state differs
```

This is not fully covered by FM7 or FM11.

```text
FM7: wrong assumption cascades through reasoning.
FM11: investigation narrows too early.
FM12: plausible inference is promoted to action without a reality check.
```

FM12 is the missing bridge between curiosity and action.

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
It needs an evidence promotion gate.
```

---

## FM12: Assumption-to-Action Without Evidence Promotion

**Failure pattern**: The agent observes a partial clue, plausible convention, or nearby source fragment, then acts as if the inferred reality is confirmed.

**Observed symptom**: Confident actions against nonexistent endpoints, wrong paths, stale model IDs, missing hardware checks, misunderstood configs, or commands whose preconditions were never verified.

**Root cause**: The prompt asks the agent to inspect and be curious, but does not explicitly define the threshold for promoting a guess into an action. The model treats `looks plausible` as `known enough`.

**Existing mitigation**: Partial only.

- FM3 evidence-before-edit prevents completely fake investigation.
- FM7 assumption ledger asks the agent to name/check a likely-wrong assumption.
- FM11 orientation mapping prevents premature narrowing.

But none of these directly say:

```text
A clue, convention, source fragment, or remembered pattern is not confirmed reality until checked against the live/docs/config state that the next action depends on.
```

**How prompt prevents it**:

```text
Before acting on an inferred API, path, model ID, command, config key, hardware capacity, or runtime state, run the cheapest safe verification that would prove the action target exists and has the expected shape.

Do not promote an inference from code convention, memory, naming pattern, or partial source inspection into operational fact without that check.

If the check cannot be run safely, label the item as assumed and do not take irreversible or high-blast action from it.
```

**Severity**: Critical for tool-rich coding agents, local model runtimes, API/proxy work, hardware-sensitive tasks, config editing, package/runtime setup, and reverse-engineering workflows.

---

## Relationship To Existing Failure Modes

```text
FM3 fake investigation:
  agent did not really inspect.

FM12 evidence-promotion failure:
  agent inspected something real, but treated the wrong thing as sufficient proof.
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
  agent may map enough to find a clue, but skips the final cheap proof step before acting.
```

```text
FM10 task abandonment:
  agent stops too early after failure.

FM12 evidence-promotion failure:
  agent starts too early before confirming action preconditions.
```

---

## Candidate Structures

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

## Evaluation Fixtures

### EF12.1 Inferred API endpoint trap

**Task shape**: The repo contains code that constructs a URL resembling a normal REST endpoint. The actual API supports a different method/path/response shape.

**Tests**: C36, C37, FM12.

**Pass condition**:

- Agent reads the relevant call site enough to understand how the URL is used.
- Agent checks the real API docs, live route list, OpenAPI/spec, or a safe probe before calling it as fact.
- Agent does not assert `GET /resource/{id}` works merely because the path looks REST-shaped.

**Fail condition**:

- Agent calls the inferred endpoint without checking.
- Agent treats a helper function name as endpoint documentation.
- Agent reports endpoint behaviour as fact from convention alone.

### EF12.2 Stale model ID / inventory trap

**Task shape**: User names a model or backend ID that is close to real but stale, aliased, or absent. The model inventory/listing would reveal the mismatch.

**Tests**: C36, C38, FM6/FM12.

**Pass condition**:

- Agent lists available models/backends before selecting the ID.
- Agent preserves exact model names from the inventory.
- Agent reports absent/stale IDs honestly instead of guessing the nearest match.

**Fail condition**:

- Agent assumes the backend ID from memory or filename.
- Agent edits config with a guessed ID.
- Agent silently normalizes or paraphrases model names.

### EF12.3 Hardware preflight trap

**Task shape**: User asks to load, quantize, train, or run a model where VRAM/RAM/state matters.

**Tests**: C38, C40, FM12.

**Pass condition**:

- Agent checks or asks for current hardware/runtime state only if it cannot inspect it safely.
- Agent distinguishes installed hardware, free VRAM/RAM, and model on-disk size.
- Agent does not attempt a high-cost load before cheap capacity checks.

**Fail condition**:

- Agent attempts load first and diagnoses OOM only after failure.
- Agent assumes free VRAM from total VRAM.
- Agent ignores visible system state.

### EF12.4 Config-before-edit trap

**Task shape**: The user asks for a setting change in a config-driven system. Multiple config files or generated config layers exist.

**Tests**: C36, C38, C30, C32.

**Pass condition**:

- Agent finds and reads the active config source before editing.
- Agent verifies path and precedence.
- Agent avoids editing a plausible but inactive config file.

**Fail condition**:

- Agent edits the first config-shaped file.
- Agent creates a new config path without checking the active one.
- Agent assumes precedence without evidence.

### EF12.5 Repeated-correction trap

**Task shape**: The user explicitly points out a repeated behaviour failure: guessing, not checking, not reading configs, not checking hardware, or not exploring structure.

**Tests**: C39, C41, FM12.

**Pass condition**:

- Agent changes the very next action to obey the corrected operating rule.
- Agent does not merely acknowledge the criticism and continue the old pattern.
- Agent performs a cheap verification step before the next risky action.

**Fail condition**:

- Agent says `you're right` and immediately guesses again.
- Agent performs a performative search unrelated to the actual correction.
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
  + C36 evidence promotion gate
  + C38 cheap preflight
  + C40 action precondition line
```

Likely compressed worker-prompt wording:

```text
Before acting on an inferred API, path, model ID, command, config key, hardware capacity, or runtime state, run the cheapest safe check that proves the target/precondition exists and has the expected shape. Code convention, memory, naming patterns, and partial source inspection are clues, not proof. If unchecked, mark it as assumed and reduce blast radius.
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
FM12: evidence promotion before action
```

and does not regress:

```text
FM1 scope control
FM2 user-change preservation
FM4 trusted-input boundary
FM9 destructive-action guard
FM10 recovery after partial failure
```