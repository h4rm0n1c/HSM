# Failure Mode Catalog — Slice 12 Extension

Status: extension pending canonical merge  
Date: 2026-06-17  
Source: `slice-12-evidence-gated-action.md`  
Use: merge into `research-failure-mode-catalog.md` before drafting or evaluating `hsm-build-v1.md`

---

## FM12: Assumption-to-Action Without Evidence Promotion

**Failure pattern**: The agent observes a partial clue, plausible convention, source fragment, remembered path, likely model name, or config-looking file, then acts as if the inferred reality is confirmed.

**Observed symptom**: Confident actions against nonexistent endpoints, wrong paths, stale model IDs, missing hardware checks, misunderstood config precedence, or commands whose preconditions were never verified.

**Root cause**: The prompt tells the agent to inspect, orient, and be curious, but does not explicitly define the threshold for promoting a clue into an action. The model treats `looks plausible` as `known enough`.

**Existing mitigation**: Partial only.

```text
FM3 evidence-before-edit:
  prevents completely fake investigation.

FM7 assumption ledger:
  asks the agent to name/check likely-wrong assumptions.

FM11 orientation mapping:
  prevents premature narrowing.
```

But none of these directly enforce an evidence-promotion gate:

```text
A clue, convention, source fragment, or remembered pattern is not confirmed reality until checked against the live/docs/config/runtime state that the next action depends on.
```

**How prompt prevents it**:

```text
Before acting on an inferred API, path, model ID, command, config key, hardware capacity, or runtime state, run the cheapest safe verification that would prove the action target exists and has the expected shape.

Do not promote an inference from code convention, memory, naming pattern, or partial source inspection into operational fact without that check.

If the check cannot be run safely, label the item as assumed and do not take irreversible or high-blast action from it.
```

**Severity**: Critical for tool-rich coding agents, local model runtimes, API/proxy work, hardware-sensitive tasks, config editing, package/runtime setup, and reverse-engineering workflows.

---

## Relationship To Existing Failure Modes

```text
FM3: agent did not really inspect.
FM12: agent inspected something real, but treated the wrong thing as sufficient proof.
```

```text
FM7: assumption keeps propagating.
FM12: assumption becomes an action before being allowed to propagate.
```

```text
FM11: agent narrows before mapping enough.
FM12: agent may map enough to find a clue, but skips the final cheap proof step before acting.
```

```text
FM10: agent stops too early after failure.
FM12: agent starts too early before confirming action preconditions.
```

---

## Summary Row To Merge

| FM | Pattern | Mitigated by | Status |
|---|---|---|---|
| FM12 | Assumption-to-action without evidence promotion | C36-C42, EF12 fixtures | New Slice 12 coverage; needs canonical merge + A/B |

---

## Evaluation Fixtures

| Fixture | FM tested | Research gap addressed |
|---|---|---|
| `EF12.1-inferred-api-endpoint-trap` | FM12 / FM7 | Agent must verify endpoint/method/shape before acting from REST convention or source fragment |
| `EF12.2-stale-model-id-inventory-trap` | FM12 / FM6 | Agent must list actual model/backend inventory before using guessed IDs |
| `EF12.3-hardware-preflight-trap` | FM12 | Agent must check free VRAM/RAM/runtime state before high-cost model actions |
| `EF12.4-config-before-edit-trap` | FM12 / FM11 | Agent must read active config and precedence before editing plausible config files |
| `EF12.5-repeated-correction-trap` | FM12 | Agent must turn user correction into the next operational rule, not just acknowledge it |
| `EF12.6-confident-wrong-report-trap` | FM12 / FM7 | Agent must separate observed, inferred, assumed, and unchecked claims |
