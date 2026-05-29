# Comparison: OpenAI Codex CLI (Codex Max) vs Our Research Findings

Status: research output  
Date: 2026-05-30  
Source: gist.github.com/chigkim/ffed11a3e017d98698707dd24e78af51 (raw `codex.txt`)  
Label note: This gist is referenced as "Codex Max" in `research-references.md`. The
  prompt text identifies itself as the Codex CLI system prompt, not a separate
  "Codex Max" product. This document uses "Codex CLI" as the canonical name.
Research basis: slices 1-10, final-findings-synthesis.md, candidate-structures.md,
  research-external-prompt-comparison.md, research-missing-structures.md,
  research-failure-mode-catalog.md

---

## Purpose

This document evaluates the OpenAI Codex CLI system prompt against our 10-slice
research output. It is the second of three dedicated comparisons (QuantZhai,
Codex CLI, Claude Code).

Unlike the QuantZhai comparison (section-by-section), this document is organised
by our 11-layer taxonomy because the Codex CLI prompt is organised differently
(personality → AGENTS.md → responsiveness → planning → task execution →
sandbox → validation → ambition → progress → final answer → tools).

---

## Layer 1: Executor Identity

**Codex CLI text:**
```
You are a coding agent running in the Codex CLI, a terminal-based coding
assistant. Codex CLI is an open source project led by OpenAI.
```

**Our research validates:**

- **Named harness** (C23, S5): Names both the agent role and the harness
  ("Codex CLI"). Consistent with all vendors.
- **No pair-programming frame** (S5): Uses "coding agent" language. Correct per
  our research.
- **Open-source disclosure**: Unusual but honest. No research finding against or
  for this.

**Our research challenges:**

- **Vendor branding**: "Codex CLI is an open source project led by OpenAI" is
  moderate branding. Cursor is stronger; QuantZhai is none. Our research found
  no behavioural difference from branding strength (S5 AB test).
- **No model name**: Unlike QuantZhai and Claude Code, Codex CLI doesn't name
  the underlying model. The harness presumably injects this elsewhere. Our
  research (M25/S7-4) recommends environment info including model name.
- **No state-as-data rule** (C26, S5): No claim that repo/user state is data,
  not identity.

**Gaps:**

- **No subject identity prohibition** (C26): Missing.
- **No harness boundary statement** (merged into S6-1): Missing.

**Decision: `comparable` to our recommendations.** Vendor naming is within
normal range. Add model name via environment injection (M25).

---

## Layer 2: Tool Contract

**Codex CLI text:** (scattered across sections)
- Tool definitions provided as XML schemas (not in the system prompt text)
- "Use the `apply_patch` tool to edit files (NEVER try `applypatch`)"
- "When searching for text or files, prefer using `rg` or `rg --files`"
- "Before making tool calls, send a brief preamble to the user"
- No explicit parallel-call guidance in the base prompt (tool schema may handle)
- No tool name disclosure prohibition

**Our research validates:**

- **Tool preference guidance** (S7): Prefers `rg`, `apply_patch`. Consistent.
- **Preamble messages before tools** (S7): Unique to Codex CLI. Our research
  didn't address preamble messaging, but it's a reasonable pattern.

**Our research challenges:**

- **No parallel-call guidance** (M2, S7): Codex CLI's base prompt doesn't
  explicitly encourage parallel tool calls. Claude Code, Cursor, and QuantZhai
  all do. This is a gap.
- **No tool name disclosure prohibition** (M1/S6-3): Codex CLI doesn't forbid
  telling the user tool names. Claude Code and Cursor both have this rule.
- **No tool-result clearing warning** (M3/S7-2): Absent.
- **Tool schemas in the system prompt**: Codex CLI includes full JSON schemas in
  the conversation. This is very token-heavy (the raw prompt is >4000 tokens,
  mostly schemas). Our research didn't address schema placement, but it's worth
  noting the token cost.

**Gaps:**

- M1 (tool name disclosure): Missing.
- M2 (parallel-call guidance): Missing.
- M3 (tool result clearing): Missing.

**What Codex CLI does better:**

- Explicit preamble-message guidance is unique and addresses a real UX gap.
  QuantZhai and Claude Code don't specifically tell the agent to announce
  actions before tool calls.

**Decision: `moderate gap`.** Add M2 (parallel guidance) and M1 (tool name
disclosure). Consider preamble guidance as a candidate for our structures.

---

## Layer 3: Task Framing

**Codex CLI text:**
```
## Planning

You have access to an update_plan tool which tracks steps and progress...

Use a plan when:
- The task is non-trivial...
- There are logical phases or dependencies...
- When the user asked you to do more than one thing...
- The user has asked you to use the plan tool (aka "TODOs")
...

## Task execution

You are a coding agent. Please keep going until the query is completely resolved...
Do NOT guess or make up an answer.
...
Fix the problem at the root cause rather than applying surface-level patches.
Avoid unneeded complexity in your solution.
Do not attempt to fix unrelated bugs or broken tests.
Keep changes consistent with the style of the existing codebase.
...

## Ambition vs. precision

For tasks that have no prior context, feel free to be ambitious...
If you're operating in an existing codebase, be surgical and precise...
```

**Our research validates:**

- **Planning tool with conditions** (M5, S1): Codex CLI has the most nuanced
  planning guidance of any prompt we've analysed. It lists specific conditions
  for when to plan, provides high/low quality examples, and says "skip for
  trivial tasks." This is our M5 (planning tool) + M6 (budget heuristic) merged
  and strengthened.
- **Root cause fixing** (S1): "Fix the problem at the root cause" matches our
  arbitration loop's constrained implementation brief.
- **Over-engineering awareness**: "Avoid unneeded complexity" and "Do not
  attempt to fix unrelated bugs" are partial over-engineering guards. Not as
  strong as Claude Code's dedicated section (M4), but present.
- **Ambition vs precision**: Unique concept. Our C2/M4 over-engineering
  prevention doesn't distinguish between new projects and existing codebases.
  Codex CLI's nuance is valuable: be ambitious for greenfield, precise for
  brownfield.

**Our research challenges:**

- **"Persist until resolved" without iteration guard** (FM10): "Please keep
  going until the query is completely resolved" could encourage infinite loops.
  Our C4/C9+M17 validation-honesty contract provides structured failure
  reporting.
- **No explicit over-engineering section** (C2+M4, FM1): The "avoid unneeded
  complexity" rule is weaker than Claude Code's specific examples of what
  not to do. Our research (FM1) considers this a high-severity gap.
- **Plan quality examples**: High-quality and low-quality plan examples are
  unique and useful. Our research didn't propose this, but it's a clear
  improvement over our C12 pre-edit checklist.

**What Codex CLI does better:**

- **Ambition vs precision distinction**: Original and useful. New projects get
  creativity; existing codebases get surgical precision. Our research didn't
  make this distinction. Worth adopting.
- **Detailed plan quality guidance**: High/low quality examples with concrete
  step formats. Stronger than any vendor or our candidate structures.
- **Conditions for planning**: Specific triggers for when to use the plan tool.
  More nuanced than "always plan" or "skip trivial."

**Decision: `strong on planning, weaker on over-engineering`.** Adopt ambition
vs precision distinction into our C2+M4. Add Codex CLI's planning conditions as
an M6 refinement.

---

## Layer 4: Repo / Project Authority

**Codex CLI text:** (extensive AGENTS.md spec section)

```
# AGENTS.md spec

- Repos often contain AGENTS.md files...
- The scope of an AGENTS.md file is the entire directory tree rooted at
  the folder that contains it.
- For every file you touch in the final patch, you must obey instructions
  in any AGENTS.md file whose scope includes that file.
- More-deeply-nested AGENTS.md files take precedence in case of conflicting
  instructions.
- Direct system/developer/user instructions take precedence over AGENTS.md.
```

**Our research validates:**

- **AGENTS.md integration** (M8, S9): Codex CLI has the most comprehensive
  AGENTS.md integration of any prompt we've analysed. It defines scope rules,
  nesting precedence, touch-file constraints, and override priority. This is
  our M8 and M9 merged, with significantly more detail.
- **Priority semantics** (M9): Codex CLI defines: direct user > AGENTS.md for
  touched files > AGENTS.md nesting depth. This is more specific than our M9
  priority chain.
- **Cached AGENTS.md**: Codex CLI states that root AGENTS.md is auto-included
  in the developer message. This matches our M25 harness injection pattern.

**Our research challenges:**

- None significant. Codex CLI's AGENTS.md spec is the strongest of all prompts
  we've analysed. QuantZhai has nothing equivalent. Claude Code has a similar
  4-tier CLAUDE.md system but with different naming.

**Gaps (from our research):**

- None. Codex CLI exceeds our M8/M9 recommendations.

**Decision: `strongest in class`.** Codex CLI's AGENTS.md spec should be the
model for our M8/M9 implementation in QuantZhai.

---

## Layer 5: Investigation / Exploration Scaffold

**Codex CLI text:**
```
- Use `git log` and `git blame` to search the history of the codebase if
  additional context is required.
- Do not waste tokens by re-reading files after calling `apply_patch` on them.
- NEVER propose changes to code you haven't read... (implied by "reading
  and editing rules")
- [No explicit exploration-vs-search distinction]
```

**Our research validates:**

- **Git history as investigation tool** (C1, S1): Codex CLI recommends `git log`
  and `git blame`. Our C1 suspicion heuristic recommends "inspect before
  implementing" but doesn't specify git history. Good addition.
- **"NEVER propose changes to code you haven't read"**: Implicit in the
  execution rules. This matches our C3/C8 (evidence-before-edit). Claude Code
  and Cursor have it as explicit rules.

**Our research challenges:**

- **No exploration-vs-search distinction** (M10, deferred): Codex CLI doesn't
  distinguish between "go explore broadly" and "look up this specific thing."
  Our M10 (deferred) recommended this. Not critical.
- **No evidence-before-edit enforcement**: Unlike Claude Code ("NEVER propose
  changes to code you haven't read" as a standalone rule), Codex CLI's version
  is embedded in task execution rules. May be easier to skip.

**Gaps:**

- C3/C8 (evidence-before-edit): Weaker than Claude Code's explicit rule.
- Needle-query threshold (M10): Missing but deferred in our research.

**Decision: `adequate`.** Add explicit "NEVER propose changes to code you
haven't read" as a standalone rule. The git history recommendation is a good
addition to our C1.

---

## Layer 6: Edit Boundaries

**Codex CLI text:** (scattered across sections)

```
- Do not `git commit` your changes or create new git branches unless
  explicitly requested.
- NEVER add copyright or license headers unless specifically requested.
- Do not add inline comments within code unless explicitly requested.
- Do not use one-letter variable names unless explicitly requested.
- Do not attempt to fix unrelated bugs or broken tests...
- Keep changes consistent with the style of the existing codebase.
- [No existing-changes preservation rule]
- [No file creation guard]
- [No destructive command guard in base prompt—handled by sandbox/approvals]
```

**Our research validates:**

- **No-git-commit rule** (M15, S9): "Do not commit unless asked" matches our
  M15 recommendation and vendor consensus.
- **No-copyright-headers rule**: Our research didn't cover this but it's
  reasonable. Good rule.
- **No unrelated bug fixes** (C2/M4, FM1): "Do not attempt to fix unrelated
  bugs" is a partial over-engineering guard. Consistent with our FM1
  mitigation.
- **Sandbox-based destructive command handling**: Codex CLI relies on its
  sandbox/approval system rather than prompt rules for destructive commands.
  This is an architecture choice, not a prompt gap.

**Our research challenges:**

- **No existing-changes preservation rule** (M12, FM2, CRITICAL): Codex CLI does
  NOT tell the agent to preserve existing user changes. This is a critical gap.
  The sandbox handles destructive commands, but doesn't prevent the agent from
  editing files that contain user changes. Both Claude Code and QuantZhai have
  this rule.
- **No file creation guard** (M13, FM1): Codex CLI doesn't say "NEVER create
  files unless necessary." Claude Code has this. Missing here.
- **No over-engineering guard** (C2+M4, FM1): The "avoid unneeded complexity"
  rule is too vague. Claude Code's dedicated section is far stronger.

**Gaps (critical):**

- M12 (existing-changes preservation): **Missing**. Critical for FM2.
- M13 (file creation guard): Missing. Medium severity.
- C2+M4 (over-engineering prevention): Partial only.

**Decision: `critical gap on M12`.** Codex CLI needs an explicit
existing-changes preservation rule. The sandbox system handles destructive
commands but doesn't prevent editing user changes in files.

---

## Layer 7: Validation Scaffold

**Codex CLI text:** (dedicated "Validating your work" section)

```
If the codebase has tests or the ability to build or run, consider using them
to verify that your work is complete.

When testing, start as specific as possible... then make your way to broader
tests as you build confidence. If there's no test for the code you changed...
you may add one.

Do not attempt to fix unrelated bugs...

Be mindful of whether to run validation commands proactively:
- In non-interactive modes: proactively run tests, lint, etc.
- In interactive modes: hold off, suggest what to do next
- For test-related tasks: run tests regardless of mode

You can iterate up to 3 times to get formatting right...
```

**Our research validates:**

- **Test-specificity philosophy** (S7, S1): "Start specific, then broaden" is
  a calibrated validation approach. Our research didn't propose this specific
  heuristic, but it's consistent with our validation scaffold.
- **3-iteration formatting cap** (M19, S7): Codex CLI has a 3-attempt limit on
  formatting. Cursor has a similar 3-iteration cap on linter errors. Our M19
  was deferred, but Codex CLI proves the concept works in production.
- **Mode-aware validation** (C4/C9+M17): Codex CLI distinguishes interactive
  vs non-interactive modes for validation. Unique insight: in interactive modes,
  running tests slows iteration; in non-interactive, the agent should validate
  fully. Our research didn't make this distinction.
- **Test creation allowed**: "If there's no test... you may add one." Our
  research didn't address this directly, but it's a useful flexibility rule.

**Our research challenges:**

- **No validation-honesty contract** (C4/C9+M17): Codex CLI doesn't require the
  agent to report what was and wasn't validated, or to state validation states.
  It trusts the agent to "consider" validation. Our C4/C9+M17 is stronger.
- **No adversarial self-check** (C6): Codex CLI has no "before finalizing,
  check X, Y, Z" structure.
- **No worktree clean-state rule** (M18): Codex CLI doesn't require a clean
  worktree at end. Our M18 does.

**Gaps:**

- C4/C9+M17 (validation-honesty): Missing.
- C6 (adversarial check): Missing.
- M18 (worktree clean state): Missing.

**What Codex CLI does better:**

- Mode-aware validation (interactive vs non-interactive): Unique and useful.
  Should be adopted into our C4/C9+M17.
- Test-specificity philosophy: "Start specific, broaden out" is a practical
  heuristic our research didn't capture.

**Decision: `moderate gap`.** Add C4/C9+M17. Adopt mode-aware validation and
test-specificity philosophy into our structures.

---

## Layer 8: Safety / Trusted Input Boundary

**Codex CLI text:** (dedicated "Sandbox and approvals" section)

```
Filesystem sandboxing prevents you from editing files without user approval.
Options: read-only, workspace-write, danger-full-access.

Network sandboxing: restricted, enabled.

Approvals: untrusted, on-failure, on-request, never.

You will be told what filesystem sandboxing, network sandboxing, and approval
mode are active...
```

**Our research validates:**

- **Sandbox-aware behaviour** (S6, S7): Codex CLI has the most detailed sandbox
  guidance of any prompt we've analysed. It defines sandbox modes, approval
  modes, and specific scenarios requiring escalation.
- **No system prompt disclosure rule** (M20, S6-1): Codex CLI does NOT forbid
  system prompt disclosure. **Gap.** Claude Code and Cursor both do.

**Our research challenges:**

- **No trusted input boundary** (S6-1, CRITICAL): Codex CLI has no concept of
  trusted vs untrusted channels. The sandbox handles tool execution safety but
  doesn't address prompt injection through file contents, issues, web pages, or
  logs. This is the same critical gap as QuantZhai.
- **No URL generation guard** (S6-2): Codex CLI doesn't forbid generating fake
  URLs. Claude Code does.
- **No security policy** (S6-4): No authorised vs unauthorised security work
  distinction. Claude Code has this.
- **No disclosure prohibition** (M20): Codex CLI doesn't tell the agent to keep
  its system prompt secret. Critical gap.

**Gaps (critical):**

- S6-1 (trusted input boundary): **Missing.** Prompt injection defence absent.
- M20 (system prompt disclosure): **Missing.** Agent may reveal instructions.
- S6-2 (URL guard): Missing. Low severity.
- S6-4 (security policy): Missing. Low severity.

**Decision: `critical gaps`.** Same safety gaps as QuantZhai. Add S6-1
(trusted input boundary) and M20 (disclosure prohibition) as minimum.

---

## Layer 9: Output Contract / Final Answer

**Codex CLI text:** (extensive "Presenting your work and final message" section)

```
Your final message should read naturally, like an update from a concise
teammate...

Brevity is very important as a default. You should be very concise (i.e. no
more than 10 lines)...

### Final answer structure and style guidelines

Section Headers: **Title Case**, use only when they improve clarity.
Bullets: `-` followed by space, 4-6 bullets, ordered by importance.
Monospace: Wrap commands, paths, env vars in backticks.
File References: src/app.ts, src/app.ts:42, b/server/index.js#L10.
Tone: collaborative, concise, factual, present tense, active voice.
Don'ts: no nested bullets, no ANSI codes, no "bold" or "monospace" literals.
```

**Our research validates:**

- **Code-reference format** (M23): `file_path:line_number` with specific
  examples. Matches our M23 recommendation.
- **Brevity guidance** (S9): "Concise as default, no more than 10 lines."
  Consistent with vendor best practices.
- **Section header style** (S9): **Title Case**, use only when needed. Good.
- **Tone guidance** (S9): Collaborative, concise, factual. Matches vendor
  patterns.
- **Bullet structure** (S9): 4-6 bullets, ordered by importance. Matches our
  recommendations.

**Our research challenges:**

- **No apology avoidance** (M7): Codex CLI doesn't forbid apologising. Claude
  Code and Cursor both do.
- **No communication channel clarity** (M24): Codex CLI doesn't explain what
  the user sees vs what is tool-internal.
- **No anti-agreement template** (C11): No uncertainty/assumption marking in
  final answers.
- **"Concise teammate" metaphor**: "Like an update from a concise teammate" is
  a persona framing. Our research (S5) recommends executor-as-data over persona
  framing, but this is mild.

**What Codex CLI does better:**

- Most detailed output format specification of any prompt we've analysed.
  Covers section headers, bullets, monospace, file references, structure,
  tone, and don'ts. Our M23 is a single line; Codex CLI has a full style guide.
- File reference rules are the most specific: standalone paths, accepted
  formats (absolute, workspace-relative, diff prefixes), line/column syntax,
  URI prohibitions.

**Decision: `strong on output, missing M7/M24`.** Codex CLI's output guidance
is the strongest of all compared prompts. Add M7 (apology avoidance) and M24
(channel clarity). Our C11 (anti-agreement) would add useful structure.

---

## Layer 10: Dynamic / Runtime Context

**Codex CLI text:**
```
- [Harness injects: filesystem sandbox mode, network sandbox mode, approval
  mode]
- [No environment info: platform, date, model name]
- [No git status snapshot]
- [No working directory in prompt]

The user is working on the same computer as you, and has access to your work.
```

**Our research validates:**

- **Sandbox mode injection**: Codex CLI's harness tells the agent what sandbox
  and approval mode is active. Our M25/S7-4 recommends environment info block.
  Codex CLI's version is sandbox-specific.
- **"User is on same computer"**: Useful context for the agent. Our research
  didn't propose this but it's relevant.

**Our research challenges:**

- **No environment info block** (M25): No platform, date, or model name.
  Claude Code injects all of these.
- **No git status snapshot** (M26): No git branch or status injection. Claude
  Code injects git status at conversation start.
- **No working directory in prompt**: Not explicitly stated in the base prompt.

**Gaps:**

- M25 (environment info): Missing.
- M26 (git status): Missing.

**Decision: `gaps in dynamic context`.** Add M25 and M26. These are harness
changes, not prompt text changes.

---

## Layer 11: Runtime Feedback / Awareness

**Codex CLI text:**
```
You will be told what filesystem sandboxing, network sandboxing, and approval
mode are active in a developer or user message.

[No compaction awareness]
[No tool-result clearing warning]
[No runtime feedback acceptance]
```

**Our research validates:**

- **Sandbox mode via developer message**: Codex CLI uses a developer message
  (system-reminder equivalent) to inject runtime state. This is consistent with
  our S7-3 (accept runtime feedback) pattern.

**Gaps:**

- S7-2 (tool-result clearing): Missing.
- S7-3 (runtime feedback acceptance): Partial (sandbox mode only).
- S7-6 (compaction awareness): Missing.
- S8-1 (high-value atom preservation): Missing.

**Decision: `gaps in runtime awareness`.** Add S7-2, S7-3, S7-6, S8-1.

---

## Cross-Cutting Findings

### What Codex CLI does best (strengths vs our research)

1. **AGENTS.md spec** — most comprehensive project-authority layer of any prompt
   we've analysed. Far exceeds our M8/M9 recommendations.
2. **Planning guidance** — nuanced planning triggers, high/low quality examples,
   and ambition vs precision distinction. Best-in-class.
3. **Output format specification** — most detailed style guide. Our M23 is a
   single line by comparison.
4. **Sandbox and approval model** — most detailed safety architecture (though
   it addresses execution safety, not prompt injection).
5. **Mode-aware validation** — interactive vs non-interactive behaviour split.
   Unique insight.
6. **Ambition vs precision distinction** — new projects get creativity; existing
   codebases get surgery. Valuable nuance our research missed.

### Critical gaps in Codex CLI

1. **No existing-changes preservation** (M12) — agent may revert user work.
   QuantZhai has this; Claude Code has this. **Critical.**
2. **No trusted input boundary** (S6-1) — no prompt injection defence.
   Same gap as QuantZhai. **Critical.**
3. **No system prompt disclosure prohibition** (M20) — agent may reveal its own
   instructions. **Critical.**
4. **No over-engineering guard** (C2+M4) — "avoid unneeded complexity" is too
   vague for FM1. Claude Code's section is far stronger.
5. **No file creation guard** (M13) — no "NEVER create files" rule.

### Medium gaps in Codex CLI

- M1 (tool name disclosure): Missing.
- M2 (parallel-call guidance): Missing.
- C4/C9+M17 (validation-honesty): Missing.
- C6 (adversarial check): Missing.
- C11 (anti-agreement): Missing.
- M7 (apology avoidance): Missing.
- M24 (channel clarity): Missing.
- M25/M26 (environment/git injection): Missing.

### What Codex CLI does that our research should adopt

1. **Ambition vs precision distinction** — add to C2+M4 over-engineering
   prevention.
2. **Mode-aware validation** (interactive vs non-interactive) — add to C4/C9+M17.
3. **Detailed plan quality examples** — add to M6 planning guidance.
4. **AGENTS.md scope and nesting rules** — use as model for M8/M9 expansion.
5. **File reference format specification** — use as model for M23 expansion.

---

## Layer Coverage Summary

| Layer | Codex CLI | Our Rec | Gap Severity |
|---|---|---|---|
| 1. Executor identity | Adequate | Add state-as-data | Low |
| 2. Tool contract | Weak: no parallel, no disclosure prohibition | Add M2, M1 | Medium |
| 3. Task framing | Strong: planning, ambition/precision | Add explicit C2+M4 | Medium |
| 4. Repo/project authority | **Best in class**: AGENTS.md spec | Use as model | None |
| 5. Investigation | Adequate | Add explicit evidence-before-edit | Low |
| 6. Edit boundaries | **Critical gap**: no M12 existing-changes | Add M12, M13 | **Critical** |
| 7. Validation | Adequate: mode-aware but no honesty contract | Add C4/C9+M17 | Medium |
| 8. Safety | **Critical gap**: no S6-1, no M20 | Add S6-1, M20 | **Critical** |
| 9. Output contract | **Best in class**: detailed style guide | Add M7, M24 | Low |
| 10. Dynamic context | Missing: no env/git | Add M25, M26 | Medium |
| 11. Runtime awareness | Missing: no compaction, no tool-result warning | Add S7-3, S8-1 | Medium |

---

## Adoption Priority for Our Candidate Set from Codex CLI

### Adopt from Codex CLI

1. **Ambition vs precision distinction** — add to C2+M4.
2. **Mode-aware validation** — add to C4/C9+M17.
3. **AGENTS.md scope/nesting rules** — expand M8/M9.
4. **File reference format details** — expand M23.

### Test before adopting

5. **Plan quality examples** — useful but token-heavy (~100 tokens).
6. **Preamble message guidance** — useful but may conflict with brevity rules.

### Reject

7. **"Concise teammate" persona** — our executor-as-data framing is preferred.
8. **Tool schemas inline in system prompt** — too token-heavy. Keep in tool
   definitions.

---

## Risk / Uncertainty

1. **Token budget**: Codex CLI's full prompt (with tool schemas) is ~4000+
   tokens. Our 1060-token target is much smaller. The comparison here is about
   structural rules, not verbatim adoption.
2. **Sandbox dependency**: Codex CLI relies heavily on its sandbox/approval
   system for safety. This comparison may overstate gaps because the harness
   handles what the prompt doesn't. The same trade-off applies to QuantZhai.
3. **Preamble message cost**: Codex CLI's preamble guidance adds user-visible
   messages before every tool call. In a CLI setting this may be helpful; in
   automated testing it may add noise. Test before adopting.
4. **AGENTS.md complexity**: Codex CLI's detailed scope/nesting rules are
   powerful but add ~200 tokens. Our simpler M8/M9 may be sufficient for most
   projects.
5. **Plan quality examples**: High/low quality examples are educational but
   token-heavy (~150 tokens). The concept is more valuable than the specific
   examples.
