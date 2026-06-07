# OpenCode Prompt Source Snapshot

Status: source collection staged for later analysis  
Source repo: `anomalyco/opencode`  
Source ref inspected: `dev`  
Date added: 2026-06-07

This folder records the OpenCode prompt surface for the coding-agent system prompt research project.

The immediate purpose is source capture and source-map hygiene only. Do not treat this file as the final analysis. The dedicated comparison and synthesis updates should happen in a later research pass.

## Prompt Selection Entry Point

OpenCode selects provider/base prompt text in:

```text
packages/opencode/src/session/system.ts
```

Prompt selection observed from source:

```text
gpt-4 / o1 / o3       -> session/prompt/beast.txt
gpt + codex           -> session/prompt/codex.txt
other gpt             -> session/prompt/gpt.txt
gemini-*              -> session/prompt/gemini.txt
claude                -> session/prompt/anthropic.txt
trinity               -> session/prompt/trinity.txt
kimi                  -> session/prompt/kimi.txt
everything else       -> session/prompt/default.txt
```

`opencode-go/deepseek-v4-flash` is expected to fall through to `session/prompt/default.txt` unless some runtime, provider, or agent-level override changes the selected prompt.

## Files To Capture

### Provider/base prompt files

```text
packages/opencode/src/session/prompt/default.txt
packages/opencode/src/session/prompt/anthropic.txt
packages/opencode/src/session/prompt/beast.txt
packages/opencode/src/session/prompt/gemini.txt
packages/opencode/src/session/prompt/gpt.txt
packages/opencode/src/session/prompt/kimi.txt
packages/opencode/src/session/prompt/codex.txt
packages/opencode/src/session/prompt/trinity.txt
packages/opencode/src/session/prompt/max-steps.txt
```

### Built-in agent prompts

```text
packages/opencode/src/agent/generate.txt
packages/opencode/src/agent/prompt/explore.txt
packages/opencode/src/agent/prompt/compaction.txt
packages/opencode/src/agent/prompt/title.txt
packages/opencode/src/agent/prompt/summary.txt
```

### Command templates

```text
packages/opencode/src/command/template/initialize.txt
packages/opencode/src/command/template/review.txt
```

### Tool prompt/description text

```text
packages/opencode/src/tool/task.txt
packages/opencode/src/tool/shell/shell.txt
packages/opencode/src/tool/shell/prompt.ts
```

`prompt.ts` is included because it dynamically renders the shell tool prompt around `shell.txt`.

## Raw Source URLs

```text
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/default.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/anthropic.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/beast.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/gemini.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/gpt.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/kimi.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/codex.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/trinity.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/session/prompt/max-steps.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/agent/generate.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/agent/prompt/explore.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/agent/prompt/compaction.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/agent/prompt/title.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/agent/prompt/summary.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/command/template/initialize.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/command/template/review.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/tool/task.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/tool/shell/shell.txt
https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/opencode/src/tool/shell/prompt.ts
```

## Notes For Later Analysis

- OpenCode has no single static full prompt. The sent system content is assembled from provider or agent prompt text, runtime environment, instruction files, skills, optional user/system text, and plugin transforms.
- OpenCode Go DeepSeek V4 Flash appears to use `default.txt` as the provider/base prompt by selector fallthrough.
- Tool schemas and tool descriptions are separate from the system prompt text but materially affect behaviour.
- `beast.txt` is structurally unusual and should be analysed separately from the calmer provider prompts.
