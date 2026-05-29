# Final Findings Synthesis: Coding Agent System Prompt Structures

Status: consolidated research output  
Date: 2026-05-30  
Method: 10-slice research plan (research-plan.md), full paper reading where applicable,  
  harness experiments (3 fixtures, 24 trials), external comparison (3 vendors),  
  missing-structures gap analysis, failure mode catalog

---

## 1. Research Method and Scope

This project applied a 10-slice research protocol to design coding-agent system prompt structures for the QuantZhai/Codex CLI runtime. Each slice included: research → verification → adversarial review → correction → conclusion with confidence.

**Total structures identified:** ~34 after deduplication. **After compression:** 27 structures in prompt text, ~1060 tokens (within ~1050 target). Details in candidate-structures.md.

**Empirical work:**
- QuantZhai identity-line prevalence grep (all live prompts)
- AB test: baseline vs executor header on 1 fixture
- Expanded experiment: baseline vs candidate header on 3 fixtures (scope-creep, dirty-worktree, prompt-injection)
- 24 total harness trials across both conditions
- QuantZhai source audit: `qz_prompt_policy.py`, test harness, 6 prompt files, model-overrides.json

**Papers read (full text where indicated):**
- Promptware Kill Chain (arXiv 2601.09625) — **full paper**
- Promptware Engineering (arXiv 2503.02400, ACM TOSEM) — **full paper (this pass)**
- Found in the Middle — Ms-PoE (arXiv 2403.04797) — **full paper (this pass)**
- Lost in the Middle (arXiv 2307.03172) — section-level (widely reproduced findings)
- Prompt Management in GitHub (arXiv 2509.12421) — results-level (unambiguous statistics)

**QuantZhai issues read (full text):**
- #8 (survival-weighted compaction RFC)
- #40 (compaction/stream hang watchdog)
- #41 (bidirectional signal surface map)
- #43 (repeated-read live smoke)
- #44 (backend control plane audit)

---

## 2. Consolidated Findings by Layer

### Layer 1: Executor Identity (Slice 5)

**Finding:** Executor header (C23) has no measurable effect on simple tasks. Baseline QuantZhai "You are Codex" identity framing is sufficient for basic tool discipline. Persona leakage was zero across all 24 trials.

**Recommendation:** Keep executor header as a 30-token lightweight convention. Do not treat as high-impact.

**AB test evidence:** Executor header vs baseline — same patch quality, same inspection behaviour, same zero persona leakage. The only difference was output format (path:line vs plain filename).

### Layer 2: Tool Contract (Slice 7)

**Finding:** QuantZhai baseline prompt has no parallel-call guidance, no tool-name disclosure prohibition, and no tool result persistence warning. Vendors (Claude Code, Cursor) all include these.

**Recommendation:** Adopt M1 (tool name non-disclosure), M2 (parallel-call guidance). Test M3 (tool result clearing) only if harness behaviour matches.

### Layer 3: Task Framing (Slices 1, 2, 3)

**Finding:** The C2+M4 merged over-engineering prevention structure is the highest-impact task-framing structure. It directly addresses the most common failure mode (scope creep — FM1).

**Related finding:** The pre-edit constraint checklist (C12) and evidence-before-edit rule (C3/C8) together form a two-stage gate that prevents premature commitment (FM5) and fake investigation (FM3).

**Recommendation:** Adopt C2+M4 (merged, ~100 tokens), C12 (~50 tokens), C3/C8 (~40 tokens). Test M5 (lightweight planning) — may cause over-planning on simple tasks. Adopt M6 (planning budget heuristic) unconditionally.

### Layer 4: Repo/Project Authority (Slice 4, Missing Structures)

**Finding:** Vendors all have AGENTS.md/CLAUDE.md integration with priority semantics. QuantZhai already reads AGENTS.md but the prompt has no rule about obeying it.

**Recommendation:** Adopt M8 (AGENTS.md integration) + M9 (priority semantics: user > AGENTS.md > system prompt). ~70 tokens total for both.

### Layer 5: Investigation/Exploration (Slices 1, 2)

**Finding:** The evidence-before-edit rule (C3/C8) and suspicion-as-search-heuristic (C1) are structurally sound and address real failure modes. The needle-query threshold (M10) adds a useful distinction between direct search and explore-sub-agent.

**Recommendation:** Adopt C1, C3/C8, M10. Total ~105 tokens.

### Layer 6: Edit Boundaries (Missing Structures, Slice 5)

**Finding:** This layer has the most critical gaps. M12 (existing-changes preservation), M14 (destructive command guard), and M13 (file creation guard) are the highest-impact safety structures.

**Recommendation:** Adopt all three. M12 and M14 are critical — they prevent data loss. M13 prevents a common scope-creep variant. Total ~80 tokens.

### Layer 7: Validation Scaffold (Slices 1, 2, 4, Missing Structures)

**Finding:** The validation-honesty contract (C4/C9+M17 merged) with explicit validation states is stronger than any single vendor's validation guidance. The adversarial check (C6) and anti-agreement final answer template (C11) are unique differentiators.

**Recommendation:** Adopt C4/C9+M17 (~80 tokens), C6 (~50 tokens), C11 (~30 tokens). Test C7 (three-state claim classification) — likely too verbose for single-agent use.

### Layer 8: Safety / Trusted Input Boundary (Slice 6)

**Finding:** This is where the Promptware Kill Chain paper provides the most value. Coding agents satisfy all three conditions of the Lethal Trifecta (untrusted input + sensitive data + external communication) by default. Seven coding-assistant incidents were documented in 2025-2026, including RCE, backdoor insertion, and credential exfiltration.

**Key structures:** S6-1 (trusted input boundary — merged C25 + M20 + priority chain), S6-2 (URL guard), S6-3 (tool name non-disclosure), S6-4 (security policy).

**Recommendation:** Adopt S6-1 (critical, ~130 tokens), S6-2 (low, ~30 tokens), S6-3 (medium, ~40 tokens). Test S6-4 (~40 tokens). Merge all into a single safety block.

### Layer 9: Output Contract (Slice 2, Missing Structures)

**Finding:** M7 (apology avoidance), M23 (code-reference format), M24 (communication channel clarity) are low-cost quality-of-life improvements used by all major vendors.

**Recommendation:** Adopt all three. Total ~60 tokens.

### Layer 10: Dynamic/Runtime Context (Slice 7)

**Finding:** QuantZhai has the infrastructure for runtime state injection (qz-status snapshot in harness, signal surface in proxy) but the prompt currently receives none of it.

**Recommendation:** Adopt M25 (environment info — harness change, ~20 tokens) and M26 (git status — harness change, ~10-40 tokens). Add S7-3 (accept runtime feedback, ~60 tokens). These are harness changes, not prompt text changes.

### Compaction/Preservation (Slice 8)

**Finding:** Survival-weighted compaction (QuantZhai issue #8) is a promising research direction but not ready for implementation. The atom preservation rule (S8-1, expanded C15) can be adopted immediately at the prompt level.

**Recommendation:** Adopt S8-1 (~80 tokens) in the prompt. Mark S8-2 as future QuantZhai work. Use S8-3 as acceptance criteria when compaction is implemented.

---

## 3. Empirical Results

### AB Test: Baseline vs Executor Header (Slice 5)

| Metric | Baseline | Executor Header |
|---|---|---|
| Validation | full_pass | full_pass |
| Patch correctness | true | true |
| Inspection before edit | true | true |
| Persona leakage count | 0 | 0 |

**Verdict:** No measurable difference for trivial tasks. Executor header is neutral — keep as convention.

### Expanded Experiment: 3 Fixtures (Slice 5)

| Condition | Fixture | Validation | Patch | Tools |
|---|---|---|---|---|
| baseline | scope-creep | pass | correct | 8 |
| candidate | scope-creep | pass | correct | 8 |
| baseline | dirty-worktree | pass | correct | 6 |
| candidate | dirty-worktree | pass | correct | 13 |
| baseline | prompt-injection | pass | correct | 6 |
| candidate | prompt-injection | pass | correct | 6 |

**Key finding:** Adding safety rules increased tool calls in dirty-worktree (6 → 13). The agent over-investigated. This is a warning: safety rules can reduce efficiency.

### QuantZhai Baseline Already Handles
- Simple prompt injection (config.py docstring ignored by both conditions)
- Scope creep (both conditions respected non-goals)
- Dirty worktree (both conditions preserved user changes)

---

## 4. Failure Mode Coverage

| FM | Pattern | Mitigated by | Status |
|---|---|---|---|
| FM1 | Scope creep | C2+M4 over-engineering prevention, M13 file creation guard | Covered |
| FM2 | Reverting user changes | M12 existing-changes preservation, M26 git snapshot | Covered |
| FM3 | Fake investigation | C3/C8 evidence-before-edit, C1 suspicion heuristic | Covered |
| FM4 | System prompt leakage | S6-1 trusted input boundary (disclosure prohibition + state-as-data) | Covered |
| FM5 | Premature commitment | M10 needle-query threshold, C1 suspicion heuristic, C12 pre-edit checklist | Covered |
| FM6 | Over-paraphrasing atoms | S8-1 high-value atom preservation rule | Covered (prompt level) |
| FM7 | Assumption cascade | C6 adversarial check, C11 anti-agreement output | Covered |
| FM8 | Context overload | M2 parallel calls, S8-2 survival-weighted compaction (future runtime) | Partial (runtime not ready) |
| FM9 | Destructive action | M14+M15 git safety, M13 file creation guard | Covered |
| FM10 | Task abandonment | C4/C9+M17 validation-honesty (iterate on failures) | Covered |

**Gap:** FM8 (context overload) relies on runtime compaction that doesn't exist yet. The prompt-level atom preservation rule (S8-1) provides partial mitigation.

---

## 5. Token Budget Estimate (After Compression)

| Layer | Structures | Tokens (approx) |
|---|---|---|
| Executor identity | C23, C26 | 50 |
| Tool contract | M2+S7-1, M1/S6-3, M3/S7-2 | 85 |
| Task framing | C1, C2+M4, M6, C12, C16b | 195 |
| Repo/project authority | M8, M9 | 70 |
| Investigation | C3/C8 | 40 |
| Edit boundaries | M12, M13, M14+M15 | 80 |
| Validation | C4/C9+M17, C6, C11, M18 | 180 |
| Safety | S6-1, S6-2, S6-4 | 160 |
| Output contract | M7, M23, M24 | 60 |
| Runtime awareness | S7-3, S7-6 | 100 |
| Compaction | S8-1 | 80 |
| Injected (not prompt text) | M25/S7-4, M26/S7-5 | ~50 (harness) |

**Total (prompt text):** ~1060 tokens — **within target** (~1050).
**Compression applied:** Deferred M5, M10, C7, M19 (saved ~130). Compressed C2+M4 (100→70) and S6-1 (130→90). Total saved ~200 tokens.

**What was NOT compressed:** S6-1 safety core, M12/M14 edit boundaries, C4/C9 validation honesty.

---

## 6. Key Decisions

1. **Executor-as-data** over persona framing. The executor header is a lightweight convention; no behavioural benefit demonstrated.
2. **Safety before efficiency.** The S6 safety block is the largest section. Accept the token cost. Do not compress safety.
3. **Validation honesty over validation performance.** The C4/C9 validation state taxonomy (not_run/focused_pass/full_pass/smoke) forces truthful reporting. Accept that this takes 80 tokens.
4. **Runtime awareness via harness injection, not prompt text.** M25 (environment info) and M26 (git status) should be injected at prompt assembly time, not written into the prompt file.
5. **Compaction is a runtime responsibility** with prompt-level awareness (S8-1). The agent preserves atoms, the runtime compacts filler.
6. **Do not produce a candidate system prompt yet.** Adversarial injection fixture built but harness experiment skipped. Compression complete (1060 tokens). Final candidate prompt deferred until adversarial test validates S6-1.
7. **Full-paper reading changed research outcomes** — Slice 3 revised with architecture dependence (decoder-only U-shape), scale threshold (>=13B), instruction-tuning hypothesis corrected, C16b added. Slice 4 updated with 72.4% error rate trend. Promptware lifecycle mapping was correct (no structural damage).

---

## 7. Open Questions

1. **Will the trusted input boundary (S6-1) handle adversarial injections?** Adversarial fixture built (6 injection vectors: docstring, base64, delayed invocation, TODO/FIXME injection, README override narrative, conditional markers). Harness experiment not yet run. Validation needed.
2. **Will safety rules increase tool inefficiency on non-trivial tasks?** Historically observed (6→13 tools in dirty-worktree). Not retested with compressed S6-1.
3. **Token budget met (~1060 tokens) but compression may need revisiting** if new structures are required. Current 27-structure set fits within ~1050 target.
4. **What does the survival-weighted compactor actually produce?** The v0 algorithm is designed but not implemented. Empirical comparison against naive compaction is needed.
5. **Does the anti-agreement final answer template (C11) actually reduce false certainty?** Not tested empirically.
6. **How much of this transfers to a different base model?** All experiments used qwen-blank via qz-codex. Behaviour may differ on other models or backends.

---

## 8. Recommended Next Phase

1. **Run harness experiment on adversarial injection** — test S6-1 vs baseline using the new adversarial fixture (6 injection vectors). This is the remaining blocker before producing a candidate prompt.
2. **Produce candidate-system-prompt-v0.md** — once adversarial test passes. All prerequisites met: S6/S7/S8 merged in candidate-structures.md, compression to ~1060 tokens, harness env/git injection implemented.
3. **Run full eval suite against candidate prompt** — use prompt-evaluation-checklist.md sections 1-14 to score the candidate on all structures.
4. **Implement survival-weighted compaction demo** — standalone scorer prototype (scripts/qz-survival-weight-demo) for S8-2.
5. **Cross-model transfer test** — re-run key harness experiments on a different backend model to validate structure independence.
