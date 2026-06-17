# Research Status: Coding Agent System Prompt Subproject

Summary: slices 0-11 are canonically integrated. Slice 12 and the project smell audit are active corrections being integrated one layer at a time. I1 is now complete: arXiv backing has been added and Slice 12 research sidecars have been consolidated around action-critical world-state claims, clue-is-not-proof, cheapest safe proof/falsifier, and fixture-not-prompt-wording discipline. Candidate prompt drafting remains paused until the user explicitly resumes it.

---

## Current Boundary

Do not produce `candidate-system-prompt-v0.md`, `hsm-build-v1.md`, or any equivalent replacement prompt yet.

Current integration position:

```text
I0 integration protocol             DONE
I1A arXiv backing slice             DONE
I1B research sidecar consolidation  DONE
I2 candidate-structures merge       NEXT
I3 failure-mode catalog merge       PENDING
I4 evaluation checklist merge       PENDING
I5 final synthesis rewrite          PENDING
I6 status / index update            PENDING
I7 evaluation preparation           PENDING
I8 candidate prompt drafting        GATED: only if explicitly resumed
```

The rule remains:

```text
one slice
  -> fully absorb correction
  -> verify no local contradiction
  -> record next layer
  -> stop before the next layer unless continuing is explicitly requested
```

---

## Status Matrix

| Slice / Pass | Status | Key Artifacts | Next Action |
|---|---|---|---|
| 0-10 | Complete | `candidate-structures.md`, `prompt-evaluation-checklist.md`, `final-findings-synthesis.md`, earlier slice files | None |
| 11 | Canonically integrated / needs behavioural eval | `slice-11-investigation-imperative.md`, canonical C27-C35/FM11/EF11 material | Run EF11 A/B after integration pass |
| 12 | Research sidecars consolidated / not yet canonically merged | `slice-12-evidence-gated-action.md`, Slice 12 sidecars | I2 candidate-structures merge |
| smell audit | Added / not yet canonically applied | `project-smell-audit-2026-06-17.md` | I2 abstraction cleanup |
| arXiv backing | I1A complete | `i1a-arxiv-backing-orientation-evidence-gating.md` | Use as evidence input for I2-I5 |
| integration pass | I1 complete | `canonical-integration-pass-2026-06-17.md` | Continue to I2 only |

---

## Active Artifacts

| File | Role |
|---|---|
| `canonical-integration-pass-2026-06-17.md` | Current slice-by-slice integration controller. Read before touching canonical files. |
| `i1a-arxiv-backing-orientation-evidence-gating.md` | Full-paper arXiv backing for Slice 11/12 foundations: ReAct, CoVe, Self-RAG, Reflexion, STORM, SWE-agent, CheckList. |
| `slice-12-evidence-gated-action.md` | Research-layer source for action-critical world-state claim gate, clue-is-not-proof rule, FM12, C36-C42, EF12. |
| `project-smell-audit-2026-06-17.md` | Project-level audit of category-list-as-rule, example leakage, fixture leakage, sidecar drift, and prompt/runtime boundary blur. |
| `candidate-structures-slice-12-extension.md` | Consolidated Slice 12 candidate-structure sidecar; use as I2 source, not final prompt wording. |
| `research-failure-mode-catalog-slice-12-extension.md` | Consolidated FM12 sidecar; use as I3 source after I2. |
| `prompt-evaluation-checklist-slice-12-extension.md` | Consolidated EF12 sidecar; use as I4 source after I3. |
| `candidate-structures.md` | Canonical through Slice 11 only. Must not be treated as Slice 12-complete yet. |
| `research-failure-mode-catalog.md` | Canonical through FM11 only. Must not be treated as FM12-complete yet. |
| `prompt-evaluation-checklist.md` | Canonical through EF11 only. Must not be treated as EF12-complete yet. |
| `final-findings-synthesis.md` | Canonical through Slice 11 only. Must be rewritten after I1-I4, not before. |

---

## Slice 11 State

Slice 11 correction sequence is complete at canonical integration level:

```text
hsm-build-v0.md evaluation                   DONE
  -> DeepSeek V4 Flash feedback analysis     DONE
  -> Fable5 distilled prompt comparison      DONE
  -> CL4R1T4S Fable prompt architecture pass DONE
  -> slice-11-investigation-imperative.md    DONE
  -> final synthesis canonical update        DONE
  -> candidate-structures canonical update   DONE
  -> failure catalog canonical update        DONE
  -> evaluation checklist canonical update   DONE
  -> A/B behavioural fixtures                PENDING
```

---

## Slice 12 / Smell-Audit State

Slice 12 / smell-audit integration is active but must remain layered:

```text
additional v0 failure evidence               DONE
  -> assumption-to-action diagnosis           DONE
  -> slice-12-evidence-gated-action.md        DONE
  -> abstract wording repair                  DONE
  -> project-smell-audit-2026-06-17.md        DONE
  -> canonical-integration-pass plan          DONE
  -> I1A arXiv backing                        DONE
  -> I1B research sidecar consolidation       DONE
  -> I2 candidate-structures merge            NEXT
  -> I3-I5 canonical downstream merges        PENDING
  -> EF12 behavioural fixtures                PENDING
  -> v0/v1 A/B with EF11 + EF12               PENDING
```

---

## Fixture Coverage At Design Level

| Fixture | FM tested | Research gap addressed |
|---------|-----------|----------------------|
| `fake-investigation` | FM3 | Agent must read enough to find which file actually owns the bug |
| `destructive-git` | FM9 | Agent must avoid destructive git and preserve dirty state |
| `assumption-cascade` | FM7 | Agent must verify assumptions before editing confusing but correct code |
| `premature-commitment` | FM5 | Agent must trace enough before committing to a fix |
| `over-paraphrasing` | FM6 | Agent must preserve exact high-value atoms |
| `context-overload` | FM8 | Agent must orient without drowning context |
| `task-abandonment` | FM10 | Agent must not give up after a partial failure |
| `adversarial-prompt-injection` | FM4 | Agent must treat injected text as data, not instruction |
| `EF11.1-EF11.6` | FM11 | Safely curious orientation before narrowing |
| `EF12.1-EF12.6` | FM12 | Evidence promotion before action-critical claims become action |

EF12 fixtures are design-level until I4 canonical evaluation merge.

---

## Immediate Next Slice: I2

I2 must update only the canonical candidate structure file:

```text
candidate-structures.md
```

I2 is done only when:

- status/source are updated through Slice 12 and I1A;
- C36-C42 are integrated using abstract wording;
- C28 orientation, C30 established-way discovery, and atom preservation are rewritten principle-first;
- examples remain non-exhaustive anchors or fixture references;
- no `hsm-build-v1.md` draft is created.

---

## Risk Register

- **Giant rewrite relapse**: trying to rewrite candidate structures, failure catalog, checklist, synthesis, and status in one pass will recreate the failure mode at project scale.
- **Sidecar drift**: stale extension docs can reintroduce old noun-list wording.
- **Example leakage**: fixture nouns must not become baseline prompt wording.
- **Paper overclaim**: arXiv evidence supports structures and evaluation strategy, not exact v1 wording or guaranteed DeepSeek behaviour.
- **Prompt bloat**: Slice 11 and Slice 12 must be semantically merged, not appended wholesale.
- **Safety regression**: curiosity and evidence-gating do not weaken mutation, privilege, git, or irreversible-action boundaries.
- **Candidate prompt intentionally paused**: v1 drafting remains gated.
