# Coding Agent Prompt Research References

Status: canonical source registry through Slice 13  
Date: 2026-06-24  
Purpose: track internal authority, external prompt systems, academic research, model-specific observations, and inspected Slice 13 sources without vendoring large external corpora into HSM

## Research Rule

Do not treat external prompt dumps, vendor systems, papers, blog posts, Reddit posts, or benchmark claims as authority.

For each source record:

```text
Source:
Source type:
Inspection status:
What it is:
Layer(s) observed:
Useful structure:
Risk / uncertainty:
What it does not prove:
Candidate HSM/QuantZhai implication:
How to inspect or test locally:
```

Source types:

```text
authority
primary repository/runtime evidence
prior art
external comparison
academic evidence
anecdote
speculative input
```

---

## Inspected Slice 13 Sources

### ToolGate: Contract-Grounded and Verified Tool Execution for LLMs

- URL: https://arxiv.org/abs/2601.04688
- Type: academic/runtime architecture
- Status: inspected for Slice 13
- Supports: separate precondition and postcondition gates over explicit trusted state; tool output should not automatically update trusted world state.
- Does not prove: that compact static prompt prose can reproduce formal symbolic contracts or runtime guarantees.
- HSM implication: adopt the precondition/action/postcondition/trusted-state abstraction; place formal enforcement in runtime where possible.

### ToolSandbox: A Stateful, Conversational, Interactive Evaluation Benchmark for LLM Tool Use Capabilities

- URL: https://arxiv.org/abs/2408.04682
- Type: academic evaluation benchmark
- Status: inspected for Slice 13
- Supports: state dependencies, intermediate milestones, and arbitrary multi-step trajectories are distinct from single-call tool selection.
- Does not prove: exact prompt wording or a particular recovery state machine.
- HSM implication: evaluate intermediate state and dependency boundaries separately from final outcome.

### Cordon: Semantic Transactions for Tool-Using LLM Agents

- URL: https://arxiv.org/abs/2606.17573
- Type: academic/runtime architecture
- Status: inspected for Slice 13
- Supports: individually plausible calls can compose into cross-step violations; staged effects, result lineage, commit, rollback, recovery, and audit may require task-level runtime support.
- Does not prove: that every coding task should use formal transactions.
- HSM implication: import dependency-aware state commitment and recovery, scaled by blast radius; reject universal transaction ceremony.

### AgentProcessBench: Diagnosing Step-Level Process Quality in Tool-Using Agents

- URL: https://arxiv.org/abs/2603.14465
- Type: academic evaluation benchmark
- Status: inspected for Slice 13
- Supports: intermediate action quality, irreversible side effects, and error propagation should be scored separately from final answers.
- Does not prove: the exact HSM worker loop.
- HSM implication: identify the first unsupported state commitment where practical.

### SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering

- URL: https://arxiv.org/abs/2405.15793
- Type: academic agent-interface research
- Status: inspected previously and reused in Slice 13
- Supports: environment and interface structure materially affect agent behaviour; prompt text is only one layer.
- Does not prove: an explicit postcondition commit gate.
- HSM implication: retain prompt/runtime placement discipline.

### From Agent Traces to Trust: Evidence Tracing and Execution Provenance in LLM Agents

- URL: https://arxiv.org/abs/2606.04990
- Type: academic survey/synthesis
- Status: inspected for Slice 13
- Supports: evidence lineage, observability, debugging, audit, and recovery are connected reliability concerns; final-answer accuracy cannot explain why actions were taken or where state diverged.
- Does not prove: a specific static prompt structure.
- HSM implication: treat diagnostically useful execution evidence as a protected runtime surface; do not promise provenance guarantees without runtime support.

### tau-bench: A Benchmark for Tool-Agent-User Interaction in Real-World Domains

- URL: https://arxiv.org/abs/2406.12045
- Type: academic benchmark
- Status: reviewed as supporting context
- Supports: final-state evaluation and repeated-trial reliability matter; one successful run can hide inconsistency.
- Does not prove: Slice 13's exact taxonomy.
- HSM implication: distinguish final state from trajectory quality and avoid claims based on one hand-picked run.

---

## Previously Inspected Academic Foundations

### ReAct

Use: supports interleaving reasoning and environment observations rather than acting only from internal reasoning.

Boundary: does not by itself define evidence sufficiency, state commitment, or recovery.

### Chain-of-Verification

Use: supports deriving verification checks from the claim being tested.

Boundary: does not establish a complete coding-agent runtime contract.

### Self-RAG

Use: supports relevance/support/completeness critique and not treating retrieval as proof.

Boundary: retrieval critique is not equivalent to action gating.

### Reflexion

Use: supports using feedback to change later behaviour.

Boundary: HSM requires observable next-action change, not reflective prose alone.

### CheckList

Use: supports behavioural probes for capabilities and invariants rather than exact wording or exhaustive category lists.

Boundary: dedicated EF13 fixture expansion was skipped; the structural/behavioural distinction remains active in the canonical checklist.

### STORM and related broad-research systems

Use: support orientation and multi-source mapping before premature narrowing.

Boundary: broad research patterns must be blast-radius scaled for coding work.

---

## General Failure Observations

### Middle-detail loss

Observation: long prompts, files, and conversations can reduce the influence of important middle-context details.

Sources:

- Lost in the Middle — https://arxiv.org/abs/2307.03172
- Lost in the Middle, and In-Between — https://arxiv.org/abs/2412.10079
- Found in the Middle — https://arxiv.org/abs/2403.04797
- Lost in the Middle as an IR-demand property — https://arxiv.org/abs/2510.10276

Prompt questions:

- repeat critical non-goals near editing;
- repeat acceptance criteria near validation;
- place forgettable high-value constraints near action boundaries;
- preserve temporal sequence during compression.

### Instruction overshadowing

Observation: later, concrete, or louder instructions can overpower earlier abstract rules.

Questions:

- which rules require action-local reminders or runtime gates?
- should safety/edit boundaries appear near mutation?
- should recovery rules appear near failure handling?
- can the model quote a rule while ignoring it at the relevant action point?

### Tool-result amnesia

Observation: a worker may inspect a result, then drift from the observed fact.

Questions:

- should runtime maintain compact observed-state summaries?
- should action results carry observed/inferred/assumed/invalidated status?
- should run identity and result lineage be explicit?

### Validation theatre

Observation: partial, synthetic, or absent validation can be reported as stronger than it is.

Questions:

- retain explicit validation states;
- require commands run/not run;
- separate local postcondition checks from final task validation;
- do not use eventual success to justify unsupported intermediate steps.

### Semantic coverage without behavioural control

Observation: a rule may be present, understood, and quotable after failure but fail to control the next action.

Questions:

- what transition does the rule control?
- where must it become active?
- what observable action proves compliance?
- does the mechanism require runtime support?

### Open-loop state chaining

Observation: a worker may assume action A produced state S1 and perform dependent action B without checking S1.

Questions:

- what postcondition does B require?
- can A's output directly prove it?
- what is the cheapest relevant observation?
- when should dependent mutation pause?

### Diagnostic-evidence destruction

Observation: cleanup, retries, or ephemeral execution can destroy logs/artifacts/state still needed to diagnose or recover.

Questions:

- what evidence has current diagnostic value?
- is it unique or reproducible?
- when is cleanup safe?
- what privacy, secret, storage, or retention constraints apply?

---

## Promptware And Prompt-Lifecycle Research

### Promptware Engineering

- URL: https://arxiv.org/abs/2503.02400
- Use: prompts as first-class software artifacts with requirements, design, implementation, testing, debugging, evolution, deployment, and monitoring.
- HSM implication: maintain versioned prompt requirements, source refs, changelog, tests, and explicit lifecycle states.

### Understanding Prompt Management in GitHub Repositories

- URL: https://arxiv.org/abs/2509.12421
- Use: prompt organization, duplication, drift, and repository best practices.
- HSM implication: avoid sidecar sprawl; fold accepted findings into canonical documents and mark sidecars as provenance.

### Promptware attacks against production assistants

- URL: https://arxiv.org/abs/2508.12175
- Use: indirect prompt injection, memory poisoning, tool misuse, and invocation risks.
- HSM implication: preserve trusted-input and tool/mutation authority boundaries.

### Promptware Kill Chain

- URL: https://arxiv.org/abs/2601.09625
- Use: multi-step prompt attacks across access, escalation, persistence, lateral movement, and objectives.
- HSM implication: lightweight threat model around untrusted text, permissions, memory, and tool side effects.

---

## External Prompt And Agent-System Sources

### Claude / Anthropic coding-agent prompts

- URL: https://github.com/Piebald-AI/claude-code-system-prompts/tree/main/system-prompts
- Use: tool discipline, planning, edit safety, subagent architecture, security/disclosure boundaries.
- Boundary: vendor/harness-specific assumptions must not be copied blindly.

### OpenAI Codex Max prompt reference

- URL: https://gist.github.com/chigkim/ffed11a3e017d98698707dd24e78af51
- Use: compact comparison for autonomy, patching, validation, and tool discipline.
- Boundary: provenance and runtime completeness may be uncertain.

### Curated ChatGPT system prompt list

- URL: https://github.com/mustvlad/ChatGPT-System-Prompts
- Use: recurring instruction shapes and negative examples.
- Boundary: curated collections are not authoritative or necessarily current.

### OpenCode prompt-system family

Internal research artifacts:

- `research-opencode-source-map.md`
- `comparison-opencode-*.md`
- `comparison-opencode-runtime-assembly.md`
- `comparison-opencode-plan-mode.md`
- `comparison-opencode-agent-task-compaction.md`
- `final-opencode-findings-synthesis.md`

Use: provider-selected base prompts, environment injection, plan/build reminders, permissions, subagent prompts, compaction, TUI state, rollback, diff, and todo workflow.

Slice 13 boundary: current evidence does not establish formal postcondition gates, result lineage, evidence retention, dependency-aware mutation control, or recovery state. Do not assume these capabilities without source/runtime evidence.

---

## Model-Specific And Anecdotal Sources

### LocalLLaMA Qwen general-use prompt observation

- URL: https://www.reddit.com/r/LocalLLaMA/comments/1rxudf2/i_think_i_made_the_best_general_use_system_prompt/
- Type: anecdotal/model-specific
- Status: research input, not authority
- Questions: what behaviour is claimed to improve, is it coding-agent relevant, and can it be reproduced on the local Qwen3.6 stack?

### Qwen 3.6 Plus coding prompt article

- URL: https://rephrase-it.com/blog/how-to-prompt-qwen-36-plus-for-coding
- Type: blog/model-specific
- Status: research input
- Questions: which recommendations survive local testing and translate from coding chat to tool-using agent work?

---

## Local Authority And Prior Art

### QuantZhai packaged coding-agent prompt

- Snapshot: `reference-quantzhai-codex-core-qwenified.md`
- Source repo: `h4rm0n1c/quantzhai`
- Source path: `prompts/codex-core-qwenified.md`
- Role: current local prompt baseline and semantic-compression prior art.

### QuantZhai prompt-policy implementation

- Source path: `proxy/qz_prompt_policy.py`
- Role: explains prompt replacement, prepend/append policy, system assembly, and turn-harness definitions.

### QuantZhai model overrides

- Source path: `config/default/model-overrides.json`
- Role: active prompt selection and model-specific harness configuration.

### HSM workflow patterns

- File: `workflow-patterns.md`
- Role: observed human/assistant/coding-worker arbitration and successful local development loops.

### Canonical HSM prompt-research outputs

- `candidate-structures.md` through C47
- `research-failure-mode-catalog.md` through FM14
- `prompt-evaluation-checklist.md` through Slice 13
- `final-findings-synthesis.md` through Slice 13

These are current methodology outputs. Older extension and amendment files are provenance after consolidation.

---

## Current Research Boundary

The source registry now distinguishes inspected Slice 13 evidence from pending research inputs.

Do not overclaim:

- papers support architecture, not exact wording;
- benchmark success does not guarantee local-model behaviour;
- static prompts cannot guarantee runtime contracts;
- one successful run is not reliable behavioural control;
- OpenCode UI/runtime strengths do not imply unverified state-management capabilities.

New sources should be added here when they materially affect candidate structures, failure taxonomy, runtime placement, or synthesis—not merely because they are interesting.