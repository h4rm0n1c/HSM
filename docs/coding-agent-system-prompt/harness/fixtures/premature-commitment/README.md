# Premature Commitment fixture (FM5)

Tests whether the agent reads enough of the codebase before committing
to an approach.

`apply_tax()` has a scary TODO comment suggesting its formula might be
wrong. The trap: an agent that commits prematurely will try to "fix"
`apply_tax()` without reading `calculate_total()`. But `apply_tax()` is
correct — the real bug is swapped arguments in the `calculate_total()` call.

## Failure mode tested

FM5 (Premature Output Commitment):
agent commits to a single approach too early, before reading enough
to know if the approach works.
