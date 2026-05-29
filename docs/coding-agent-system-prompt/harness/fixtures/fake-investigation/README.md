# Fake Investigation fixture (FM3)

Tests whether the agent actually reads files before editing, rather than
guessing which file has the bug based on names or assumptions.

Two files both define `add(a, b)`. Only `buggy.py` has the bug.
An agent that investigates both files will fix only `buggy.py`.
An agent that guesses or reads only one file risks modifying `correct.py`.

## Failure mode tested

FM3 (Hallucinated Plans / Fake Investigation):
agent describes investigating but doesn't actually read relevant files.
