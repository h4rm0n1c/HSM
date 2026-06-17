# I1A: arXiv Backing for Orientation and Evidence-Gated Action

Status: research-layer evidence slice; not yet canonical candidate/failure/eval merge  
Date: 2026-06-17  
Integration pass: I1 research-layer consolidation  
Scope: backing Slice 11 and Slice 12 with full-paper arXiv evidence before downstream rewrite

---

## Purpose

Slice 11 and Slice 12 came from behavioural feedback on `hsm-build-v0.md`, especially DeepSeek-style failures:

```text
safe but shallow investigation
  -> plausible clue
  -> inferred world-state claim
  -> action before proof
  -> repeated correction acknowledged but not integrated
```

This slice adds full-paper arXiv backing before those findings flow into canonical candidate structures, failure modes, evaluation checklist, and final synthesis.

This is not a prompt rewrite. It is the evidence layer for later rewrites.

---

## Existing Research Standard

The existing research queue already requires more than link collecting. For each source, the subproject expects extraction of:

```text
Source
What it is
Prompt layer(s) observed
Useful shape
Risk / uncertainty
Candidate HSM/QuantZhai rule
How to test locally
```

That standard should apply here too. The goal is to identify what each paper supports, what it does not support, and where the result belongs.

---

## Research Questions

### RQ1: Orientation before narrowing

Do existing papers support a pre-action orientation / pre-writing / environment-mapping stage before committing to a solution path?

Relevant Slice 11 claim:

```text
For unfamiliar, uncertain, or high-blast work, map enough of the system before narrowing to the obvious target.
```

### RQ2: Evidence promotion before action

Do existing papers support a gate between plausible clue and action-critical fact?

Relevant Slice 12 claim:

```text
Before action, identify the action-critical world-state claim.
A clue is not proof.
Promote the claim with the cheapest safe check that can prove or falsify it.
```

### RQ3: Feedback as operating-rule update

Do existing papers support using failure/user/environment feedback to change the next action policy, not merely apologize or retry blindly?

Relevant Slice 12 claim:

```text
A repeated correction should become the operating rule for the next action.
```

### RQ4: Fixtures as invariant tests, not prompt wording

Do existing papers support evaluation designs where concrete examples are probes for broader capabilities rather than exhaustive rule lists?

Relevant smell-audit claim:

```text
Examples belong in fixtures.
Prompt rules should name the invariant first.
```

---

## Papers Read

The sources below were read as papers, not abstract-only references. PDF URLs are included for reproducibility.

### 1. ReAct: Synergizing Reasoning and Acting in Language Models

Source: https://arxiv.org/pdf/2210.03629

**What it supports**

ReAct directly supports the idea that reasoning and acting should be interleaved. The paper argues that chain-of-thought alone is a static black box when it is not grounded in external observations, and that this can lead to hallucination and error propagation. ReAct instead uses thought-action-observation trajectories: reasoning updates action plans, and actions retrieve external information that updates reasoning.

**Mapping to HSM**

- Supports Slice 11: orientation and information gathering are not optional decoration; actions can gather evidence that changes the plan.
- Supports Slice 12: action should be conditioned by observations, not just internal plausible reasoning.
- Supports tool-rich coding agents: the worker loop should be `reason -> inspect/probe -> observe -> update`, not `reason -> act from guess`.

**Candidate rule supported**

```text
Reasoning alone is not enough when the next action depends on current world state. Use safe observations from the environment to update the plan before acting.
```

**Risk / boundary**

ReAct supports interleaving reasoning and action, but it does not by itself define a sufficient evidence threshold for an action-critical claim. HSM still needs Slice 12's explicit evidence-promotion gate.

**Local test idea**

A fixture where the agent can read one plausible file but must inspect a second environment signal before acting. Passing requires updating the plan after observation.

---

### 2. Chain-of-Verification Reduces Hallucination in Large Language Models

Source: https://arxiv.org/pdf/2309.11495

**What it supports**

Chain-of-Verification supports explicit verification before finalizing claims. The method drafts an initial response, plans verification questions, answers them independently to reduce bias from the original response, then produces a verified response.

**Mapping to HSM**

- Supports Slice 12's evidence-promotion gate.
- Supports the move from `looks plausible` to `what would prove/falsify this?`.
- Supports factoring verification checks so they do not simply copy the original hallucinated answer.
- Supports the idea that verification questions should be generated from the claim being checked, not from a fixed category list.

**Candidate rule supported**

```text
For an action-critical claim, generate the check from the claim itself. Where possible, answer/check it independently from the clue that suggested it.
```

**Risk / boundary**

CoVe is primarily about factual hallucination in generated answers, not file mutation, APIs, hardware state, or coding-agent tools. HSM must adapt the idea from factual claims to operational world-state claims.

**Local test idea**

EF12.1 inferred API endpoint trap: the agent must generate and run a check that tests the endpoint/method/shape rather than simply accepting the source helper name or REST convention.

---

### 3. Self-RAG: Learning to Retrieve, Generate, and Critique through Self-Reflection

Source: https://arxiv.org/pdf/2310.11511

**What it supports**

Self-RAG supports adaptive retrieval and critique rather than indiscriminate retrieval. The paper distinguishes whether retrieval is needed, whether retrieved material is relevant, whether generation is supported, and whether the response is useful or complete.

**Mapping to HSM**

- Supports Slice 12: not every clue deserves action; the system needs claim-specific support and relevance checks.
- Supports smell audit: examples are not enough; a rule should encode the invariant of support/relevance/completeness.
- Supports validation against retrieved/contextual evidence rather than merely retrieving something and treating that as proof.

**Candidate rule supported**

```text
A check must target the action-critical claim. Retrieval or inspection is only useful if it can establish relevance, support, or completeness for that claim.
```

**Risk / boundary**

Self-RAG is a training/inference framework with reflection tokens, not a drop-in static prompt instruction. HSM should import the structure of adaptive retrieval/critique, not the mechanism.

**Local test idea**

A fixture where the agent performs an irrelevant search before acting. Passing requires checking the source of truth that actually proves or falsifies the action-critical claim.

---

### 4. Reflexion: Language Agents with Verbal Reinforcement Learning

Source: https://arxiv.org/pdf/2303.11366

**What it supports**

Reflexion supports using feedback signals to change later action policy without updating model weights. The paper frames verbal reflection as a way to learn from task feedback and improve subsequent trials, including coding tasks.

**Mapping to HSM**

- Supports Slice 12 EF12.5 repeated-correction trap.
- Supports converting user/environment/test feedback into a durable operating-mode correction.
- Supports the idea that blind retry without reflection is weak; feedback must be interpreted into actionable change.

**Candidate rule supported**

```text
When feedback identifies a repeated failure mode, convert it into the operating rule for the next action before continuing.
```

**Risk / boundary**

Reflexion relies on self-reflection quality and can still fail, especially in weaker models or insufficient feedback settings. HSM should not trust self-reflection as proof. It should require the corrected rule to change the next observable action.

**Local test idea**

EF12.5 repeated-correction trap: after the user says the agent is guessing instead of checking, the next action must be a relevant cheap verification, not another guessed edit/search.

---

### 5. STORM: Assisting in Writing Wikipedia-like Articles From Scratch with Large Language Models

Source: https://arxiv.org/pdf/2402.14207

**What it supports**

STORM supports a pre-writing/research stage before generating a final output. It finds that direct prompting often asks shallow basic questions, while perspective-guided, iterative research produces better breadth and organization. It explicitly treats research, perspective discovery, question asking, source gathering, and outline generation as a pre-writing phase.

**Mapping to HSM**

- Supports Slice 11 orientation before narrowing.
- Supports the idea that obvious/direct questions are too shallow for complex tasks.
- Supports territory mapping: gather perspectives/surfaces before writing/acting.
- Supports surface-signal discipline: different perspectives expose different missing information.

**Candidate rule supported**

```text
For unfamiliar or broad work, do a bounded pre-action orientation pass that discovers the relevant surfaces/perspectives before committing to a target.
```

**Risk / boundary**

STORM targets long-form grounded writing, not coding agents. HSM should import the pre-writing/orientation structure and multi-perspective question logic, not the full article-generation pipeline.

**Local test idea**

EF11.5 curiosity-vs-scope trap: a complex unfamiliar repo task should trigger shallow/bounded orientation over relevant surfaces, not immediate edit and not unlimited research.

---

### 6. SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering

Source: https://arxiv.org/pdf/2405.15793

**What it supports**

SWE-agent supports the claim that coding-agent performance depends on the agent-computer interface, not only the static prompt. The paper argues that LM agents struggle with raw shell interaction and benefit from an interface that provides structured actions, code search, file viewing/editing, and command feedback.

**Mapping to HSM**

- Supports the existing synthesis claim that prompt files are not the whole agent.
- Supports Slice 11/12 as runtime-aware: orientation and evidence promotion require usable observation/action channels.
- Supports treating tool contracts, feedback, and environment state as part of the agent operating system.

**Candidate rule supported**

```text
Do not solve interface/runtime-state problems with static prompt sludge. Put observation, search, edit, feedback, and validation affordances into the harness where possible.
```

**Risk / boundary**

SWE-agent is a system/interface paper. It supports runtime/harness design more strongly than baseline prompt wording. HSM should use it to decide placement: static prompt vs runtime injection vs tool contract.

**Local test idea**

A comparison where the same prompt has raw shell-only access versus dedicated search/view/edit feedback. Passing analysis should attribute behaviour changes to interface/runtime, not just prompt text.

---

### 7. CheckList: Beyond Accuracy — Behavioral Testing of NLP Models

Source: https://arxiv.org/pdf/2005.04118

**What it supports**

CheckList supports behaviour-focused evaluation through capability/test-type matrices. It demonstrates that systematic behavioural testing can uncover failures missed by aggregate benchmarks, and that capabilities/test types generalize beyond individual examples.

**Mapping to HSM**

- Supports smell audit: fixtures should test invariants/capabilities, not become exhaustive prompt lists.
- Supports EF11/EF12 as capability tests: orientation, evidence promotion, action boundary, feedback integration.
- Supports the idea that example cases should be generated under a general behaviour class.

**Candidate rule supported**

```text
Evaluation fixtures are probes for behavioural invariants. A candidate prompt passes by implementing the invariant, not by containing the fixture nouns.
```

**Risk / boundary**

CheckList targets NLP tasks rather than coding-agent operation, but the software-testing analogy transfers cleanly to prompt eval harness design.

**Local test idea**

For FM12, generate multiple fixtures with different nouns: API route, path, model inventory, config precedence, hardware capacity, active process, permissions, external service state. The prompt should pass by checking action-critical claims, not by matching a listed noun.

---

## Cross-Paper Synthesis

### Finding A: Slice 11 is backed by pre-action research / orientation literature

STORM supports an explicit pre-writing/research stage for complex grounded generation. SWE-agent supports the importance of navigation/search/view/edit affordances in software engineering environments. ReAct supports observation-driven plan updates. Together, these back Slice 11's claim that safe containment alone is not enough: complex tasks need bounded orientation before narrowing.

Practical HSM wording:

```text
For unfamiliar, uncertain, or high-blast work, orient before narrowing. Map the surfaces that determine authority, ownership, execution, validation, and existing convention. Scale the depth by blast radius.
```

### Finding B: Slice 12 is backed by verification / retrieval / critique literature

CoVe supports planned, claim-specific verification questions. Self-RAG supports adaptive retrieval and critique for relevance/support/completeness. ReAct supports action/observation loops that ground reasoning. Together, these back Slice 12's claim that a clue must be promoted before it becomes action-critical fact.

Practical HSM wording:

```text
Before action, identify the action-critical world-state claim. A clue is not proof. Promote the claim with the cheapest safe check that can prove or falsify it. If unchecked, reduce, defer, or stop action by blast radius.
```

### Finding C: Feedback correction needs observable next-action change

Reflexion supports verbal feedback as a mechanism for improving later decisions. But it also shows that reflection quality matters. For HSM, the prompt should not require ritual apologies or verbose self-reflection; it should require the next action to change.

Practical HSM wording:

```text
When feedback identifies a repeated failure pattern, convert it into the operating rule for the next action and show it through the next check or action boundary.
```

### Finding D: Fixtures must test invariants, not become rule lists

CheckList supports capability/test-type matrices and behavioural probes. This backs the smell audit: examples are useful for evaluation, but prompt text should name the invariant first.

Practical HSM wording:

```text
Use examples to test the invariant, not define the boundary of the rule.
```

---

## What These Papers Do Not Prove

- They do not prove the exact final wording for `hsm-build-v1.md`.
- They do not prove that any one prompt sentence fixes DeepSeek V4 Flash behaviour.
- They do not remove the need for EF11/EF12 A/B testing.
- They do not imply every task needs broad research; STORM supports pre-writing for complex grounded generation, not research theatre for small edits.
- They do not imply self-reflection is enough; Reflexion supports feedback integration, but HSM still needs external checks and observable action changes.
- They do not imply static prompts should contain runtime inventories; SWE-agent supports placing interface/state affordances in the harness.

---

## Impact On Integration Pass

### I1 research layer

This paper slice should be treated as an additional research-layer source alongside:

```text
slice-12-evidence-gated-action.md
project-smell-audit-2026-06-17.md
```

### I2 candidate structures

Use this evidence to support:

- C27 active investigator stance
- C28 principle-first orientation pass
- C29 assumption/check scaffold
- C30 established project-surface discovery
- C36 action-critical claim gate
- C37 clue-is-not-proof rule
- C38 cheapest falsifier preflight
- C39 feedback integration checkpoint
- C42 observed/inferred/assumed/unchecked reporting

### I3 failure-mode catalog

Use this evidence to distinguish:

```text
FM3: no real inspection
FM7: unchecked assumption cascades
FM11: real inspection, but too narrow before orientation
FM12: clue becomes action-critical fact without proof
```

### I4 evaluation checklist

Use CheckList to justify EF11/EF12 fixtures as behavioural-invariant tests.

### I5 final synthesis

The final synthesis should no longer say merely:

```text
coding agents must be safely curious
```

It should say:

```text
coding agents need bounded orientation before narrowing and evidence promotion before action.
```

---

## Next Step

Continue I1 research-layer consolidation by updating stale Slice 12 sidecars so they reflect:

```text
world-state claim
action-critical claim
clue is not proof
cheapest safe proof/falsifier
examples are fixtures, not prompt wording
```

Do not move to I2 until the sidecars are coherent.
