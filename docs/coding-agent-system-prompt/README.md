# Coding Agent System Prompt Subproject

Status: active research workspace; canonical research consolidated through Slice 13  
Parent project: Human State Machine  
Related runtime/prior-art project: `h4rm0n1c/quantzhai`

## Purpose

This directory develops coding-agent system-prompt and runtime structures from observed behaviour, source comparisons, failure analysis, and local workflow evidence.

The goal is not to impose one hidden reasoning ritual. It is to provide a compact durable scaffold for:

- clear task framing;
- safely curious orientation;
- evidence promotion before action;
- closed-loop execution after action;
- authority, edit, and user-work boundaries;
- evidence-preserving recovery;
- honest validation and confidence-aware reporting;
- semantic compression without losing control flow.

Current worker model:

```text
user intent + repository/runtime state + tool contract + workflow scaffold
  -> orientation / territory mapping
  -> bounded investigation
  -> precondition / evidence-promotion gate
  -> one bounded state transition
  -> postcondition / dependent-action gate
  -> trusted-state update or recovery
  -> final validation
  -> concise report
```

## Current Research Conclusion

```text
orient before narrowing
verify the state that permits action
perform one bounded transition
verify the state produced before dependent action
if reality differs, preserve needed evidence and re-ground
validate the final result honestly
```

The key research distinction is:

```text
semantic coverage:
  a rule exists and can be explained

behavioural control:
  the rule changes the action at the relevant boundary
```

## Canonical Source Of Truth

Read these first:

1. [`RESEARCH_STATUS.md`](RESEARCH_STATUS.md) — current position and next phase.
2. [`candidate-structures.md`](candidate-structures.md) — canonical structures through C47.
3. [`research-failure-mode-catalog.md`](research-failure-mode-catalog.md) — canonical failure taxonomy through FM14.
4. [`prompt-evaluation-checklist.md`](prompt-evaluation-checklist.md) — canonical structural/behavioural checklist through Slice 13.
5. [`final-findings-synthesis.md`](final-findings-synthesis.md) — complete current synthesis through Slice 13.
6. [`research-plan.md`](research-plan.md) — canonical research methodology.
7. [`research-references.md`](research-references.md) — canonical source registry.

The accepted Slice 13 material is folded into those canonical files. No overlay composition is required.

## Provenance And Audit Trail

Detailed derivation remains available in:

- [`slice-13-closed-loop-execution.md`](slice-13-closed-loop-execution.md) — primary Slice 13 research;
- [`candidate-structures-slice-13-extension.md`](candidate-structures-slice-13-extension.md) — merged candidate-layer provenance;
- [`research-failure-mode-catalog-slice-13-extension.md`](research-failure-mode-catalog-slice-13-extension.md) — merged taxonomy provenance;
- [`prompt-evaluation-checklist-slice-13-extension.md`](prompt-evaluation-checklist-slice-13-extension.md) — merged checklist provenance;
- [`final-findings-synthesis-amendment-2026-06-23.md`](final-findings-synthesis-amendment-2026-06-23.md) — merged synthesis provenance;
- [`slice-13-consolidation-pass-2026-06-24.md`](slice-13-consolidation-pass-2026-06-24.md) — consolidation audit record.

These files explain how the conclusion was reached. Future prompt work should use the canonical files above.

## Failure Boundary

```text
FM7:
  assumption propagates through reasoning

FM12:
  unverified current-state claim authorizes action

FM13:
  unverified action result authorizes dependent action

FM14:
  diagnostic evidence is destroyed before recovery can use it
```

## Repository Roles

- **HSM**: methodology, research, state/control architecture, failure taxonomy, synthesis.
- **QuantZhai**: runtime, prompt assembly, compaction, harness, and local execution experiments.
- **NetTTS**: deterministic weighting/segmentation prior art where relevant.
- External prompts and papers: research inputs, not authority.

## Research Protocol

Each slice should include:

```text
research
  -> verification
  -> adversarial review
  -> correction
  -> conclusion with confidence
  -> placement and downstream integration
```

A candidate structure should identify:

- the invariant;
- the action boundary or state transition it controls;
- observable compliance;
- prompt/runtime/process placement;
- evidence for and against;
- non-regression and complexity risks;
- affected canonical documents.

## Current Supporting Documents

### Comparisons

- `comparison-quantzhai-codex-core-qwenified.md`
- `comparison-codex-cli-max.md`
- `comparison-claude-code.md`
- `comparison-opencode-*.md`
- `research-opencode-source-map.md`
- `comparison-opencode-runtime-assembly.md`
- `comparison-opencode-plan-mode.md`
- `comparison-opencode-agent-task-compaction.md`
- `research-opencode-vs-cli-family.md`
- `final-opencode-findings-synthesis.md`

### Existing evaluation material

- `evaluation-plan-ef11-ef12.md` — retained Slice 11/12 plan with an explicit Slice 13 scope boundary.

Dedicated EF13 fixture expansion was skipped by user direction. Closed-loop behaviour can still be assessed through the canonical checklist and real execution traces.

## Next Phase

The next task is prompt engineering from the consolidated research stack:

```text
canonical structures + failure taxonomy + checklist + synthesis
  -> coherent fat prototype
  -> semantic compression
  -> behavioural review
```

The earlier chat-produced v2 is a design probe, not the source of truth.