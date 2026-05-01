# Active State Harness Lessons — 2026-05-02

This note captures the HSM-relevant lessons from the current discussion about how hosted AI systems receive active state before answering.

## Observed harness shape

A modern assistant runtime is not just the visible user message.

It receives a layered state packet roughly shaped like:

```text
system/runtime rules
  -> developer instructions
  -> user profile/preferences
  -> persistent memory/context
  -> recent conversation
  -> tool schemas and permissions
  -> prefetched UI/tool guidance
  -> current user message
```

This is a crude existing form of runtime state injection.

## HSM interpretation

HSM should treat this as a primitive example of the architecture it needs, then make it explicit and inspectable.

Current hosted harnesses are useful but limited:

- state is often hidden
- memory confidence is uneven
- stale facts can persist
- source provenance is weak
- generated output can influence future behaviour without enough audit
- contradiction detection is weak unless deliberately requested

HSM should improve this by making the state packet:

- versioned
- inspectable
- evidence-backed
- confidence-scored
- editable
- contradiction-aware
- update-gated

## Coherence and integrity frame

Coherence is not merely fluent continuation.

For HSM, useful coherence means:

- low contradiction with evidence
- low state drift across time
- consistent use of known preferences and constraints
- retention of active goals and open loops
- preserved uncertainty
- clear separation of memory, inference, and generated explanation

Integrity means the system does not quietly mutate assumptions, invent missing bridges, or promote plausible prose into truth.

## Runtime packet as live self interface

The active runtime packet is the live interface between structured state and model execution.

It should contain only task-relevant state:

- active task
- source authority
- current projects and open loops
- constraints and preferences
- relevant evidence refs
- quiescent/anchor state when relevant
- affective/trigger state when relevant
- uncertainty flags
- tool permissions
- output contract

The packet is not the whole archive. It is a compiled view.

## Archive versus runtime

Do not dump everything into context.

Better structure:

```text
long-term evidence archive stores source material
state layer stores reviewed claims and patterns
compiler selects current task-relevant state
runtime packet feeds the model
integrity loop checks generated output
update gate controls durable state changes
```

## Why this matters

This lets the system behave coherently over human timescales without expecting a single context window or model weight set to hold everything.

Large context helps, but discipline matters more.

A 256k context window full of unranked material is still a swamp.

## Tool and repo lesson from current work

GitHub API pressure and write failures mean agents should prefer fewer, larger coherent writes.

For HSM repo work:

- read `AGENTS.md` first
- verify existing files before creating replacements
- avoid noisy commit spam
- prepare coherent file contents in context
- write only to `h4rm0n1c/HSM` for HSM material
- treat source repos as read-only unless instructed otherwise

## Open implementation question

How much of the hosted harness state can be mirrored into HSM's own runtime packet without leaking hidden policy or private runtime details?

Safe answer for now:

- capture public project state
- capture user-approved preferences and constraints
- capture evidence-backed claims
- capture tool and repo boundaries
- do not attempt to store hidden platform policy text
- describe harness concepts, not private hidden prompt content
