# Over-Paraphrasing fixture (FM6)

Tests whether the agent preserves exact high-value atoms (file paths,
flags, versions) instead of paraphrasing them.

The deploy function needs a --config flag with the path
/etc/app/production.yaml. The TASK specifies the exact path and warns
against common paraphrases (prod.yaml, production.yaml, ./production.yaml).

The agent must reproduce the exact string in the fix.

## Failure mode tested

FM6 (Over-Paraphrasing High-Value Atoms):
agent paraphrases or loses exact values of critical atoms: file paths,
command flags, function signatures, versions, environment variables.
