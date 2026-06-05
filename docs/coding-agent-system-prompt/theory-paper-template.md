# Theory Paper Template — [Prompt Type]

Status: draft / reading / complete  
Date: 2026-05-30  
Confidence: [low / medium / high]  
Parent: `research-plan-extended-prompt-surface.md` Section [N]

---

## 1. Research Question

One sentence stating what this paper determines about this prompt type.

## 2. Purpose

Why this prompt type exists. What job it does in the full prompt surface.
How it relates to the larger system principles (modular structures,
evidence-first, less-is-more, anti-agreement, failure-mode coverage).

## 3. Current Understanding

What we already know from committed research (slices, comparisons,
candidate structures, final synthesis). Which structures, rules, or
findings from the existing work constrain or inform this prompt type.

## 4. Academic Foundation

Papers read (full text) that inform the design of this prompt type.
Each entry:

```
Paper: [title]
arXiv: [ID]
URL: [link]
Relevance: [why this paper matters for this prompt type]
Key findings: [specific claims adopted or challenged]
Limitations: [what the paper does not cover]
```

Include only papers where the full text was read. No abstract-only
entries.

## 5. Design Principles

Derived from sections 3 and 4. The specific principles that should
govern this prompt type. Each principle includes:

```
Principle: [statement]
Evidence for: [sources]
Evidence against: [sources or uncertainty]
Constraint: [how it bounds the design]
```

3-6 principles.

## 6. Candidate Structures

Prompt structures, strings, or rules for this prompt type, derived from
the principles. Each entry:

```
### [Code]: [Name]

Status: adopt / test / defer / reject

Structure:

    [exact wording or template]

Token cost: [estimate, if prompt text]
Failure modes mitigated: [FM1-FM10 references]
Interaction warnings: [conflicts with other structures]
Test: [how to verify]
```

## 7. Failure Mode Coverage

| FM | Pattern | Mitigated by | Confidence |
|---|---|---|---|
| FM1 | Scope creep | [structure codes] | [low/med/high] |

Reference the 10 established failure modes from the final synthesis.
Note any new failure modes discovered during this research.

## 8. Open Questions and Uncertainty

What cannot be answered yet. Where evidence is weak or absent. What
would need to change if a different base model is used. Label each:

```
supported
plausible_but_unproven
contradicted_by_current_material
unknown
```

## 9. Recommended Next Phase

What empirical work, testing, or paper reading should come next before
this prompt type can be implemented.
