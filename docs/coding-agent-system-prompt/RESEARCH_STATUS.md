# Research Status: Coding Agent System Prompt Subproject

Summary: all 10 research slices are complete. Candidate structures, failure-mode
coverage, vendor comparisons, and the original final synthesis exist, but the
OpenCode material is now marked as needing a deeper resynthesis pass before any
candidate prompt is drafted.

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
| 10 | Complete / paused before candidate | `candidate-structures.md`, `prompt-evaluation-checklist.md`, `final-findings-synthesis.md` | Repair OpenCode comparison/resynthesis layer before candidate prompt work |

---

## Current Boundary

Candidate prompt drafting is paused.

Do not produce `candidate-system-prompt-v0.md` yet.

The immediate work is resynthesis only:

```text
OpenCode source map
  -> OpenCode runtime assembly comparison
  -> OpenCode plan-mode comparison
  -> OpenCode task/subagent/compaction comparison
  -> OpenCode vs CLI-family synthesis
  -> update final-findings-synthesis.md after the above
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
| `comparison-opencode-*.md` | Dedicated OpenCode comparisons for anthropic, beast, codex, default, gemini, gpt, kimi, and trinity base prompt variants. These are useful but too thin compared with the older reports. |
| `final-opencode-findings-synthesis.md` | Rewritten as a resynthesis boundary document. It now explicitly blocks candidate prompt drafting until OpenCode is compared with the older discipline. |
| `final-findings-synthesis.md` | Existing final synthesis. It should be updated only after the OpenCode resynthesis documents are complete. |

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

---

## Remaining Work (in priority order)

1. **OpenCode source map** — Create `research-opencode-source-map.md` to map static prompts, runtime assembly, reminders, commands, tools, task/subagent prompts, skills, permissions, and TUI/workflow observations.
2. **OpenCode runtime assembly comparison** — Create `comparison-opencode-runtime-assembly.md` to compare provider routing, environment injection, skills, command templates, permission state, and plugin transforms against Rule Zero.
3. **OpenCode plan-mode comparison** — Create `comparison-opencode-plan-mode.md` to compare read-only plan mode, plan files, explore agents, build switch, and plan exit against the arbitration-loop research.
4. **OpenCode task/subagent comparison** — Create `comparison-opencode-agent-task-compaction.md` for task, explore, compaction, summary, and title prompt surfaces.
5. **OpenCode vs CLI family synthesis** — Create `research-opencode-vs-cli-family.md`, comparing OpenCode as a whole prompt system against QuantZhai, Codex CLI, Claude Code, Cursor, and the earlier external matrix.
6. **Update final synthesis** — Update `final-findings-synthesis.md` only after the above OpenCode resynthesis documents exist.
7. **Candidate prompt text** — Still paused. Do not draft `candidate-system-prompt-v0.md` until the OpenCode resynthesis layer is repaired.

---

## Quick Wins

- Upgrade the thin OpenCode comparison files to the older report standard:

```text
Observed:
Validated by our research:
Challenged by our research:
What OpenCode does better:
What OpenCode does worse:
Gap:
Risk / uncertainty:
Runtime vs prompt placement:
Decision:
Fixture implication:
```

- Add a source map before changing any candidate structures.
- Keep OpenCode UI/TUI behaviours separate from static prompt text.
- Keep `candidate-system-prompt-v0.md` out of scope until resynthesis is complete.

---

## Risk Register

- **OpenCode integration was premature**: The current OpenCode base-prompt reports are useful, but thinner than the earlier QuantZhai/Codex/Claude reports. Their findings should not drive prompt drafting yet.
- **Runtime boundary incomplete**: OpenCode runtime behaviour is assembled from source beyond the base prompt files. Base-prompt comparison alone is insufficient.
- **Candidate prompt intentionally paused**: The synthesis and candidate structures exist, but the next deliverable is not a candidate prompt. It is the repaired OpenCode comparison/resynthesis layer.
- **Prompt bloat risk remains**: Candidate work, when resumed, must still respect the QuantZhai proportional-compactness constraint.
- **CLI UX vs prompt text**: OpenCode plan mode, diff rendering, rollback, todo UI, and permission handling are likely CLI/harness design findings, not static prompt rules.
