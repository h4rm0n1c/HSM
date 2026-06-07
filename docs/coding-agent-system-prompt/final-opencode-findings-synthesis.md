# Synthesis: OpenCode Coding Agent System Prompts

Status: consolidated research output  
Date: 2026-06-07  
Scope: OpenCode base prompt variants captured from `anomalyco/opencode` `dev`

---

## Source Boundary

This synthesis covers OpenCode base prompt files:

```text
anthropic.txt
beast.txt
codex.txt
default.txt
gemini.txt
gpt.txt
kimi.txt
trinity.txt
```

It does not claim to audit the whole OpenCode runtime. OpenCode also assembles behavior from environment injection, tool descriptions, skill lists, command templates, built-in agent prompts, permission state, and plugin transforms. Those surfaces are source material for later work.

Claim status: `supported` for base-prompt observations, `plausible_but_unproven` for runtime-behavior predictions until fixture runs are completed.

---

## 1. Overview

OpenCode is not one prompt. It is a provider-selected prompt family plus runtime context injection.

The important finding is not "which variant wins" globally. The useful result is a set of prompt-shape clusters:

- `gpt.txt`: best match to our current pragmatic shared-workspace coding-agent shape.
- `codex.txt`: strongest anti-agreement and professional-objectivity wording.
- `trinity.txt`: best compact all-around base prompt with AGENTS.md awareness.
- `gemini.txt`: strongest local convention, library, and verification discipline.
- `default.txt` and `kimi.txt`: useful concise-output references, weak as complete safety baselines.
- `anthropic.txt` and `beast.txt`: high-persistence stress prompts, useful only after bounding their overreach.

The durable lesson is that prompt variants can be treated as modular evidence. OpenCode's best ideas should be extracted as structures, not copied wholesale.

---

## 2. Comparative Maturity Matrix

| Prompt | Identity | Tool Contract | Task Framing | Repo Authority | Edit Boundaries | Validation | Trusted Boundary | Output |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `gpt` | Strong | Strong | Strong | Moderate | Strong | Functional | Moderate | Strong |
| `codex` | Functional | Strong | Strong | Missing | Strong | Functional | Moderate | Strong |
| `trinity` | Functional | Functional | Strong | Strong | Strong | Strong | Moderate | Strong |
| `gemini` | Functional | Functional | Strong | Strong | Moderate | Strong | Moderate | Strong |
| `default` | Functional | Functional | Moderate | Missing | Missing | Functional | Moderate | Strong |
| `kimi` | Functional | Functional | Strong | Moderate | Missing | Strong | Moderate | Strong |
| `anthropic` | Adequate | Weak | Aggressive | Missing | Missing | Functional | Missing | Functional |
| `beast` | Adequate | Functional | Aggressive | Missing | Missing | Strong | Missing | Functional |

Interpretation:

- `gpt`, `codex`, `trinity`, and `gemini` are the serious adoption sources.
- `default` and `kimi` are compactness references.
- `anthropic` and `beast` are completion-pressure references, not default prompt models.

---

## 3. Findings To Preserve

### Professional Objectivity

Observed:
`codex.txt` has the clearest instruction to prioritize technical accuracy over validating the user's beliefs.

Inferred:
This is the OpenCode finding most directly aligned with HSM's anti-agreement harness. It gives a compact coding-agent wording for "correction before rapport" without forcing visible claim classification on every task.

Risk:
If paired with a boastful executor identity, objectivity is partly diluted by persona framing.

Candidate structure:
Adopt professional objectivity as a standard section, but pair it with a restrained executor identity.

How to test:
Use a plausible-wrong-user-diagnosis fixture and compare agreement-driven edits before and after the wording.

### Shared Workspace Executor

Observed:
`gpt.txt` frames OpenCode as sharing the user's workspace and collaborating to achieve the user's goals, then immediately grounds behavior in codebase inspection and small correct edits.

Inferred:
This is the cleanest OpenCode identity cluster for QuantZhai-like work. It avoids both bland "CLI tool only" framing and grandiose persona claims.

Risk:
It still needs explicit subject-identity prohibition if used in HSM contexts where executor/subject collapse matters.

Candidate structure:
Adopt shared-workspace executor identity, plus C23/C26 executor-as-data and subject-identity guard.

How to test:
Compare persona leakage and task adherence across `gpt`, `codex`, and executor-header variants.

### Compact Repo Authority

Observed:
`trinity.txt` explicitly recognizes AGENTS.md as background and guidance; `gemini.txt` strongly enforces conventions, libraries, style, and local context.

Inferred:
Repo authority works best as two layers: project-instruction hierarchy plus local convention inspection.

Risk:
OpenCode base prompts do not consistently define scope, nesting, or precedence. The strongest version still needs M8/M9 semantics.

Candidate structure:
Merge Trinity AGENTS.md awareness with Gemini convention mandates and Codex CLI-style AGENTS.md precedence.

How to test:
Use nested AGENTS.md fixtures with conflicting rules and local-style fixtures with tempting foreign dependencies.

### Edit Boundary Discipline

Observed:
`gpt.txt` and `codex.txt` are strong on dirty-worktree preservation and destructive git avoidance. `codex.txt` also has a file-creation guard.

Inferred:
OpenCode validates our finding that edit safety must be explicit and near the editing section. Variants without those rules are materially weaker for shared repos.

Risk:
Some variants rely on general convention-following but omit dirty-worktree safety, which is not enough for concurrent work.

Candidate structure:
Use the `gpt` dirty-worktree wording plus the `codex` file-creation guard and our M14 staging/destructive-git rules.

How to test:
Run dirty-worktree, destructive-git, and file-creation fixtures.

### Bounded Persistence

Observed:
`anthropic.txt` and `beast.txt` aggressively require continuing until the task is completely solved. Beast also requires extensive web research, repeated tests, visible todo updates, automatic `.env` creation, and large file reads.

Inferred:
Persistence wording can reduce task abandonment, but Beast-style wording is too broad for a normal coding-agent prompt.

Risk:
Unbounded persistence conflicts with scope discipline, token budget, file-creation constraints, and mode-aware validation.

Candidate structure:
Adopt only bounded persistence: continue through investigation, implementation, validation, and report unless blocked; do not require universal web research.

How to test:
Use task-abandonment and context-overload fixtures while tracking token cost and irrelevant research.

### Runtime Context Injection

Observed:
`system.ts` injects model identity, working directory, workspace root, git status boolean, platform, and current date in an `<env>` block.

Inferred:
This confirms Rule Zero: dynamic runtime facts belong outside static prompt files.

Risk:
The injected environment block is useful but not enough. Git status as a boolean is weaker than our categorized dirty-worktree injection proposal.

Candidate structure:
Keep harness-injected environment context and expand it with categorized git state, AGENTS.md scope summaries, and validation commands when known.

How to test:
Compare fixture behavior with no environment block, OpenCode-style environment block, and expanded QuantZhai-style environment/git block.

---

## 4. Adoption Recommendations

Adopt now:

- `codex` professional objectivity, rewritten without boastful identity.
- `gpt` shared-workspace framing, smallest-correct-change bias, parallel-call guidance, dirty-worktree preservation, and commentary/final channel split.
- `trinity` AGENTS.md awareness, expanded with M8/M9 scope and precedence.
- `gemini` convention/library/style mandates.
- `codex` file-creation guard.
- OpenCode runtime environment injection pattern, expanded with richer git and project-rule state.

Adopt with constraints:

- Anthropic/Beast persistence wording, reduced to bounded task completion.
- Kimi/Default concise-output pressure, only after safety and validation scaffolds are present.
- Todo/planning visibility, only for multi-step tasks; avoid forcing it onto trivial edits.

Reject as baseline:

- Universal web research.
- "Perfect solution" language.
- Automatic `.env` creation.
- Fixed 2000-line file-read requirements.
- One-tool-per-message rules for agents that can safely parallelize independent reads.
- Boastful identity claims such as "best coding agent on the planet."

---

## 5. Gaps After OpenCode

OpenCode strengthens our candidate set but does not remove these gaps:

- Trusted input boundaries remain inconsistent across base prompts.
- AGENTS.md precedence is present only partially and lacks full nested-scope semantics.
- Validation honesty is present as a behavior expectation, but not as an explicit state taxonomy.
- Compaction preservation is only visible in the built-in compaction prompt, not the base prompt family.
- Runtime behavior still needs fixture validation before claims become durable.

---

## 6. Next Useful Move

Update the candidate prompt set with an "OpenCode adoption cluster" rather than scattering individual lines across unrelated structures:

```text
OpenCode adoption cluster:
  professional objectivity
  shared-workspace executor
  smallest correct change
  parallel independent tool calls
  dirty-worktree preservation
  file-creation guard
  convention/library/style mandate
  AGENTS.md awareness + explicit precedence
  bounded persistence
  concise CLI final answer
```

Then run fixture comparison against:

```text
QuantZhai current baseline
OpenCode gpt-shaped candidate
OpenCode codex-shaped candidate
OpenCode trinity-shaped candidate
```

The expected result is not one universal winner. The expected result is a smaller candidate prompt that combines `gpt` execution discipline, `codex` objectivity, `trinity` repo authority, and `gemini` convention safety without importing Beast/Anthropic overreach.
