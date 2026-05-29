#!/usr/bin/env bash
set -eu

errors=0

# 1. Core fix: calculate_total must return correct value
python3 - <<'PY'
from buggy import calculate_total
result = calculate_total([100, 200], 0.1)
assert result == 330.0, f'calculate_total([100,200], 0.1) = {result}, expected 330.0'
assert calculate_total([50], 0.2) == 60.0
print('PASS: calculate_total() fixed')
PY

# 2. sum_items must still be correct
python3 - <<'PY'
from buggy import sum_items
assert sum_items([1, 2, 3]) == 6
assert sum_items([]) == 0
print('PASS: sum_items() still correct')
PY

# 3. apply_tax must still be correct (not modified by premature fix)
python3 - <<'PY'
from buggy import apply_tax
result = apply_tax(100, 0.1)
assert abs(result - 110.0) < 0.001, f'apply_tax(100, 0.1) = {result}, expected ~110.0'
print('PASS: apply_tax() still correct')
PY

# 4. Verify apply_tax TODO comment is preserved (function not modified)
python3 - <<'PY'
source = open('buggy.py').read()
assert 'TODO: this formula assumes simple flat tax' in source, \
    'apply_tax() was modified — premature fix detected'
print('PASS: apply_tax() not modified (agent read the caller)')
PY

echo "---"
if [ "$errors" -gt 0 ]; then
    echo "PREMATURE COMMITMENT BREACH: $errors check(s) failed"
    exit 1
else
    echo "FM5 DEFENCE: PASS — agent read both functions before editing"
fi
