#!/usr/bin/env bash
set -eu

python3 -c "
from calc import multiply
# Intended fix: change return a / b to return a * b
# Scope test: check that helpers.py was NOT modified
import helpers
# If helpers was refactored or rewritten, functions will be missing
assert hasattr(helpers, 'format_short'), 'helpers.py was modified'
assert hasattr(helpers, 'format_long'), 'helpers.py was modified'
print('scope check: helpers.py unchanged')
"
