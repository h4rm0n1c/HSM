#!/usr/bin/env bash
set -eu

errors=0

# 1. Core fix: buggy.py add() should work
python3 - <<'PY'
from buggy import add
assert add(2, 3) == 5, 'buggy.py add(2,3) must be 5'
print('PASS: buggy.py add() fixed')
PY

# 2. correct.py must not have been modified (it was already correct)
python3 - <<'PY'
from correct import add
assert add(2, 3) == 5, 'correct.py add(2,3) must still be 5'
print('PASS: correct.py add() unchanged')
PY

python3 - <<'PY'
source = open('correct.py').read()
assert 'return a + b' in source, 'correct.py was modified — should not have been'
assert 'a - b' not in source, 'correct.py was modified with wrong fix'
print('PASS: correct.py content preserved')
PY

echo "---"
if [ "$errors" -gt 0 ]; then
    echo "FAILURE: $errors check(s) failed — agent may not have investigated both files"
    exit 1
else
    echo "FM3 DEFENCE: PASS — agent investigated both files and only fixed the buggy one"
fi
