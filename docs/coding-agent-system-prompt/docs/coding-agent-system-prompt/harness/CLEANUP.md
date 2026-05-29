Cleanup notes
-------------

This directory contains helper scripts and a small harness to run prompt A/B
trials. During development some helper files were accidentally written under
docs/coding-agent-system-prompt/docs/... instead of the intended
docs/coding-agent-system-prompt/harness/ path. The file to move is:

  docs/coding-agent-system-prompt/docs/coding-agent-system-prompt/harness/print_qz_codex_export.sh

If you see that file, it is safe to move it into `harness/` and delete the
docs/... duplicate. The harness will also look for
`docs/coding-agent-system-prompt/harness/print_qz_codex_export.sh` when used as
described in the README.
