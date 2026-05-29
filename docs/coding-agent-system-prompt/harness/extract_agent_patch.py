#!/usr/bin/env python3
"""Try to extract a patch from an agent output file.

Search heuristics (ordered):
- look for a fenced code block that contains 'diff' or '*** Begin Patch' or 'git apply' text
- look for '*** Begin Patch' .. '*** End Patch' block
- look for 'diff --git' and extract the contiguous diff

Writes agent_patch.patch into the same directory if a candidate is found and exits 0.
Exits 1 if nothing found.
"""
import re
import sys
from pathlib import Path


def extract_fenced_blocks(text):
    # find ```...``` blocks
    pattern = re.compile(r"```(?:[\w+-]*)\n(.*?)```", re.DOTALL)
    return pattern.findall(text)


def find_begin_end_patch(text):
    m = re.search(r"\*\*\* Begin Patch\b", text)
    if not m:
        return None
    start = m.start()
    end = text.find('*** End Patch', start)
    if end == -1:
        # take rest
        return text[start:]
    return text[start:end+len('*** End Patch')]


def find_diff(text):
    m = re.search(r"(^diff --git[\s\S]*?$)|(^@@ )", text, re.M)
    if not m:
        # find first 'diff --git' anywhere
        idx = text.find('diff --git')
        if idx == -1:
            return None
        return text[idx:]
    return text[m.start():]


def main():
    if len(sys.argv) < 2:
        print('usage: extract_agent_patch.py <agent_output.txt>', file=sys.stderr)
        sys.exit(2)

    path = Path(sys.argv[1])
    if not path.exists():
        print('file not found', path, file=sys.stderr)
        sys.exit(2)

    text = path.read_text()

    # 1. fenced blocks
    for block in extract_fenced_blocks(text):
        if '*** Begin Patch' in block or 'diff --git' in block or block.strip().startswith('*** Begin Patch') or block.strip().startswith('diff --git'):
            out = path.with_name('agent_patch.patch')
            out.write_text(block)
            print('wrote', out)
            sys.exit(0)

    # 2. begin/end patch
    b = find_begin_end_patch(text)
    if b:
        out = path.with_name('agent_patch.patch')
        out.write_text(b)
        print('wrote', out)
        sys.exit(0)

    # 3. git diff
    d = find_diff(text)
    if d:
        out = path.with_name('agent_patch.patch')
        out.write_text(d)
        print('wrote', out)
        sys.exit(0)

    print('no patch found', file=sys.stderr)
    sys.exit(1)


if __name__ == '__main__':
    main()
