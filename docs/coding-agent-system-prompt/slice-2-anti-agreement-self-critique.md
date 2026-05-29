# Slice 2: Evidence, anti-agreement, and self-criticism

Status: completed  
Date: 2026-05-28  
Confidence: medium  
Parent: `research-plan.md` Slice 2

---

## Question

How should the prompt require self-critique without making the coding agent slow, argumentative, or timid?

## Hypothesis

The useful structure is not "argue with the user." It is:

```text
classify claim
list evidence for
list evidence against
name uncertainty
choose next useful action
```

## Sources inspected

| Source | What it contributed |
| --- | --- |
| `docs/anti-agreement-harness.md` | Full classification system (7 claim types + Evidence/Inference/Uncertainty/Risk/Next frame); challenge obligations; source-check discipline |
| `docs/runtime-and-integrity.md` | Integrity loop: extract claims -> check source support -> check state conflict -> decide update class -> record provenance |
| `workflow-patterns.md` | Cross-linking observation (adversarial reasoning as load-bearing structure); suspicion-handling scaffold |
| `slice-1-arbitration-loop.md` | C3 (evidence-before-edit), C4 (validation-honesty) candidate structures |
| Codex Max prompt | No explicit adversarial review or self-critique pattern. Validation guidance (start specific, go broader) but no "evidence against" or uncertainty labelling. |
| Claude Code review prompts | Three-state classification: CONFIRMED / PLAUSIBLE / REFUTED with explicit criteria for each. Used for code review, not agent self-critique. |
| Promptware Engineering (arXiv 2503.02400) | Treats prompts as software artifacts with SE lifecycle (testing, debugging, evolution). No specific adversarial structures for coding-agent prompts, but lifecycle framing supports the idea of prompt verification. |

## Research tasks completed

### 1. Extract anti-agreement rules that map to coding tasks

The anti-agreement harness defines these rules. Each maps to a coding-task equivalent:

| Anti-agreement rule | Coding-task equivalent |
| --- | --- |
| evidence before inference | Inspect files/repo/tests before implementing. Don't implement from suspicion. |
| correction before rapport | When source contradicts user's hypothesis, follow the source and report the correction. |
| uncertainty before false confidence | Label validation states: not_run, focused, full, smoke. Don't call it green without the lived workflow check. |
| source boundaries before smooth narrative | Report what was checked and what wasn't. Cite paths, commands, test results. |
| contradiction preservation before coherence theatre | A test that fails after your change is not "works except for..." — it's a red result. Report it. |
| falsifiability before theory-protection | State what would prove your fix wrong. If you can't, the fix may be untestable. |

### 2. Compare against external review patterns

**Claude Code review** is the closest match. It uses a three-state classification system (CONFIRMED / PLAUSIBLE / REFUTED) that mirrors the anti-agreement harness's claim classification. Key differences:

- Claude's system is for reviewing OTHER people's code, not self-critique
- Claude uses CONFIRMED/PLAUSIBLE/REFUTED — a subset of the anti-agreement harness's 7-class system
- Claude's verification is external (separate verifier agent), not internal (agent checking its own work)

**Codex Max** has no adversarial structure at all. The closest is the validation philosophy ("start specific, then broader") and sandbox escalation rules — but these are procedural, not epistemic.

**Finding:** External prompts either have no adversarial structure (Codex Max) or have it only for a separate reviewer role (Claude Code review). No external prompt encodes self-critique as an explicit reasoning phase for the coding agent's own work.

### 3. Separate useful self-critique from visible over-explanation

**Useful self-critique** is about what the agent observed, what it assumes, and what it didn't check. It shows up in the final answer as signal about reliability.

**Over-explanation** is the agent narrating every doubt aloud during work. "I'm not sure if this is the right file... I'll check... Actually it might be the other file..." — this is noise, not critique.

**Boundary rule:** Self-critique is OUTPUT-visible, not PROCESS-visible. The agent should do its work normally, apply an internal adversarial check on its own conclusions before reporting, and report the results of that check concisely in the final answer.

**Exception:** If the agent discovers during investigation that the user's hypothesis is wrong, that should be reported immediately, not hidden until the final answer. This is correction-before-rapport, not process noise.

### 4. Define when adversarial review must be visible vs internal/task-local

| Task type | Adversarial review | Visibility |
| --- | --- | --- |
| Trivial (typo fix, single-line change) | None | Not needed |
| Known pattern (add route following convention) | Light: check conventions were followed | Final answer only |
| Non-trivial bug fix | Full: what was inspected, what was assumed, what remains uncertain | Final answer |
| New feature / unfamiliar codebase | Full + evidence-for/evidence-against/uncertainty | Final answer + any mid-task corrections to user's hypothesis |
| Review / audit | Per Claude Code pattern (CONFIRMED/PLAUSIBLE/REFUTED) | Report structure |

**Rule of thumb:** If the change could be wrong in a way the agent wouldn't notice, adversarial review is needed. If the change is mechanically straightforward (rename, format, obvious bug), skip it.

## Adversarial review

### Q1: Could "evidence against" become performative noise?

**Yes.** "I fixed the typo. Evidence against: the typo might still be there." That's a checkbox exercise that adds no value.

**Mitigation:** Require source citations for both evidence-for and evidence-against. "Evidence against" must cite an uninspected code path, an untested edge case, an unverified assumption — not just "it might be wrong." If there is no concrete evidence against, say "none found" and stop.

**Evidence from Claude Code review:** The recall-biased variant (part 5) explicitly says "REFUTED only when constructible from the code" — this is the right discipline. Evidence against must be concrete, not speculative.

### Q2: Could the agent invent counterarguments without evidence?

**Yes.** A model can generate plausible-sounding counterarguments without actually checking. "Evidence against: the API might return 403" — without actually calling the API.

**Mitigation (same as Q1):** Require source references. "I did not check X" is honest. "X might be wrong" with no reference is noise.

**Design rule:** The classification output must distinguish:
- "I checked: file Y line Z shows..." (evidence)
- "I did not check: file Y because..." (gap)
- "I assume: because no evidence contradicts..." (inference)
- No free-floating "might" without source context.

### Q3: Could this create refusal-like paralysis?

**Yes.** If the agent must run an adversarial check before every tool call, it will never finish.

**Mitigation:** The adversarial check runs ONCE — between implementation and final answer. It is a blink, not a loop. Do the work, check it once, report.

**Evidence from workflow-patterns.md:** The suspicion-handling scaffold already says "This is a scaffold, not a mandatory answer format." Same principle here — the adversarial check is a standard, not a straitjacket.

### Q4: What is the minimum viable adversarial check?

For a coding agent prompt:

```text
Before finalizing, check:
1. Did I inspect the owning files, or did I implement from memory/suspicion?
2. Did I run validation, or am I assuming it works?
3. What would make this wrong that I haven't checked?
```

Three questions. One second of reasoning. No verbose output unless the answers reveal a real problem.

### Q5: Does this belong in the system prompt, or in task briefs / tool contracts?

The minimum viable check (3 questions) belongs in the system prompt — it's a general reasoning discipline that applies to every non-trivial task.

The full Evidence/Inference/Uncertainty/Risk frame belongs in the final-answer contract (also prompt-level), but only for complex tasks.

The CONFIRMED/PLAUSIBLE/REFUTED classifier belongs in code-review mode / specialised review prompts, not the default coding prompt.

## Conclusion

Decision: **adopt with constraints**

Confidence: **medium**

### Evidence for

- Anti-agreement harness provides a well-structured framework that can be adapted for coding-agent use
- Claude Code review prompts already use a similar three-state classifier (CONFIRMED/PLAUSIBLE/REFUTED) — proven effective for code review
- The cross-linking observation in workflow-patterns.md identifies adversarial reasoning as a load-bearing structure, not optional
- External prompts have no self-critique structure, suggesting this is an underexplored area worth testing

### Evidence against

- No external coding-agent prompt uses self-critique as an explicit phase — they all skip it or handle it procedurally (validation steps, not epistemic checks)
- Risk of performative noise is real and hard to tune without local testing
- Minimum viable check has not been tested locally — the right weight is unknown

### Uncertainty

- Whether the minimum viable check (3 questions) is enough or too much for local Qwen/Codex behaviour
- Whether "evidence against" will produce useful signal or boilerplate in practice
- Whether the adversarial check should be a separate reasoning pass or merely a final-answer template constraint

### Risk

- Overweighting adversarial review makes the agent slow and timid — the exact opposite of the "bias to action" in the QuantZhai baseline prompt
- Underweighting it lets agreement-engine drift continue unchecked
- The right balance can only be found through local testing

## Candidate structures

### C6: Minimum viable adversarial check (prompt structure)

For non-trivial changes, before finalizing:

```text
Before finalizing, check:
1. Did I inspect the owning files, or did I implement from memory or assumption?
2. Did I run validation, or am I assuming it works?
3. What would make this wrong that I haven't checked?
```

For trivial changes, skip.

**Belongs in:** coding-agent system prompt (under validation scaffold, or as a separate final-answer preflight)
**How to test:** Give agent a non-trivial bug with a plausible-but-wrong diagnosis. Check whether the adversarial check catches it before final answer.

### C7: Three-state claim classification for review mode (prompt structure)

For review/audit tasks, use the three-state classifier:

```text
Classify each finding as:
- CONFIRMED — can name the inputs/state that trigger it. Quote the line.
- PLAUSIBLE — mechanism is real, trigger is uncertain. State what would confirm it.
- REFUTED — factually wrong or guarded elsewhere. Quote the line that proves it.
```

**Belongs in:** coding-agent system prompt (under review-mode section) or task brief for review tasks
**Note:** This is adapted from Claude Code's review pattern. It is proven for code review.
**How to test:** Give agent a diff with actual bugs, plausible false positives, and harmless changes. Check classification accuracy.

### C8: Evidence-before-edit gate (prompt structure — refinement of C3)

When the user's task brief includes a suspected root cause:

```text
Before implementing, inspect the owning file(s). If the source contradicts the
task's suspected fix, follow the source and report the corrected shape before editing.
```

**Already defined in Slice 1 as C3.** Listed here to show the connection to the anti-agreement harness.

### C9: Validation-honesty contract (prompt structure — refinement of C4)

```text
After editing, report what validation was run, what validation was not run, and
the validation state for each: not_run | focused_pass | full_pass | smoke_yellow | smoke_red | blocked.
Do not call a result green without explaining which state it covers.
```

**Already defined in Slice 1 as C4.** Listed here to show the connection.

### C10: Adversarial review as explicit prompt section (structural decision)

This is the open design question from the cross-linking observation in `workflow-patterns.md`. Two options:

**Option A (process-only):** Adversarial review lives in upstream docs and tool contracts. The coding-agent prompt gets C6 (minimum check) and C9 (validation honesty) only. No explicit adversarial reasoning phase.

**Option B (prompt-visible):** The coding-agent prompt includes an explicit section:

```text
### Self-critique

Before finalizing a non-trivial change, run a quick adversarial check:
- What evidence supports my approach? (cite files, tests, or commands)
- What evidence contradicts it or what remains unchecked? (name specific gaps)
- What would falsify my fix?
Then report the results concisely in the final answer when they reveal real uncertainty.
```

**Decision:** Defer. The right weight depends on local testing. Add C6 (minimum check) to the prompt for now. If it produces useful signal without slowing the agent, expand to the full adversarial check. If it produces noise, keep it as process-only.

### C11: Anti-agreement final answer template (prompt structure)

For non-trivial changes, compress the adversarial check into the final answer:

```text
Checked: [files, commands, tests]
Did not check: [gaps]
Assumed: [inferences]
Uncertain: [what remains ambiguous]
```

**Belongs in:** coding-agent system prompt (under final-answer contract)
**How to test:** Compare final answers with and without this structure. Do they contain fewer false claims of certainty?

## Follow-up

1. **Add C6 (minimum viable check) to candidate structures** for Slice 10 consolidation.
2. **Test C11 (anti-agreement final answer)** against the QuantZhai baseline prompt — does it improve reporting honesty without adding verbosity?
3. **Defer C10 decision** until C6 can be evaluated in a local run.
4. **The cross-linking observation in workflow-patterns.md** already connects this slice to the anti-agreement harness, C3/C4 from Slice 1, and the adversarial review gate from the research protocol. That connection was the direct result of the user's observation about adversarial reasoning as an allocation heuristic.
