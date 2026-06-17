# Failure Mode Catalog — Slice 12 Extension

Status: research-layer extension pending canonical merge  
Date: 2026-06-17  
Sources: `slice-12-evidence-gated-action.md`; `project-smell-audit-2026-06-17.md`; `i1a-arxiv-backing-orientation-evidence-gating.md`  
Use: merge into `research-failure-mode-catalog.md` during I3, after I2 candidate-structure merge

---

## Integration Boundary

This file is not the canonical failure catalog yet.

It exists to make the research layer coherent before downstream merge. It must not be treated as final prompt wording.

Concrete examples in this file are **fixtures and probes**, not the boundary of the rule.

---

## FM12: Assumption-to-Action Without Evidence Promotion

**Failure pattern**: The agent observes a clue, forms a claim about current reality, and takes an action whose correctness depends on that claim before the claim has been promoted by evidence.

**Observed symptom**: Confident action against a world state that was never actually checked. The visible form may be a nonexistent endpoint, wrong file path, stale model/backend ID, inactive config layer, missing capacity preflight, misunderstood command precondition, or any other action target whose current existence/shape/state was inferred rather than verified.

These examples are non-exhaustive. The invariant is:

```text
action depends on a claim about current reality
  -> the claim is action-critical
  -> a clue suggested it
  -> the agent acted before proof/falsification
```

**Root cause**: The prompt tells the agent to inspect, orient, and be curious, but does not define the threshold for promoting a clue into an action-critical fact. The model treats `looks plausible` as `known enough`.

**Existing mitigation**: Partial only.

```text
FM3 evidence-before-edit:
  prevents completely fake investigation.

FM7 assumption ledger:
  asks the agent to name/check likely-wrong assumptions.

FM11 orientation mapping:
  prevents premature narrowing.
```

These reduce related failures, but none directly enforces the final evidence-promotion gate:

```text
A clue is not proof.
A clue can guide investigation.
A clue cannot justify action until the action-critical claim is checked.
```

**How prompt prevents it**:

```text
Before action, identify the action-critical claim about current reality: the claim that must be true for the next action to be correct.

Promote that claim with the cheapest safe check that can prove or falsify it. The check must target the claim the action depends on, not provide random reassurance.

If the claim cannot be checked safely, keep it labelled as assumed and reduce, defer, or stop action by blast radius.
```

**Severity**: Critical for tool-rich coding agents, local model runtimes, API/proxy work, hardware-sensitive tasks, config editing, package/runtime setup, reverse-engineering workflows, and any task where a wrong action target can waste time, corrupt state, or mislead the user.

---

## Research Backing

I1A adds full-paper backing for this failure class.

- ReAct supports interleaving reasoning with environment observations, rather than acting from static internal reasoning alone.
- Chain-of-Verification supports generating verification checks from the claim being checked.
- Self-RAG supports relevance/support/completeness critique rather than treating retrieval or inspection as proof by itself.
- Reflexion supports converting feedback into changed later behaviour, but HSM requires observable next-action change rather than ritual reflection.
- SWE-agent supports treating observation/action affordances as part of the agent operating system, not static prompt text alone.
- CheckList supports treating concrete cases as behavioural probes for invariants, not exhaustive rule categories.

Boundary: these papers support the structure and evaluation strategy. They do not prove exact `hsm-build-v1.md` wording, and they do not remove the need for EF11/EF12 A/B tests.

---

## Relationship To Existing Failure Modes

```text
FM3: agent did not really inspect.
FM12: agent inspected something real, but treated a clue as sufficient proof for action.
```

```text
FM7: unchecked assumption propagates through reasoning.
FM12: unchecked assumption crosses the action boundary.
```

```text
FM11: agent narrows before mapping enough of the territory.
FM12: agent may map enough to find a clue, then skip the final proof step before action.
```

```text
FM10: agent stops too early after failure.
FM12: agent starts too early before confirming action preconditions.
```

---

## Summary Row To Merge During I3

| FM | Pattern | Mitigated by | Status |
|---|---|---|---|
| FM12 | Assumption-to-action without evidence promotion | C36-C42, EF12 fixtures | Research-layer extension; needs canonical merge + A/B |

---

## Evaluation Fixtures

The fixture nouns are probes for the invariant, not prompt wording.

| Fixture | FM tested | Research gap addressed |
|---|---|---|
| `EF12.1-inferred-api-endpoint-trap` | FM12 / FM7 | Agent must verify endpoint/method/shape before acting from convention or source fragment |
| `EF12.2-stale-model-id-inventory-trap` | FM12 / FM6 | Agent must list actual inventory before using guessed model/backend IDs |
| `EF12.3-hardware-preflight-trap` | FM12 | Agent must check current capacity/state before high-cost model actions |
| `EF12.4-config-before-edit-trap` | FM12 / FM11 | Agent must prove active config source/precedence before editing plausible config files |
| `EF12.5-repeated-correction-trap` | FM12 | Agent must turn user correction into the next operating rule, not merely acknowledge it |
| `EF12.6-confident-wrong-report-trap` | FM12 / FM7 | Agent must separate observed, inferred, assumed, and unchecked claims |

Additional future fixtures should vary the concrete noun while preserving the invariant:

```text
next action depends on current reality
  -> agent has only a clue
  -> cheap safe proof/falsifier exists
  -> pass requires checking the claim, not matching an example category
```

---

## I3 Merge Notes

When merging into the canonical failure catalog:

1. Do not paste the old noun-list prevention rule.
2. Add FM12 as first-class alongside FM1-FM11.
3. Update the relationships section so FM3/FM7/FM11/FM12 are distinct.
4. Update FM6 if needed so exact-atom preservation is framed as preserving exact spans whose corruption changes task semantics, not merely a finite list of atom types.
5. Keep the paper backing in source/confidence notes without overclaiming exact prompt wording.
