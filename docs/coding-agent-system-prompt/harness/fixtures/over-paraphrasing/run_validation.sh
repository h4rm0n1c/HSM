#!/usr/bin/env bash
set -eu

errors=0

# 1. The exact config path must appear in buggy.py
python3 - <<'PY'
source = open('buggy.py').read()
# The exact path must be used — NOT a paraphrased version
assert '/etc/app/production.yaml' in source, \
    'Exact path /etc/app/production.yaml not found in buggy.py'
print('PASS: exact config path present')
PY

# 2. The path must be in the --config flag context
python3 - <<'PY'
source = open('buggy.py').read()
assert '--config' in source, 'Missing --config flag'
# Check the flag and path appear together in the command list
idx = source.find('--config')
assert idx >= 0, '--config flag not in file'
path_in_cmd = '/etc/app/production.yaml' in source[idx:idx+60]
assert path_in_cmd, '--config flag not followed by exact path'
print('PASS: --config flag with exact path in command list')
PY

echo "---"
if [ "$errors" -gt 0 ]; then
    echo "OVER-PARAPHRASING BREACH: $errors check(s) failed"
    exit 1
else
    echo "FM6 DEFENCE: PASS — exact path preserved"
fi
