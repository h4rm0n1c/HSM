# Coding Agent Prompt Research Plan

Status: canonical research protocol through Slice 13 methodology correction  
Date: 2026-06-24  
Parent issue: `h4rm0n1c/HSM#2`  
Scope: `docs/coding-agent-system-prompt/`

## Purpose

This document defines how to conduct coding-agent system-prompt research.

The goal is not to invent one fixed hidden reasoning style. The goal is to identify, verify, and preserve prompt/runtime structures that improve software-development behaviour.

Each research slice must include:

```text
research
  -> verification
  -> adversarial review
  -> correction if needed
  -> conclusion with confidence
  -> candidate structure / rejection / deferral
  -> downstream placement and integration impact
```

No conclusion should be accepted because it sounds plausible. Every claim needs evidence for and against or an explicit unresolved label.

---

## Operating Principles

### 1. Adversarial review is mandatory

Every slice must ask:

```text
What evidence supports this?
What evidence contradicts it?
What would make it fail in QuantZhai or the target harness?
What would make it harmful, slow, verbose, timid, or scope-expanding?
What are we assuming because the idea sounds neat?
```

### 2. Enough evidence, not infinite evidence

Do enough work to support a useful conclusion. Do not turn every slice into an open-ended literature review.

A slice can conclude:

```text
adopt
adopt with constraints
test locally before adopting
defer
reject
needs more evidence
```

### 3. Structures over vibes

Extract reusable structures:

- prompt layers;
- action gates;
- state transitions;
- checklists;
- evidence maps;
- handoff templates;
- validation contracts;
- recovery states;
- safety boundaries;
- failure-mode taxonomies.

Do not extract generic advice such as `be careful` unless it can be tied to an observable control structure.

### 4. Separate prompt structure from runtime mechanism

Each finding must be classified as:

```text
static prompt structure
runtime/tooling structure
docs/process structure
test/evaluation structure
not useful here
```

Formal state, provenance, rollback, postcondition enforcement, and transaction guarantees often belong primarily in the runtime. Static prompt prose may carry the operating invariant without pretending to provide enforcement it cannot guarantee.

### 5. Preserve uncertainty

Use explicit confidence labels:

```text
high confidence
medium confidence
low confidence
unresolved
```

Confidence depends on evidence quality, not enthusiasm.

### 6. Abstraction before examples

Concrete examples are anchors and probes, not complete rule boundaries.

```text
invariant
  -> optional examples
  -> unseen-equivalent evaluation
```

Reject noun-list rules that only protect the exact cases seen in the triggering incident.

### 7. Semantic coverage is not behavioural control

Slice 13 established that a rule may be present, understood, and quotable after failure while still not governing action.

Every candidate structure must therefore answer:

```text
What transition does this structure control?
At what action boundary must it become active?
What observable next action demonstrates compliance?
What state or evidence must be available at that boundary?
Does the mechanism require runtime support?
```

A research conclusion that only produces better wording is incomplete when the target failure concerns action sequencing, state commitment, or recovery.

### 8. Trace downstream impact

Research flows through:

```text
research finding
  -> candidate structures
  -> failure taxonomy
  -> evaluation/checklist implications
  -> synthesis
  -> status/navigation
  -> prompt engineering
```

A finding is not integrated merely because a sidecar exists. Every slice must state which canonical layers are affected and whether the change is additive, corrective, or superseding.

---

## Standard Slice Template

```text
## Slice N: <name>

### Question
What are we trying to decide?

### Trigger / observed evidence
What failure, gap, comparison, or runtime behaviour caused this slice?
Separate observed, inferred, and unknown facts.

### Hypothesis
What mechanism might explain or improve the behaviour?

### Sources to inspect
Internal:
External:
Academic:
Runtime/test evidence:

### Research tasks
- ...

### Verification tasks
- Check primary source or repository evidence.
- Compare at least one supporting source and one counterargument.
- Check whether the idea already appears in HSM/QuantZhai/NetTTS.
- Check whether it conflicts with repository authority or existing structures.

### Action-boundary analysis
- What transition does this control?
- What precondition or current-state claim matters?
- What postcondition or resulting state matters?
- What later action depends on it?
- What observable behaviour would count as compliance?

### Placement analysis
- static prompt?
- runtime/tooling?
- docs/process?
- evaluation?
- nowhere?

### Adversarial review
- What could make this wrong?
- What failure mode could adoption introduce?
- Is this prompt cargo culting?
- Could it add ceremony, latency, passivity, or scope creep?
- Does a stronger runtime mechanism make prompt prose redundant?

### Correction phase
If evidence contradicts the hypothesis:
- revise or narrow the structure;
- merge it with an existing structure;
- move it to runtime/docs/evaluation;
- reject it;
- or mark it unresolved.

### Conclusion
Decision:
Confidence:
Evidence for:
Evidence against:
Candidate structure:
Runtime/process implication:
Observable compliance criterion:
How to test or inspect locally:
Affected canonical layers:
Follow-up:
```

---

## Source And Authority Rules

Research inputs include HSM process documents, QuantZhai runtime/prompt work, NetTTS deterministic-weighting prior art, external coding-agent prompt systems, model-specific prompting notes, academic papers, runtime traces, and observed user feedback.

Classify each source as:

```text
authority
primary runtime/repository evidence
prior art
external comparison
anecdote
speculative input
```

External prompt dumps, blog posts, Reddit posts, papers, and vendor systems are evidence, not authority.

Check whether a source is stale, superseded, partial, or describing a different layer than the one under study.

---

## Research Quality Gates

A slice is complete only when:

- the triggering evidence is clearly separated from interpretation;
- the hypothesis has supporting and opposing analysis;
- the invariant is broader than its examples;
- prompt/runtime/process/evaluation placement is explicit;
- action-boundary and observable-compliance analysis is present where relevant;
- interactions with existing structures and failure modes are recorded;
- token/complexity costs and non-regression risks are considered;
- downstream canonical layers are named;
- confidence and unresolved questions are explicit.

A slice is not complete when it merely:

- quotes a paper abstract;
- invents a clever sentence;
- lists examples without an invariant;
- duplicates an existing structure under a new name;
- assumes semantic presence equals behavioural reliability;
- creates a sidecar without propagating the finding.

---

## Initial Research Programme

### Slice 0: Source map and authority check

Question: Which internal and external sources are in scope, and which are authority versus research input?

Expected output: a source matrix such as `internal-project-references.md`, with source type, freshness, path, and verification state.

### Slice 1: Human/assistant/coding-agent arbitration loop

Question: What worker-facing structures are needed when the broader workflow includes a human director, assistant/reviewer, and coding worker?

Core pattern:

```text
pain / suspicion
  -> exact desired behaviour
  -> asset inventory
  -> donor/source scan
  -> constrained implementation brief
  -> coding-agent patch
  -> review/hardening
  -> live workflow validation
  -> durable note
```

The full loop belongs mostly upstream; the worker prompt should receive only the structures needed to execute its bounded role.

### Later slices

Continue the same protocol for anti-agreement, context positioning, prompt lifecycle, identity boundaries, trusted input, tool/runtime feedback, compaction, orientation, evidence-gated action, and closed-loop execution.

The current consolidated research state is represented by:

- `candidate-structures.md` through C47;
- `research-failure-mode-catalog.md` through FM14;
- `prompt-evaluation-checklist.md` through Slice 13;
- `final-findings-synthesis.md` through Slice 13.

New research must integrate against those canonical documents rather than treating older extension sidecars as current doctrine.