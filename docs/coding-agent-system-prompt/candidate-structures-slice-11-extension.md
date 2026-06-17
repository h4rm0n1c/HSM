# Candidate Prompt Structures — Slice 11 Extension

Status: integration extension  
Date: 2026-06-17  
Extends: `candidate-structures.md`  
Primary source: `slice-11-investigation-imperative.md`

## Purpose

This file integrates Slice 11 into the candidate-structure set without rewriting the large Slice 10 consolidation file.

The Slice 10 candidate set remains the base catalogue. This extension adds C27-C35, correcting the observed `hsm-build-v0.md` failure where the prompt optimized for containment more strongly than curiosity.

## Integration rule

When building the next prompt candidate, use:

```text
candidate-structures.md
  + candidate-structures-slice-11-extension.md
  + final-findings-synthesis-amendment-2026-06-17.md
```

Do not draft `hsm-build-v1.md` from `candidate-structures.md` alone.

## Architecture correction

The prompt stack should include a positive investigation layer near the top:

```text
executor identity
  -> active investigator stance
  -> authority and trusted-input boundary
  -> orientation / territory mapping
  -> blast-radius-scaled exploration
  -> tool and capability probing
  -> assumption check and source audit
  -> scoped action / edit boundaries
  -> validation and baseline discipline
  -> safety / escalation / irreversible-action gates
  -> final answer with surface-signal classification
  -> optional style/compression layer
```

This does not weaken safety. It moves curiosity before containment and places safety around mutation, escalation, and irreversible action.

---

## C27: Investigator stance

Decision: adopt with constraints.  
Layer: executor identity / task stance.  
Prompt cost: ~25 tokens.

```text
Be an active investigator before becoming an editor. For non-trivial or unfamiliar work, understand the system shape before narrowing to the obvious file. Curiosity informs scope; it does not erase it.
```

### Why

The existing executor identity says what the model is not: not human, not author, not subject. It does not say the positive stance the worker should inhabit. Without a positive stance, dense stop/permission/scope rules dominate.

### Risk

Can become research theatre if unbounded. Keep the trigger to non-trivial or unfamiliar work.

### Test

Run EF11.5. A low-blast task should get only a shallow check, not a broad sweep.

---

## C28: Orientation pass

Decision: adopt with blast-radius scaling.  
Layer: task framing / investigation scaffold.  
Prompt cost: ~55 tokens.

```text
Before acting in an unfamiliar repo or domain, map the territory: local rules, directory shape, manifests/configs, scripts, tests, existing helpers, and likely owning files. For low-blast tasks, do a shallow map. For high-blast or uncertain tasks, map deeper before editing.
```

### Why

This repairs the `inspect enough` failure. The agent needs a first step that asks what kind of system it is inside before affected-file narrowing.

### Risk

Can cause broad filesystem scanning. Bind to blast radius and stop mapping when the action slice is grounded.

### Test

Run EF11.2 and EF11.3. The agent should verify path/project shape and check relevant config before acting.

---

## C29: Assumption ledger

Decision: adopt lightly.  
Layer: investigation scaffold / before-send check.  
Prompt cost: ~35 tokens.

```text
Before acting, name the assumption most likely to be wrong and the cheapest check that would falsify it. If the check is cheap and safe, run it before editing. If not, mark the assumption in the report.
```

### Why

This converts meta-cognition into observable behaviour without forcing a long reasoning dump.

### Risk

Can add verbosity. Use for non-trivial, high-uncertainty, prior-failure, or high-blast tasks.

### Test

Run EF11.3. The hidden config should be found because the agent checks the assumption that the obvious file is sufficient.

---

## C30: Established-way discovery

Decision: adopt.  
Layer: repo/project authority / edit boundary.  
Prompt cost: ~30 tokens.

```text
Before adding a new helper, config path, command, schema, or workflow, look for the existing project way. Reuse or extend it unless evidence shows it is absent or broken.
```

### Why

The strongest transferable Fable5 distilled structure is not style; it is established-way discovery. It prevents parallel systems and needless reinvention.

### Risk

Can over-search. Limit it to things the task would create or alter.

### Test

Run EF11.1. Passing behaviour finds and reuses the existing helper rather than inventing a new one.

---

## C31: Surface signal over silence

Decision: test locally before global adoption.  
Layer: final answer contract / investigation scaffold.  
Prompt cost: ~45 tokens.

```text
If investigation reveals relevant signal outside the narrow requested change, surface it. Separate blockers, task-relevant findings, and optional follow-ups. Do not bury important evidence merely because it was not part of the first scope boundary.
```

### Why

The v0 scope rules can make the agent suppress useful discoveries. This tells the worker to preserve relevant signal without expanding into it.

### Risk

Can create noisy final reports. Require classification: `blocks task`, `affects confidence`, or `follow-up`.

### Test

Run EF11.4. The agent should complete the requested task and report the adjacent flaw as a follow-up, not silently ignore it and not fix it unasked.

---

## C32: Path-to-action lock

Decision: adopt.  
Layer: edit boundary.  
Prompt cost: ~25 tokens.

```text
Before editing, deleting, moving, or creating a file, verify the actual path and parent directory in the current workspace. Do not act from a remembered or assumed path.
```

### Why

Wrong-path action is a concrete failure. This is a cheap operational guard.

### Risk

Minimal. It adds one safe read/list step before mutation.

### Test

Run EF11.2. The user names a close-but-wrong path; the agent finds the real one before action.

---

## C33: Fork judgment

Decision: adopt with blast-radius scaling.  
Layer: planning / final answer contract.  
Prompt cost: ~45 tokens.

```text
At a meaningful fork, name the options, give the recommended path, and state why the alternatives lose. For low-blast reversible choices, decide and proceed. For high-blast or underspecified choices, ask with a recommendation.
```

### Why

This prevents both timid question loops and unilateral high-risk action.

### Risk

Can become a strategy essay for small tasks. Use only at meaningful forks.

### Test

Create a fixture where two implementation paths exist: one local and reversible, one architectural. Passing behaviour chooses the local path when sufficient and asks only for the architectural fork.

---

## C34: Minimal-to-correct, not minimal-to-green

Decision: test before adopting as static wording.  
Layer: implementation / validation.  
Prompt cost: ~40 tokens.

```text
A passing focused gate is the floor, not the goal. Within the chosen slice, make the touched behaviour actually correct. Do not expand scope, but do not stop at the smallest patch that merely silences the symptom.
```

### Why

This repairs `minimal edit` being misread as `minimum thought`.

### Risk

Can justify scope creep. It must remain bounded by the chosen slice.

### Test

Create a fixture where the smallest green patch hides an edge-case failure inside the touched slice. Passing behaviour fixes the slice correctly without broad refactor.

---

## C35: Safety placement correction

Decision: adopt as prompt architecture rule.  
Layer: prompt compilation / ordering.  
Prompt cost: neutral or negative if safety prose is compressed.

```text
Place positive operating stance and orientation before dense stop/privilege rules. Safety constrains action; it should not be the first and loudest description of the agent's job.
```

### Why

Models overweight early, concrete, repeated instruction blocks. If the prompt opens with hard stops and prohibitions, the worker identity becomes defensive and under-investigative.

### Risk

Do not weaken safety content. Reorder and compress it.

### Test

A/B `hsm-build-v0.md` against `hsm-build-v1.md` on EF11 fixtures. v1 should investigate more before narrowing without increasing unsafe actions.

---

## Updated recommendation summary

### Add to prompt text

| # | Rule | Cost | Priority |
|---|---|---:|---|
| C27 | Investigator stance | ~25 | high |
| C28 | Orientation pass | ~55 | critical for unfamiliar/high-uncertainty tasks |
| C29 | Assumption ledger | ~35 | high |
| C30 | Established-way discovery | ~30 | high |
| C31 | Surface signal over silence | ~45 | test |
| C32 | Path-to-action lock | ~25 | high |
| C33 | Fork judgment | ~45 | medium |
| C34 | Minimal-to-correct | ~40 | test |
| C35 | Safety placement correction | structural | critical |

Approximate new prompt-text cost if all C27-C34 are included: ~300 tokens. This is too large to append naively.

## Compression guidance

Do not append all Slice 11 wording to v0.

Instead:

1. Move C27/C28 near the top.
2. Merge C29 into the existing adversarial check.
3. Merge C30/C32 into the edit-boundary section.
4. Merge C31 into final answer contract.
5. Merge C33 into existing question/plan rules.
6. Merge C34 into validation/implementation.
7. Apply C35 by moving and compressing safety prose.

Expected net increase after compression: ~90-140 tokens, not ~300.

## Interaction conflicts

- C28 vs FM8 context overload: controlled by blast-radius scaling.
- C31 vs FM1 scope creep: controlled by classification as blocker / affects confidence / follow-up.
- C34 vs C2/M4 over-engineering guard: controlled by `within the chosen slice` wording.
- C35 vs S6 safety: no conflict if safety is preserved and moved closer to mutation/escalation rules.

## Prompt-build blocker

Do not build `hsm-build-v1.md` from the Slice 10 consolidated candidate set alone. Use this extension, then run the Slice 11 eval fixtures.
