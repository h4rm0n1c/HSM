# Final Findings Synthesis Amendment: Safely Curious Coding Agents

Status: amendment to `final-findings-synthesis.md`  
Date: 2026-06-17  
Primary new slice: `slice-11-investigation-imperative.md`  
Prompt drafting: still paused pending candidate/eval updates.

## Amendment claim

The current synthesis remains correct that a coding-agent system is not one perfect prompt. It is a layered operating system around a worker model.

The correction is that the worker scaffold must include a positive investigation imperative before dense containment language.

The new rule:

```text
Containment is not enough.
A coding agent must be safely curious.
```

Safely curious means:

```text
orient before narrowing
check assumptions before acting
find the established project way before building a new one
surface relevant signal instead of hiding it as out-of-scope
then choose the smallest correct slice under explicit safety boundaries
```

## What changed

The previous synthesis emphasized:

- executor identity
- tool contract
- repo authority
- trusted input boundary
- task framing
- investigation scaffold
- edit-boundary scaffold
- validation scaffold
- runtime feedback
- final answer contract
- optional style/compression layer

That remains useful, but the ordering and emphasis need repair.

The agent needs this layer near the top:

```text
operating stance: active investigator over repo/project data
orientation and territory mapping
blast-radius-scaled curiosity
assumption check
surface-signal contract
```

Without that layer, `scope`, `minimal edit`, `stop`, and `inspect enough` are liable to collapse into defensive literalism.

## Why this matters

A prompt can be locally safe and globally weak.

The failed v0 behaviour showed this shape:

```text
safe executor -> obvious file -> minimum inspection -> narrow action/report
```

The corrected target is:

```text
active investigator -> system map -> assumptions and unknowns -> evidence
  -> bounded action -> validation -> concise signal report
```

This does not weaken edit boundaries. It makes the action slice better informed before the boundary is chosen.

## Updated architecture pattern

Previous compact worker stack:

```text
executor identity
  -> tool contract
  -> repo authority
  -> trusted input boundary
  -> task framing
  -> investigation scaffold
  -> edit-boundary scaffold
  -> validation scaffold
  -> runtime feedback acceptance
  -> final answer contract
  -> optional style/compression layer
```

Amended worker stack:

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

## Adopted research correction

Add a new failure mode:

```text
FM11: Premature Narrowing / Curiosity Collapse
```

Add candidate structures:

```text
C27 Investigator stance
C28 Orientation pass
C29 Assumption ledger
C30 Established-way discovery
C31 Surface signal over silence
C32 Path-to-action lock
C33 Fork judgment
C34 Minimal-to-correct, not minimal-to-green
C35 Safety placement correction
```

Add evaluation fixtures:

```text
EF11.1 Existing helper trap
EF11.2 Wrong path trap
EF11.3 Hidden config trap
EF11.4 Surface signal trap
EF11.5 Curiosity vs scope trap
EF11.6 Stop-too-early trap
```

## Source treatment

`Fable5.md` from `sgup/ai` is high-value external synthesis. It should influence structures, not be copied wholesale. Its transferable shapes are evidence labels, established-way discovery, baseline discipline, project-history grounding, fork judgment, green-gate-as-floor, and before-send self-audit.

`CLAUDE-FABLE-5.md` from `elder-plinius/CL4R1T4S` is an unverified external prompt dump. Treat it as capability-shape contrast only. Its useful signals are tool/capability scanning, file existence checks, current-info verification, and tool-use scaling. Do not import its product policy, wellbeing policy, broad guardrails, or static bulk into a coding-agent worker prompt.

## Prompt-build implication

The next build should not simply append more text to v0.

The right repair is:

1. Move positive operating stance above stop rules.
2. Compress duplicated containment text.
3. Replace `inspect enough` with blast-radius-scaled orientation.
4. Add a cheap assumption check before action.
5. Add surface-signal reporting.
6. Keep strict mutation, privilege, git, validation, and trusted-input boundaries.

The likely prompt delta is modest. The behavioural delta should be large.

## Confidence

Confidence: medium-high.

Evidence for:

- live DeepSeek V4 Flash feedback identified the same missing frames repeatedly
- `hsm-build-v0.md` really is dominated by stop, handoff, privilege, and minimal-scope language
- Fable5 distilled instructions supply stronger project-grounded judgment structures
- HSM anti-agreement doctrine already supports assumption checks and falsification
- OpenCode research already supports separate Explore/plan/build/runtime layers

Evidence against / unresolved:

- still needs fixture evaluation
- one model/session may exaggerate containment effects
- prompt-order effects need A/B testing
- too much curiosity wording can become research theatre or broad sweeps

## Decision

Adopt Slice 11 as a research correction.

Do not draft the final replacement prompt until candidate structures, failure-mode catalog, and evaluation checklist are updated or consciously deferred.
