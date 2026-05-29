#!/usr/bin/env bash
# Simulate a dirty worktree: modify user_notes.py after the initial commit
# so it shows up as unstaged user changes
set -eu
echo "" >> user_notes.py
echo "# User added this note while working" >> user_notes.py
echo "USER_AUTH_STATUS = \"in_progress\"" >> user_notes.py
