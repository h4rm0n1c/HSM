# Research Status: Coding Agent System Prompt Subproject

Summary: all 10 research slices are complete. Candidate structures, failure-mode
coverage, vendor comparisons, OpenCode resynthesis, and the final synthesis
update now exist. Candidate prompt drafting remains paused.

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
| 10 | Complete / candidate paused | `candidate-structures.md`, `prompt-evaluation-checklist.md`, `final-findings-synthesis.md` | Candidate prompt work remains paused until explicitly resumed |

---

## Current Boundary

Candidate prompt drafting is paused.

Do not produce `candidate-system-prompt-v0.md` yet.

The OpenCode resynthesis sequence is complete at research level:

```text
OpenCode source map                          DONE
  -> OpenCode runtime assembly comparison    DONE
  -> OpenCode plan-mode comparison           DONE
  -> OpenCode task/subagent comparison       DONE
  -> OpenCode vs CLI-family synthesis        DONE
  -> update final-findings-synthesis.md      DONE
```

---

## Existing Artifacts

| File | What it covers |
|---|---|
| `slice-6-safety-untrusted-instructions.md` | Slice 6: promptware kill chain, trusted input boundary, disclosure prohibition, URL guard, tool name non-disclosure, security policy |
| `slice-7-tool-stream-state-feedback.md` | Slice 7: parallel-call guidance, tool result persistence, runtime feedback acceptance, environment/git injection, compaction awareness |
| `slice-8-compaction-preservation.md` | Slice 8: survival-weighted compaction (QuantZhai #8), high-value atom preservation (expanded C15), NetTTS prosody transfer, compaction acceptance criteria |
| `comparison-quantzhai-codex-core-qwenified.md` | Dedicated comparison: QuantZhai codex-core-qwenified vs all 10 research slices. Section-by-section validation, challenge, and gap analysis. |
| `comparison-codex-cli-max.md` | Dedicated comparison: OpenAI Codex CLI (Codex Max) vs all 10 research slices. 11-layer taxonomy analysis with adoption recommendations. |
| `comparison-claude-code.md` | Dedicated comparison: Claude Code v2.1.143 vs all 10 research slices. Includes memory system and sub-agent architecture evaluation. |
| `comparison-opencode-*.md` | Dedicated OpenCode comparisons for anthropic, beast, codex, default, gemini, gpt, kimi, and trinity base prompt variants. Useful base-prompt comparisons, now supplemented by deeper resynthesis docs. |
| `research-opencode-source-map.md` | Source map for OpenCode prompt/runtime surfaces: base prompts, system runtime, reminders, task/subagent prompts, compaction, and user-observed TUI behaviours. |
| `comparison-opencode-runtime-assembly.md` | Runtime assembly comparison: provider routing, environment injection, skills, reminders, task/subagent prompts, Explore, compaction, and CLI/TUI placement. |
| `comparison-opencode-plan-mode.md` | Plan-mode comparison: read-only planning, plan-file exception, explore agents, build switch, question vs plan-exit boundary, and runtime placement. |
| `comparison-opencode-agent-task-compaction.md` | Task/subagent/compaction comparison: when not to delegate, Explore role, main-agent accountability, and anchored compaction. |
| `research-opencode-vs-cli-family.md` | Cross-family synthesis comparing OpenCode against QuantZhai, Codex CLI, Claude Code, Cursor/external matrix, and HSM slice findings. |
| `final-opencode-findings-synthesis.md` | Resynthesis boundary document. It explicitly blocks candidate prompt drafting until OpenCode is compared with the older discipline. |
| `final-findings-synthesis.md` | Final consolidated synthesis, now updated with the repaired OpenCode prompt-system-family findings. |

---

## Fixture Coverage

| Fixture | FM tested | Research gap addressed |
|---------|-----------|----------------------|
| `fake-investigation` | FM3 (Hallucinated Investigation) | Agent must read both files to find which has the bug |
| `destructive-git` | FM9 (Destructive Action) | Agent must avoid git-reset/git-checkout, preserve dirty state |
| `assumption-cascade` | FM7 (Assumption Cascade) | Agent must verify assumptions before editing confusing but correct code |
| `premature-commitment` | FM5 (Premature Commitment) | Agent must trace the full call chain before committing to a fix |
| `over-paraphrasing` | FM6 (Over-Paraphrasing) | Agent must preserve exact config path, not paraphrase it |
| `context-overload` | FM8 (Context Overload) | Six modules, agent must find the one with the bug |
| `task-abandonment` | FM10 (Task Abandonment) | Two bugs, agent must not give up after fixing the first |
| `adversarial-prompt-injection` | FM4 (advanced) | Zero-width spaces, Unicode confusables, delayed invocation base64, HTML comment injection |

All 10 failure modes have fixture coverage: FM1, FM2, FM3, FM4, FM5, FM6, FM7, FM8, FM9, FM10.

OpenCode-specific fixture extensions are proposed in `final-findings-synthesis.md` and `research-opencode-vs-cli-family.md`:

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

1. **Fixture extensions** — Add OpenCode-specific fixture ideas if behavioural comparison is needed.
2. **TUI source audit** — Inspect plan-mode toggle, visible state, rollback, patch/diff rendering, todo UI, and permission common-node behaviour if QuantZhai CLI design work resumes.
3. **Candidate prompt text** — Still paused. Do not draft `candidate-system-prompt-v0.md` until the user explicitly resumes candidate prompt work.

---

## Quick Wins

- Add OpenCode fixture extensions when ready to test behaviour.
- Audit OpenCode TUI/runtime source for plan toggle, rollback, todo UI, diff rendering, and permission UX.
- Keep OpenCode UI/TUI behaviours separate from static prompt text.
- Keep `candidate-system-prompt-v0.md` out of scope until explicitly resumed.

---

## Risk Register

- **Runtime boundary still partially unaudited**: plugin, permission, command, and TUI implementation details remain open if precise OpenCode behaviour is required.
- **Candidate prompt intentionally paused**: The next deliverable is not a candidate prompt unless the user explicitly resumes that stage.
- **Prompt bloat risk remains**: Candidate work, when resumed, must still respect the QuantZhai proportional-compactness constraint.
- **CLI UX vs prompt text**: OpenCode plan mode, diff rendering, rollback, todo UI, and permission handling are likely CLI/harness design findings, not static prompt rules.
- **Behaviour not yet measured**: OpenCode-inspired runtime ideas still need fixture runs before any claim of behavioural improvement.
