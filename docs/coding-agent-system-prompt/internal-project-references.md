# Internal Source Matrix: Slice 0 Output

Status: completed  
Date: 2026-05-28  
Source: Slice 0 of `research-plan.md` — source map and authority check

## Source classification key

| Label | Meaning |
| --- | --- |
| authority | Doctrine or protocol for this subproject |
| prior_art | Existing work elsewhere in the HSM/QuantZhai/NetTTS stack |
| reference | External source for shape extraction, not authority |
| anecdotal | Single-user observation, unverified |
| speculative | Open idea, uncommitted |
| stale | Reference points to nonexistent or moved file |

## Internal sources

### Coding-agent system prompt subproject (this directory)

| Source | Type | Freshness | Path | Note |
| --- | --- | --- | --- | --- |
| README.md | authority | current | `docs/coding-agent-system-prompt/README.md` | Scope, seed thesis, working rules |
| AGENTS.md | authority | current | `docs/coding-agent-system-prompt/AGENTS.md` | Local agent rules, source boundaries, QuantZhai boundary |
| research-plan.md | authority | current | `docs/coding-agent-system-prompt/research-plan.md` | 11-slice protocol with mandatory adversarial review |
| workflow-patterns.md | authority | current | `docs/coding-agent-system-prompt/workflow-patterns.md` | Behavioural target material from QuantZhai/HSM work |
| research-references.md | authority | current | `docs/coding-agent-system-prompt/research-references.md` | External/ academic queue with research rules |
| reference-quantzhai-codex-core-qwenified.md | prior_art | snapshot at commit 2b2fe8b | `docs/coding-agent-system-prompt/reference-quantzhai-codex-core-qwenified.md` | Baseline prompt; not live QuantZhai authority |

### HSM root docs

| Source | Type | Freshness | Path | Note |
| --- | --- | --- | --- | --- |
| AGENTS.md | authority | current | `HSM/AGENTS.md` | Root harness with anti-agreement requirement |
| README.md (root) | authority | current | `HSM/README.md` | Project overview and source boundaries |
| docs/README.md | authority | current | `HSM/docs/README.md` | Documentation index |
| anti-agreement-harness.md | authority | current | `HSM/docs/anti-agreement-harness.md` | Claim classification, uncertainty, falsification — HSM doctrine |
| runtime-and-integrity.md | authority | current | `HSM/docs/runtime-and-integrity.md` | Runtime packet, update gate, truth discipline — HSM design |
| source-map-and-roadmap.md | authority | current | `HSM/docs/source-map-and-roadmap.md` | Repo boundaries and implementation phases |
| hsm_ai_workflow_arbitrator_observations.md | authority | current | `HSM/docs/hsm_ai_workflow_arbitrator_observations.md` | 14 observed workflow patterns from one subject (N=1) |
| identity-as-data-contract.md | authority | May 17, 2026 | PR #1 (OPEN, not merged) | Executor/subject separation doctrine; pending merge |

### Verification finding: identity-as-data-contract.md

Not yet merged into main branch. PR #1 is open. The doc exists as reviewable diff content. The doctrine is referenced in the research plan but is not yet committed HSM authority. Treat as proposed doctrine, not ratified.

### QuantZhai issues

| Source | Type | State | Date | Relevance to prompt research |
| --- | --- | --- | --- | --- |
| #8 | prior_art | OPEN | May 13 | **High** — survival-weighted compaction RFC; directly relevant to Slice 8 (compaction/high-value atoms) |
| #37 | prior_art | CLOSED | May 14 | **High** — architectural seam extraction; surface map for QuantZhai module boundaries |
| #40 | prior_art | CLOSED | May 14 | **Medium** — stream watchdog/recovery; relevant to stream-state feedback (Slice 7) |
| #41 | prior_art | CLOSED | May 14 | **High** — bidirectional signal surface map; inventories what QuantZhai sees/injects |
| #43 | prior_art | CLOSED | May 14 | **Medium** — repeated-read live smoke; operational test pattern |
| #44 | prior_art | CLOSED | May 14 | **Medium** — backend control plane audit; script vs proxy ownership |
| #65 | prior_art | CLOSED | May 20 | **Medium** — Docker lifecycle proxy migration; runtime control-plane evolution |

### NetTTS

| Source | Type | Freshness | Path | Note |
| --- | --- | --- | --- | --- |
| prosody_encoder_detaIls.md | stale | unknown | `nettts/docs/prosody_encoder_detaIls.md` | **Not found at expected path.** Repo exists at `/home/harri/nettts` but file missing or renamed |

### Verification finding: NetTTS prosody encoder path

The path `docs/prosody_encoder_detaIls.md` referenced in research-plan.md (Slice 0 sources) and research-references.md does not exist. The NetTTS repo is at `/home/harri/nettts` but the docs directory layout does not match. This needs correction before Slice 8.

## External sources (status: uninspected)

These are queued in `research-references.md` but have not been fetched or analysed in this pass. Listed here for completeness of the source map.

| Source | Type | Risk |
| --- | --- | --- |
| Claude/Anthropic system prompts (Piebald-AI) | reference | Third-party collection, provenance unclear, may be outdated |
| OpenAI Codex Max gist | reference | Single gist, unverified, anecdotal |
| Curated ChatGPT prompt list (mustvlad) | reference | Mixed quality, broad collection |
| Qwen Reddit post (LocalLLaMA) | anecdotal | Single user, untestable without local replication |
| Qwen 3.6 Plus coding blog (rephrase-it) | reference | SEO content, not research-grade |

## Academic sources (status: uninspected)

| Source | Relevance | Why referenced |
| --- | --- | --- |
| Lost in the Middle (2307.03172) | High | Directly supports middle-detail loss observations in workflow-patterns.md |
| Lost in Middle multi-hop (2412.10079) | Medium | Multi-hop QA extension |
| Found in the Middle (2403.04797) | Medium | Positional encoding mitigation |
| Lost in Middle emergent property (2510.10276) | Low-Medium | Emergent property framing |
| Promptware Engineering (2503.02400) | High | Prompt lifecycle methodology |
| Prompt Management in GitHub (2509.12421) | Medium | Anti-patterns for prompt repos |
| Promptware Attacks (2508.12175) | Medium | Safety boundaries |
| Promptware Kill Chain (2601.09625) | Medium | Multi-step attack model |

## Source classification summary

```text
authority:    12 sources (subproject docs + HSM doctrine)
prior_art:    8 sources (QuantZhai issues + prompt snapshot)
reference:    5 sources (external prompts, blog)
anecdotal:    1 source (Reddit Qwen post)
stale:        1 source (NetTTS prosody encoder path)
uninspected:  13 sources (5 external + 8 academic)
```

## Key findings

1. **Internal authority is well-structured.** The subproject docs are coherent, up to date, and properly layered. No contradictions found between them.

2. **QuantZhai issues are recent and relevant.** All referenced issues are <3 weeks old. Issues #8 (survival-weighted compaction) and #41 (signal surface map) are the most relevant to prompt research.

3. **HSM PR #1 is not merged.** The identity-as-data contract is referenced as doctrine but is still an open PR. Research plan should note this as pending authority, not ratified.

4. **NetTTS prosody encoder reference is stale.** The path `nettts/docs/prosody_encoder_detaIls.md` does not exist. Must be located or removed before Slice 8.

5. **External queues are untouched.** All external prompt sources and academic papers are uninspected. This limits the confidence of any "novel" claim about prompt structures until Slice 9 (external comparison).

6. **Single-subject N=1 risk.** `hsm_ai_workflow_arbitrator_observations.md` draws 14 patterns from one observed feature (PuTTY OSC52). Valuable but needs calibration against other evidence before treating patterns as general.

## Research plan updates needed

- Slice 0 sources list: correct NetTTS prosody encoder path or mark as unresolved
- Slice 0 sources list: add PR #1 identity-as-data contract as pending authority
- Slice 0 sources list: note that `hsm_ai_workflow_arbitrator_observations.md` is N=1
