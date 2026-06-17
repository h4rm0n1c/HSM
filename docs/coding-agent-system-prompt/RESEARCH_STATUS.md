# Research Status: Coding Agent System Prompt Subproject

Summary: slices 0-12 are canonically integrated across candidate structures, failure modes, evaluation checklist, final synthesis, indexes, and evaluation preparation. I7 is now complete: `evaluation-plan-ef11-ef12.md` defines how to test `hsm-build-v0.md` and a future v1 against EF11, EF12, and critical non-regression fixtures. Candidate prompt drafting remains paused until the user explicitly resumes it.

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
I7 evaluation preparation           DONE
I8 candidate prompt drafting        GATED: only if explicitly resumed
```

---

## Status Matrix

| Slice / Pass | Status | Key Artifacts | Next Action |
|---|---|---|---|
| 0-10 | Complete | earlier slice files | None |
| 11 | Canonically integrated / needs behavioural eval | `slice-11-investigation-imperative.md`, canonical C27-C35/FM11/EF11 material | Run EF11 A/B during evaluation |
| 12 | Canonically integrated / needs behavioural eval | `slice-12-evidence-gated-action.md`, canonical C36-C42/FM12/EF12 material | Run EF12 A/B during evaluation |
| smell audit | Applied through canonical files and indexes | `project-smell-audit-2026-06-17.md` | Use as guard against example leakage during future drafting |
| arXiv backing | I1A complete | `i1a-arxiv-backing-orientation-evidence-gating.md` | Use as evidence boundary; do not overclaim exact wording |
| integration pass | I7 complete | `canonical-integration-pass-2026-06-17.md`, `evaluation-plan-ef11-ef12.md` | I8 only if user explicitly resumes candidate prompt drafting |

---

## Active Artifacts

| File | Role |
|---|---|
| `canonical-integration-pass-2026-06-17.md` | Slice-by-slice integration controller. Current position: I7 complete; I8 gated. |
| `candidate-structures.md` | Canonical C1-C42 candidate structures. Use for future prompt drafting, but do not draft v1 yet. |
| `research-failure-mode-catalog.md` | Canonical FM1-FM12 failure catalog. |
| `prompt-evaluation-checklist.md` | Canonical checklist through EF12, including v0/v1 pass criteria. |
| `evaluation-plan-ef11-ef12.md` | I7 behavioural A/B plan for v0/future-v1 across EF11, EF12, and non-regression fixtures. |
| `final-findings-synthesis.md` | Canonical synthesis through Slice 12: safely curious orientation plus evidence-gated action. |
| `slice-11-investigation-imperative.md` | Slice 11 research source/provenance. |
| `slice-12-evidence-gated-action.md` | Slice 12 research source/provenance. |
| `project-smell-audit-2026-06-17.md` | Bad-smell audit: noun-list-as-rule, example leakage, fixture leakage, sidecar drift, prompt/runtime boundary blur. |
| `i1a-arxiv-backing-orientation-evidence-gating.md` | Full-paper backing for Slice 11/12 structures and evaluation strategy. |
| `docs/coding-agent-system-prompt/README.md` | Subproject entry point, updated through I7. |
| `docs/README.md` | Repo documentation front door, updated through I7. |

Provenance sidecars remain for audit trail, but canonical material is in the main files above.

---

## Integrated Correction State

```text
slices 0-10                                DONE
  -> Slice 11 safely curious orientation    DONE
  -> Slice 12 evidence-gated action         DONE
  -> smell-audit abstraction repair         DONE
  -> I1 research sidecar consolidation      DONE
  -> I2 candidate structures merge          DONE
  -> I3 failure catalog merge               DONE
  -> I4 evaluation checklist merge          DONE
  -> I5 final synthesis rewrite             DONE
  -> I6 status / index update               DONE
  -> I7 evaluation preparation              DONE
  -> I8 candidate prompt drafting           GATED
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

EF11/EF12 fixtures are canonical in the checklist and operationalized in `evaluation-plan-ef11-ef12.md`, but still need actual behavioural runs.

---

## Immediate Next Choices

The project is back on track at the research layer. Next useful choices are:

1. **Run v0 evaluation first** using `evaluation-plan-ef11-ef12.md`.
2. **Resume candidate drafting explicitly** and create a future `hsm-build-v1.md`, then run v0/v1 A/B.
3. **Prepare fixture files/scripts** if evaluation should be automated rather than manual.

Do not draft v1 unless the user explicitly resumes candidate prompt work.

---

## Risk Register

- **Evaluation theatre**: do not claim v1 improvement until EF11/EF12 and non-regression fixtures are actually run.
- **Example leakage**: fixture nouns must not become baseline prompt wording.
- **Paper overclaim**: arXiv evidence supports structures and evaluation strategy, not exact v1 wording or guaranteed DeepSeek behaviour.
- **Prompt bloat**: Slice 11 and Slice 12 must be semantically merged, not appended wholesale.
- **Safety regression**: curiosity and evidence-gating do not weaken mutation, privilege, git, or irreversible-action boundaries.
- **Candidate prompt intentionally paused**: v1 drafting remains gated.
