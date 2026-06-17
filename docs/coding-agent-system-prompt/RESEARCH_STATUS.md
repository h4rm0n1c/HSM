# Research Status: Coding Agent System Prompt Subproject

Summary: slices 0-11 are canonically integrated. Slice 12 and the project smell audit are being integrated one layer at a time. I4 is now complete: `prompt-evaluation-checklist.md` is canonical through EF12, with C36-C42 checks, FM12 coverage, invariant-testing warnings, EF12.1-EF12.6 fixtures, and updated v0/v1 A/B criteria. Candidate prompt drafting remains paused until the user explicitly resumes it.

---

## Current Boundary

Do not produce `candidate-system-prompt-v0.md`, `hsm-build-v1.md`, or any equivalent replacement prompt yet.

Current integration position:

```text
I0 integration protocol             DONE
I1A arXiv backing slice             DONE
I1B research sidecar consolidation  DONE
I2 candidate-structures merge       DONE
I3 failure-mode catalog merge       DONE
I4 evaluation checklist merge       DONE
I5 final synthesis rewrite          NEXT
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
| 0-10 | Complete | earlier slice files, `final-findings-synthesis.md` | None |
| 11 | Canonically integrated / needs behavioural eval | `slice-11-investigation-imperative.md`, canonical C27-C35/FM11/EF11 material | Run EF11 A/B after integration pass |
| 12 | Candidate structures, failure catalog, and evaluation checklist merged / final synthesis pending | `slice-12-evidence-gated-action.md`, updated `candidate-structures.md`, updated `research-failure-mode-catalog.md`, updated `prompt-evaluation-checklist.md` | I5 final synthesis rewrite |
| smell audit | Applied through evaluation checklist / synthesis + index pending | `project-smell-audit-2026-06-17.md` | I5 abstraction cleanup |
| arXiv backing | I1A complete | `i1a-arxiv-backing-orientation-evidence-gating.md` | Use as evidence input for I5 |
| integration pass | I4 complete | `canonical-integration-pass-2026-06-17.md`, updated checklist | Continue to I5 only |

---

## Active Artifacts

| File | Role |
|---|---|
| `canonical-integration-pass-2026-06-17.md` | Current slice-by-slice integration controller. Read before touching canonical files. |
| `i1a-arxiv-backing-orientation-evidence-gating.md` | Full-paper arXiv backing for Slice 11/12 foundations: ReAct, CoVe, Self-RAG, Reflexion, STORM, SWE-agent, CheckList. |
| `slice-12-evidence-gated-action.md` | Research-layer source for action-critical world-state claim gate, clue-is-not-proof rule, FM12, C36-C42, EF12. |
| `project-smell-audit-2026-06-17.md` | Project-level audit of category-list-as-rule, example leakage, fixture leakage, sidecar drift, and prompt/runtime boundary blur. |
| `candidate-structures.md` | Canonical through Slice 12. Use as I5 source, but do not draft v1 yet. |
| `research-failure-mode-catalog.md` | Canonical through FM12. Use as I5 source. |
| `prompt-evaluation-checklist.md` | Canonical through EF12. Use as I5 source. |
| `candidate-structures-slice-12-extension.md` | Provenance sidecar for Slice 12 candidate structures; canonical material is now merged into `candidate-structures.md`. |
| `research-failure-mode-catalog-slice-12-extension.md` | Provenance sidecar for FM12; canonical material is now merged into `research-failure-mode-catalog.md`. |
| `prompt-evaluation-checklist-slice-12-extension.md` | Provenance sidecar for EF12; canonical material is now merged into `prompt-evaluation-checklist.md`. |
| `final-findings-synthesis.md` | Canonical through Slice 11 only. Must be rewritten next. |

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
  -> I2 candidate-structures merge            DONE
  -> I3 failure-mode catalog merge            DONE
  -> I4 evaluation checklist merge            DONE
  -> I5 final synthesis rewrite               NEXT
  -> I6 status / index update                 PENDING
  -> EF12 behavioural fixtures                DESIGN-LEVEL READY
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

EF12 fixtures are now canonical in the checklist but still behavioural-design level until actually run.

---

## Immediate Next Slice: I5

I5 must update only the canonical final synthesis:

```text
final-findings-synthesis.md
```

I5 is done only when:

- status/source are updated through Slice 12;
- core thesis becomes `safely curious + evidence-gated action`;
- FM12 and C36-C42 are integrated into the architecture, not appended;
- list-shaped example wording is repaired where it would leak into prompt text;
- final synthesis no longer says the next step is only EF11 or only Slice 11 work;
- no prompt draft is produced.

---

## Risk Register

- **Giant rewrite relapse**: trying to rewrite synthesis, status, indexes, and prompt in one pass will recreate the failure mode at project scale.
- **Sidecar drift**: stale extension docs can reintroduce old noun-list wording.
- **Example leakage**: fixture nouns must not become baseline prompt wording.
- **Paper overclaim**: arXiv evidence supports structures and evaluation strategy, not exact v1 wording or guaranteed DeepSeek behaviour.
- **Prompt bloat**: Slice 11 and Slice 12 must be semantically merged, not appended wholesale.
- **Safety regression**: curiosity and evidence-gating do not weaken mutation, privilege, git, or irreversible-action boundaries.
- **Candidate prompt intentionally paused**: v1 drafting remains gated.
