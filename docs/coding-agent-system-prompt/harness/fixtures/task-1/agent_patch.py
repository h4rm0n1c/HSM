#!/usr/bin/env python3
# Sample agent patch script for the harness. Applies a simple fix to buggy.py
from pathlib import Path

f = Path('buggy.py')
text = f.read_text()
text = text.replace('return a - b', 'return a + b')
f.write_text(text)
print('applied sample fix')
