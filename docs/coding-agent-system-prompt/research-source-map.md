# Source Map — Extended Prompt Surface Research

Status: source scouting complete  
Date: 2026-05-30  
Method: arxiv search, vendor prompt audit, existing slice scan  
Verification: full-paper PDF confirmed for each entry

---

## How to use this

Each entry maps to a theory paper in the extended prompt surface plan.
Papers are grouped by target prompt type. Within each group, papers are
ordered by expected relevance to the theory paper.

For each paper:
- `arxiv ID` for retrieval
- `Relevance` states why the paper matters for coding-agent prompt design
- `Key findings` are the specific claims or structures we may adopt
- `Full paper read` is confirmed for critical papers (noted as CHECKED)

---

## 1. System Prompt Theory Paper

**Status:** ~80% of source material already in committed slices 1-10.
These papers fill remaining gaps.

### 1.1 Promptware Engineering
- **arXiv:** 2503.02400
- **URL:** https://arxiv.org/abs/2503.02400
- **Already read:** CHECKED (slice 4)
- **Relevance:** Lifecycle model for prompt development. Direct match for
  our prompt-structures-as-software-artifacts approach.
- **Key findings used in slices:** lifecycle stages (requirements through
  monitoring), prompt testing, versioning discipline, maintainability.
- **Gap filled:** The lifecycle layer is our authority for treating prompt
  structures as testable components, not magic wording.

### 1.2 Promptware Kill Chain
- **arXiv:** 2601.09625
- **URL:** https://arxiv.org/abs/2601.09625
- **Already read:** CHECKED (slice 6)
- **Relevance:** Lethal Trifecta (untrusted input + sensitive data +
  external communication) applies directly to coding agents.
- **Key findings used in slices:** trusted input boundary (S6-1), disclosure
  prohibition (S6-3), security policy (S6-4).
- **Gap filled:** Safety layer with formal threat model.

### 1.3 Lost in the Middle
- **arXiv:** 2307.03172
- **URL:** https://arxiv.org/abs/2307.03172
- **Already read:** section-level (widely reproduced)
- **Relevance:** Position bias in long contexts. Critical for prompt
  ordering discipline (critical constraints at start/end, not middle).
- **Key findings used in slices:** C12 (pre-edit checklist near action
  points), C16b (query-aware contextualization), position-aware ordering.
- **Gap filled:** Empirical basis for placement rules in prompt text.

### 1.4 Found in the Middle
- **arXiv:** 2403.04797
- **URL:** https://arxiv.org/abs/2403.04797
- **Already read:** CHECKED (slice 3)
- **Relevance:** Ms-PoE positional encoding as mitigation for middle loss.
  Architecture-dependent finding: decoder-only U-shape, >=13B scale
  threshold.
- **Key findings used in slices:** C16b added, slice 3 revised with
  architecture-dependence finding, StableBeluga-13B regression noted.
- **Gap filled:** Architecture-aware context placement.

### 1.5 Prompt Management in GitHub
- **arXiv:** 2509.12421
- **URL:** https://arxiv.org/abs/2509.12421
- **Already read:** results-level (unambiguous statistics)
- **Relevance:** Empirical study of prompt organization in GitHub repos.
  Anti-patterns to avoid.
- **Key findings used in slices:** metadata headers (C17-C22), source refs,
  explicit status fields in prompt files.
- **Gap filled:** Repo-level prompt hygiene.

---

## 2. Compaction Prompt Theory Paper

**Status:** ~15% covered by existing slice 8 (S8-1 atom preservation rule,
S8-2 survival-weighted compaction RFC, S8-3 NetTTS transfer).
New sources needed for the full compaction prompt design.

### 2.1 LLMLingua (core paper)
- **arXiv:** 2310.05736
- **URL:** https://arxiv.org/abs/2310.05736
- **Full paper:** PDF confirmed
- **Relevance:** Foundational prompt compression via token-level perplexity.
  Coarse-to-fine: budget controller, iterative token compression,
  distribution alignment. Up to 20x compression with minimal loss.
- **Key findings for theory paper:**
  - Budget controller: different components (instruction, demos, question)
    need different compression ratios
  - Iterative token compression preserves interdependence between tokens
  - Distribution alignment between small compressor and target LLM
- **For coding-agent compaction:** Must not blindly compress — instruction
  and question parts need lower compression ratios than verbose tool output.

### 2.2 LongLLMLingua
- **Conference:** ACL 2024 (Long Papers)
- **URL:** https://aclanthology.org/2024.acl-long.91/
- **Full paper:** PDF confirmed
- **Relevance:** Question-aware coarse-to-fine compression for long contexts.
  Addresses position bias + key information density. Document reordering.
- **Key findings for theory paper:**
  - Contrastive perplexity for question-relevant token identification
  - Document reordering to minimise position bias
  - Subsequence recovery to preserve key information integrity
- **For coding-agent compaction:** Question-aware compression maps to
  task-context-aware compaction. The agent's current task is the "question."

### 2.3 LLMLingua-2
- **arXiv:** 2403.12968
- **URL:** https://arxiv.org/abs/2403.12968
- **Full paper:** PDF confirmed
- **Relevance:** Reformulates prompt compression as token classification
  (preserve/discard) using full bidirectional context. 3x-6x faster than
  original LLMLingua. XLM-RoBERTa/mBERT compressors.
- **Key findings for theory paper:**
  - Bidirectional context for token importance (vs unidirectional perplexity)
  - Faithfulness guarantee: compressed prompt must not hallucinate
  - Matching rate as quality metric for compression
- **For coding-agent compaction:** Faithfulness requirement is critical —
  coding agents need exact paths, version strings, config values preserved
  verbatim.

### 2.4 Cat: Context as a Tool
- **arXiv:** 2512.22087
- **URL:** https://arxiv.org/abs/2512.22087
- **Full paper:** PDF confirmed
- **Relevance:** Context management as a callable tool for SWE-agents.
  Structured context workspace: stable task semantics + condensed long-term
  memory + high-fidelity short-term interactions.
- **Key findings for theory paper:**
  - Cat treats context management as an active, learnable agent capability
  - Three-part context workspace (fixed anchor, long-term memory, working
    memory) is a reference architecture for compaction prompt design
  - 57.6% on SWE-Bench-Verified with bounded context
- **For coding-agent compaction:** Directly applicable to SWE agent context
  management. The structured workspace model could inform compaction prompt
  structure (what to preserve, what to compress, what to discard).

### 2.5 Acon: Agent Context Optimization
- **arXiv:** 2510.00615
- **URL:** https://arxiv.org/abs/2510.00615
- **Full paper:** PDF confirmed
- **Relevance:** Unified framework for compressing both environment
  observations and interaction histories. Guideline optimisation via
  failure analysis. Distillation into smaller compressors.
- **Key findings for theory paper:**
  - Observation compression + history compression are separate concerns
  - Compression guideline optimisation from failure trajectories
  - 26-54% memory reduction, preserves 95% accuracy after distillation
- **For coding-agent compaction:** The observation/history separation maps
  to tool-output vs agent-reasoning separation in compaction.

### 2.6 ReSum
- **arXiv:** 2509.13313
- **URL:** https://arxiv.org/abs/2509.13313
- **Full paper:** PDF confirmed
- **Relevance:** Periodic context summarization for unbounded web agent
  exploration. Converts growing interaction histories into compact
  reasoning states.
- **Key findings for theory paper:**
  - Summary-conditioned reasoning (agent learns to reason FROM summaries)
  - Segmented trajectory training with advantage broadcasting
  - 4.5% improvement over ReAct, 8.2% after RL training
- **For coding-agent compaction:** Periodic trigger (approaching context
  limit) is a deployment pattern. Summary-conditioned reasoning is an
  open research question for compacted agent sessions.

### 2.7 SUPO: Summarization-Augmented Policy Optimization
- **arXiv:** 2510.06727
- **URL:** https://arxiv.org/abs/2510.06727
- **Full paper:** PDF confirmed
- **Relevance:** RL finetuning with summarization-based context management
  for long-horizon tool-use agents. Jointly optimises tool-use and
  summarization strategies.
- **Key findings for theory paper:**
  - Policy gradient representation for summarization-augmented MDP
  - Overlong trajectory masking mechanism
  - Working context reset to initial prompt + summary
- **For coding-agent compaction:** The "reset to initial prompt + summary"
  pattern is a candidate for QuantZhai compaction architecture.

### 2.8 The Complexity Trap
- **arXiv:** 2508.21433
- **URL:** https://arxiv.org/abs/2508.21433
- **Full paper:** PDF confirmed
- **Relevance:** Direct comparison of observation masking vs LLM
  summarization for SWE agent context management. Simple approaches can
  match sophisticated compression.
- **Key findings for theory paper:**
  - Observation masking halves cost vs raw agent, matching LLM-Summary
  - Most recent context is often sufficient for SE agents
  - Hybrid (mask early, summarize late) best of both worlds
- **For coding-agent compaction:** Challenge to "always summarize"
  assumption. Simple truncation may be sufficient for many cases.
  This should inform when compaction triggers are worth the cost.

### 2.9 SAC: Semantic-Anchor Compression
- **arXiv:** 2510.08907
- **URL:** https://arxiv.org/abs/2510.08907
- **Full paper:** PDF confirmed
- **Relevance:** Autoencoding-free context compression using anchor tokens
  with bidirectional attention. No pretraining on reconstruction tasks.
- **Key findings for theory paper:**
  - Anchor tokens from original context (not learned)
  - Bidirectional attention for global context capture
  - Outperforms AE-based compression on QA and summarization
- **For coding-agent compaction:** Interesting for KV cache compression
  but less directly applicable to prompt-level compaction. Nice-to-have.

### 2.10 CPC: Context-Aware Prompt Compression
- **arXiv:** 2409.01227
- **URL:** https://arxiv.org/abs/2409.01227
- **Full paper:** PDF confirmed
- **Relevance:** Sentence-level compression using contrastive context-aware
  sentence encoder. Preserves human readability.
- **Key findings for theory paper:**
  - Sentence-level preserves coherence better than token-level
  - Contrastive training for relevance scoring
  - Up to 10.93x faster than LongLLMLingua
- **For coding-agent compaction:** Sentence-level compression preserves
  readability. Important for compaction prompts that must be interpretable.

### 2.11 GistPool
- **arXiv:** 2504.08934
- **URL:** https://arxiv.org/abs/2504.08934
- **Full paper:** PDF confirmed
- **Relevance:** In-context compression via gist tokens with no
  architectural modification. GistPool improves on gisting for long
  contexts.
- **Key findings for theory paper:**
  - Gist struggles with long contexts (information flow interruption,
    capacity limits, attention constraints)
  - Average pooling baseline surprisingly outperforms gisting
  - GistPool: uniform token distribution + separate finetuning +
    activation shifting
- **For coding-agent compaction:** Negative result (gisting fails at long
  context) is useful design knowledge. Average pooling as surprising
  baseline matches "simpler is often better" from The Complexity Trap.

### 2.12 EDU-based Context Compressor
- **arXiv:** 2512.14244
- **URL:** https://arxiv.org/abs/2512.14244
- **Full paper:** PDF confirmed
- **Relevance:** Structure-then-select compression using Elementary
  Discourse Units. Preserves global structure + fine-grained detail.
- **Key findings for theory paper:**
  - Linear text -> structural relation tree of EDUs
  - Query-relevant sub-tree selection
  - Faithfulness via source-index anchoring (eliminates hallucination)
- **For coding-agent compaction:** Structure preservation could help
  maintain causal reasoning chains across compression boundaries.

---

## 3. Reasoning Effort Strings Theory Paper

**Status:** ~5% covered (no dedicated research in existing slices).
Entirely new sources needed.

### 3.1 Reasoning on a Budget: A Survey
- **arXiv:** 2507.02076
- **URL:** https://arxiv.org/abs/2507.02076
- **Full paper:** PDF confirmed
- **Relevance:** Comprehensive survey of efficient test-time compute
  strategies. Two-tiered taxonomy: L1 controllability (fixed budget) vs
  L2 adaptiveness (dynamic scaling).
- **Key findings for theory paper:**
  - L1: reasoning_effort parameter (o-series: low/medium/high), thinking
    budget (Claude Sonnet)
  - L2: dynamic scaling based on difficulty/confidence
  - Benchmark data showing trade-offs between performance and token usage
  - Hybrid thinking models as emerging trend
- **For reasoning-effort strings:** The L1/L2 taxonomy provides the
  theoretical framework. L1 maps to fixed effort levels (low/medium/high/
  xhigh). L2 maps to adaptive allocation.

### 3.2 Budget Guidance
- **arXiv:** 2506.13752
- **URL:** https://arxiv.org/abs/2506.13752
- **Full paper:** PDF confirmed
- **Relevance:** Lightweight predictor for Gamma distribution over
  remaining thinking length. Soft token-level steering toward specified
  thinking budget. No LLM fine-tuning.
- **Key findings for theory paper:**
  - Budget forcing (abrupt stop) cuts off unfinished thoughts
  - Budget guidance (smooth steering) maintains reasoning quality
  - 26% accuracy gain under tight budgets vs baseline
  - 63% of full-thinking tokens with competitive accuracy
- **For reasoning-effort strings:** If QuantZhai implements token-level
  budget control, budget guidance is the state of the art. For prompt-level
  strings, the relationship between expressed budget and actual behaviour
  is the key insight.

### 3.3 TALE: Token-Budget-Aware LLM Reasoning
- **arXiv:** 2412.18547
- **URL:** https://arxiv.org/abs/2412.18547
- **Full paper:** PDF confirmed
- **Relevance:** Token elasticity phenomenon — LLMs fail to follow very
  small budgets but follow larger budgets. Optimal token budget per
  question exists.
- **Key findings for theory paper:**
  - Token elasticity: actual token usage vs specified budget is nonlinear
  - Reasonable budget range compresses CoT (258 -> 86 tokens)
  - Too-small budget causes overshoot (10 token budget -> 157 tokens)
  - TALE-EP: zero-shot budget estimation + prompting
  - 67% token reduction with <3% accuracy loss
- **For reasoning-effort strings:** Token elasticity is critical — effort
  strings must account for nonlinear response. Very-low-effort may
  actually cost more than medium-effort.

### 3.4 Plan and Budget
- **arXiv:** 2505.16122
- **URL:** https://arxiv.org/abs/2505.16122
- **Full paper:** PDF confirmed
- **Relevance:** Budget Allocation Model (BAM) — reasoning as sequence of
  sub-questions with varying uncertainty. Decay-based budget scheduling.
- **Key findings for theory paper:**
  - BAM theoretical model: allocate tokens where uncertainty reduction is
    greatest
  - Front-loaded budget allocation (early reasoning gets more tokens)
  - 193.8% improvement in efficiency on complex tasks
- **For reasoning-effort strings:** Front-loaded budget concept is useful
  — early reasoning in a coding-agent turn (file reading, investigation)
  may need more effort budget than later verification.

### 3.5 SEAL: Steerable Reasoning Calibration
- **arXiv:** 2504.07986
- **URL:** https://arxiv.org/abs/2504.07986
- **Full paper:** PDF confirmed
- **Relevance:** Training-free reasoning calibration via latent-space
  steering vector. Identifies execution/reflection/transition thought
  categories. Reduces reflection/transition tokens.
- **Key findings for theory paper:**
  - Reasoning trace categories: execution, reflection, transition
  - Reflection/transition tokens are often wasteful
  - Steering vector = execution_embedding - (reflection + transition)
  - 11.8-50.4% token reduction, 11% accuracy improvement
- **For reasoning-effort strings:** Thought category analysis is useful for
  understanding what effort strings should actually steer. Effort = more
  execution, less wasteful reflection.

### 3.6 Fractional Reasoning
- **arXiv:** 2506.15882
- **URL:** https://arxiv.org/abs/2506.15882
- **Full paper:** PDF confirmed
- **Relevance:** Continuous control over reasoning intensity via latent
  steering vector with tunable scaling factor. No fine-tuning.
- **Key findings for theory paper:**
  - Continuous (not discrete) reasoning intensity control
  - Extracts latent shift from reasoning-promoting inputs
  - Supports breadth-based (Best-of-N) and depth-based (self-reflection)
    scaling
- **For reasoning-effort strings:** Continuous control is future. For now,
  discrete effort levels are the QuantZhai constraint. The paper
  demonstrates that reasoning intensity is a continuous latent variable.

### 3.7 Sys2Bench
- **arXiv:** 2502.12521
- **URL:** https://arxiv.org/abs/2502.12521
- **Full paper:** PDF confirmed
- **Relevance:** Benchmark comparing CoT, SC, ToT, RAP across 11 reasoning
  and planning tasks. No single technique dominates.
- **Key findings for theory paper:**
  - Scaling inference compute has diminishing returns
  - Tree search methods don't benefit from larger models the same way CoT
    does
  - Task-dependent optimal reasoning strategy
- **For reasoning-effort strings:** Reinforces that effort levels should
  be task-aware. One-size-fits-all effort strings are suboptimal.

---

## 4. Cross-Cutting Interactions Theory Paper

**Status:** ~20% covered by existing vendor comparisons (Claude Code,
Codex CLI, Cursor) and candidate-structures.md conflict warnings.

### 4.1 Vendor prompt audit — already committed
- **Files available:**
  - `comparison-claude-code.md` — 11-layer analysis incl. memory system
    and sub-agent architecture
  - `comparison-codex-cli-max.md` — 11-layer taxonomy analysis with
    interaction patterns (mode-aware validation, prompt caching, AGENTS.md
    priority)
  - `comparison-quantzhai-codex-core-qwenified.md` — section-by-section
    against all 10 slices
- **Relevance:** Cross-cutting patterns found across vendors include:
  - Priority resolution (user > AGENTS.md > system prompt) — M9
  - Mode-aware validation (interactive vs non-interactive) — C4/C9+M17
  - Prompt caching interaction: separate injection to preserve cache
  - System-reminder markers for override semantics (Claude Code)
- **Gap:** No vendor document explains how system prompt, compaction
  prompt, and reasoning effort strings interact. This is undocumented
  by all vendors — we're breaking new ground.

### 4.2 Candidate-structures.md conflict registry
- **File available:** `candidate-structures.md` lines 764-850
- **Relevance:** Interaction conflicts between our own structures:
  - C1/C3 "never delegate understanding" may conflict with sub-agent usage
  - M4 "bias strongly to speed" may conflict with over-engineering guard
  - S6-1 "STOP IMMEDIATELY and ask" may conflict with "bias to action"
  - Priority chain: direct user > AGENTS.md > system prompt
- **Gap:** These are conflicts within the system prompt only. No
  cross-surface (system + compaction + reasoning) conflicts identified yet.

### 4.3 Missing academic sources to inspect
- **No known papers** on system-prompt / compaction-prompt / reasoning-effort
  interaction. This area appears unresearched in academic literature.
- **Fallback method:** Design conflict/redundancy matrix empirically.
  Audit QuantZhai's existing prompt surface (system + any compaction +
  any effort steering) for overlaps and contradictions.
- **Candidate cross-cutting principles from existing work:**
  - Centralise authority rules (priority chain) in system prompt — do not
    repeat in compaction or reasoning strings
  - Compaction prompt should NOT repeat safety rules (S6 layer) — those
    belong in system prompt only
  - Reasoning effort strings should NOT override tool contract rules
    (parallel calls, tool name nondisclosure)
  - Token budget: system prompt ~1060, compaction prompt ~50-100,
    reasoning strings ~10-30 each. Total surface target ~1200 max.

---

## Source Map Summary

| Theory Paper | Existing Coverage | New Sources Needed | Confidence |
|---|---|---|---|
| System Prompt | ~80% (slices 1-10) | 1-2 papers for gap fill | High |
| Compaction Prompt | ~15% (slice 8 only) | 7-8 papers (recommended: 2.1, 2.2, 2.4, 2.5, 2.8) | Medium |
| Reasoning Effort | ~5% (none) | 4-5 papers (3.1, 3.2, 3.3, 3.5) | Medium-Low |
| Cross-Cutting | ~20% (vendor audits) | No papers found — empirical design | Low (novel ground) |

## Paper Access Priority

Write theory papers in this order. Read papers in this order per paper:

1. **System Prompt** (highest confidence, warm-up)
2. **Compaction Prompt** (largest source gap, most papers to read)
3. **Reasoning Effort** (moderate source gap, new domain)
4. **Cross-Cutting** (no papers, empirical only — can start while reading)
