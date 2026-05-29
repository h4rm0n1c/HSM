# Slice 3: Context-position and middle-detail loss

Status: completed  
Date: 2026-05-28  
Confidence: medium  
Parent: `research-plan.md` Slice 3

---

## Question

How should prompt structures compensate for important middle-context details being lost?

## Hypothesis

Critical constraints should be repeated near action points as short local checklists rather than buried once in long prose.

## Sources inspected

| Source | What it contributed |
| --- | --- |
| Lost in the Middle (arXiv 2307.03172) | Foundational result: performance degrades when relevant info is in the middle of long contexts. Best at start/end. Even long-context models show this. Task: multi-document QA + key-value retrieval. Accepted at TACL 2023. |
| Lost in the Middle multi-hop (arXiv 2412.10079) | Problem is worse when multiple pieces of info must be connected across context positions. Mitigations: reduce superfluous content (KG extraction, summarization), chain-of-thought prompting. |
| Found in the Middle (arXiv 2403.04797) | Model-level mitigation via Ms-PoE positional encoding. 3.8 avg accuracy gain on Zero-SCROLLS. Problem is partly architectural (RoPE decay), not fully prompt-solvable. |
| `workflow-patterns.md` | Already identified the flaw and proposed mitigations: repeat constraints near action points, checklists before edits, don't bury non-goals |
| QuantZhai issue #8 | Survival-weighted compaction RFC. Tangentially relevant (what survives compression vs position loss). |

## Research tasks completed

### 1. Summarize what the papers actually show

**Lost in the Middle (2307.03172) — the foundational result:**

- Task: Given N documents, find the one with the answer. The relevant document is placed at position 1, N/2, or N.
- Finding: Performance is best when the relevant document is first, worst when it's in the middle. The U-shaped curve is consistent across model families and sizes.
- Even models fine-tuned for long context (e.g., 32K) show the same U-shape, just with a wider plateau.
- **Critical nuance for coding-agent prompts:** The paper tests document retrieval, not task execution. The coding-agent scenario is different — the model is executing a sequence of actions, not picking one answer from a document pile. The position bias likely applies differently when the model is actively reading, editing, and testing.

**Multi-hop (2412.10079) — extension to connected evidence:**

- When the task requires connecting information from two different positions in the context, performance degrades more than single-position loss.
- Prompt-side mitigations (reducing superfluous content, CoT) help but don't eliminate the problem.
- **Coding-agent relevance:** Software tasks often require connecting a constraint from the task brief (start of context) with a file observation from a read tool (end of context). If the constraint is in the middle of a long prompt, it's doubly disadvantaged — both by position and by the need to connect across positions.

**Found in the Middle (2403.04797) — architectural mitigation:**

- Ms-PoE modifies RoPE position indices to reduce long-term decay, assigns different scaling to different attention heads.
- This is a model-level fix, not a prompt-level fix. It shows the flaw is partly architectural.
- **Implication for prompt design:** Prompt-level mitigations can help but cannot fully compensate for an architectural position bias. The prompt structures should work WITH the bias (put critical things at start/end) rather than trying to override it.

### 2. Identify what is directly applicable to coding-agent prompts

**What transfers from the papers:**

- The U-shaped position bias is real and affects all tested models. Coding agents are not immune.
- Constraints in the MIDDLE of a long prompt or task brief are the most likely to be lost.
- Connecting two pieces of information across positions (constraint + observation) is harder than using either alone.

**What does NOT transfer directly:**

- The paper tasks are document QA, not software task execution. A coding agent reads files, runs commands, and edits — a different cognitive load profile.
- The papers test single-answer retrieval. A coding agent works over multiple turns with tool feedback, which may shift position effects.
- Long-context models are improving. The 2023 results may not hold at the same magnitude for 2026 models (Qwen3.6, etc.).
- **Ms-PoE** is a model-level RoPE modification — not applicable to prompt design.

**What the coding-agent scenario changes:**

In a coding-agent context, "middle" can mean any of:
1. Middle of the system prompt (base instructions buried under identity + tools + rules)
2. Middle of a long task brief (constraints between context and acceptance criteria)
3. Middle of a long file being read (relevant function surrounded by boilerplate)
4. Middle of a long conversation (earlier instructions overshadowed by later ones)

Each has different implications.

### 3. Distinguish model-level from prompt-structure mitigations

| Mitigation | Level | Limitation |
| --- | --- | --- |
| Ms-PoE positional encoding | Model | Requires model modification; not available in QuantZhai's Qwen setup |
| Reduce superfluous context | Prompt/runtime | Already done in QuantZhai compaction; limited by what the agent needs |
| Repeat constraints near action points | Prompt structure | Testable now; risk of bloat |
| Put critical content at start/end of prompt | Prompt structure | Feasible; conflicts with other ordering constraints |
| Short checklists before edits | Prompt structure | Testable now; candidate structure |

**Finding:** The most practical mitigations for this subproject are prompt-structure level. Model-level fixes (Ms-PoE) are outside scope.

## Adversarial review

### Q1: Does repeating constraints increase compliance or just bloat?

**It can do both.** The papers suggest repetition near the action point helps. The risk is:
- Repeating every constraint doubles or triples the prompt length
- Repeated content may cause instruction overshadowing (later instructions outweigh earlier ones)
- The agent may learn to wait for the "local checklist" and ignore the main prompt

**Mitigation:** Do not repeat everything. Repeat only:
1. Non-goals (most commonly violated during scope creep)
2. Acceptance criteria (most commonly lost between brief and validation)
3. Safety/edit boundaries (most consequential when forgotten)

Everything else lives in the base prompt and task brief once.

### Q2: Which details deserve repetition?

From the analysis of failure modes in `workflow-patterns.md` and observed behaviour:

| Detail | Repetition worth? | Reason |
| --- | --- | --- |
| Non-goals | **Yes** | Scope creep is the most common failure pattern |
| Acceptance criteria | **Yes** | Agents often implement and then validate against different criteria |
| File paths / function names | **Maybe** | Repeat near the edit step, not earlier |
| Tool prohibitions | **No** (if in base prompt) | Base prompt is read once; repeating in every task brief is wasted tokens |
| Style instructions | **No** | Style is optional; correctness is not |
| Safety boundaries | **Yes** | Sandbox rules near tool-use instructions |
| The adversarial check (C6) | **No** | Should fire once before final answer, not repeated |
| Exact commands from user | **No** | User commands are early-context; they already have position advantage |

**Rule:** Repetition is for things the agent would not notice it forgot. Non-goals and acceptance criteria are forgettable. Tool prohibitions and style guides are not.

### Q3: Can a local checklist replace repetition?

**Yes — this is the better approach.**

Instead of repeating "do not refactor unrelated code" in three places, have a short pre-edit checklist:

```text
Before editing, confirm:
  - This change is within the stated non-goals? [Y/N]
  - I have inspected the owning file? [Y/N]
  - The fix addresses the root cause, not a symptom? [Y/N]
```

This is lighter than full prose repetition and forces the check at the right point.

**Evidence from the multi-hop paper:** Reducing superfluous content helps. A checklist is less superfluous than repeated prose.

### Q4: Does this belong in prompt wording, task packet format, or compaction logic?

| Structure | Belongs in |
| --- | --- |
| Pre-edit checklist | Prompt wording (short, standard) |
| Non-goals near edit instructions | Task packet format (task brief template) |
| Acceptance criteria near validation step | Task packet format |
| High-value atom preservation | Compaction logic (QuantZhai runtime) |
| Position-aware prompt ordering | Prompt wording + harness logic |

**Key boundary:** The prompt should define the *structure* (checklists, repetition rules). The task packet should supply the *content* (specific non-goals, acceptance criteria). The compaction runtime should preserve the *atoms* (paths, flags, versions).

## Conclusion

Decision: **adopt with constraints**

Confidence: **medium**

### Evidence for

- Lost in the Middle papers provide rigorous empirical evidence for U-shaped position bias across model families
- workflow-patterns.md already identified the same flaw independently and proposed the same mitigations — convergent evidence
- The multi-hop extension shows the problem is worse for connected evidence, which is the norm in software tasks
- Checklist approach is lighter than prose repetition and less prone to bloat

### Evidence against

- Paper tasks are document QA, not software engineering — the direct applicability is uncertain
- Model-level fixes (Ms-PoE) may reduce the problem magnitude for newer models; the 2023 results may be partially outdated
- No local testing has been done to measure middle-detail loss in QuantZhai's specific prompt stack + Qwen3.6
- Checklist before every edit could become mechanical and ignored

### Uncertainty

- Whether Qwen3.6 (2025/2026) shows the same U-shape magnitude as the 2023 GPT/LLaMA models tested in the paper
- Whether the pre-edit checklist actually improves constraint retention or becomes token noise
- Whether position bias is different for models running in a tool-use loop (read-edit-test-report) versus static QA

### Risk

- Over-repetition bloats the prompt and may cause instruction overshadowing (later instructions overriding earlier ones)
- Checklists before every edit slow down trivial tasks (typo fix, rename)
- The mitigations may help at the margins but not address the core architectural issue

## Candidate structures

### C12: Pre-edit constraint checklist (prompt structure)

```text
Before editing a non-trivial change, confirm:
- This change stays within the stated non-goals
- The owning file has been inspected
- The fix addresses the root cause, not just the symptom
- Acceptance criteria are still achievable after this edit
```

**Belongs in:** coding-agent system prompt (under edit-boundary scaffold)
**How to test:** Give agent a task with explicit non-goals and a tempting adjacent fix. Check whether the checklist catches the scope creep.

### C13: Non-goals placement rule (task packet structure)

```text
Non-goals must appear in the task brief within 3 lines of the edit instructions,
not only in the introductory context.
```

**Belongs in:** task brief template / upstream docs
**How to test:** Compare scope-creep rate between briefs with non-goals at top vs non-goals near edit instructions.

### C14: Acceptance criteria near validation (task packet structure)

```text
Acceptance criteria must be repeated immediately before the validation step,
not only in the initial task brief.
```

**Belongs in:** task brief template / upstream docs
**How to test:** Compare whether agents validate against the original criteria or invent their own when criteria are only at the start.

### C15: High-value atom preservation rule (prompt + runtime)

For compaction (in the QuantZhai compaction runtime, not the prompt):

```text
When compressing context, preserve exact:
- file paths, function names, line numbers
- CLI flags, environment variables
- version strings, model names
- error messages and exit codes
- explicit negation and constraints
- user corrections

Summarize everything else.
```

**Belongs in:** compaction runtime (QuantZhai), referenceable from prompt
**Already covered by:** QuantZhai issue #8 (survival-weighted compaction RFC)

### C16: Position-aware prompt ordering (prompt structure)

Order the system prompt so the most forgettable critical content is at the start or end, not the middle:

```text
START (high retention):
  executor identity (short)
  tool contract (short)

EARLY:
  safety boundaries
  edit boundaries
  validation honesty

MIDDLE (lower retention — use checklists instead):
  exploration strategy
  plan tool rules
  special user requests

END (high retention):
  final answer contract
  adversarial check (C6)
  pre-edit checklist (C12)
```

**Belongs in:** prompt wording / prompt stack ordering
**How to test:** Compare whether the adversarial check (C6) fires more reliably when placed at the end vs middle of the prompt.

## Follow-up

1. **Add C12 (pre-edit checklist) and C16 (position-aware ordering) to candidate structures** for Slice 10.
2. **Test C12 locally** — give the existing QuantZhai prompt a task with non-goals and see if the checklist catches violations.
3. **Note the paper-to-practice gap:** The Lost in the Middle results are from document QA, not software tasks. A coding-agent-specific position-bias test would be valuable but is outside this subproject's scope.
4. **C15 (high-value atom preservation) already has a home** in QuantZhai issue #8 and the survival-weighted compaction RFC. No need to re-invent here.
