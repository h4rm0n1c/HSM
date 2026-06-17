# Research Status: Coding Agent System Prompt Subproject

Summary: slices 0-12 are canonically integrated across candidate structures, failure modes, evaluation checklist, and final synthesis. I6 is now complete: `RESEARCH_STATUS.md`, `docs/coding-agent-system-prompt/README.md`, and `docs/README.md` point to the Slice 12 state and remove stale `through Slice 11` entry points. Candidate prompt drafting remains paused until the user explicitly resumes it.

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
I5 final synthesis rewrite          DONE
I6 status / index update            DONE
I7 evaluation preparation           NEXT
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
| 0-10 | Complete | earlier slice files | None |
| 11 | Canonically integrated / needs behavioural eval | `slice-11-investigation-imperative.md`, canonical C27-C35/FM11/EF11 material | Run EF11 A/B during I7 |
| 12 | Canonically integrated / needs behavioural eval | `slice-12-evidence-gated-action.md`, canonical C36-C42/FM12/EF12 material | Run EF12 A/B during I7 |
| smell audit | Applied through canonical files and indexes | `project-smell-audit-2026-06-17.md` | Use as guard against example leakage during future drafting |
| arXiv backing | I1A complete | `i1a-arxiv-backing-orientation-evidence-gating.md` | Use as evidence boundary; do not overclaim exact wording |
| integration pass | I6 complete | `canonical-integration-pass-2026-06-17.md`, updated indexes | Continue to I7 only |

---

## Active Artifacts

| File | Role |
|---|---|
| `canonical-integration-pass-2026-06-17.md` | Slice-by-slice integration controller. Current position: I7 evaluation preparation next. |
| `candidate-structures.md` | Canonical C1-C42 candidate structures. Use for future prompt drafting, but do not draft v1 yet. |
| `research-failure-mode-catalog.md` | Canonical FM1-FM12 failure catalog. |
| `prompt-evaluation-checklist.md` | Canonical checklist through EF12, including v0/v1 pass criteria. |
| `final-findings-synthesis.md` | Canonical synthesis through Slice 12: safely curious orientation plus evidence-gated action. |
| `slice-11-investigation-imperative.md` | Slice 11 research source/provenance. |
| `slice-12-evidence-gated-action.md` | Slice 12 research source/provenance. |
| `project-smell-audit-2026-06-17.md` | Bad-smell audit: noun-list-as-rule, example leakage, fixture leakage, sidecar drift, prompt/runtime boundary blur. |
| `i1a-arxiv-backing-orientation-evidence-gating.md` | Full-paper backing for Slice 11/12 structures and evaluation strategy. |
| `docs/coding-agent-system-prompt/README.md` | Subproject entry point, updated through Slice 12. |
| `docs/README.md` | Repo documentation front door, updated through Slice 12. |

Provenance sidecars remain for audit trail, but canonical material is in the main files above.

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

Slice 12 / smell-audit integration is complete at canonical document level:

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
  -> I5 final synthesis rewrite               DONE
  -> I6 status / index update                 DONE
  -> I7 evaluation preparation                NEXT
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

EF11/EF12 fixtures are canonical in the checklist but still behavioural-design level until actually run.

---

## Immediate Next Slice: I7

I7 must prepare evaluation without drafting a prompt:

```text
hsm-build-v0.md
  vs
future hsm-build-v1.md or equivalent revised prompt
```

I7 is done only when:

- EF11.1-EF11.6 and EF12.1-EF12.6 are ready to run as an A/B suite;
- critical non-regression fixtures are listed;
- v0 failure expectations are separated from v1 pass criteria;
- any future v1 success claim has a concrete pass threshold;
- no prompt draft is produced.

---

## Risk Register

- **Evaluation theatre**: do not claim v1 improvement until EF11/EF12 and non-regression fixtures are actually run.
- **Example leakage**: fixture nouns must not become baseline prompt wording.
- **Paper overclaim**: arXiv evidence supports structures and evaluation strategy, not exact v1 wording or guaranteed DeepSeek behaviour.
- **Prompt bloat**: Slice 11 and Slice 12 must be semantically merged, not appended wholesale.
- **Safety regression**: curiosity and evidence-gating do not weaken mutation, privilege, git, or irreversible-action boundaries.
- **Candidate prompt intentionally paused**: v1 drafting remains gated.
