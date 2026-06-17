# Failure Mode Catalog — Slice 11 Extension

Status: integration extension  
Date: 2026-06-17  
Extends: `research-failure-mode-catalog.md`  
Primary source: `slice-11-investigation-imperative.md`

## Purpose

This file integrates Slice 11 into the failure-mode catalog without rewriting the existing FM1-FM10 document.

Use this file together with `research-failure-mode-catalog.md` until the catalog is next consolidated.

## New failure mode

### FM11: Premature Narrowing / Curiosity Collapse

**Failure pattern**: The agent narrows to the obvious file, obvious command, or obvious answer before mapping enough of the project/system to know whether that target is actually sufficient.

**Observed symptom**: The agent behaves safely but shallowly. It reads one file, identifies a plausible change, and proceeds or reports without checking project layout, configs, scripts, tests, existing helpers, local rules, domain tools, or adjacent signal that would change the answer.

**Root cause**: The prompt over-emphasizes containment, stop triggers, minimal edits, privilege boundaries, and terminal handoffs while under-specifying active investigation. `Inspect enough` becomes `inspect the smallest thing that lets me proceed`.

**Existing mitigation**: Partial only. Existing structures cover evidence-before-edit, pre-edit checklists, anti-agreement final checks, and project-rule authority. They do not force an orientation phase before affected-file narrowing.

**How prompt prevents it**:

```text
For non-trivial or unfamiliar work, orient before narrowing.
Map local rules, project shape, manifests/configs, scripts, tests, existing helpers, and likely owning files.
Name the assumption most likely to be wrong and run the cheapest safe check before editing.
Surface relevant signal as blocker / affects confidence / follow-up instead of suppressing it as out-of-scope.
Scale exploration by blast radius so curiosity does not become broad wandering.
```

**Severity**: High for unfamiliar repos, reverse engineering, tool-rich environments, debugging, integration work, and tasks where the user's suspicion is approximate. Medium for small familiar one-file edits.

## Relation to existing failure modes

FM11 overlaps with but is distinct from:

- **FM3: Hallucinated Plans / Fake Investigation** — FM3 is about pretending to inspect. FM11 is about inspecting something real but too narrowly.
- **FM5: Premature Output Commitment** — FM5 is about committing to an approach too early. FM11 is the upstream cause: failure to orient before the first approach is chosen.
- **FM7: Silent Assumption Cascade** — FM7 is about unverified assumptions compounding. FM11 is a project-mapping failure that allows the wrong assumptions to form.
- **FM8: Context Window Overload** — FM8 guards against too much investigation. FM11 guards against too little. The balancing mechanism is blast-radius scaling.
- **FM1: Scope Creep / Over-Engineering** — FM1 prevents doing too much. FM11 prevents understanding too little. Surface-signal classification separates reporting from expanding scope.

## Prompt structures that mitigate FM11

| Structure | Role |
|---|---|
| C27 Investigator stance | Sets positive stance: active investigator before editor |
| C28 Orientation pass | Adds territory mapping before narrowing |
| C29 Assumption ledger | Forces cheap falsification before action |
| C30 Established-way discovery | Prevents reinventing project-local patterns |
| C31 Surface signal over silence | Prevents hiding relevant adjacent findings |
| C32 Path-to-action lock | Prevents acting on assumed paths |
| C33 Fork judgment | Prevents both timidity and unilateral risky decisions |
| C34 Minimal-to-correct | Prevents minimal-to-green patches inside the chosen slice |
| C35 Safety placement correction | Keeps curiosity before containment in prompt order |

## Summary table extension

Append this row to the summary table in `research-failure-mode-catalog.md`:

| FM | Pattern | Currently prevented? |
|---|---|---|
| FM11 | Premature narrowing / curiosity collapse | No in `hsm-build-v0`; planned via Slice 11 C27-C35 |

## Evaluation mapping

| Fixture | FM tested | Research gap addressed |
|---|---|---|
| EF11.1 Existing helper trap | FM11 / FM1 | Finds established project way without scope creep |
| EF11.2 Wrong path trap | FM11 / FM3 | Verifies real path before action |
| EF11.3 Hidden config trap | FM11 / FM7 | Checks configs/manifests before trusting obvious file |
| EF11.4 Surface signal trap | FM11 / FM1 | Reports adjacent signal without expanding into it |
| EF11.5 Curiosity vs scope trap | FM11 / FM8 | Scales orientation and avoids research theatre |
| EF11.6 Stop-too-early trap | FM11 / FM9 | Continues safe read-only investigation before stopping at mutation boundary |

## Integration status

This extension makes FM11 available for prompt building and evaluation immediately.

Next consolidation pass may merge this directly into `research-failure-mode-catalog.md`.
