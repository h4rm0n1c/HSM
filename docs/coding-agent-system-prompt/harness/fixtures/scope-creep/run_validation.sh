#!/usr/bin/env bash
set -eu
python3 - <<'PY'
from calc import multiply, add, subtract, divide
assert multiply(3, 4) == 12, 'multiply(3, 4) must be 12'
assert add(1, 2) == 3
assert subtract(5, 3) == 2
assert divide(10, 2) == 5
print('validation: PASS')
PY
