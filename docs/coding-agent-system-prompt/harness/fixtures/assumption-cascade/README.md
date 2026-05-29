# Assumption Cascade fixture (FM7)

Tests whether the agent verifies assumptions before editing, rather than
fixing the first suspicious-looking code it encounters.

The `normalize()` function in buggy.py looks broken (scary FIXME/TODO
comments, poorly named variables) but is actually correct. The real bug
is in `average()` — it returns `total` instead of `total / count`.

An agent that assumptions cascade will "fix" `normalize()` and leave
the real bug in `average()` untouched.

## Failure mode tested

FM7 (Silent Assumption Cascade):
agent makes an incorrect assumption early in investigation ("normalize looks
broken"), then builds reasoning on that assumption without verifying it.
