# Coding Agent Prompt Research References

Status: pending research queue  
Purpose: point this subproject at external prompt sources and Qwen-specific prompting notes without copying large external corpora into HSM.

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

Treat prompt leaks, curated collections, Reddit posts, and blog posts as research inputs, not authority.

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
