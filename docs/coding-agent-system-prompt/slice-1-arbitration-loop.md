# Slice 1: Human/assistant/coding-agent arbitration loop

Status: completed  
Date: 2026-05-28  
Confidence: medium  
Parent: `research-plan.md` Slice 1

---

## Question

What working structures should a coding-agent prompt support when the broader workflow includes a human director, assistant/reviewer, and coding worker?

## Hypothesis

The best structure is an explicit arbitration loop:

```text
pain / suspicion
  -> exact desired behaviour
  -> asset inventory
  -> donor scan
  -> constrained implementation brief
  -> coding-agent patch
  -> review/hardening
  -> live workflow validation
  -> durable note
```

## Sources inspected

### Internal

| Source | What it contributed |
| --- | --- |
| `workflow-patterns.md` | Core productive loop (suspicion -> audit -> hypothesis -> slice -> execute -> validate -> document) |
| `hsm_ai_workflow_arbitrator_observations.md` | 14 patterns from PuTTY OSC52 case study; convergence ladder (pattern 14); bounded patch loop template; suggested arbitrator loop |
| QuantZhai #37 | Architectural seam extraction: design-first, test-backed extraction loop |
| QuantZhai #40 | Stream watchdog: explicit failure state taxonomy before implementation |
| QuantZhai #41 | Signal surface map: map-then-implement discipline |
| QuantZhai #43 | Repeated-read live smoke: test-after-implement pattern |
| QuantZhai #44 | Backend control plane audit: audit-doc-first pattern |
| QuantZhai #65 | Docker lifecycle: slice-based design (Slice A design, B-D implementation, E smoke) |
| `reference-quantzhai-codex-core-qwenified.md` | Baseline QuantZhai prompt — does NOT encode arbitration loop |

### External

| Source | Key finding |
| --- | --- |
| Codex Max prompt (gist) | Two-role model (human + coding agent). No upstream assistant/reviewer role. No asset inventory, donor scan, or difficulty reclassification. Single monolithic prompt. |
| Claude Code general-purpose agent | Same two-role model. Subagent reports to caller, no encoding of arbitration stages upstream. |
| Claude Code explore agent | Read-only specialist. Explicit role boundary. No arbitration loop. |

## Research tasks completed

### 1. Extract recurring loop stages

Three independent formulations of the same loop exist across internal docs:

**workflow-patterns.md:**
```text
suspicion/friction -> evidence audit -> hypothesis -> slice plan -> execute -> focused validation -> real workflow check -> durable docs -> next slice
```

**arbitrator observations pattern 14 (convergence ladder):**
```text
complaint -> desired behaviour -> asset inventory -> donor scan -> constrained spec -> agent implement -> review harden -> build/test -> workflow validate -> document/remember
```

**arbitrator observations (suggested arbitrator loop):**
```text
parse friction -> extract behaviour -> inventory assets -> search donors -> classify difficulty -> produce brief -> delegate edits -> review -> get real test -> convert to durable memory
```

**Common core across all three:**
```text
friction/pain
  -> exact desired behaviour
  -> asset inventory (what exists)
  -> donor/pattern research (how others solved it)
  -> constrained implementation brief (what + non-goals)
  -> coding-agent execution
  -> focused validation
  -> lived workflow proof
  -> durable note
```

### 2. Identify coding-agent prompt vs upstream placement

**Critical finding: The arbitration loop is NOT a coding-agent prompt structure. It is an upstream process structure.**

The coding agent is the WORKER in this loop, not the controller. The loop is owned by the human + assistant/reviewer. Putting the full loop into the coding-agent system prompt would:
- Cause over-planning (agent would try to inventory assets and run donor scans before every edit)
- Create role confusion (the coding agent should not be deciding task difficulty classification)
- Add bureaucracy to simple tasks

What belongs in the coding-agent system prompt is a SUBSET of the loop that governs the coding agent's behaviour within it:

```text
Upstream (assistant/spec docs):   Coding-agent prompt:
───────────────────────────────   ───────────────────────────────
friction/pain                     [not visible to coding agent]
exact desired behaviour           acceptance criteria in task brief
asset inventory                   [not visible — upstream resolves this]
donor scan                        [not visible — upstream resolves this]
constrained implementation brief  task brief with non-goals
coding-agent patch                [the agent's job]
review/hardening                  validation honesty + evidence reporting
lived workflow proof              validation states (not_run/focused/full/smoke)
durable note                      changed-file report + test result
```

### 3. Compare against real examples

| Example | Loop stages observed | Outcome |
| --- | --- | --- |
| PuTTY OSC52 | friction -> desired behaviour -> asset inventory -> donor scan (mintty, Alacritty, WezTerm, kitty) -> constrained spec -> OpenCode patch -> review -> build/test -> real workflow test -> README note | Success, 2 commits |
| QuantZhai #40 (watchdog) | design doc -> taxonomy -> implementation -> tests | Success |
| QuantZhai #41 (signal map) | doc-first mapping -> implementation deferred | Design only (intentional) |
| QuantZhai #44 (backend audit) | audit doc -> readiness helper -> script update | Success |
| QuantZhai #65 (Docker lifecycle) | Slice A design -> Slices B-D implementation -> Slice E smoke | In progress |

All observed successful QuantZhai slices follow a variant of the loop. The ones that skip stages (no donor scan, no asset inventory) are the ones with known codebases and familiar patterns.

### 4. Compare against external prompts

**All external prompts (Codex Max, Claude Code) use a two-role model: human + coding agent.**

Neither encodes:
- An upstream assistant/reviewer role
- Asset inventory as a distinct stage
- Donor scan as a distinct stage
- Difficulty reclassification
- Explicit lived-workflow validation gate

**Implication:** The three-role arbitration loop is novel relative to vendor prompts. This is either:
- (a) A genuine improvement for the HSM-style split-role workflow (supported by PuTTY example), or
- (b) Unnecessary overhead that vendors deliberately avoided for generality.

Current evidence favours (a) for this specific use case, but it is unproven for general coding-agent usage.

## Adversarial review

### Q1: Could this make simple tasks too bureaucratic?

**Yes.** A 10-stage loop for "fix typo in README.md" would be absurd.

**Mitigation:** The loop is for non-trivial tasks. Simple tasks skip directly to patch. Need an explicit trigger gate: "Run this loop only when the task is non-trivial, the codebase is unfamiliar, or the user requests it."

**Evidence:** In the PuTTY example, asset inventory + donor scan were the critical steps. In a trivial typo fix, they would be overhead. The loop is not one-size-fits-all.

### Q2: Could this cause over-planning instead of editing?

**Yes.** The loop has 3 planning-adjacent stages (asset inventory, donor scan, constrained spec) before implementation. If the coding agent runs these, it will plan more than it edits.

**Mitigation:** The coding agent must NOT own these stages. They belong upstream in the assistant's process. The coding agent receives the constrained brief as input.

**Risk:** Even in the upstream assistant, there is a danger of over-planning — producing a beautiful spec that never gets implemented. QuantZhai issues #37, #40, #41, #44, #65 all follow the design-first pattern and all produced working code. So the risk is real but manageable with slice discipline.

### Q3: Should the coding agent always run donor scans, or only when the task is novel?

**The coding agent should NOT run donor scans.** This is an upstream function.

**Why:** Donor scan requires:
- External search (web/GitHub)
- Judgment about which donors are authoritative
- Attribution and legal awareness
- Architectural comparison across projects

A coding agent running in a local repo with a tool budget should not be doing open-ended web research for donor patterns unless explicitly instructed.

**Exception:** If the coding agent is specifically tasked with a donor scan as its entire job (e.g., "find similar implementations in this repo"), it can do a repo-local search. But the cross-project donor scan belongs upstream.

### Q4: Does this belong in the system prompt or in task briefs?

**Mostly in task briefs / upstream process docs.**

The coding-agent system prompt should encode:

```text
suspicion as search heuristic (do not implement directly from suspicion)
inspect before implement (find owning files first)
non-goals tracking (stay within slice bounds)
validation honesty (report real vs partial test results)
```

These are NOT the arbitration loop itself. They are the encoding of the CODING AGENT'S ROLE within the loop.

The full arbitration loop belongs in:
- `docs/process` (for the human)
- upstream assistant prompts (for the assistant/reviewer)
- task brief templates (for handoff to the coding agent)

### Additional adversarial findings

**Q5: Are external prompts a valid comparison?**

Only partially. Codex and Claude Code are designed as **single-agent systems** where the human interacts directly with the coding agent. They don't need an arbitration loop because there's no third role. Their design choice is valid for their use case. It does NOT mean the arbitration loop is wrong for a multi-agent workflow.

This slice's adversarial finding: the hypothesis is comparing two different system architectures. The loop is not a "better" coding-agent prompt structure — it's a different architecture (three-role vs two-role). The real question (for the QuantZhai runtime context, not this subproject) is: should the broader system use three roles or two? This subproject's scope is limited to what the coding-agent prompt should contain within whichever architecture is chosen.

**Q6: What would make this fail in QuantZhai?**

If the coding agent receives a well-formed task brief that already encodes all constraints, the loop is already partially completed upstream. If the upstream assistant produces poor briefs (vague scope, no non-goals, no acceptance criteria), the loop fails at the handoff point, not inside the coding agent.

The failure mode is: **upstream does the loop poorly, downstream suffers.** This is correct — the loop is an upstream process discipline.

## Conclusion

Decision: **adopt with constraints** (not as coding-agent prompt structure, as upstream process)

Confidence: **medium**

### Evidence for

- PuTTY OSC52 case study shows the full loop produces convergent, successful outcomes (N=1, strong but single example)
- QuantZhai issues #37-#65 consistently use a design-first/test-backed pattern that matches the loop
- External prompts do NOT encode an arbitration loop, confirming it's not needed for two-role systems but may be needed for three-role

### Evidence against

- N=1 for the full loop (PuTTY only; QuantZhai examples are narrower)
- External vendors deliberately chose two-role systems; they may have evidence that three-role is slower
- No controlled comparison between two-role and three-role for the same task

### Uncertainty

- Whether the loop improves outcomes over a skilled human writing tight briefs without a formal process
- Whether the loop becomes overhead for experienced users who already do it implicitly
- Whether QuantZhai should be two-role (user + coding agent) or three-role (user + assistant + coding agent)

### Risk

- If the loop is encoded in the coding-agent prompt, it will cause over-planning and bureaucracy
- If it's encoded only in upstream docs, it may be skipped by lazy upstream work
- The three-role system may be too heavy for simple tasks

## Candidate structures

These are the structures that belong in the coding-agent system prompt (the worker's role within the loop), NOT the full arbitration loop.

### C1: Suspicion-as-search-heuristic (prompt structure)

```text
When the user gives a suspicion, treat it as a search heuristic, not proof.
Inspect source/captures/tests before implementing.
If the change is trivial (<10 lines, single file, simple logic), proceed directly.
Do not implement from suspicion alone unless the fix is obvious and the evidence is already present.
```

**Belongs in:** coding-agent system prompt (under task-framing scaffold)
**How to test:** Give agent a suspicion with wrong root cause; check if it inspects before implementing.

### C2: Slice-discipline gate (prompt structure)

```text
For non-trivial changes, identify the smallest useful behaviour slice.
Track non-goals explicitly.
Do not expand into adjacent cleanup, refactoring, or documentation unless the task brief explicitly includes them.
```

**Belongs in:** coding-agent system prompt (under edit-boundary scaffold)
**How to test:** Give agent a narrow bug report in a messy file; check if it fixes only the bug or also cleans up surroundings.

### C3: Evidence-before-edit rule (prompt structure)

```text
Before editing, inspect the owning file(s), relevant tests, and local instructions.
If current source contradicts the task brief's suspected fix shape, follow the source and report the corrected shape.
```

**Belongs in:** coding-agent system prompt (under exploration scaffold)
**How to test:** Give a task brief with a plausible but wrong diagnosis; check if the agent discovers the real issue during inspection.

### C4: Validation-honesty contract (prompt structure)

```text
After editing, report:
- what validation was run (commands executed)
- what validation was not run (commands not executed)
- validation state: not_run, focused_pass, full_pass, smoke_yellow, smoke_red, blocked
Do not call a result green if only focused or synthetic validation was run.
```

**Belongs in:** coding-agent system prompt (under validation scaffold)
**How to test:** Run agent on a fix without tests; check if it reports "no tests available" or "not_run" rather than claiming success.

### C5: Arbitration loop template (process structure — NOT prompt)

This belongs in `docs/process` or upstream assistant prompts, NOT in the coding-agent system prompt.

```text
## Arbitration loop for non-trivial tasks

1. **Friction/pain** — What is actually wrong or annoying?
2. **Exact desired behaviour** — What concrete path should work?
3. **Asset inventory** — What code, build, tools, docs, agents, and donor projects exist?
4. **Difficulty reclassification** — Is this greenfield or a bounded transplant?
5. **Donor scan** — Which existing projects solved this? What shape should be borrowed?
6. **Constrained brief** — Produce task brief with: objective, constraints, non-goals, likely files, exact tests, acceptance criteria, red lines.
7. **Coding agent** — Feed brief to coding agent; let it produce focused patch.
8. **Review/harden** — Check safety, encoding, errors, tests, docs.
9. **Lived workflow test** — Does the original pain disappear in real use?
10. **Durable note** — Commit, README update, test script, lesson learned.

Use abbreviated forms (skip 3-5) for known patterns, trivial fixes, and familiar codebases.
```

**Belongs in:** docs/process structure
**How to test:** Apply to next non-trivial feature; compare outcome against ad-hoc workflow.

## Follow-up

1. **Experimental test:** Next time a non-trivial QuantZhai feature is designed, apply the full arbitration loop explicitly and compare with prior features that used it implicitly.
2. **Prompt integration:** Add C1-C4 as candidate structures to `candidate-structures.md` (Slice 10 output).
3. **Process integration:** Consider adding C5 to QuantZhai workflow docs or HSM arbitrator process notes.
4. **Architecture decision affects placement:** Whether the broader QuantZhai runtime stays two-role (user + coding agent) or adopts three-role (user + assistant + coding agent) affects how much of the loop goes upstream versus into the coding-agent prompt. This decision is outside this subproject's scope, but candidate structures C1-C4 apply regardless.
