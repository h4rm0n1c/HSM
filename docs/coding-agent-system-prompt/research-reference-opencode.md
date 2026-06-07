# OpenCode Prompt Research Reference

Status: source-capture stub  
Date: 2026-06-07  
Source repo: `anomalyco/opencode`  
Local source folder: `docs/coding-agent-system-prompt/external-reference/OpenCode/`

## Why this exists

OpenCode was not part of the original external prompt-source set. It is now relevant because the `opencode-go/deepseek-v4-flash` behaviour appears to depend on OpenCode's dynamically assembled prompt surface, not one single static prompt.

This file records that the OpenCode source folder exists. The actual comparison, adoption analysis, and final synthesis updates are deliberately deferred.

## Source layers to inspect later

```text
provider/base prompts
agent override prompts
command templates
tool descriptions
shell prompt renderer
system prompt assembly code
request preparation code
```

## Key source paths

```text
docs/coding-agent-system-prompt/external-reference/OpenCode/README.md
docs/coding-agent-system-prompt/external-reference/OpenCode/fetch-opencode-prompts.sh
```

## Deferred analysis questions

- Should OpenCode's `default.txt` be compared as a generic open-model prompt rather than a DeepSeek-specific prompt?
- Does `beast.txt` represent a useful autonomy pattern or a failure-prone overdrive mode?
- Which OpenCode rules belong in static prompt text versus runtime/tool descriptions under the HSM Rule Zero principle?
- Does OpenCode's very strong brevity pressure explain odd behaviour from DeepSeek V4 Flash?
- Which OpenCode prompt fragments should be adopted, rejected, or tested in QuantZhai?
