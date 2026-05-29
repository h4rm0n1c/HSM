# Slice 8: Compaction / High-Value Atom Preservation

Status: research output  
Date: 2026-05-30  
Confidence: medium  
Parent: `research-plan.md` Slice 8  
Sources: QuantZhai issue #8 (survival-weighted compaction RFC, full text); NetTTS `vox_parser.cpp` prosody weighting; Slice 3 C15 (high-value atom preservation); candidate-structures.md C15

---

## Question

When context is compacted or summarised (either by the agent itself, by the runtime, or by a compression pass), which atoms must be preserved exactly for the agent to remain effective?

## Hypothesis

Compaction is inevitable in long-running coding-agent sessions. The question is not whether to compact but how. High-value atoms are not the same as high-probability tokens — they are the load-bearing details that, if lost, cause the agent to make incorrect edits, wrong commands, or invalid assumptions.

A deterministic survival-weight heuristic (inspired by NetTTS prosody weighting) can outperform naive token-count compaction and LLM-based summarisation for preserving coding-agent-critical information.

## Sources Inspected

### QuantZhai Issue #8: RFC — NetTTS-Inspired Survival-Weighted Compaction

Full issue text read (48 paragraphs). Key contributions:

**Core hypothesis:**
NetTTS prosody weight (which words need breathing room for intelligible speech) can be adapted to compaction weight (which words/spans need preservation for meaning to survive compression).

**Proposed two-factor model:**
- `token_cost` — how expensive is this text in token budget
- `meaning_weight` — how dangerous is it to compress/delete/paraphrase this text

**Heavy spans (preserve exact):**
- proper nouns / TitleCase words
- numbers, versions, dates, measurements
- file paths
- commands
- CLI flags
- environment variables
- function names, class names
- error strings
- quoted text
- hyphenated technical terms
- long or many-syllable domain words
- rare/local project terms
- user corrections
- explicit constraints
- negation terms: not, never, no, without, unless

**Light spans (drop or crush):**
- common stopwords
- connective prose
- repeated explanation
- low-information politeness/filler
- already-preserved restatements

**Medium spans (summarise):**
- normal explanatory prose

**Design principles:**
- Deterministic v0 (no embeddings required)
- Does not cross memory_domain/workspace scope
- Does not create durable memory
- Does not bypass LimbiCore state boundary
- Integrates as a renderer or utility job, not a model-level change

**Open questions from the issue:**
- How much of NetTTS weight() transfers directly?
- Should syllable count matter for code/technical text?
- Should rarity be approximated without embeddings?
- Can project-local term frequency identify important weird words?
- How should exactness_risk interact with summary budget?
- Can this improve current compaction bridge behaviour measurably?
- Should the scorer emit advisory comments, or only guide compaction silently?
- How do we prevent over-preserving every long word?

### Slice 3 C15: High-Value Atom Preservation

From `slice-3-context-position-middle-loss.md` — already identified as a process/runtime structure, not prompt text. The atom preservation list matches issue #8's heavy-span classification with minor differences.

| Atom type | Slice 3 C15 | Issue #8 heavy spans |
|---|---|---|
| File paths | yes | yes |
| Function names | yes | yes |
| CLI flags | yes | yes |
| Environment variables | yes | yes |
| Version strings | yes | yes |
| Error messages | yes | yes |
| Negations | yes | yes |
| User corrections | yes | yes |
| Model/profile names | — | yes |
| Explicit constraints | — | yes |
| Quoted text | — | yes |

Issue #8 adds model/profile names, explicit constraints, and quoted text. These should be added to the atom preservation list.

### NetTTS Prosody Weighting (vox_parser.cpp)

The prior art for the survival-weight concept. NetTTS classifies words as LIGHT, MEDIUM, or HEAVY based on deterministic features:
- LIGHT: stopwords, light verbs
- HEAVY: digits, hyphenated words, TitleCase words, units, long words, many-syllable words
- The beat builder inserts breaks around heavy material
- Overloaded runs are split for listener parseability

**Transfer insight:** If a heuristic can determine which words need prosodic space for a human listener, the same heuristic can determine which spans need exact preservation for an LLM consumer. The underlying problem (salience under bandwidth constraint) is structurally similar.

### Existing Harness Experiment on Compaction

The qwen-blank test (experiments/qwen-blank-select-20260529T161135Z) loaded the model and confirmed it works with qz-codex. No compaction test was run — the compaction experiment was blocked by model selection rollback. This slice is design-only pending a stable backend.

---

## Adversarial Review

**Q1: Is survival-weighted compaction better than LLM summarisation for agent context?**

Probably yes for high-value atoms. LLM summarisation tends to:
- Flatten exact commands into vague descriptions ("ran a build command" → lost `DOCKER_BUILDKIT=1`)
- Drop negation ("do not delete config" → lost the constraint)
- Paraphrase critical error messages into generic explanations
- Over-summarise user corrections

A deterministic survival-weight compactor preserves the load-bearing atoms and summarises only the filler. The two approaches could be combined: survival-weight identifies what must survive, LLM summarisation compresses the rest.

**Q2: Should the agent be aware of compaction?**

Yes, lightly. The agent should know that compaction may occur and should preserve high-value atoms in its own intermediate reasoning. See Slice 7 S7-6 (continuation and compaction awareness).

**Q3: Who owns compaction — the agent, the runtime, or both?**

Both, with different responsibilities:

| Layer | Compaction responsibility | Structure |
|---|---|---|
| Prompt | Instruct agent to preserve high-value atoms in its reasoning | S7-6 |
| Runtime | Survival-weighted compaction of conversation history | Issue #8 |
| Harness | Snapshot key state before/after compaction | qz-status |

The runtime owns the actual compaction mechanism. The prompt sets expectations so the agent can compensate.

**Q4: Can over-preservation happen?**

Yes — the main risk. If every long word is preserved, compaction saves nothing. The exactness_risk field in the v0 model is meant to address this: a long word that is common English ("implementation") has low exactness_risk; an unusual project name ("QuantZhaiProxyRouterV3") has high exactness_risk. The threshold needs tuning.

**Q5: Is this worth implementing before we have compaction pressure?**

Yes — because the atom classification is useful even without a compactor. The prompt's compaction-awareness rule (S7-6) tells the agent which atoms to preserve in its own reasoning. This works today, with no runtime changes. The compactor is a runtime optimisation of the same principle.

---

## Candidate Structures

### Structure S8-1: High-Value Atom Preservation Rule (adopt — prompt level)

Merge and update C15 with the expanded atom list from issue #8:

```
If compression or compaction occurs, preserve these atoms exactly
(rather than paraphrasing):
- file paths, function names, class names
- CLI flags, environment variable names
- version strings, date/number literals
- error messages, command output excerpts
- negation: not, never, no, without, unless, and similar
- user corrections and explicit constraints
- model/profile names
- quoted text and exact error strings
- project-specific or domain-specific proper nouns
Everything else can be summarised.
```

**Source**: C15 (Slice 3) + Issue #8 heavy-span list + S7-6
**Token cost**: ~80 tokens
**Test**: Give agent a multi-step task, then check after compaction whether exact commands, paths, and constraints survive in agent output. Manual inspection for now — automated compaction fixture would be needed for CI.

### Structure S8-2: Survival-Weighted Compaction Design (process — runtime)

This is a runtime structure, not prompt text. Key design points from issue #8 for reference:

**Algorithm v0:**
1. Tokenize into words/spans/lines
2. Annotate each span with deterministic features
3. Produce `meaning_weight` (light/medium/heavy) and `exactness_risk` (low/medium/high)
4. Preserve heavy exact spans verbatim
5. Summarise medium spans
6. Drop or crush light spans
7. Emit compact packet with provenance/source pointers where possible

**Weight features (deterministic, v0):**
- TitleCase / uppercase / mixed case
- Contains digit or version pattern
- Contains path separator (`/`, `\`) or file extension
- Contains `=` (env var or flag assignment)
- Contains hyphenated compound
- Length in characters or estimated tokens
- Contains quoted substring
- Matches known negation tokens
- Contains project-local rare term (if available)

**Source**: QuantZhai issue #8
**Status**: RFC — not implemented
**Next step**: Build standalone scorer prototype (scripts/qz-survival-weight-demo or proxy/qz_survival_weight.py)

### Structure S8-3: Compaction Safety Acceptance Criteria (process)

From issue #8's acceptance criteria: a useful compaction prototype should show:

```
- preserves exact command strings
- preserves file paths
- preserves version numbers
- preserves error names/messages
- preserves explicit negation and constraints
- preserves model/profile names
- preserves user corrections
- reduces filler/repetition
- keeps output readable enough for an LLM to use
```

**Source**: QuantZhai issue #8 acceptance criteria
**Status**: Process structure — use as evaluation checklist for any compaction implementation

---

## Integration: Compaction in the Prompt Stack

Compaction affects the prompt stack at two layers:

**Layer 1: Agent-side (prompt text)**
The agent is told what to preserve in its own reasoning (S8-1). This is a lightweight behavioural rule that works today, with no runtime dependency. It belongs in the runtime awareness section alongside S7-1 through S7-6.

**Layer 2: Runtime-side (compaction mechanism)**
The runtime applies survival-weighted compaction to the conversation history or tool result log (S8-2). This is a future implementation in QuantZhai, not a prompt structure. The v0 algorithm is deterministic, uses no embeddings, and produces a compacted context packet that preserves high-value atoms.

**Trigger condition:** Compaction should be triggered by:
- Token budget approaching limit
- Explicit compact request from agent or client
- Stream-compact lifecycle event
- Runtime pressure signal (e.g., repeated-read overhead)

---

## Follow-up

1. **Add S8-1 (expanded atom preservation) to candidate-structures.md** — update the existing C15 entry with the expanded atom list from issue #8.
2. **Mark S8-2 (survival-weighted compaction) as future QuantZhai work** — reference in the compaction/preservation roadmap.
3. **Do not block prompt text on compaction runtime** — S8-1 is independent and can be adopted immediately.
4. **When compaction is implemented in QuantZhai:** run the acceptance criteria (S8-3) against both naive summarisation and survival-weighted compaction on identical fixtures.
5. **When compaction is available in harness:** add a compaction-awareness test to the evaluation checklist (prompt-evaluation-checklist.md).
