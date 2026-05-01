# Integrity Check

Use this checklist before promoting generated output into durable HSM state.

## 1. Classify the output

Mark each significant claim as one of:

- direct evidence restatement
- summary
- inference
- hypothesis
- emotional interpretation
- style rendering
- action proposal
- user-provided update
- contradiction candidate
- durable state candidate

## 2. Source support

For each candidate durable claim:

- What source supports it?
- Is the source direct, third-party, self-report, versioned artifact, or model inference?
- Is the source current or stale?
- Is the date known, approximate, or unknown?
- Is there contradictory evidence?
- Is the confidence label appropriate?

## 3. Boundary checks

Reject or downgrade if the claim:

- treats inference as fact
- fills a gap with plausible prose
- flattens contradiction into a neat story
- confuses immediate reaction with stable trait
- confuses later explanation with proven cause
- loses source provenance
- overstates confidence
- violates repository write boundaries

## 4. Update decision

Choose one:

```text
reject
keep as transient output
store as hypothesis
store as low-confidence observation
store as durable claim
store as preference update
store as state update
store as open uncertainty
```

## 5. Record metadata

Durable updates need:

- source id
- source type
- confidence
- date or period
- sensitivity
- reason for update
- reviewer or agent id if available
- contradiction links if any

## 6. Final rule

Generated text is output until promoted by an integrity decision.
