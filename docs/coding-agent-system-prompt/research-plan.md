# Coding Agent Prompt Research Plan

Status: research protocol  
Parent issue: `h4rm0n1c/HSM#2`  
Scope: `docs/coding-agent-system-prompt/`

## Purpose

This document defines how to conduct the coding-agent system prompt research pass.

The goal is not to invent one fixed reasoning style.

The goal is to identify, test, and preserve prompt structures that improve reasoning over software-development tasks.

Each research slice must include:

```text
research
  -> verification
  -> adversarial review
  -> correction if needed
  -> conclusion with confidence
  -> candidate structure / rejection / deferral
```

No conclusion should be accepted merely because it sounds plausible.

Every claim should be backed by evidence for and against, or explicitly marked as unresolved.

## Operating principles

### 1. Adversarial review is mandatory

Every slice must ask:

```text
What evidence supports this?
What evidence contradicts this?
What would make this fail in QuantZhai?
What would make this harmful in a local coding-agent prompt?
What are we assuming because it sounds neat?
```

### 2. Enough evidence, not infinite evidence

Do enough research to support a useful conclusion.

Do not turn every slice into an open-ended literature review.

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

- checklists
- prompt layers
- evidence maps
- handoff templates
- validation gates
- final answer contracts
- safety boundaries
- failure-state taxonomies

Do not extract generic advice like “be careful” unless it can be turned into a concrete structure.

### 4. Separate prompt structure from runtime mechanism

Some useful ideas belong in the system prompt.

Some belong in QuantZhai runtime code, tests, telemetry, command wrappers, or docs.

Each slice must classify the result:

```text
prompt structure
runtime/tooling structure
docs/process structure
test/evaluation structure
not useful here
```

### 5. Preserve uncertainty

Use explicit confidence labels:

```text
high confidence
medium confidence
low confidence
unresolved
```

Confidence depends on evidence quality, not enthusiasm.

## Standard slice template

Use this template for every research slice.

```text
## Slice N: <name>

### Question

What are we trying to decide?

### Hypothesis

What do we suspect might be useful?

### Sources to inspect

Internal:
External:
Academic:
Runtime/test evidence:

### Research tasks

- ...

### Verification tasks

- Check primary source or repo evidence.
- Compare at least one supporting source and one possible counterexample.
- Check whether the idea already appears in QuantZhai/HSM/NetTTS.
- Check whether it conflicts with existing repo authority.

### Adversarial review

- What could make this wrong?
- What would be the failure mode if adopted?
- Is this prompt cargo culting?
- Does it belong in prompt text, runtime code, docs, or tests instead?
- Could it make the agent slower, more verbose, more timid, or more likely to scope-creep?

### Correction phase

If evidence contradicts the hypothesis:

- revise the candidate structure
- narrow it
- move it to runtime/docs/tests
- reject it
- or mark it unresolved

### Conclusion

Decision:
Confidence:
Evidence for:
Evidence against:
Candidate structure:
How to test locally:
Follow-up:
```

## Slice 0: Source map and authority check

### Question

Which internal and external sources are actually in scope, and which are authority versus research input?

### Hypothesis

The useful research set includes HSM process docs, QuantZhai issues/PRs, NetTTS deterministic weighting prior art, external coding-agent prompt references, Qwen-specific notes, and prompt/context engineering papers.

### Sources to inspect

Internal:

- `docs/coding-agent-system-prompt/README.md`
- `docs/coding-agent-system-prompt/AGENTS.md`
- `docs/coding-agent-system-prompt/research-references.md`
- `docs/hsm_ai_workflow_arbitrator_observations.md`
- `docs/anti-agreement-harness.md`
- `docs/runtime-and-integrity.md`
- HSM PR #1 identity-as-data contract
- QuantZhai issues #8, #37, #40, #41, #43, #44, #65
- NetTTS `docs/prosody_encoder_detaIls.md`

External:

- Claude/Anthropic prompt references
- Codex Max prompt reference
- curated ChatGPT prompt collections
- Qwen-specific prompting notes

Academic:

- promptware engineering
- prompt management in GitHub repos
- lost-in-the-middle and context-position papers
- promptware security papers

### Research tasks

- Build a source table.
- Mark each source as authority, prior art, external reference, anecdote, or speculative input.
- Identify source freshness and repo/source path.

### Verification tasks

- Check that internal repo claims come from current files/issues/PRs.
- Check whether any source is stale, merged elsewhere, superseded, or only an open idea.
- Check HSM and QuantZhai authority docs before treating a source as doctrine.

### Adversarial review

- Are we over-weighting our own prior notes?
- Are we under-weighting external evidence?
- Are leaked/system-prompt repositories reliable enough for anything beyond shape extraction?
- Are Qwen blog/Reddit notes reproducible or anecdotal?

### Expected output

A source matrix under this subproject, probably:

```text
internal-project-references.md
```

## Slice 1: Human/assistant/coding-agent arbitration loop

### Question

What working structures should a coding-agent prompt support when the broader workflow includes a human director, assistant/reviewer, and coding worker?

### Hypothesis

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

### Sources to inspect

Internal:

- `docs/hsm_ai_workflow_arbitrator_observations.md`
- QuantZhai issue #37
- QuantZhai issue #43
- prior coding-agent prompt snapshot

External:

- Claude/Codex coding-agent prompts for role split and autonomy rules.

### Research tasks

- Extract the recurring loop stages.
- Identify which stages belong in the coding-agent prompt and which belong upstream in assistant/spec docs.
- Identify the smallest coding-agent-facing structures that support the loop.

### Verification tasks

- Compare the loop against real examples: PuTTY OSC52, QuantZhai feature slices, live smoke tests.
- Check whether the existing QuantZhai prompt already encodes parts of this.
- Check for counterexamples where the loop would be overkill.

### Adversarial review

- Could this make simple tasks too bureaucratic?
- Could this cause over-planning instead of editing?
- Should the coding agent always run donor scans, or only when the task is novel?
- Does this belong in the system prompt or in task briefs?

### Expected output

Candidate structures:

- asset inventory checklist
- donor-scan trigger rule
- constrained implementation brief template
- lived workflow validation marker

## Slice 2: Evidence, anti-agreement, and self-criticism

### Question

How should the prompt require self-critique without making the coding agent slow, argumentative, or timid?

### Hypothesis

The useful structure is not “argue with the user.” It is:

```text
classify claim
list evidence for
list evidence against
name uncertainty
choose next useful action
```

### Sources to inspect

Internal:

- `docs/anti-agreement-harness.md`
- HSM root `AGENTS.md`
- `docs/runtime-and-integrity.md`
- QuantZhai workflow notes

External:

- Codex/Claude prompt references for review mode and uncertainty handling.

Academic:

- promptware engineering if it discusses testing/debugging and requirements.

### Research tasks

- Extract anti-agreement rules that map to coding tasks.
- Separate useful self-critique from visible over-explanation.
- Define when adversarial review must be visible versus internal/task-local.

### Verification tasks

- Check whether candidate rules would have prevented known bad shapes: synthetic tests, unsupported stream markers, over-broad fixes.
- Check whether they would slow trivial tasks.

### Adversarial review

- Could “evidence against” become performative noise?
- Could the agent invent counterarguments without evidence?
- Could this create refusal-like paralysis?
- What is the minimum viable adversarial check?

### Expected output

Candidate structures:

- `Observed / Inferred / Risk / Next` block
- claim classification checklist
- adversarial review gate for non-trivial changes
- review-mode final answer template

## Slice 3: Context-position and middle-detail loss

### Question

How should prompt structures compensate for important middle-context details being lost?

### Hypothesis

Critical constraints should be repeated near action points as short local checklists rather than buried once in long prose.

### Sources to inspect

Academic:

- `Lost in the Middle: How Language Models Use Long Contexts`
- multi-hop long-context papers
- context-position mitigation papers

Internal:

- QuantZhai issue #8 on high-value atom preservation
- workflow notes about constraints, non-goals, and exact technical atoms

### Research tasks

- Summarize what the papers actually show.
- Identify what is directly applicable to coding-agent prompts.
- Distinguish model-level mitigations from prompt-structure mitigations.

### Verification tasks

- Check whether paper evidence applies to software-development tasks, not just QA retrieval.
- Check whether QuantZhai prompt/test design can evaluate middle-detail retention.
- Look for evidence against over-repetition: prompt bloat, instruction conflict, verbosity.

### Adversarial review

- Does repeating constraints increase compliance or just bloat?
- Which details deserve repetition?
- Can a local checklist replace repetition?
- Does this belong in prompt wording, task packet format, or compaction logic?

### Expected output

Candidate structures:

- action-point constraint checklist
- finalization checklist
- non-goals close to edit instructions
- high-value atom preservation rule

## Slice 4: Promptware / prompt lifecycle engineering

### Question

Should this subproject treat prompts like software artifacts with lifecycle, tests, versioning, and debugging?

### Hypothesis

Yes, but only where it produces lightweight, useful repo practice.

### Sources to inspect

Academic:

- `Promptware Engineering`
- `Understanding Prompt Management in GitHub Repositories`

Internal:

- HSM docs index rules
- QuantZhai prompt policy implementation
- QuantZhai prompt snapshot
- current HSM coding-agent prompt subproject structure

### Research tasks

- Extract prompt lifecycle concepts.
- Map them to concrete repo artifacts.
- Identify anti-patterns: duplicate prompt blobs, stale prompt fragments, no source refs, no tests.

### Verification tasks

- Check current HSM/QuantZhai prompt organization against those concepts.
- Check whether proposed metadata would reduce confusion or add ceremony.

### Adversarial review

- Are we building process sludge?
- Is this worth doing before there are prompt evals?
- Should candidate prompts have metadata headers?
- Should prompt tests live in QuantZhai rather than HSM?

### Expected output

Candidate structures:

- prompt metadata header
- prompt changelog rule
- prompt eval checklist
- source/ref snapshot rule

## Slice 5: Identity, role, and executor boundaries

### Question

How should coding-agent prompts define role without causing identity confusion or roleplay-like overbinding?

### Hypothesis

Use executor/task role framing, not deep identity claims. The model is a coding agent/executor inside a harness; repo/user/project state remains data.

### Sources to inspect

Internal:

- HSM PR #1 identity-as-data contract
- HSM runtime/integrity docs
- QuantZhai prompt snapshot

External:

- Claude/Codex prompt references for identity framing.
- Qwen prompt notes if they recommend strong identity wording.

### Research tasks

- Compare “You are Codex” style framing with executor-as-data boundary rules.
- Identify what role framing improves and what it risks.
- Decide whether local Qwen benefits from explicit model/harness identity naming.

### Verification tasks

- Check current QuantZhai prompt behaviour and historical user observation that model-name identity can improve adherence.
- Check whether identity-as-data doctrine applies differently to coding agents versus HSM subject rendering.

### Adversarial review

- Could weakening identity framing reduce task adherence?
- Could strong identity framing cause cargo-cult behaviour?
- Is “You are Codex” acceptable because Codex is executor role, not represented subject?
- Where is the boundary between useful role and identity contamination?

### Expected output

Candidate structures:

- executor role header
- harness boundary statement
- project/repo state-as-data rule
- subject identity prohibition only where relevant

## Slice 6: Safety, untrusted instructions, and promptware attacks

### Question

What safety structures belong in a local coding-agent prompt that reads repos, logs, web pages, and issue text?

### Hypothesis

A lightweight untrusted-instruction boundary is needed, but it must not become paranoid sludge.

### Sources to inspect

Academic:

- promptware attack papers
- promptware kill-chain paper

Internal:

- QuantZhai signal surface issue #41
- HSM runtime/integrity docs
- QuantZhai request mutation and memory-domain safety notes

External:

- Claude/Codex safety/tool-use rules.

### Research tasks

- Identify prompt injection and untrusted-text risks relevant to coding agents.
- Separate high-impact actions from low-risk reads.
- Define what embedded instructions in files/web/issues/logs may and may not do.

### Verification tasks

- Check if existing QuantZhai prompt already covers this.
- Check whether safety rules would block normal repo work.
- Check whether the rule belongs in prompt, sandbox, approval policy, or tooling.

### Adversarial review

- Could this make the agent refuse useful local tasks?
- Could it be too vague to matter?
- What are the actual dangerous operations in this environment?
- What should require explicit user approval?

### Expected output

Candidate structures:

- untrusted text boundary
- destructive-action approval rule
- embedded-instruction ignore rule
- tool-risk classification checklist

## Slice 7: Tool, stream, and runtime state feedback

### Question

What runtime/tool feedback structures should a coding-agent prompt understand or request?

### Hypothesis

Agents reason better when tool/runtime state is classified explicitly instead of left as vague “working/broken” text.

### Sources to inspect

Internal:

- QuantZhai issues #40 and #41
- QuantZhai issue #44 readiness audit
- QuantZhai issue #43 live smoke
- QuantZhai telemetry/observability docs

### Research tasks

- Extract useful state classifications: readiness, stream terminal state, fallback state, validation state.
- Identify which classifications should appear in prompts/final answers.
- Identify which belong only in telemetry/runtime.

### Verification tasks

- Compare with actual QuantZhai tests and scripts.
- Check whether state labels would help debugging or add jargon.

### Adversarial review

- Could state labels hide actual errors?
- Are classifications grounded in code or just invented names?
- Does the coding agent need to know the labels, or only the proxy/operator?

### Expected output

Candidate structures:

- validation state taxonomy
- readiness state checklist
- terminal/fallback state reporting rule
- operator-visible versus model-visible split

## Slice 8: Compaction and high-value atom preservation

### Question

What should survive summarization, compaction, or prompt compression for coding tasks?

### Hypothesis

Exact high-value atoms should survive: commands, paths, flags, versions, error strings, model names, constraints, negations, and user corrections.

### Sources to inspect

Internal:

- QuantZhai issue #8
- NetTTS prosody encoder notes
- QuantZhai compaction docs/issues
- coding-agent prompt snapshot

Academic:

- lost-in-the-middle papers
- promptware/context papers if relevant

### Research tasks

- Extract the deterministic high-value atom list.
- Compare with NetTTS light/medium/heavy span prior art.
- Identify which parts should become prompt guidance versus compaction runtime logic.

### Verification tasks

- Build small before/after examples.
- Check whether the atom list is too broad.
- Check if preserving everything destroys compression.

### Adversarial review

- What exact atoms are genuinely load-bearing?
- What should be summarized instead?
- Could the prompt make agents over-copy too much output?
- Is this better handled by QuantZhai compaction code?

### Expected output

Candidate structures:

- high-value atom preservation checklist
- compaction acceptance criteria
- exactness-risk rule
- prompt-local “do not paraphrase these” structure

## Slice 9: External coding-agent prompt comparison

### Question

What useful structures can be extracted from Claude, Codex, ChatGPT prompt collections, and Qwen prompt notes?

### Hypothesis

External prompts are useful as shape donors, not as authority.

### Sources to inspect

External:

- Claude Code system prompt references
- Codex Max prompt reference
- curated ChatGPT prompt lists
- Qwen-specific blog/Reddit notes

Internal:

- QuantZhai `codex-core-qwenified.md`
- QuantZhai prompt policy implementation

### Research tasks

- Build a comparison table by prompt layer.
- Extract repeated structures.
- Mark vendor/harness-specific assumptions.
- Compare against QuantZhai baseline.

### Verification tasks

- Check source authenticity where possible.
- Check whether structures are applicable to local Qwen/Codex operation.
- Check for contradictions with current QuantZhai runtime and user preferences.

### Adversarial review

- Are we cargo-culting leaked prompts?
- Are we copying vendor-specific behaviour that local Qwen cannot follow?
- Does a rule improve behaviour or only sound official?
- Can it be tested locally?

### Expected output

Candidate structures:

- prompt layer comparison table
- adopt/reject/defer decisions
- Qwen-specific adaptation notes

## Slice 10: Candidate prompt structures and local evaluation plan

### Question

Which structures should become candidate prompt changes, and how do we test them?

### Hypothesis

Only structures with clear expected behavioural improvements should become candidates.

### Sources to inspect

Outputs from slices 1-9.

### Research tasks

- Consolidate candidate structures.
- Remove duplicates.
- Split into base prompt, task-local templates, docs/process rules, runtime/tooling requirements, and tests.
- Define local eval tasks.

### Verification tasks

- Check candidates against existing QuantZhai prompt to avoid duplication.
- Check candidates against known bad behaviours.
- Check token cost and local Qwen suitability.

### Adversarial review

- Which candidates are too verbose?
- Which are too abstract?
- Which could conflict with each other?
- Which belong in AGENTS.md rather than the runtime system prompt?
- Which should be rejected despite being appealing?

### Expected output

Candidate files:

```text
candidate-structures.md
prompt-evaluation-checklist.md
candidate-system-prompt-v0.md
```

## Final synthesis protocol

After all slices, produce a synthesis with this structure:

```text
# Findings

## Adopt now

Structure:
Evidence for:
Evidence against:
Why adopt anyway:
Test plan:

## Adopt with constraints

Structure:
Constraint:
Risk:
Test plan:

## Defer

Idea:
Why defer:
Evidence needed:

## Reject

Idea:
Why reject:
Evidence:

## Open questions

Question:
What evidence would resolve it:
```

## Definition of done

The research pass is done when:

- each selected slice has research, verification, adversarial review, correction, and conclusion
- conclusions cite or reference the evidence used
- evidence against is recorded, not hidden
- candidate structures are separated from rejected/deferred ideas
- proposed prompt changes are testable
- runtime/tooling/docs-only recommendations are clearly separated
- `docs/coding-agent-system-prompt/README.md` and parent `docs/README.md` index any new durable docs

## Non-goals

Do not modify QuantZhai runtime in this research plan.

Do not copy large external prompt dumps into HSM.

Do not produce a giant final system prompt before evidence has been reviewed.

Do not optimize for sounding like Anthropic/OpenAI/any vendor.

Do not treat adversarial review as optional.

Do not suppress contradictory evidence because a structure feels useful.
