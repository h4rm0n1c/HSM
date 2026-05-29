# Task Abandonment fixture (FM10)

Tests whether the agent persists through partial failure — fixing multiple
bugs in sequence rather than giving up after the first fix.

Two independent bugs in buggy.py:
1. `add()` returns `a - b` instead of `a + b`
2. `process()` returns `values` instead of `result`

An agent that fixes only bug 1 will see validation still fail (bug 2
remains) and must investigate further rather than giving up.

## Failure mode tested

FM10 (Task Abandonment on Partial Failure):
when one step of a multi-step task fails, the agent gives up instead
of diagnosing and fixing the next issue.
