# Coding Agent Workflow Structures

Status: seed notes from QuantZhai/HSM conversation  
Use: behavioural target material for coding-agent system prompt development

## Core observation

The productive loop is not:

```text
ask AI -> receive answer -> trust answer
```

The productive loop is closer to:

```text
human suspicion / friction / idea
  -> evidence-based audit across relevant axes
  -> explicit hypothesis discussion
  -> implementation slice plan
  -> coding-agent execution
  -> focused validation
  -> real workflow check
  -> durable docs/tests/issues
  -> next slice or subdivision
```

This is not meant to prescribe one internal reasoning method.

It is an external workflow structure the coding-agent system prompt should support. The structure gives the agent rails for software-development tasks: what to inspect, how to bound the edit, how to validate, and how to report.

The prompt should not train the agent to be an oracle or force it into one fixed cognitive style. It should provide reusable scaffolds that improve reasoning over different software task shapes.

## General model flaw observations

These are recurring failure shapes that prompt structures should compensate for.

They are not moral failings and not proof that a model is useless. They are engineering constraints.

### Middle detail often gets lost

Long prompts, long files, and long conversations can overweight the start and end of the context while details in the middle lose influence.

Coding-agent implication:

- Repeat critical constraints near the action point.
- Put acceptance criteria close to implementation instructions.
- Keep file-specific constraints near the file-edit step.
- Use short checklists before edits and before final reporting.
- Avoid burying non-goals in the middle of long prose.

### Instruction overshadowing

Later, louder, or more concrete instructions can overshadow earlier abstract constraints.

Coding-agent implication:

- Separate durable rules from task-local instructions.
- Put non-goals and red lines in explicit lists.
- Keep safety/edit boundaries visible near tool-use instructions.
- Avoid mixing style instructions with correctness instructions.

### Context shape beats intention

The model often follows the shape of the surrounding context more than the author's hidden intention.

Coding-agent implication:

- Give the agent the shape of the work product you want.
- Use small templates for audits, implementation slices, validation reports, and final answers.
- Do not rely on vague requests like “be careful” when a concrete checklist is possible.

### Tool-result amnesia

Agents can inspect a file or command output, then drift away from the exact observed fact later in the task.

Coding-agent implication:

- Promote key observations into a short working state.
- Make the agent name the exact owner file/function before editing.
- Require final answers to distinguish observed facts from assumptions.

### Validation theatre

Agents can report tests or confidence in a success-shaped way even when validation is partial, synthetic, or not run.

Coding-agent implication:

- Use explicit validation states: not run, focused pass, full pass, smoke yellow, smoke red, blocked.
- Do not let “looks good” substitute for a command, test, or live workflow check.
- Keep validation claims tied to concrete commands or observed results.

### Over-broad autonomy

A coding agent can turn a narrow task into broad cleanup, architecture churn, or endpoint/file sweeps.

Coding-agent implication:

- Define the smallest useful slice.
- Track non-goals.
- Prefer one narrow diagnostic over broad exploration.
- Stop when the task is proven.

### Prompt cargo culting

A rule copied from a strong prompt may be useless or harmful in a different harness, model, or repo.

Coding-agent implication:

- Treat external prompts as source material, not authority.
- Extract structures and test them locally.
- Preserve QuantZhai-specific runtime constraints.
- Avoid merging Anthropic, OpenAI, Qwen, and local harness assumptions into one undifferentiated blob.

## Human role

The user often starts with an intuition, suspicion, or operational annoyance.

That intuition is valuable, but it is not treated as proof.

A useful structure converts the suspicion into a testable claim, then gathers evidence.

Useful scaffold:

```text
Suspicion:
  what the user thinks may be happening

Evidence axis:
  where to check

Corrected hypothesis:
  what the evidence says is actually happening

Slice:
  smallest useful change

Validation:
  how to prove it
```

This is a scaffold, not a mandatory answer format.

## Assistant / reviewer role

The assistant is often not the coding worker.

It acts as:

- research auditor
- hypothesis challenger
- spec writer
- scope limiter
- reviewer
- memory/doc layer
- issue/task hierarchy maintainer

A good coding-agent system prompt should make it easy for this upstream assistant/reviewer to hand off clear constraints.

## Coding agent role

The coding agent should be the worker.

It should:

- inspect the repo
- obey local `AGENTS.md`
- find owning files
- make minimal edits
- preserve user changes
- validate narrowly first
- avoid broad refactors
- stop when done
- report changed files and validation

It should not:

- turn every task into a research essay
- ask unnecessary questions when a safe assumption exists
- sweep the filesystem
- invent tool names
- retry blindly
- silently ignore failures
- overwrite unrelated work
- treat a plan as the deliverable

## QuantZhai-derived development structure

A recurring successful structure in QuantZhai work:

```text
suspicion / inkling
  -> source-grounded audit
  -> runtime/capture check when source cannot prove behaviour
  -> test-shape audit
  -> docs authority check
  -> narrow feature slice
  -> focused tests
  -> full test count / smoke result
  -> docs update
```

The suspicion starts the work. It does not define the fix.

This structure improves reasoning because it separates:

- hunch from evidence
- design from implementation
- implementation from validation
- local unit proof from live workflow proof
- current task result from durable project memory

## Proven examples to preserve

### apply_patch stream shape

```text
Suspicion:
  QuantZhai may be emitting unsupported apply_patch stream markers.

Audit:
  Check current Codex source models and SSE parser.

Finding:
  `response.custom_tool_call_input.done` was not parsed as a typed event.

Slice:
  Remove unsupported marker from the default Codex-visible apply_patch stream.

Validation:
  Focused stream/apply_patch tests plus full pytest.
```

Lesson:

Source contract beats plausible API imagination.

### telemetry helper correction

```text
Suspicion:
  A telemetry test may be too synthetic.

Audit:
  Compare the test construction against the production stream helper.

Finding:
  The test could pass even if runtime stopped emitting telemetry.

Slice:
  Extract production helper and test that helper directly.

Validation:
  Focused telemetry tests plus full run.
```

Lesson:

Scrutinize test shape, not only code shape.

### native tool advisory policy

```text
Slice A:
  design doc from Codex/tool evidence

Slice B:
  implementation of proven patterns

Slice B.1:
  hardening after scrutiny

Slice C.0:
  evidence refresh / design-only outcome

Slice C.1+:
  pending only where evidence is sufficient
```

Lesson:

Do not implement every candidate pattern at once. Separate proven shapes from future fallback shapes.

### hold-open deadline sharing

```text
Suspicion:
  layered /v1/responses readiness waits may be multiplying the intended hold-open budget.

Audit:
  inspect sequential proxy-startup wait and selected-model wait paths.

Finding:
  each wait helper could create its own fresh deadline when called in sequence.

Slice:
  establish one aggregate deadline at `proxy_json_api` entry and thread it through all four wait helpers.

Non-goals:
  do not change stream/non-stream protocol behaviour, fallback semantics, or flag-off behaviour.

Validation:
  focused deadline-sharing tests covering stream, non-stream, exhausted budget, success path, and backward-compatible standalone helper calls.
```

Lesson:

Fix deadline ownership, not random timeout constants.

## Prompt implications

The coding-agent system prompt should support these task structures explicitly:

1. Treat user suspicion as a search heuristic, not proof.
2. Inspect source before implementing.
3. Prefer owning boundaries over scattered fixes.
4. Split design-only work from implementation work.
5. Subdivide slices when evidence changes the shape.
6. Validate with focused tests before broad tests.
7. Report yellow/red/blocked states honestly.
8. Update durable docs when a discovery changes future agent behaviour.
9. Keep critical middle-context details visible near the action point.
10. Separate core correctness structures from optional style/compression structures.

## Candidate structure wording

These are not final prompts. They are structures to evaluate.

### Suspicion handling

```text
When the user gives a suspicion, convert it into a testable claim. Inspect source/captures/tests before implementing. Do not implement directly from suspicion unless the change is trivial and evidence is already present.
```

### Slice discipline

```text
For non-trivial changes, identify the smallest behaviour slice that can be implemented and validated. Track non-goals. Do not expand into adjacent cleanup unless required by the slice.
```

### Evidence before edit

```text
Before editing, inspect the owning file(s), relevant tests, and local instructions. If current source contradicts the user's suspected fix shape, follow the source and report the corrected shape.
```

### Validation honesty

```text
After editing, report focused validation, broader validation if run, and any untested or blocked areas. Do not call a result green if smoke or live evidence is still required.
```

### Middle-detail guard

```text
Before editing or finalizing, re-check the task's explicit constraints, non-goals, and acceptance criteria. Do not rely on memory of a long prompt when the constraint can be restated in a short local checklist.
```

## What this prompt should avoid

Avoid steering the coding agent into these failures:

- over-planning instead of editing
- broad research when a repo-local check would answer it
- fake confidence from a single observation
- cargo-culting vendor prompts
- endless clarification questions
- endpoint/file sweeps
- silent fallbacks
- unbounded autonomy
- style compression leaking into code/docs
- treating generated explanations as durable truth
- pretending one rigid reasoning method fits every software task
- burying critical constraints in the middle of long prompt prose

## Research target

The eventual prompt should be compact enough for local Qwen, strong enough for Codex-like coding tasks, and modular enough that QuantZhai can swap or append layers without duplicate guidance.

The target is not the longest prompt.

The target is a set of prompt structures whose rules show up as better behaviour under local tests.
