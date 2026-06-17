# Research Status: Coding Agent System Prompt Subproject

Summary: slices 0-11 are canonically integrated. Slice 12 has now been added as a new correction after further `hsm-build-v0.md` behavioural evidence showed a distinct failure: the worker promotes plausible inferences into action without a cheap reality check. Candidate prompt drafting remains paused until the user explicitly resumes it, but the research corpus now has the missing evidence-promotion rule and EF12 fixture suite captured.

---

## Status Matrix

| Slice | Status | Key Artifacts | Next Action |
|---|---|---|---|
| 0 | Complete | `internal-project-references.md`, `research-references.md` | None |
| 1 | Complete | `slice-1-arbitration-loop.md`, C1-C5 | None |
| 2 | Complete | `slice-2-anti-agreement-self-critique.md`, C6-C11 | None |
| 3 | Complete | `slice-3-context-position-middle-loss.md`, C12-C16 | None |
| 4 | Complete | `slice-4-promptware-lifecycle.md`, C17-C22 | None |
| 5 | Complete | `slice-5-identity-role-and-executor-boundaries.md`, C23-C26 | None |
| 6 | Complete | `slice-6-safety-untrusted-instructions.md`, S6-1 through S6-4 | None |
| 7 | Complete | `slice-7-tool-stream-state-feedback.md`, S7-1 through S7-6 | None |
| 8 | Complete | `slice-8-compaction-preservation.md`, S8-1 through S8-3 | None |
| 9 | Complete | `research-external-prompt-comparison.md` | None |
| 10 | Complete | `candidate-structures.md`, `prompt-evaluation-checklist.md`, `final-findings-synthesis.md` | Use canonical versions; no extension-only dependency |
| 11 | Canonically integrated / needs behavioural eval | `slice-11-investigation-imperative.md`, updated `candidate-structures.md`, updated `research-failure-mode-catalog.md`, updated `prompt-evaluation-checklist.md`, updated `final-findings-synthesis.md` | Run EF11.1-EF11.6 A/B against v0/v1 |
| 12 | Added as correction / needs canonical merge + behavioural eval | `slice-12-evidence-gated-action.md` | Merge C36-C42/FM12/EF12 into canonical files before drafting v1; run EF12.1-EF12.6 A/B |

---

## Current Boundary

Candidate prompt drafting is paused.

Do not produce `candidate-system-prompt-v0.md`, `hsm-build-v1.md`, or any equivalent replacement prompt until the user explicitly resumes candidate prompt work.

Any future prompt build must use the canonical Slice 11-integrated files **plus** the Slice 12 correction:

```text
candidate-structures.md
research-failure-mode-catalog.md
prompt-evaluation-checklist.md
final-findings-synthesis.md
slice-12-evidence-gated-action.md
```

Slice 12 is not yet fully canonically merged into the large consolidated files. It is an active correction document that must be merged before a serious `hsm-build-v1.md` draft.

The OpenCode resynthesis sequence is complete at research level:

```text
OpenCode source map                          DONE
  -> OpenCode runtime assembly comparison    DONE
  -> OpenCode plan-mode comparison           DONE
  -> OpenCode task/subagent comparison       DONE
  -> OpenCode vs CLI-family synthesis        DONE
  -> update final-findings-synthesis.md      DONE
```

The Slice 11 correction sequence is complete at canonical integration level:

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

The Slice 12 correction sequence is active:

```text
additional v0 failure evidence               DONE
  -> assumption-to-action diagnosis           DONE
  -> slice-12-evidence-gated-action.md        DONE
  -> canonical candidate/failure/eval merge   PENDING
  -> EF12 behavioural fixtures                PENDING
  -> v0/v1 A/B with EF11 + EF12               PENDING
```

---

## Existing Artifacts

| File | What it covers |
|---|---|
| `slice-6-safety-untrusted-instructions.md` | Slice 6: promptware kill chain, trusted input boundary, disclosure prohibition, URL guard, tool name non-disclosure, security policy |
| `slice-7-tool-stream-state-feedback.md` | Slice 7: parallel-call guidance, tool result persistence, runtime feedback acceptance, environment context injection, git state injection |
| `slice-8-compaction-preservation.md` | Slice 8: survival-weighted compaction (QuantZhai #8), high-value atom preservation rule, NetTTS prosody weighting transfer, compaction safety acceptance criteria |
| `slice-11-investigation-imperative.md` | Slice 11 correction: safely curious execution, orientation before narrowing, assumption ledger, surface-signal discipline, C27-C35, EF11 fixtures |
| `slice-12-evidence-gated-action.md` | Slice 12 correction: evidence-promotion gate before action, source-code-is-not-runtime rule, cheap preflight checks, FM12, C36-C42, EF12 fixtures |
| `candidate-structures.md` | Canonical C1-C35 candidate structures, including Slice 11; must be updated with Slice 12 before v1 drafting |
| `research-failure-mode-catalog.md` | Canonical FM1-FM11 failure-mode catalog; must be updated with FM12 before v1 drafting |
| `prompt-evaluation-checklist.md` | Canonical checklist and fixtures, including EF11.1-EF11.6; must be updated with EF12 before v1 drafting |
| `final-findings-synthesis.md` | Canonical final synthesis through Slice 11; must be amended with Slice 12 before v1 drafting |
| `candidate-structures-slice-11-extension.md` | Provenance extension used before canonical integration; retained for audit trail |
| `research-failure-mode-catalog-slice-11-extension.md` | Provenance extension for FM11; retained for audit trail |
| `prompt-evaluation-checklist-slice-11-extension.md` | Provenance extension for EF11 fixtures; retained for audit trail |
| `comparison-quantzhai-codex-core-qwenified.md` | Dedicated comparison: QuantZhai codex-core-qwenified vs research slices |
| `comparison-codex-cli-max.md` | Dedicated comparison: OpenAI Codex CLI (Codex Max) vs research slices |
| `comparison-claude-code.md` | Dedicated comparison: Claude Code v2.1.143 vs research slices |
| `comparison-opencode-*.md` | Dedicated OpenCode comparisons for anthropic, beast, codex, default, gemini, gpt, kimi, and trinity base prompt variants |
| `research-opencode-source-map.md` | Source map for OpenCode prompt/runtime surfaces |
| `comparison-opencode-runtime-assembly.md` | Runtime assembly comparison |
| `comparison-opencode-plan-mode.md` | Plan-mode comparison |
| `comparison-opencode-agent-task-compaction.md` | Task/subagent/compaction comparison |
| `research-opencode-vs-cli-family.md` | Cross-family synthesis comparing OpenCode against QuantZhai, Codex CLI, Claude Code, Cursor/external matrix, and HSM findings |
| `final-opencode-findings-synthesis.md` | Resynthesis boundary document |

---

## Fixture Coverage

| Fixture | FM tested | Research gap addressed |
|---------|-----------|----------------------|
| `fake-investigation` | FM3 | Agent must read both files to find which has the bug |
| `destructive-git` | FM9 | Agent must avoid git-reset/git-checkout and preserve dirty state |
| `assumption-cascade` | FM7 | Agent must verify assumptions before editing confusing but correct code |
| `premature-commitment` | FM5 | Agent must trace the full call chain before committing to a fix |
| `over-paraphrasing` | FM6 | Agent must preserve exact config path, not paraphrase it |
| `context-overload` | FM8 | Agent must find the relevant module without drowning context |
| `task-abandonment` | FM10 | Agent must not give up after a partial failure |
| `adversarial-prompt-injection` | FM4 | Unicode/confusable/delayed-invocation injection cases |
| `EF11.1-existing-helper-trap` | FM11 / FM1 | Agent must find established project way before creating a helper |
| `EF11.2-wrong-path-trap` | FM11 / FM3 | Agent must verify real path before action |
| `EF11.3-hidden-config-trap` | FM11 / FM7 | Agent must check configs/manifests before trusting obvious file |
| `EF11.4-surface-signal-trap` | FM11 / FM1 | Agent must report adjacent signal without expanding scope |
| `EF11.5-curiosity-vs-scope-trap` | FM11 / FM8 | Agent must scale orientation and avoid research theatre |
| `EF11.6-stop-too-early-trap` | FM11 / FM9 | Agent must continue safe read-only investigation before stopping at mutation boundary |
| `EF12.1-inferred-api-endpoint-trap` | FM12 / FM7 | Agent must verify endpoint/method/shape before acting from REST convention or source fragment |
| `EF12.2-stale-model-id-inventory-trap` | FM12 / FM6 | Agent must list actual model/backend inventory before using guessed IDs |
| `EF12.3-hardware-preflight-trap` | FM12 | Agent must check free VRAM/RAM/runtime state before high-cost model actions |
| `EF12.4-config-before-edit-trap` | FM12 / FM11 | Agent must read active config and precedence before editing plausible config files |
| `EF12.5-repeated-correction-trap` | FM12 | Agent must turn user correction into the next operational rule, not just acknowledge it |
| `EF12.6-confident-wrong-report-trap` | FM12 / FM7 | Agent must separate observed, inferred, assumed, and unchecked claims |

All 12 failure modes now have fixture coverage at design level: FM1 through FM12.

OpenCode-specific fixture extensions remain proposed:

```text
opencode-provider-route
opencode-plan-readonly
opencode-build-handoff
opencode-subagent-needle
opencode-subagent-broad
opencode-subagent-wrong
opencode-compaction-atoms
```

---

## Remaining Work

1. **Canonical Slice 12 merge** — Merge FM12, C36-C42, and EF12.1-EF12.6 into the consolidated candidate structures, failure catalog, evaluation checklist, and final synthesis.
2. **A/B prompt evaluation** — Run EF11.1-EF11.6 and EF12.1-EF12.6 against `hsm-build-v0.md` and the future revised prompt.
3. **Candidate prompt text** — Still paused. Draft only if the user explicitly resumes candidate prompt work.
4. **OpenCode fixture extensions** — Add OpenCode-specific fixture ideas if behavioural comparison is needed.
5. **TUI source audit** — Inspect plan-mode toggle, visible state, rollback, patch/diff rendering, todo UI, and permission common-node behaviour if QuantZhai CLI design work resumes.

---

## Quick Wins

- Canonically merge Slice 12 before drafting any v1 prompt.
- Run EF12.1 and EF12.5 manually against `hsm-build-v0.md`; these directly target the new observed DeepSeek failures.
- Add one compact evidence-promotion sentence to any future v1 draft rather than a long Slice 12 block.
- Keep EF11 and EF12 separate in evaluation: curiosity/orientation and evidence-promotion are different failure classes.

---

## Risk Register

- **Slice 11 not behaviourally measured yet**: C27-C35 and EF11.1-EF11.6 are canonical but still need A/B runs.
- **Slice 12 not canonically merged yet**: C36-C42/FM12/EF12 currently live in `slice-12-evidence-gated-action.md`; consolidated files still need update.
- **Curiosity can become research theatre**: Blast-radius scaling is mandatory. Low-blast tasks should not trigger broad exploration.
- **Verification can become performative**: Slice 12 requires the cheapest check that proves the next action's precondition, not random busywork.
- **Prompt bloat risk increased**: Slice 11 and Slice 12 must be semantically merged into existing sections, not appended wholesale.
- **Safety must not be weakened**: The correction is ordering, evidence, and action gating, not removal. Safety remains strict around mutation, privilege, git, and irreversible actions.
- **Runtime boundary still partially unaudited**: plugin, permission, command, and TUI implementation details remain open if precise OpenCode behaviour is required.
- **Candidate prompt intentionally paused**: The next deliverable is not a candidate prompt unless the user explicitly resumes that stage.
- **CLI UX vs prompt text**: OpenCode plan mode, diff rendering, rollback, todo UI, and permission handling are likely CLI/harness design findings, not static prompt rules.
