# Final Findings Synthesis: Coding Agent System Prompt Structures

Status: consolidated research output  
Date: 2026-06-02  
Scope: 10-slice protocol + external reference analysis + production subagent dispatch  
  + agent prompt patterns + skill prompt patterns  

---

## 0. Rule Zero: Prompt Files Say What, Not How

**Don't put in the prompt file what can be deterministically coded and injected or called as a tool.**

A prompt file should describe the task, the output contract, and the constraints — not the data retrieval, the tool mechanics, or the preference biases. Everything that can be computed, fetched, or derived deterministically should live outside the prompt: in tools, in injected context blocks, or in orchestrator logic.

### What this means in practice

| Belongs in the prompt | Belongs outside the prompt |
|---|---|
| Task description | Data retrieval logic (`get_records()`, `get_features()`) |
| Output schema & contract | Preference profiles and user biases |
| Constraints and rules | Tool implementation details |
| Decision criteria | Static reference tables that change per user |
| Claim/evidence format | Hardcoded lists of what tools exist |

### The dynamic injection pattern

The orchestrator reads the user's deterministic profile (features, preference transformer, tag frequency) and injects it as a context block when dispatching the agent. The agent receives its task + the user-specific context. It does not fetch the context itself.

```
Static prompt file:
  "You are a narrative structure analyst.
   Classify each chunk: scene_structure, arc_position, temporal_framing.
   Output format: [schema].
   Constraints: confidence anchors, claim requirements."

Injected at dispatch time:
  "User preference context:
     Top strong_positive: inflation, canine, dominant
     Source profile: second-person POV, touch-dominant
   Calibrate your classifications with this profile."
```

The prompt file never changes per user. The injected context changes every dispatch.

### Why this is the foundation

Every pattern in this document is an expression of this rule:
- **Compressed subagent identity**: the orchestrator provides context, so the subagent doesn't need to re-learn why it exists
- **Tool-split upfront**: the tool strategy is declared at dispatch time, not hardcoded
- **Routing dispatch**: the orchestrator decides which specialist to dispatch, not the specialist itself
- **Structured output contracts**: the format is outside the prompt, enforced by the receiving system
- **Two-phase design**: the deterministic phase is outside the LLM prompt entirely

All patterns below assume Rule Zero is applied. If Rule Zero is not applied — if data retrieval, tool selection, or user context is hardcoded in the prompt — the other patterns will be less effective because the prompt will be fighting against static data that should be dynamic.

---

## 1. Architecture Patterns

How agents are structurally organized.

### Two-Phase Design

Split work into a deterministic computation phase followed by an LLM judgment phase. The deterministic phase (script, tool, or calculation) produces objective metrics. The LLM phase interprets those metrics and produces the final output.

The script phase provides ground truth the LLM can trust. The LLM is explicitly told not to re-do what the script already computed. This prevents wasted work and ensures consistency.

Common in code analysis agents where the first phase extracts structural data (directory trees, import graphs, fan-in/fan-out metrics) and the second phase assigns semantic meaning (layer membership, architectural role).

### Dual-Mode Execution

Agents operate in distinct modes (planning / execution / verification) with tool-gated transitions between them. Each mode has a different set of allowed actions and a different artifact to produce (implementation plan, code, walkthrough).

The mode transition is enforced by explicit tool calls — the agent cannot enter execution without first completing planning and getting approval. This is a harder gate than self-enforced checklists.

### Routing-as-Lookup-Table

Instead of conditional branching logic ("if task type X, do Y"), flatten the decision tree into a lookup table. The agent identifies the task type, finds the matching row, and follows the prescribed workflow or reads the referenced instruction file.

This eliminates nested conditionals and reduces the chance of the agent choosing the wrong branch. It also makes the routing logic inspectable and auditable.

---

## 2. Identity Patterns

How agents are framed at the start of their prompt.

### Role Identity ("You are X")

Direct second-person role assignment in the opening line. The identity is tightly scoped to the agent's specific job. The framing includes both what the agent does and how it should behave (thorough yet concise, precise, etc.).

This pattern is used for agents that perform a specific analytical task (code analysis, architecture analysis, domain analysis). It is NOT used for meta-skills that teach how to create something.

### Executor-as-Data

A lightweight machine-readable header naming the executor, role, model target, and harness. No persona framing — the agent is positioned as a data-processing system, not a character. The header is ~30 tokens.

Empirical testing shows no measurable behavioural difference between executor-as-data and role identity on simple tasks. Persona leakage is zero in both cases.

### No Identity (Meta-Skills)

Skills that teach *how to* create something (agents, skills, explanations) do not adopt a persona. They use third-person description in the frontmatter and imperative/infinitive form in the body. The model is positioned as a tool user, not the tool itself.

The third-person form ("This skill should be used when...") serves as a trigger gate — it describes the conditions under which the skill activates, not what the model should be.

### Compressed Subagent Identity

A 4-line template that compresses identity, task, output contract, and constraint into ~50 tokens:

```
You are a focused [domain] subagent.
Your only job is to [specific bounded task — one sentence].
Return only: [exact output format — table / list / bytes].
Do not: [one key exclusion].
```

This is significantly tighter than the ~100+ tokens used by full role identity prompts. It works because the orchestrator already provides context — the subagent doesn't need to re-learn why it exists.

---

## 3. Agentic Dispatch Patterns

How multi-agent systems are orchestrated.

### Commit-Before-Dispatch

Before launching any subagent, the orchestrator writes out the names of every subagent it will launch. This is a cognitive forcing function — it prevents forgetting or skipping subagents.

The commit step happens before any work begins. It also serves as a plan that can be verified by a human or another agent before execution starts.

### Parallel Fork-Join

All subagents are dispatched simultaneously. The orchestrator waits for all to complete, then merges results. Subagents do not communicate with each other — they only return results to the coordinator.

This is the dominant dispatch pattern because it minimizes wall-clock time and maximizes parallelism. It assumes subagents are independent.

### Structured Subagent Output Contract

Every subagent returns a mandatory structured block — not freeform text:

```
TASK: <task name>
STATUS: success | partial | failed
FINDING: <concise finding>
EVIDENCE: <exact output>
CONFIDENCE: high | medium | low
NEXT: <what coordinator should do>
CLEANUP: <scratch dir, detached processes, PIDs>
```

This contracts what the coordinator needs to make a decision. STATUS has three states:
- `success` — all criteria met
- `partial` — nonempty evidence that does not satisfy success criterion
- `failed` — no useful evidence

The partial state is critical — it allows the coordinator to salvage useful work from a failed subagent rather than treating any failure as total.

### Completion Gate

A task with subagents is complete only when ALL named subagents have returned AND the deliverable file exists. Partial subagent failure triggers STATUS: partial, not expanded investigation.

This gate prevents the orchestrator from declaring success prematurely. The deliverable file existence check provides an objective completion signal.

### Retry Budget (1+1)

One initial attempt plus one bounded retry. The retry must change one named parameter or hypothesis — it is not a rerun of the same approach. If the retry also fails, the result is STATUS: partial.

This prevents infinite retry loops while still allowing recovery from obvious mistakes.

### Routing Dispatch

The orchestrator classifies the incoming task against a routing table and dispatches to the matching specialist subagent. The routing table is a flat lookup table mapping task types to subagent paths — not a nested decision tree.

This is the dominant pattern in skill-based systems where different subagents handle different task domains.

### Adversarial Audit Dispatch

A variant of parallel fork-join where subagents are purposely assigned overlapping or contradictory tasks — one to find evidence, one to find gaps, one to find contradictions. The coordinator compares all three and produces a reconciled result.

This catches errors that a single specialist would miss because the specialists are incentivized to look for different things.

---

## 4. Constraint Patterns

How agents are told what to do and what not to do.

### Negative Space ("Write Safety")

A dedicated section listing what the agent must NOT do. Rules are phrased as negative assertions: "Do not X", "Never Y without Z", "If X, stop and explain."

This is more effective than positive-only instructions because it narrows the action space explicitly. The combination "Do X, but never Y" constrains more precisely than "Do X" alone.

### Positive Space (Release-Blocker Checklists)

A numbered list of conditions that must be true before the agent considers the task complete. Each item is independently verifiable. The checklist defines completion mechanically, not subjectively — the agent checks items off rather than judging "is this good enough."

### Epistemic Constraints ("Trust the Script")

When a deterministic script has already computed something, the agent is told not to re-read the source or re-derive the result. The agent trusts the script's output and operates on it.

This prevents wasted work (the agent re-discovering what the script already found) and inconsistency (the agent reaching a different conclusion than the script).

### Scope-Boundary Declarations

Explicit statements of what the agent will NOT handle. When the agent encounters something outside scope, it degrades gracefully (reports and stops) rather than attempting unknown workflows.

---

## 5. Tool Patterns

How tools are documented and selected.

### Tool-Split Upfront

The tool selection strategy is declared at the top of the prompt, before any workflow steps. The agent knows which tool to use for which job before it starts working.

This prevents the agent from making suboptimal tool choices reactively during execution. Common splits: app connector for reads, CLI for operations the connector doesn't expose.

### Helper-First Hierarchy

Multi-agent systems define a priority-ordered tool selection protocol rather than leaving tool choice to individual agents. The priority order is listed explicitly: dedicated library > analysis framework > supplementary tools > custom code.

Agents are expected to check if a tool already exists before writing scratch code.

### Parallel-Call Guidance

All independent tool calls should be made in parallel. If the agent already read a file earlier in the turn, it should use that information rather than reading again.

This prevents tool serialization and repeated reads, which are the most common source of inefficiency.

---

## 6. Output Patterns

How agents structure their output.

### Pre-Assigned Output Weights

When an agent produces structured output (edges, nodes, scores), the weights are pre-assigned by relationship type in a lookup table. The agent does not choose weights — it looks them up.

This eliminates guesswork and ensures consistency across agents and iterations.

### Quality-as-Checklist

Output quality is defined as a set of independently verifiable conditions. The agent checks each condition before delivering. If any condition fails, the output is not delivered — it is corrected first.

### Evidence Contract

When an API or tool has a known limitation, the prompt establishes a workaround contract: the agent must include compensating context in the output. The contract specifies what evidence to include per type.

### Final Answer Constraint

Specific rules about what the final answer must NOT contain (e.g., "Do not cite the local path in your final answer"). These override natural model behaviour and are highly defensive — they exist because the model would naturally do the wrong thing.

---

## 7. Communication Patterns

How agents communicate with users and other agents.

### Positive Framing

Rules phrased as "Do this" rather than "Do not do that." Positive framing has higher compliance because it gives the agent a concrete action to take. Negative framing tells the agent what to avoid but not what to replace it with.

Empirical note: systems with a positive-to-negative rule ratio above 4:1 show better compliance than systems with more balanced ratios.

### Conversational Register

A friendly, narrative tone ("Cool? Cool.") for workflow-oriented skills versus formal instruction tone for analysis agents. The register matches the expected relationship between the agent and user.

The conversational register is associated with better user satisfaction but is inappropriate for agents that need to project authority (safety monitors, validators).

### Response Style as Distinct Section

Tone, voice, and communication patterns defined in their own section rather than scattered across the prompt. This collects all communication guidance in one place where it can be referenced and audited.

### Subagent Output Contract (Structured)

Agents communicating with other agents use structured blocks (STATUS/FINDING/EVIDENCE), not natural language. The coordinator reads the structure, not the prose. Evidence is in a separate field so the coordinator can inspect it independently of the agent's interpretation.

---

## 8. Lifecycle Patterns

How agents manage their own execution context.

### Progressive Disclosure

Information is loaded at three levels: metadata (YAML frontmatter, ~50 tokens), SKILL.md (core instructions, ~1,500 words), reference files (deep details, loaded on demand).

This keeps the initial prompt lean while making detailed instructions available when needed. The frontmatter doubles as the activation trigger.

### Dual Activation Gates

The YAML frontmatter triggers skill selection (the router picks this skill based on description match). The opening line of the body confirms relevance (the model self-validates it is in the right place).

Two gates are more reliable than one — the first is automatic (router), the second is cognitive (model).

### Cleanup-With-Partial

Subagent processes have explicit lifecycle management: flush evidence before detach, run under outer timeout. If cleanup hangs after evidence is written, the result is STATUS: partial with saved log path — not failure.

This ensures that evidence is never lost due to cleanup failures.

### Canonical Workflow Bias

Prefer one simple proven workflow over a large tree of recovery branches. When a task matches a known successful pattern, follow that pattern directly instead of re-evaluating every possible fallback path.

This prevents analysis paralysis and edge-case explosion. The recovery branches exist for when the canonical workflow fails, not as alternatives to evaluate upfront.

---

## 9. Pattern Interdependencies

Some patterns depend on others:

- **Commit-before-dispatch** enables **parallel fork-join** — you cannot launch parallel agents without knowing which agents to launch.
- **Structured subagent output** enables **completion gates** — you cannot check deliverable existence without a structured result.
- **Tool-split upfront** enables **parallel-call guidance** — you cannot parallelize tool calls if you haven't decided which tool to use.
- **Negative space** plus **positive space** together define the full action space more precisely than either alone.
- **Progressive disclosure** enables **dual activation gates** — the metadata layer is the first gate, the body is the second.

---

## 10. Open Questions

1. Do ALL-CAPS constraint markers (MUST, NEVER, ALWAYS) improve compliance over plain assertion? They are used heavily in analysis agents and never in meta-skills. The skill-creator specifically warns against them. No controlled experiment found.
2. Does the compressed subagent identity template (~50 tokens) produce equivalent output quality to full role identity (~100+ tokens)? The pattern exists in production but has not been A/B tested.
3. Do adversarial audit subagents catch errors that a single specialist would miss? The pattern exists but the false positive rate (contradictions that are not actually contradictions) is not measured.
4. Is conversational register more effective than formal instruction for workflow-oriented prompts? The pattern exists in isolation but has not been compared head-to-head.
5. What is the optimal positive-to-negative rule ratio? The 4:1 observation is from a sample of 7 prompts — not statistically significant.
