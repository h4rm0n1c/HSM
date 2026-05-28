# Coding Agent Prompt Research References

Status: pending research queue  
Purpose: point this subproject at external prompt sources, Qwen-specific prompting notes, academic papers, and model flaw observations without copying large external corpora into HSM.

## Research rule

Do not vendor these sources into this repo.

For each source, later research should extract:

```text
Source:
What it is:
Prompt layer(s) observed:
Useful shape:
Risk / uncertainty:
Candidate HSM/QuantZhai rule:
How to test locally:
```

Treat prompt leaks, curated collections, Reddit posts, blog posts, and papers as research inputs, not authority.

## General flaw observations to research and compensate for

These are practical model/task failure shapes that prompt structures should account for.

### Middle detail loss

Observation:

Long prompts, long files, and long conversations can cause important middle-context details to lose influence.

Research links:

- `Lost in the Middle: How Language Models Use Long Contexts` — https://arxiv.org/abs/2307.03172
- `Lost in the Middle, and In-Between: Enhancing Language Models' Ability to Reason Over Long Contexts in Multi-Hop QA` — https://arxiv.org/abs/2412.10079
- `Found in the Middle: How Language Models Use Long Contexts Better via Plug-and-Play Positional Encoding` — https://arxiv.org/abs/2403.04797
- `Lost in the Middle: An Emergent Property from Information Retrieval Demands in LLMs` — https://arxiv.org/abs/2510.10276

Prompt-structure questions:

- Should critical acceptance criteria be repeated near the edit/finalization step?
- Should long task briefs include local checklists immediately before action?
- Does placing non-goals near file-edit instructions reduce accidental scope creep?
- Can QuantZhai tests detect whether middle constraints are being dropped?

### Instruction overshadowing

Observation:

Later, more concrete, or louder instructions can overshadow earlier abstract constraints.

Prompt-structure questions:

- Which rules belong in durable base prompt versus task-local checklist?
- Should safety/edit boundaries be repeated near tool-use instructions?
- Should style/compression instructions be isolated from correctness instructions?

### Tool-result amnesia

Observation:

A coding agent may inspect a file or command result, then drift away from the exact observed fact later.

Prompt-structure questions:

- Should agents maintain a tiny explicit working-state summary for owner files, observed facts, and assumptions?
- Should final answers require observed/fixed/untested separation?
- Should implementation slices require naming the owning file/function before editing?

### Validation theatre

Observation:

Agents can present partial, synthetic, or absent validation as stronger than it is.

Prompt-structure questions:

- Should validation states be formalized as `not_run`, `focused_pass`, `full_pass`, `smoke_yellow`, `smoke_red`, and `blocked`?
- Should final answer structure require commands run and commands not run?
- Should docs avoid words like “green” unless live smoke is actually complete?

## Academic / arXiv references to inspect later

### Promptware Engineering

Paper: `Promptware Engineering: Software Engineering for Prompt-Enabled Systems`  
URL: https://arxiv.org/abs/2503.02400

Reason to inspect:

- Treats prompts as first-class software artifacts.
- Frames prompt development as a software-engineering lifecycle: requirements, design, implementation, testing, debugging, evolution, deployment, and monitoring.
- Strong conceptual match for this subproject because the goal is not magic wording; it is prompt structures with maintainability and tests.

Research questions:

- What lifecycle concepts map cleanly onto QuantZhai prompt development?
- Can prompt requirements, prompt tests, prompt debugging, and prompt evolution become explicit repo artifacts?
- How should prompt changes be versioned and evaluated?
- What parts are too general for coding-agent system prompts?

### Prompt management in GitHub repositories

Paper: `Understanding Prompt Management in GitHub Repositories: A Call for Best Practices`  
URL: https://arxiv.org/abs/2509.12421

Reason to inspect:

- Empirical study of prompt organization and quality issues in GitHub repositories.
- Useful for avoiding prompt sprawl, duplication, formatting drift, and unreadable prompt piles.

Research questions:

- What prompt repository anti-patterns should HSM/QuantZhai avoid?
- Should prompt files have metadata headers, source refs, and explicit status fields?
- How should duplicate or obsolete prompt fragments be marked?
- What lint/checklist should apply to prompt files?

### Lost-in-the-middle baseline

Paper: `Lost in the Middle: How Language Models Use Long Contexts`  
URL: https://arxiv.org/abs/2307.03172

Reason to inspect:

- Found that long-context models often perform best when relevant information appears at the beginning or end of context and worse when it appears in the middle.
- Directly supports the flaw observation that middle details often get lost.

Research questions:

- What prompt structures compensate for position bias?
- Should critical constraints appear near both top-level task framing and action/finalization points?
- How can coding-agent benchmark tasks test for middle-detail retention?

### Lost in the middle for multi-hop reasoning

Paper: `Lost in the Middle, and In-Between: Enhancing Language Models' Ability to Reason Over Long Contexts in Multi-Hop QA`  
URL: https://arxiv.org/abs/2412.10079

Reason to inspect:

- Extends middle-loss concern to multi-hop reasoning where multiple pieces of evidence are spread across context.
- Relevant to software tasks that require connecting docs, tests, source code, logs, and runtime behaviour.

Research questions:

- How should coding-agent prompts force reconnection of separated evidence?
- Should audit outputs include a compact evidence map before implementation?
- Can source/test/doc/capture facts be converted into a short working packet before edits?

### Positional encoding / middle-context mitigation

Paper: `Found in the Middle: How Language Models Use Long Contexts Better via Plug-and-Play Positional Encoding`  
URL: https://arxiv.org/abs/2403.04797

Reason to inspect:

- Model-level mitigation for middle-context weakness.
- Not directly a prompt-engineering paper, but useful for understanding whether the flaw is prompt-solvable, model-solvable, or only partly mitigable by prompt structure.

Research questions:

- Which middle-context failures can prompt structure mitigate?
- Which failures require model/runtime changes rather than prompt wording?
- Does QuantZhai's local model/backend expose any positional behaviour worth testing?

### Promptware attacks against production assistants

Paper: `Invitation Is All You Need! Promptware Attacks Against LLM-Powered Assistants in Production Are Practical and Dangerous`  
URL: https://arxiv.org/abs/2508.12175

Reason to inspect:

- Focuses on malicious promptware, indirect prompt injection, memory poisoning, tool misuse, and agent invocation risks.
- Relevant for coding agents because tool-capable agents can execute high-impact actions.

Research questions:

- What safety boundaries belong in a coding-agent system prompt?
- How should external instructions found in files/webpages/logs be treated?
- How should memory/retrieval poisoning risks map into HSM and QuantZhai prompt structures?

### Promptware kill chain

Paper: `The Promptware Kill Chain: How Prompt Injections Gradually Evolved Into a Multi-Step Malware`  
URL: https://arxiv.org/abs/2601.09625

Reason to inspect:

- Frames prompt attacks as multi-step malware-like campaigns: initial access, privilege escalation, persistence, lateral movement, and actions on objective.
- Useful for coding-agent safety because agents combine prompts, tools, repo access, network access, and sometimes memory.

Research questions:

- Can coding-agent prompts include a lightweight threat model without becoming paranoid sludge?
- Which operations should always require explicit user approval?
- How should agents treat instructions embedded in untrusted repository files, docs, issues, webpages, or logs?

## External sources to inspect later

### Claude / Anthropic system prompts

URL: https://github.com/Piebald-AI/claude-code-system-prompts/tree/main/system-prompts

Reason to inspect:

- Reference system prompts for Claude / Anthropic-style coding agents.
- Useful for comparing tool-use discipline, planning style, refusal/safety boundaries, and repo-edit behaviour.

Research questions:

- How does Claude Code split identity, tool use, safety, and edit discipline?
- What parts are general coding-agent rules versus Anthropic-specific harness assumptions?
- Which rules translate well to local Qwen/Codex-style operation?
- Which rules are too verbose or too vendor-specific?

### OpenAI Codex Max single prompt reference

URL: https://gist.github.com/chigkim/ffed11a3e017d98698707dd24e78af51

Reason to inspect:

- Single reference prompt reportedly associated with OpenAI Codex Max.
- Useful as a compact comparison target against QuantZhai's `codex-core-qwenified.md` baseline.

Research questions:

- What does it prioritize: autonomy, safety, patching, validation, final answer shape, or tool discipline?
- Does it separate plan behaviour from implementation behaviour cleanly?
- Does it contain patterns that explain Codex's observed runtime behaviour?
- Can any rule be adapted into a Qwen-friendly shorter form?

### Curated ChatGPT system prompt list

URL: https://github.com/mustvlad/ChatGPT-System-Prompts

Reason to inspect:

- Broad curated list of system prompts.
- Useful for comparing repeated instruction shapes across ChatGPT-like agents.

Research questions:

- Which patterns recur across strong prompts?
- Which patterns are cargo-cult noise?
- Which prompts distinguish tool behaviour from conversational behaviour?
- Which prompts preserve uncertainty and evidence boundaries?

### LocalLLaMA Qwen general-use prompt observation

URL: https://www.reddit.com/r/LocalLLaMA/comments/1rxudf2/i_think_i_made_the_best_general_use_system_prompt/

Reason to inspect:

- Potentially useful observation about Qwen model prompting.
- User flagged it as interesting for local-model behaviour.

Research questions:

- What specific Qwen behaviour does the author claim to improve?
- Is the gain from identity framing, style, task decomposition, refusal handling, or verbosity control?
- Is the observation compatible with QuantZhai's local Qwen3.6 setup?
- Is it testable with coding-agent tasks rather than chat examples?

### Qwen 3.6 Plus coding prompt article

URL: https://rephrase-it.com/blog/how-to-prompt-qwen-36-plus-for-coding

Reason to inspect:

- User flagged it as potentially important for Qwen 3.6 coding prompts.
- May contain model-specific prompting advice relevant to QuantZhai's Qwen3.6 baseline.

Research questions:

- Does it recommend prompt structures that match observed Qwen3.6 behaviour?
- Does it emphasize role framing, explicit files, tests, examples, chain-of-thought suppression, or output formatting?
- Which parts are coding-agent relevant rather than ordinary coding-chat relevant?
- Can the advice be reduced into compact rules suitable for the QuantZhai prompt stack?

## Local sources to inspect alongside external references

### QuantZhai packaged coding-agent prompt

Local snapshot: `reference-quantzhai-codex-core-qwenified.md`  
Source repo: `h4rm0n1c/quantzhai`  
Source path: `prompts/codex-core-qwenified.md`

Research use:

- Current local baseline.
- Compare every external prompt against this before proposing changes.

### QuantZhai prompt policy implementation

Source repo: `h4rm0n1c/quantzhai`  
Source path: `proxy/qz_prompt_policy.py`

Research use:

- Explains how system prompt files, replacement policy, prompt append/prepend files, and turn harness definitions are assembled.
- Needed before proposing live QuantZhai prompt stack changes.

### QuantZhai default model overrides

Source repo: `h4rm0n1c/quantzhai`  
Source path: `config/default/model-overrides.json`

Research use:

- Shows the default prompt file selection and active turn harness definitions.

### Prior conversation/workflow pattern captured here

Local file: `workflow-patterns.md`

Research use:

- Captures the human/assistant/coding-agent development loop that the prompt should support.
- Treat as behavioural target material, not merely process notes.
