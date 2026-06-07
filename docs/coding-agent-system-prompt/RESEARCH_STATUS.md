# Research Status: Coding Agent System Prompt Subproject

Summary: all 10 research slices are complete. Candidate structures, failure-mode
coverage, vendor comparisons, OpenCode base-prompt comparisons, and the final
synthesis are now consolidated as of 2026-06-07.

---

## Status Matrix

| Slice | Status | Key Artifacts | Next Action |
|---|---|---|---|
| 0 | Complete | `internal-project-references.md`, `research-references.md` | None |
| 1 | Complete | `slice-1-arbitration-loop.md`, C1-C5 | None |
| 2 | Complete | `slice-2-anti-agreement-self-critique.md`, C6-C11 | None |
| 3 | Complete | `slice-3-context-position-middle-loss.md`, C12-C16 | Minor refinements: separate attention-sink vs RoPE-decay; add StableBeluga-13B regression note |
| 4 | Complete | `slice-4-promptware-lifecycle.md`, C17-C22 | Verified against full paper — lifecycle mapping correct, security coverage actually shallower than slice |
| 5 | Complete | `slice-5-identity-role-and-executor-boundaries.md`, C23-C26 | AB test and expanded experiment done |
| 6 | Complete | `slice-6-safety-untrusted-instructions.md`, S6-1 through S6-4 | Sources: full Promptware Kill Chain paper (2601.09625), OWASP LLM Top 10 2025, QuantZhai #41 |
| 7 | Complete | `slice-7-tool-stream-state-feedback.md`, S7-1 through S7-6 | Sources: QuantZhai #40, #41, #43, #44 |
| 8 | Complete | `slice-8-compaction-preservation.md`, S8-1 through S8-3 | Sources: QuantZhai #8 (full RFC), NetTTS vox_parser.cpp |
| 9 | Complete | `research-external-prompt-comparison.md` | None |
| 10 | Complete | `candidate-structures.md`, `prompt-evaluation-checklist.md`, `final-findings-synthesis.md` | Build compact `candidate-system-prompt-v0.md` and run fixture matrix |

---

## New Artifacts (this pass)

| File | What it covers |
|---|---|
| `slice-6-safety-untrusted-instructions.md` | Slice 6: promptware kill chain, trusted input boundary, disclosure prohibition, URL guard, tool name non-disclosure, security policy |
| `slice-7-tool-stream-state-feedback.md` | Slice 7: parallel-call guidance, tool result persistence, runtime feedback acceptance, environment/git injection, compaction awareness |
| `slice-8-compaction-preservation.md` | Slice 8: survival-weighted compaction (QuantZhai #8), high-value atom preservation (expanded C15), NetTTS prosody transfer, compaction acceptance criteria |
| `comparison-quantzhai-codex-core-qwenified.md` | Dedicated comparison: QuantZhai codex-core-qwenified vs all 10 research slices. Section-by-section validation, challenge, and gap analysis. |
| `comparison-codex-cli-max.md` | Dedicated comparison: OpenAI Codex CLI (Codex Max) vs all 10 research slices. 11-layer taxonomy analysis with adoption recommendations. |
| `comparison-claude-code.md` | Dedicated comparison: Claude Code v2.1.143 vs all 10 research slices. Includes memory system and sub-agent architecture evaluation. |
| `comparison-opencode-*.md` | Dedicated OpenCode comparisons for anthropic, beast, codex, default, gemini, gpt, kimi, and trinity base prompt variants. |
| `final-opencode-findings-synthesis.md` | Consolidated OpenCode prompt-family synthesis with adoption cluster, rejection list, and fixture-comparison recommendation. |
| `final-findings-synthesis.md` | Rewritten final synthesis preserving the original Rule Zero/pattern vocabulary while integrating all later research and OpenCode findings. |

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
| `adversarial-prompt-injection` | FM4 (advanced) | Zero-width spaces, Unicode confusables, delayed invocation, HTML comment injection |

All 10 failure modes now have fixture coverage: FM1 ✅, FM2 ✅, FM3 ✅, FM4 ✅ (basic + advanced), FM5 ✅, FM6 ✅, FM7 ✅, FM8 ✅, FM9 ✅, FM10 ✅

## Remaining Work (in priority order)

1. ~~Update candidate-structures.md~~ — S6-1 through S6-4, S7-1 through S7-6, and S8-1 through S8-3 are merged into the consolidated table. (DONE)
2. ~~Write final findings synthesis~~ — `final-findings-synthesis.md` rewritten on 2026-06-07 with all slices, failure modes, vendor comparisons, OpenCode audit findings, consolidated recommendation, and open questions. (DONE)
3. ~~Build adversarial prompt-injection fixture~~ (DONE — zero-width spaces U+200B, Unicode confusables, delayed invocation base64, HTML comment injection; all 4 vectors validated)
4. ~~Implement S7-4/S7-5 in harness~~ (DONE — assemble_prompt.sh upgraded with structured env block, arch/shell info, categorized git state with file counts)
5. ~~Add Slice 3 refinements~~ (DONE — already in document from full-paper reading: attention sinks vs RoPE decay at §3.1, StableBeluga-13B regression noted)
6. **Candidate prompt text** — Produce `candidate-system-prompt-v0.md` as a compact, testable baseline. Use the final synthesis non-negotiables and preserve QuantZhai proportional compactness.
7. ~~Apply comparison document findings~~ (DONE — 12 structures expanded: C2+M4 ambition-vs-precision, C4/C9+M17 mode-aware validation, M8/M9 AGENTS.md scope/nesting, M23 file reference format, M25 Claude-style environment block, S6-4 expanded auth note, S6-1 system-reminder markers, M24 don't-narrate-deliberation, C1/C3 never-delegate-understanding, M14 expanded git safety + staging rule, S7-2 Claude tool-result wording. Net +175 tokens to candidate set.)
8. ~~Build FM5/FM6/FM8/FM10 fixtures~~ (DONE — all 10 FMs now covered)

---

## Quick Wins (1-2 days)

- Draft compact `candidate-system-prompt-v0.md`
- Run fixture matrix against QuantZhai baseline, candidate v0, and OpenCode-shaped variants
- ~~Add environment/git injection to assemble_prompt.sh~~ (DONE)
- ~~Upgrade prompt-injection fixture for adversarial testing~~ (DONE)

---

## Risk Register

- **Paper depth variability**: Slices 1-5 relied on abstract/section-level reading for some papers. Verified: only Promptware Engineering (2503.02400) had section-level reads — lifecycle mapping is correct, security coverage is shallow in the paper itself. No structural damage.
- **Model switching rollbacks**: QuantZhai may roll back model selection if backend fails to load. Compaction experiments (Slice 8) blocked until stable backend.
- **Candidate prompt not yet written**: The synthesis and candidate structures are complete, but `candidate-system-prompt-v0.md` still needs to be drafted and evaluated.
- **Prompt bloat**: C1-C26 + M1-M27 + S6/S7/S8 = ~30+ structures at potentially ~1200+ tokens. Compression will be needed before producing a real system prompt.
- **QuantZhai proportional-compactness constraint**: The QuantZhai prompt is ~650 tokens by design (Caveman-inspired). Expansion justified for value, but no doubling or tripling. 1024-token max. Adoption must earn its token budget through direct failure-mode mitigation. Documented in `comparison-quantzhai-codex-core-qwenified.md` design constraint note.
- **OpenCode runtime boundary**: OpenCode findings are supported for base-prompt text only. Runtime-behaviour predictions remain `plausible_but_unproven` until fixture runs compare prompt variants.
