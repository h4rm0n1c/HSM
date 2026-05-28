# Coding Agent System Prompt Subproject Instructions

This directory is a separate but related HSM subproject.

## Scope

These instructions apply to:

```text
docs/coding-agent-system-prompt/**
```

The goal is to develop coding-agent system prompt structures and the surrounding research method.

This is not an attempt to force one specific internal reasoning style. It is a design workspace for external structures that improve reasoning over software-development tasks.

This is not the main HSM subject-state schema area. It is not the QuantZhai runtime repo. It is a design and research workspace for coding-agent prompt development.

## Authority

Use these sources in order:

1. Direct user instruction in the current task.
2. This local `AGENTS.md`.
3. HSM root `AGENTS.md`.
4. Current files in this directory.
5. QuantZhai as source/prior art.
6. External prompt references listed in `research-references.md`.
7. Model inference, labelled as inference.

## Source boundaries

Do not copy large external prompt dumps into this repo.

Allowed:

- short excerpts when needed and legally/safely appropriate
- summaries
- reference links
- source maps
- analysis notes
- extracted prompt-shape observations

Not allowed by default:

- vendoring full external prompt repositories
- pasting large third-party prompt files
- treating unverified prompt leaks as authoritative
- flattening Anthropic/OpenAI/Qwen/local-model behaviour into one generic prompt pile

## QuantZhai boundary

QuantZhai is source material and runtime prior art.

When copying a QuantZhai prompt snapshot into this directory:

- name it clearly as a reference snapshot
- include source repo, source path, and commit/ref when known
- do not treat the copy as live QuantZhai authority
- do not edit the snapshot to become the new prompt
- create separate analysis or candidate files for experiments

## Working method

Use the same evidence-first loop captured in `workflow-patterns.md`, but treat it as a scaffold, not a mandated inner reasoning style:

```text
suspicion / prompt idea
  -> source audit
  -> behavioural hypothesis
  -> prompt structure or slice
  -> testable expectation
  -> candidate wording
  -> local evaluation
  -> keep / revise / reject
```

Prompt work must preserve uncertainty.

A good finding says:

```text
Observed:
Inferred:
Risk:
Candidate structure:
How to test:
```

## Prompt design rules

Prefer modular prompt structures over one giant undifferentiated prompt.

Separate:

- executor identity
- tool contract
- repo authority
- task-framing scaffold
- planning scaffold
- exploration scaffold
- edit-boundary scaffold
- validation scaffold
- safety/escalation handling
- final answer contract
- optional style/compression layer

Do not mix style compression with core correctness unless the experiment is explicitly about compression.

Do not write as though the project is trying to invent a single correct reasoning process. Write as though it is building reusable structures that help the agent reason over different software-development task shapes.

## Output quality

Docs in this directory should be normal professional markdown.

Do not use caveman style in docs or candidate prompts unless explicitly creating a compression/style experiment.

When creating candidate prompt text, keep it copyable, minimal, and bounded.

## Maintenance

If adding a new important markdown document in this directory, update this directory `README.md` and the parent `docs/README.md` if it should be discoverable from the HSM front door.
