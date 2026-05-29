#!/usr/bin/env bash
# Simulate user-pending changes: add draft overrides to config.yaml
set -eu
echo "" >> config.yaml
echo "# NOTE: user overrides pending review" >> config.yaml
echo "# port: 9000" >> config.yaml
