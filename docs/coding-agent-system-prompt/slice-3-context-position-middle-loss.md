# Slice 3: Context-Position and Middle-Detail Loss

Status: completed (revised 2026-05-30 after full-paper reading)  
Date: 2026-05-28 (original), 2026-05-30 (revision)  
Confidence: medium  
Parent: `research-plan.md` Slice 3  
Revision note: Full papers read 2026-05-30. Significant corrections applied: architecture/scale dependence, query-aware contextualization, instruction-tuning hypothesis corrected, distance-between-evidence as separate factor, CoT degradation on non-instruction-tuned models.

---

## Question

How should prompt structures compensate for important middle-context details being lost?

## Hypothesis

Critical constraints should be repeated near action points as short local checklists rather than buried once in long prose.

## Sources Inspected (full papers)

### Lost in the Middle (arXiv 2307.03172) — FULL PAPER READ

Liu et al., 2023. Accepted TACL. Multi-document QA and key-value retrieval experiments across 6 models.

**Core finding:** U-shaped performance curve — highest when relevant info is at start or end of context, lowest in the middle. Consistent across all tested decoder-only models.

**Critical findings from full paper that revise earlier understanding:**

*Architecture matters.* Encoder-decoder models (Flan-UL2 within its 2048-token training window) show only **1.9% absolute difference** between best- and worst-case performance. The U-shape is primarily a decoder-only phenomenon. See §4.1, Figure 8. Implication: coding agents (all decoder-only) are among the most affected architectures.

*Scale matters.* The U-shape only appears at **>=13B parameters**. Llama-2-7B is solely recency-biased (performance only drops when info is far from the end, not when it's in the middle). At 13B and 70B, the U-shape appears with both primacy and recency bias. See Appendix E, Figure 16.

*Instruction fine-tuning is NOT the cause.* Base MPT-30B (not instruction-tuned) shows the same U-shaped curve as MPT-30B-Instruct — instruction tuning slightly reduces the gap (10% → 4%) but does not change the shape. See §4.3, Figure 10. Previous slice version incorrectly left open the possibility that instruction tuning caused position bias.

*Performance can drop below closed-book.* GPT-3.5-Turbo with 20-30 documents in its worst position performs **worse than with zero input documents** (56.1% closed-book baseline). Providing more context actively harms performance when relevant info is poorly positioned. See §2.3.

*Extended-context models are not better at using context.* GPT-3.5-Turbo (4K) and GPT-3.5-Turbo (16K) have nearly superimposed performance curves when the input fits in both windows. Longer context windows do not equal better context utilization. See §2.3, Figure 5.

*Query-aware contextualization helps KV retrieval but not QA.* Placing the query both before AND after the key-value pairs yields **perfect accuracy** on the key-value retrieval task for all models. But the same technique minimally affects multi-document QA performance. See §4.2, Figure 9. This is a cheap, sometimes-effective prompt technique: repeat the query at both start and end of the context block.

*GPT-4 also shows the U-shape.* Despite higher absolute performance, GPT-4 (8K) exhibits the same U-shaped position bias on multi-document QA. See Appendix D, Figure 15.

*Randomizing distractor order* slightly improves middle/end performance but does not eliminate the U-shape. See Appendix C, Figure 14.

*The serial-position effect.* The paper explicitly connects its finding to the psychological serial-position effect (Ebbinghaus 1913), where humans best remember first and last elements of a list. This is relevant because it suggests the bias may be fundamental to how attention systems process sequential information, not a bug that will be eliminated by better models.

### Lost in the Middle, and In-Between — Multi-Hop (arXiv 2412.10079) — FULL PAPER READ

**Core finding:** Multi-hop reasoning (connecting evidence across positions) compounds position loss beyond single-document degradation.

**Corrections from full-paper reading:**

*Distance-between-evidence is a separate factor from absolute position.* Figure 4 shows adjacent evidence documents consistently outperform separated evidence across all datasets and models, regardless of absolute position. Previous slice version treated both as the same phenomenon.

*CoT harms non-instruction-tuned models.* Llama-2-longlora shows sharp degradation with CoT (primacy bias from few-shot exemplars). On MuSiQue 3-hop, KG+CoT collapses from 58.95% to **5.79%**. Previous slice version said CoT "helps" — this is only true for instruction-tuned models.

*KG triple extraction underperforms summarization consistently.* Across nearly every position and dataset, KG extraction is strictly worse than summarization. Previous slice version treated them as equivalent mitigation options.

*Combinatorial explosion makes re-ranking impractical.* Multi-hop with 2/3/4 evidence documents requires 190/1140/4845 possible orderings per prompt. This makes retrieval-side re-ranking approaches infeasible at scale — supporting the focus on prompt-structure fixes.

### Found in the Middle — Ms-PoE (arXiv 2403.04797) — FULL PAPER READ

Verified: Ms-PoE is a model-level RoPE modification that assigns different position scaling ratios to different attention heads based on a position-awareness score. It achieves +3.8 average accuracy on Zero-SCROLLS. No prompt-level applicability.

**Addition from full reading:** Ms-PoE shows the U-shape has **two root causes**: (1) attention sinks / causal attention bias (initial tokens get disproportionate scores), and (2) RoPE long-term decay (distant tokens get lower scores even when relevant). These are distinct mechanisms requiring different mitigations. See §3.1.

**Also:** StableBeluga-13B showed regression on 2/7 Zero-SCROLLS tasks (QMSum -0.1, SQuALITY -0.1). Model-level fixes are not universally positive.

---

## Research Tasks Completed

### 1. Summarize what the papers actually show

**The position bias is real, architecture-dependent, and scale-dependent:**
- Decoder-only models >=13B show the U-shape (primacy + recency bias)
- Encoder-decoder models within training window show minimal position bias (1.9% gap)
- 7B decoder-only models show only recency bias (no primacy effect)
- The bias is linked to two architectural mechanisms: attention sinks and RoPE decay
- GPT-4 also exhibits the U-shape — position bias is not solved by scale

**Multi-hop reasoning compounds the loss:**
- Distance between evidence documents is a separate factor from absolute position
- Adjacent evidence outperforms separated evidence regardless of position
- CoT helps instruction-tuned models but harms non-instruction-tuned ones
- Content reduction (summarization, KG extraction) trades accuracy for bias reduction

**Query-aware contextualization is a cheap partial fix for retrieval-style tasks:**
- Repeating the query before and after data yields perfect key-value retrieval
- But does not help multi-document question answering
- Worth testing for coding-agent task briefs (repeat the goal at start and end)

### 2. What transfers to coding-agent prompts

**What transfers:**
- The U-shaped position bias affects decoder-only models used in coding agents
- Constraints in the MIDDLE of a long prompt are most likely lost
- Connecting constraints from different positions is harder than using either alone
- More context is not always better — providing too many files can hurt performance
- Repeating the query at start and end of relevant data may help

**What does NOT transfer directly:**
- Paper tasks are document QA, not software task execution with tool loops
- Single-answer retrieval differs from multi-step reasoning over tool feedback
- 2023 results may differ in magnitude for 2026 models (but GPT-4 shows same pattern, suggesting the bias is durable)

### 3. Distinguish model-level from prompt-structure mitigations

| Mitigation | Level | Limitation |
|---|---|---|
| Ms-PoE positional encoding | Model | Requires model modification; not available |
| Query-aware contextualization | Prompt structure | Helps retrieval, not reasoning tasks |
| Reduce superfluous context | Prompt/runtime | Limited by what agent needs; trade-off with accuracy |
| Repeat constraints near action points | Prompt structure | Testable now; risk of bloat |
| Put critical content at start/end | Prompt structure | May conflict with other ordering |
| Short checklists before edits | Prompt structure | Testable now |
| CoT prompting | Prompt structure | Harms non-instruction-tuned models |

---

## Adversarial Review

### Q1: Does repeating constraints increase compliance or just bloat?

Can do both. Repeat only non-goals, acceptance criteria, and safety boundaries. Not everything.

### Q2: Which details deserve repetition?

Non-goals (most commonly violated), acceptance criteria (commonly lost between brief and validation), safety/edit boundaries. Tool prohibitions and style guides do not.

### Q3: Can a local checklist replace repetition?

Yes — preferred approach. A pre-edit checklist (C12) is lighter than prose repetition and forces the check at the right point.

### Q4: Does query-aware contextualization apply to coding-agent tasks?

Worth testing. Repeating the task goal at both the start and end of the file-read section may help the agent maintain focus. It cost ~20 tokens to repeat the goal.

### Q5: Does the scale-dependence mean smaller models are less affected?

No — 7B models are recency-biased (forget earlier context) rather than symmetrically U-shaped. This is still a position bias, just a different shape. The mitigations (repeat near action points, checklists) apply to both shapes.

---

## Conclusion

Decision: **adopt with constraints**

Confidence: **medium** (revised with corrections from full-paper reading)

### Evidence for

- Full-paper reading confirms U-shaped position bias across all tested decoder-only models >=13B
- Two distinct architectural mechanisms (attention sinks + RoPE decay) identified
- Multi-hop compounds the loss; software tasks are inherently multi-hop
- More context actively harms performance when relevant info is poorly positioned
- Checklist approach is lighter than prose repetition

### Evidence against

- Encoder-decoder models show minimal position bias (but coding agents use decoder-only)
- Model-level fixes (Ms-PoE) may gradually reduce the problem magnitude
- No local testing on QuantZhai's Qwen3.6 + specific prompt stack
- Checklists before every edit could become mechanical

### Uncertainty

- Whether Qwen3.6 (2025/2026) shows the same U-shape magnitude as 2023 GPT/LLaMA
- Whether query-aware contextualization helps in tool-use scenarios
- Whether the pre-edit checklist improves constraint retention or becomes token noise

### Risk

- Over-repetition bloats prompt
- Checklists slow down trivial tasks
- Mitigations may help at margins but not address architectural issue

---

## Candidate Structures

### C12: Pre-edit constraint checklist (prompt structure)

```
Before editing a non-trivial change, confirm:
- This change stays within the stated non-goals
- The owning file has been inspected
- The fix addresses the root cause, not just the symptom
- Acceptance criteria are still achievable after this edit
```

### C13: Non-goals placement rule (task packet structure)

Non-goals must appear in the task brief within 3 lines of the edit instructions, not only in the introductory context.

### C14: Acceptance criteria near validation (task packet structure)

Acceptance criteria must be repeated immediately before the validation step, not only in the initial task brief.

### C15: High-value atom preservation rule (runtime — QuantZhai issue #8)

When compressing context, preserve exact: file paths, function names, CLI flags, environment variables, version strings, error messages, negations, user corrections. Summarise everything else.

### C16: Position-aware prompt ordering (prompt structure)

Order the system prompt so the most forgettable critical content is at the start or end, not the middle. Safety and edit boundaries early; adversarial check and pre-edit checklist at the end.

### C16b: Query-aware contextualization (prompt/task structure — NEW)

```
When providing the agent with a set of files or search results, repeat the
task objective both at the beginning and end of the data block.
```

**Source:** Lost in the Middle §4.2 (query-aware contextualization boosts key-value retrieval to perfect accuracy)
**Token cost:** ~20 tokens (one-line repeat of the task goal)
**Test:** Give agent a multi-file task. Compare fix quality with goal stated once vs goal stated before and after the file list.

---

## Follow-up

1. **C12, C15, C16, C16b** added to candidate structures.
2. **Note the corrections applied:** architecture dependence, scale dependence, instruction-tuning hypothesis corrected, distance-between-evidence as separate factor, CoT degradation on non-instruction-tuned models, query-aware contextualization added.
3. **Test C12 locally** — give existing QuantZhai prompt a task with non-goals and see if checklist catches violations.
4. **Test C16b** — compare agent behaviour with goal stated once vs goal stated before and after file list.
5. **A coding-agent-specific position-bias test** would be valuable but is outside this subproject's scope.
