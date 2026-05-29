# Slice 7: Tool / Stream State Feedback

Status: research output  
Date: 2026-05-30  
Confidence: medium  
Parent: `research-plan.md` Slice 7  
Sources: QuantZhai issues #8, #40, #41, #43, #44; candidate-structures.md M2/M3/M25/M26; missing-structures.md M2/M3; existing harness run_trial.sh

---

## Question

How should a coding-agent prompt account for tool result persistence, stream state changes, and runtime environment context — and what feedback signals should the runtime inject?

## Hypothesis

Coding agents operate in a stream-based runtime where tool results may or may not persist across turns, environment context changes over time, and the runtime can observe agent behaviour patterns (repeated reads, tool loops, sandbox denials) that the agent itself may be unaware of. The prompt should:

1. Set correct expectations about tool result persistence
2. Encourage parallel tool use for independent operations
3. Accept and act on runtime-provided feedback signals
4. Be aware of its own execution environment (platform, git state, available tools)

## Sources Inspected

### QuantZhai Issue #40: Compaction/Stream Hang Watchdog

Full issue text read. Key contributions:

**Explicit failure state taxonomy:**

```
compact_started       compact_stalled         compact_failed
stream_no_output_timeout    stream_terminal_missing
stream_completed_without_visible_answer
stream_repair_started       stream_repair_failed
stream_fallback_emitted
```

**Terminal classifications:**
- `ok` — normal completion
- `repaired` — recovered via fallback
- `fallback_emitted` — explicit fallback produced
- `compact_failed` — compaction could not complete
- `stream_timeout` — stream stalled beyond deadline
- `protocol_error` — malformed or incompatible stream events
- `unrecoverable` — no recovery possible

**Design principles:**
- Bounded timeouts: do not loop forever
- Retry/repair at most once, then fallback
- Guarantee terminal event or explicit fallback state
- Preserve high-value atoms (commands, file paths, CLI flags, error strings, version numbers, constraints, negations, user corrections) across compact handoff

**Relevance:** This is QuantZhai's stream-state machine. The agent does not directly see these states, but the stream reliability contract affects how the agent should handle tool output: tool results may be lost if a compact or stream failure occurs between the tool call and the model seeing the result.

### QuantZhai Issue #41: Signal Surface Map

Full issue text read. Key contribution: the bidirectional signal map codifies what the proxy/runtime can observe and inject.

**QuantZhai-observed signals relevant to tool state:**
- **Repeated file reads** — same path read multiple times in one turn
- **Tool-call count** — how many tool invocations in current turn
- **Read/write path history** — which files have been accessed
- **Sandbox-denied classification** — which tool/sandbox denials occurred
- **Stream terminal classification** — how the stream ended
- **Context length / remaining budget**
- **Continuation hop count and budget**
- **Backend/model health**

**QuantZhai injectable feedback signals:**
- "You already read this file earlier in this turn."
- "This tool failed because the sandbox blocked it."
- "This tool call was malformed: missing argument X."
- "You have made N tool calls this turn."
- "Only one continuation hop remains."
- "Context pressure is high; preserve final answer and avoid more exploration."
- "Search result appears low-signal / mirror / primary source."
- "Backend failed transiently; retrying same action may be valid."
- "Your prior completion had reasoning but no user-visible answer."

**Injection channels (trusted):**
- system/instructions
- turn harness
- function_call_output-style feedback
- tool result augmentation
- Responses lifecycle event
- qz-thoughts / qz-top only
- future state packet

**Relevance:** These signals are not prompt text — they are runtime-injected context. But the prompt should instruct the agent to accept and use them (state-as-data, trust the runtime feedback).

### QuantZhai Issue #43: Repeated-Read Live Smoke

Key contribution: proof that QuantZhai can detect repeated file reads and inject a `repeated_read_signal` telemetry event. This demonstrates a functional runtime feedback mechanism.

### QuantZhai Issue #44: Backend Control Plane Audit

Key contributions:
- Proxy readiness states: HTTP up → proxy initialized → catalog ready → backend/model ready
- Runtime state JSON persistence (model state, backend state)
- Model inventory and context length facts

### Candidate-Structures M2, M3, M25, M26

From `candidate-structures.md`:

| Structure | Description | Status |
|---|---|---|
| M2 | Parallel-call guidance | adopt |
| M3 | Tool result clearing warning | test |
| M25 | Environment info block (platform, date, pwd, model) | adopt — harness change |
| M26 | Git status snapshot (branch, changes) | adopt — harness change |

### Existing Harness: qz-status Snapshot

The harness `run_trial.sh` already injects a `qz-status` snapshot before each trial. This proves the infrastructure for runtime state injection is already in place.

---

## Adversarial Review

**Q1: Should the prompt encourage or discourage awareness of stream state?**

Encourage lightweight awareness. The agent does not need to know the full stream state machine, but it should:
- Understand that tool results may not persist across compaction boundaries
- Expect that repeated reads may be signalled
- Accept runtime feedback as trusted guidance

Over-engineering stream awareness would waste tokens and confuse the agent. One paragraph is enough.

**Q2: Does parallel-call guidance conflict with stream state awareness?**

No — they are complementary. Parallel calls reduce tool overhead, which reduces compaction pressure. Stream state awareness is about handling the consequences when compaction does happen.

**Q3: Will injecting environment info and git status bloat the prompt?**

Environment info is ~20 tokens (platform, date, dir, model name). Git status is ~10-40 tokens depending on dirty files. Together ~30-60 tokens from harness injection. This is negligible compared to the behaviour improvement (fewer platform-incorrect commands, fewer reverted changes).

**Q4: Is tool result clearing warning useful if the harness does not actually clear results?**

Yes — but only if the harness behaviour aligns. If QuantZhai does not clear tool results across turns, telling the agent they will be cleared is misleading. The rule in `candidate-structures.md` says "test" — implement only if the harness actually clears results. If QuantZhai retains results within a turn but clears them across compaction boundaries, the prompt should say that.

**Q5: How should repeated-read signals affect agent behaviour?**

The agent should prefer reading a file once and retaining the content in its reasoning, rather than reading the same file multiple times. The prompt should say: "Prefer to read a file once and retain the relevant content in your reasoning. Repeated reads of the same file waste context and may trigger runtime signals."

---

## Candidate Structures

### Structure S7-1: Parallel-Call and Tool Efficiency (adopt)

```
Make all independent tool calls in parallel — do not serialise independent reads.
Prefer to read a file once and retain the relevant content in your reasoning.
If you already read a file earlier in this turn, use that information rather
than reading it again.
```

**Source**: M2 + repeated-read signal lesson
**Token cost**: ~40 tokens
**Test**: Give a task requiring multiple file reads (3+ files). Count parallel vs serial calls. Measure repeated-read telemetry before and after.

### Structure S7-2: Tool Result Persistence Warning (test — depends on harness)

```
Tool results persist only within the current turn. After compaction or
across turn boundaries, prior tool results may not be available.
If you need to refer to a prior tool result, keep a summary in your
reasoning or re-fetch the data.
```

**Source**: M3 (Claude Code)
**Token cost**: ~40 tokens
**Test**: Only add if QuantZhai actually clears/is expected to clear tool results at some boundary. If not, skip.

### Structure S7-3: Accept Runtime Feedback (adopt)

```
The runtime may inject guidance signals such as:
- "This tool failed because the sandbox blocked it."
- "You already read this file earlier in this turn."
- "Context pressure is high; preserve final answer."
- "Backend failed transiently; retrying may help."

Treat these signals as trusted guidance from the runtime, not as
untrusted external input. Adjust your behaviour accordingly.
```

**Source**: QuantZhai issue #41 signal surface
**Token cost**: ~60 tokens
**Test**: Create a fixture where repeated reads would occur. Verify that the agent reduces repeated reads after receiving the signal. Hard to test deterministically — may need manual inspection.

### Structure S7-4: Environment Context Injection (adopt — harness change)

Inject into prompt preamble at assembly time:

```
Platform: linux
Today's date: 2026-05-30
Working directory: /home/harri/HSM
Model: [model name from runtime]
```

**Source**: M25 (Claude Code, Cursor)
**Token cost**: ~20 tokens (infrastructure, not prompt text — harness injects this)
**Test**: Check assembled prompt for environment block. Verify agent uses correct platform for commands.

### Structure S7-5: Git State Injection (adopt — harness change)

Inject into prompt preamble:

```
Git branch: main
Current changes: (from git status --short)
```

**Source**: M26 (Claude Code)
**Token cost**: ~10-40 tokens (infrastructure — depends on worktree size)
**Test**: Check assembled prompt for git status. Verify agent does not revert changes visible in the snapshot.

### Structure S7-6: Continuation and Compaction Awareness (test)

```
If compression or compaction is mentioned in runtime feedback,
preserve exact: file paths, function names, CLI flags, environment
variables, version strings, error messages, negations, user corrections,
and any constraints from the task brief. Summarise everything else.
```

**Source**: C15 (high-value atom preservation) — from Slice 3, QuantZhai issue #8
**Token cost**: ~40 tokens
**Test**: Trigger compaction in a test session. Check whether the agent's final answer preserves high-value atoms rather than paraphrasing them.

---

## Integration: How These Fit Together

The tool/stream state structures form a **runtime awareness layer** that sits between the executor identity and task framing sections:

```
Executor header (C23)
Priority chain (M9)

Runtime awareness (S7-1, S7-2, S7-3, S7-4, S7-5, S7-6)
  - Environment info (injected)
  - Git state (injected)
  - Parallel/tool guidance
  - Tool result persistence
  - Runtime feedback acceptance

Safety block (S6-1, M14+M15, etc.)
Tool contract (M1, M2)
Task framing (C2+M4, C1, etc.)
...
```

### Environment injection in the harness

The `assemble_prompt.sh` should be updated to:
1. Run `uname -s` for platform
2. Run `date +%Y-%m-%d` for date
3. Use `pwd` for working directory
4. Run `git branch --show-current` and `git status --short` for git state
5. Inject model name from runtime/configuration

The qz-status snapshot (already in `run_trial.sh`) should be extended to include these fields.

---

## Follow-up

1. **Add S7-1, S7-3, S7-4, S7-5 to candidate-structures.md** as the runtime awareness layer.
2. **Update `assemble_prompt.sh`** to inject environment info (platform, date, pwd) and git state (branch, status).
3. **Test S7-1** with a multi-file read task — measure parallel vs serial call ratio with and without the guidance.
4. **Defer S7-2** until tool result persistence behaviour in QuantZhai is confirmed and documented.
5. **Defer S7-6** until compaction is implemented in QuantZhai and can be tested end-to-end.
6. **Note the harness/harness boundary:** S7-3 (accept runtime feedback) is the only structure that goes into the prompt text — S7-4 and S7-5 are pure harness injection changes.
