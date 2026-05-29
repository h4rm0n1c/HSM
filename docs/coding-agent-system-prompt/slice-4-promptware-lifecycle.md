# Slice 4: Promptware / prompt lifecycle engineering

Status: completed
Date: 2026-05-29
Confidence: medium
Parent: `research-plan.md` Slice 4

---

## Question

Should this subproject treat prompts like software artifacts with lifecycle, tests, versioning, and debugging?

## Hypothesis

Yes, but only where it produces lightweight, useful repo practice.

## Sources inspected

| Source | What it contributed |
| --- | --- |
| **Promptware Engineering** (arXiv 2503.02400v2, Jan 2026, ACM TOSEM) | Full SE lifecycle framework for prompts: RE, design, implementation, testing/debugging, evolution, deployment, monitoring. Identifies "promptware crisis" (ad hoc trial-and-error). Proposes prompt design patterns, prompt-centric programming languages, prompt requirements trade-offs. Accepted in top SE journal. |
| **Understanding Prompt Management in GitHub Repositories** (arXiv 2509.12421v3, Jan 2026, IEEE Software) | Empirical study of 24,800 prompts from 92 GitHub repos. Findings: 72.8% use Markdown, 55.2% contain spelling errors, 38.5% are semantic duplicates, no standardized metadata or formatting. Recommends: standardize formats, add CI/CD quality gates, integrate duplicate detection. |
| `qz_prompt_policy.py` | QuantZhai prompt assembly system: layer-based (default → user → model overrides), deep-merge, replacement/prepend/append mode, turn harness injection, deduplication, reporting. Sophisticated runtime but no prompt-level metadata or quality gates. |
| `prompts/codex-core-qwenified.md` | Baseline QuantZhai coding-agent system prompt (100 lines). No metadata header (no version, author, date, changelog, source ref inside file). |
| `prompts/codex-core.md` | Alternate baseline (132 lines). Shares ~90% content with qwenified version. Duplicate-by-fork with undocumented diffs. |
| `config/user/prompts/prompt-compiler_v2.md`, `_v3.md` | Version-numbered filenames. Internal title says "v2.5" — filename version doesn't match internal version. No metadata header. |
| `config/user/prompts/amber_v5.md` | Version-numbered filename. No metadata header. Contains git-diff syntax artifact (`--- /dev/null\n++ b/amber_v5.md`) at top — formatting contamination from file creation method. |
| `tests/test_codex_harness_guidance.py` | Content-regression tests for the main prompt: checks key phrases are present, no auto-escalation language, section length limits. Valuable but limited — only tests one prompt file, no spellcheck, no duplication check. |
| `config/user/model-overrides.json` | Per-model system_prompt_file, prompt_append/prepend, turn_harness selection. This is the configuration layer that makes prompt lifecycle management work across profiles. |

## Research tasks completed

### 1. Extract prompt lifecycle concepts

The Promptware Engineering paper defines these lifecycle stages, mapped to concrete QuantZhai/HSM artifacts:

| Lifecycle stage | What it means for prompts | QuantZhai/HSM status |
| --- | --- | --- |
| **Requirements engineering** | What should the prompt achieve? Constraints, non-goals, capabilities. | Implicit in issue/PR descriptions. No formal prompt requirements doc. |
| **Design** | Prompt structure, role split, scaffold ordering. | Done in `research-plan.md` slices (modular scaffold design). Explicit design phase exists in this subproject. |
| **Implementation** | Writing the prompt file. | Done in `prompts/codex-core-qwenified.md` and user profile prompts. |
| **Testing** | Does the prompt produce the desired behaviour? | Content-regression tests exist (phrase presence/absence). No behavioural tests. No spellcheck. No duplication check. |
| **Debugging** | Why did the prompt fail? Which section caused the issue? | No prompt-specific debugging tools. Debugging is ad hoc by comparing model output. |
| **Evolution** | Versioning, changelog, migration. | Version-numbered filenames exist (v2, v3, v5). No changelog inside files. No migration notes between versions. |
| **Deployment** | How does the prompt reach the runtime? | QuantZhai has a sophisticated assembly system (`qz_prompt_policy.py`) with layered config, overrides, fallback. Deployment is well-solved. |
| **Monitoring** | Is the prompt still working after model/runtime changes? | No active monitoring. `snapshot-known-good/` directory captures known-good config states. |

### 2. Map lifecycle concepts to concrete repo artifacts

| Artifact | Currently exists? | Quality |
| --- | --- | --- |
| Prompt metadata header (version, author, source ref, date, changelog) | No | Missing |
| Prompt requirements doc | Partial (research-plan.md slices) | Good for design phase, not tracked per-prompt-file |
| Prompt tests — content regression | Yes (test_codex_harness_guidance.py) | Valuable but limited scope |
| Prompt tests — spellcheck | No | Missing |
| Prompt tests — duplication detection | No | Missing |
| Prompt version tags or changelog | Partial (versioned filenames) | Filename version can diverge from internal version |
| CI/CD quality gate for prompt changes | No | Missing |
| Prompt debugging guide/tools | No | Missing |
| Prompt assembly/replacement layer | Yes (qz_prompt_policy.py) | Sophisticated, well-engineered |
| Known-good config snapshots | Yes (snapshot-known-good/) | Useful precedent for prompt snapshots |

### 3. Identify anti-patterns

From the Prompt Management in GitHub paper and observed QuantZhai behaviour:

| Anti-pattern | Found in QuantZhai? | Evidence |
| --- | --- | --- |
| No metadata headers | **Yes** | No prompt file has a metadata header. Version is in filename or not at all. |
| Filename version != internal version | **Yes** | `prompt-compiler_v3.md` says "v2.5" in the title. |
| Duplicate prompt content | **Yes** | `codex-core.md` and `codex-core-qwenified.md` share ~90% content. Diff between them is undocumented. |
| Formatting contamination | **Yes** | `amber_v5.md` starts with `--- /dev/null\n++ b/amber_v5.md` — git diff artifact embedded in the prompt. |
| No spellcheck | **Yes** | 55.2% of GitHub prompts have spelling errors (paper finding). QuantZhai has no prompt spellcheck gate. |
| No behavioural tests | **Yes** | Only content-regression tests exist. No test says "this prompt should cause the agent to inspect before editing." |
| Stale prompt references | **Yes** | `qz_prompt_policy.py` at line 71 references `config/default/model-overrides.json` — which exists, but if a profile references a nonexistent prompt file, the policy silently logs it and continues. No breaking build. |

## Adversarial review

### Q1: Are we building process sludge?

**Risk: Yes, if we add metadata headers, changelogs, and quality gates to every prompt file.**

Mitigation: Apply lifecycle discipline selectively:
- **Core baseline prompts** (`codex-core-qwenified.md`, main harness) deserve metadata headers and tests — they affect every interaction.
- **Profile/roleplay prompts** (amber, prompt-compiler) need less ceremony — a version in the filename is enough.
- **Experimental scratch prompts** need nothing — no metadata, no test, no changelog.

**Rule:** The weight of lifecycle tracking should match the blast radius of the prompt. Baseline prompt = full metadata. Profile prompt = versioned filename. Scratch prompt = nothing.

### Q2: Is this worth doing before there are prompt evals?

**Short answer: Partially.**

What is worth doing now:
- **Metadata headers** on baseline prompts — low effort, high value for provenance
- **Spellcheck gate** on baseline prompt changes — trivial to add, paper evidence shows 55% of prompts have errors
- **Changelog discipline** for baseline prompt changes — low effort, documents why a prompt changed

What should wait for evals:
- **Behavioural prompt tests** ("this prompt should cause the agent to inspect before editing") — require a test harness that can run the agent and check behaviour
- **Prompt benchmarking** — requires task sets and evaluation criteria
- **Regression test suites** beyond content-checks — require more infrastructure

From the Promptware Engineering paper: "Without the SE discipline, prompt development is likely to remain mired in trial-and-error." The paper is advocating for a full lifecycle. For this subproject, the useful subset is: **metadata, spellcheck, changelog, and content-regression tests** for the baseline prompt. Defer behavioural tests and benchmarking.

### Q3: Should candidate prompts have metadata headers?

**Yes, for baseline prompts.**

Candidate header structure (adapted from the paper's call for structured metadata):

```text
---
# prompt metadata
version: 0.1.0
author: HSM coding-agent subproject
source: research-plan.md slices 1-4
model-target: Qwen3.6-35B-A3B
harness: Codex CLI / QuantZhai
status: draft | candidate | adopted | superseded
superseded-by:
changelog:
  - 2026-05-29: Initial draft from slice synthesis
---
```

This is lightweight (15 lines), provides provenance, and addresses the "no metadata" anti-pattern identified in the GitHub study.

**Counterargument from adversarial review:** Metadata headers add noise. A 15-line header in an 100-line prompt increases file size 15%. The alternative is to keep metadata in a separate manifest file. However, the paper's finding that only 7.5% of prompt collections provide any authorship attribution suggests in-file metadata is better than no metadata. A 15-line header is acceptable for baseline prompts. Skip it for profile/scratch prompts.

### Q4: Should prompt tests live in QuantZhai rather than HSM?

**Yes — prompt tests belong in QuantZhai.**

- `test_codex_harness_guidance.py` already lives in QuantZhai. This is the right home.
- HSM should define the *test criteria* (what to check). QuantZhai implements the *test code*.
- Similarly: prompt metadata headers should be defined in HSM (this subproject) but implemented in QuantZhai prompt files.

Boundary:
- **HSM:** Defines the metadata schema, test criteria, changelog rules, candidate structures
- **QuantZhai:** Implements the metadata in prompt files, writes the tests, configures CI/CD gates

### Q5: Could making prompts "software artifacts" create too much ceremony for a research subproject?

**Yes, if applied to every prompt fragment.**

Mitigation: Only apply the full lifecycle to:
1. The main baseline prompt (`codex-core-qwenified.md`)
2. Any prompt that reaches production QuantZhai users
3. Candidate prompt structures that advance to Slice 10 consolidation

Everything else (exploratory prompt fragments, analysis notes, paper extracts) stays as-is.

### Q6: What would make this fail in QuantZhai?

- If metadata headers break the prompt assembly parser (they won't — `qz_prompt_policy.py` reads the entire file as text blocks, YAML front matter in markdown is transparent to it)
- If changelog discipline creates friction for rapid iteration (mitigation: only require changelog for adopted/shipped prompts, not draft candidates)
- If tests become flaky content-checks that block legitimate prompt changes (mitigation: test targeted behavioural properties, not exact wording)

## Conclusion

Decision: **adopt with constraints**

Confidence: **medium**

### Evidence for

- Promptware Engineering paper provides strong conceptual framework (full SE lifecycle) published in top SE venue (ACM TOSEM)
- Prompt Management in GitHub paper provides empirical evidence of real problems: 55% duplication, 55% spelling errors, no metadata, no quality gates — QuantZhai exhibits several of these
- QuantZhai already has some lifecycle elements in place: versioned filenames, content-regression tests, known-good snapshots. The gap is metadata, spellcheck, changelog, and CI/CD gates.
- The lightweight approach (metadata headers + spellcheck + changelog for baseline prompts only) minimizes ceremony while addressing the identified anti-patterns

### Evidence against

- No behavioural prompt tests exist yet — lifecycle without evals is partial
- Metadata headers add token cost and file noise — 15 lines in a 100-line prompt is non-trivial
- The paper's "full lifecycle" vision is aspirational; mapping it to a two-person research subproject risks over-engineering
- None of QuantZhai's existing users have asked for prompt metadata — this is a supply-side improvement, not demand-driven

### Uncertainty

- Whether metadata headers actually improve prompt maintainability in practice (the paper recommends them but does not test this)
- Whether spellcheck gates catch real prompt bugs or just create annoying CI failures
- Whether the "baseline-only" scope is enough to test the lifecycle hypothesis, or whether it needs broader application

### Risk

- Over-engineering before behavioural evals exist: metadata + changelog + spellcheck without knowing if the prompt works well
- Changelog fatigue: requiring changelog entries for every prompt tweak
- Metadata header format may need to change as the prompt stack evolves

## Candidate structures

### C17: Prompt metadata header (prompt structure)

For baseline production prompts:

```markdown
---
# prompt metadata
version: MAJOR.MINOR.PATCH
author: <project or person>
source: <design doc, research slice, or issue ref>
model-target: <model name>
harness: <runtime name>
status: draft | candidate | adopted | superseded
superseded-by: <file path or none>
changelog:
  - YYYY-MM-DD: <description of change>
---
```

**Belongs in:** prompt file (YAML front matter for markdown prompt files)
**Applies to:** baseline/main prompts only (not profile, scratch, or experimental prompts)
**How to test:** Check that every prompt file in the baseline set has a header matching the schema. Add a linter for this.

### C18: Prompt changelog rule (process structure)

Changes to baseline/adopted prompts must include a changelog entry:

```text
When modifying a baseline or adopted prompt file, add a changelog entry to the
metadata header describing what changed and why. The entry date must match the
commit date.

Exceptions: whitespace-only fixes, formatting corrections, and comment-only
changes do not require changelog entries.
```

**Belongs in:** process docs (this subproject or QuantZhai contributing guide)
**How to test:** Review PRs that modify baseline prompt files; reject if changelog is missing for substantive changes.

### C19: Prompt spellcheck gate (tooling structure)

```text
Before merging a change to any prompt file in prompts/ or config/user/prompts/,
run a spellcheck on the added/changed lines. Reject if the change introduces
new spelling errors not present in the original.

Use an allowlist for domain-specific terms (model names, tool names, project names).
```

**Belongs in:** CI/CD configuration (GitHub Actions or QuantZhai pre-merge check)
**How to test:** Add a workflow that runs `pyspellchecker` or `codespell` on prompt file diffs.

### C20: Prompt content-regression test expansion (test structure)

Expand `test_codex_harness_guidance.py` to include:

```text
- Check that key behavioural rules are present (inspect-before-edit, validation-honesty, non-goals tracking)
- Check that no prohibited patterns are present (auto-escalation language, silent fallback instructions)
- Check that the prompt stays under a defined maximum token/word count
- Check that all section headers in the prompt match a known allowlist (preventing section drift)
```

**Belongs in:** QuantZhai tests (`tests/test_codex_harness_guidance.py`)
**Currently exists:** Section presence checks, no-auto-escalation check, length check
**Gap:** No inspection-rule presence check, no section-header drift detection, no word-count cap tied to specific token budget

### C21: Prompt source ref rule (prompt structure — refinement of existing practice)

```text
Every prompt file copied or forked from another prompt must include a source
reference in its metadata or opening comment:

Source: <original file path>
Source ref: <git commit or version>
Diff from source: <summary of changes made>
```

**Belongs in:** prompt file header
**Applies to:** derived/forked prompts
**Why:** `codex-core-qwenified.md` is a derivative of `codex-core.md` with undocumented diffs. This rule would make the relationship explicit.
**How to test:** Lint for missing source ref in non-original prompt files.

### C22: Prompt classification by lifecycle tier (process structure)

```text
Classify each prompt file into one of three lifecycle tiers:

Tier 1 — baseline: Full metadata header, changelog, content-regression tests,
  spellcheck gate, CI/CD integration. Applies to the main coding-agent prompt.

Tier 2 — profile: Versioned filename, optional metadata header. No required
  tests or CI/CD gates. Applies to user profile prompts (amber, caveman, etc.).

Tier 3 — scratch/experimental: No lifecycle requirements. Metadata optional.
  Applies to candidate drafts, one-off tests, and deprecated prompts.
```

**Belongs in:** process docs
**Why:** Prevents over-engineering scratch prompts while ensuring baseline prompts have proper lifecycle tracking. Mirrors the paper's "not all prompts need equal rigor" principle.

## Follow-up

1. **Add C17 (metadata header), C20 (test expansion), C22 (lifecycle tiers) to candidate structures** for Slice 10 consolidation.
2. **C18 (changelog rule) and C19 (spellcheck gate) belong in QuantZhai process docs** — move to QuantZhai when implementing.
3. **C21 (source ref rule) is immediately actionable** for `codex-core-qwenified.md` — add a source-ref line documenting its relationship to `codex-core.md`.
4. **Note the HSM/QuantZhai boundary:** This subproject (HSM) defines the what and why. QuantZhai implements the how. Metadata schemas and test criteria come from HSM; test code and CI/CD config live in QuantZhai.
5. **Known risk:** Metadata headers on existing prompts require touching every baseline file once. Batch this into a single commit to avoid disrupting prompt iteration velocity.
