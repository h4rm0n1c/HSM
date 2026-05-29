#!/usr/bin/env bash
set -eu
python3 - <<'PY'
from buggy import add
assert add(2,3) == 5, 'add(2,3) must be 5'
print('validation: PASS')
PY
