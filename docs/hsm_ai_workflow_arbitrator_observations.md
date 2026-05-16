# AI Workflow Arbitrator Observations

## Purpose

Record observed workflow patterns that make Harrison's AI-assisted work unusually strong, useful, convergent, and coherent.

These notes are intended as HSM / QuantZhai / LLM-arbitrator research input.

The core observation:

Harrison does not use AI as a single oracle. He naturally runs a multi-role arbitration loop:

    human intent + domain judgement
      -> assistant research / framing / constraints
      -> coding agent execution
      -> real-world test
      -> assistant review / hardening
      -> repo artifact / memory / next loop

This is closer to a practical multi-agent control system than ordinary chat usage.

## Clean example: PuTTY OSC52 fork

The PuTTY OSC52 episode is a compact working specimen.

Initial state:

- Harrison had an old PuTTY fork for suppressing F13-F24 key input.
- The local build process was partly forgotten.
- The repo still existed locally and on GitHub.
- A real annoyance existed: OpenCode claimed it had copied to clipboard, but PuTTY did not support OSC52, so Windows clipboard did not update.

Workflow:

1. Recover repository and build context.
2. Identify that PuTTY already had:
   - OSC parser machinery.
   - base64 helpers.
   - clipboard abstractions.
   - Windows clipboard backend.
3. Research donor implementations:
   - mintty for C/Windows shape.
   - Alacritty for copy/paste policy model.
   - WezTerm for parser semantics.
   - kitty for future robustness/permissions.
4. Produce a constrained coding-agent design document.
5. Feed the design to OpenCode.
6. OpenCode produced two commits:
   - initial OSC52 write support.
   - hardening/docs/manual test script.
7. Rebuild PuTTY.
8. Test with real OpenCode selection.
9. Confirm that mouse-up selection now updates local Windows clipboard.
10. Update README with tested workflow and build command.

Outcome:

A feature that initially sounded like a multi-day terminal-emulator task became a short, successful patch loop because the work was decomposed correctly.

## Pattern 1: Harrison converts vague pain into concrete operational need

Many users ask vague questions and stay vague.

Harrison usually starts with pain, but then pushes toward a concrete operation.

Example:

    "opencode says copied to clipboard but in putty on windows it doesnt really work"

This became:

    Need OSC52 write support in PuTTY fork so remote TUI selection updates Windows clipboard.

The important behaviour is not just complaining. It is forcing the problem into a testable system boundary.

Useful arbitrator lesson:

    Detect user pain, then translate it into a concrete I/O path.

For OSC52:

    remote TUI copy event -> OSC52 escape -> terminal parser -> local clipboard

For future HSM/arbitrator design, this suggests an explicit stage:

    pain/friction -> operational path extraction -> testable target

## Pattern 2: He challenges estimates and forces reclassification

The assistant initially overestimated OSC52 support as possibly taking days.

Harrison challenged that estimate by pointing out:

- Other open-source terminal emulators already implemented OSC52.
- The repo existed.
- A coding agent could perform the mechanical work.
- The task was not greenfield.

That forced the task to be reclassified from:

    hard terminal-emulator feature

into:

    bounded transplant of known behaviour into existing parser/clipboard path

This is a strong workflow pattern.

Useful arbitrator lesson:

    Estimates must be revised when the user identifies donor implementations, existing infrastructure, or mechanical-agent capacity.

The arbitrator should maintain a task classification matrix:

- Greenfield unknown.
- Known pattern, unknown codebase.
- Known codebase, unknown pattern.
- Known pattern, known codebase.
- Known pattern, known codebase, coding agent available.

The last category should receive much more aggressive implementation attempts.

## Pattern 3: Shape-donor research before implementation

Harrison explicitly pushed for a research pass over existing implementations.

This prevented speculative design.

The donor model was:

- Find projects that already solved the problem.
- Identify the behavioural shape, not necessarily copy code.
- Attribute the sources properly.
- Extract constraints and pitfalls.
- Feed those constraints to the coding agent.

This is very strong.

Useful arbitrator lesson:

    Before coding a feature, search for shape donors.

A shape donor is not necessarily a code donor.

It provides:

- Grammar.
- State transitions.
- Policy model.
- Failure handling.
- Security split.
- Test cases.
- Naming conventions.

For OSC52:

- mintty gave C/Windows shape.
- Alacritty gave permission enum shape.
- WezTerm gave parser semantics.
- kitty gave future robustness shape.

This should become a reusable HSM/QuantZhai tactic:

    donor scan -> behaviour extraction -> constrained implementation brief

## Pattern 4: He turns assistant output into agent fuel

The assistant is not only answering Harrison.

The assistant is often producing intermediate artifacts that will be consumed by another AI agent.

This means the assistant's job is not just explanation.

It is also:

- constraint authoring
- task bounding
- failure-mode enumeration
- implementation scoping
- test planning
- reviewer priming

The OSC52 plan worked because it was written as an agent-facing document:

- clear purpose
- donor attribution
- non-goals
- exact supported forms
- security policy
- file map
- coding-agent constraints
- test plan
- acceptance criteria

Useful arbitrator lesson:

    Produce agent-ingestible specs, not just human-readable advice.

A good agent brief has:

- objective
- context
- constraints
- non-goals
- likely files
- exact tests
- acceptance criteria
- red lines

This should be a standard document form in the HSM repo.

## Pattern 5: Human remains final arbiter of usefulness

Harrison does not stop at "patch compiles" or "assistant thinks it is right".

He tests against the actual lived workflow.

For OSC52, the real acceptance test was not only:

    printf ESC ] 52 ; c ; base64 BEL

It was:

    OpenCode selection -> mouse-up -> "copied to clipboard" -> Windows clipboard updates

This matters.

Useful arbitrator lesson:

    Formal tests are necessary but not sufficient. Always include a lived workflow test.

The HSM/arbitrator should distinguish:

- synthetic test
- integration test
- lived workflow validation

The lived workflow has the highest practical value.

## Pattern 6: He uses blunt correction as alignment feedback

Harrison gives direct feedback when the assistant is wrong, overcautious, vague, or not respecting his toolchain.

Examples of useful correction style:

- "you overestimated this"
- "we have donor implementations"
- "the repo is on GitHub"
- "this works now"
- "remember this pattern"

This improves the assistant's future task model.

Useful arbitrator lesson:

    Treat user correction as high-priority calibration data.

Corrections should not be smoothed away into generic apologies.

They should become explicit process deltas:

    old estimate model was wrong because X
    future estimate model must account for Y

For this case:

    If there is a local fork + build + donor implementations + coding agent, estimate implementation as a bounded patch loop, not a multi-day research project.

## Pattern 7: He creates durable artifacts after success

The strongest interactions end in durable artifacts:

- commits
- README updates
- test scripts
- docs
- tags
- build commands
- local binary names
- memory notes

This prevents rediscovery.

The "Past Harrison left one note" moment is important.

One short note allowed recovery of the build method:

    built with mingw on linux

That small artifact saved time later.

Useful arbitrator lesson:

    At the end of a successful loop, write the smallest durable note that prevents future archaeology.

Suggested standard closure checklist:

- What changed?
- How to rebuild?
- How to test?
- What worked in real use?
- What remains deliberately unsupported?
- Where is the binary/artifact?

## Pattern 8: He prefers narrow, practical modernisation over grand rewrites

Harrison often says things that sound ambitious, but the successful execution pattern is usually narrow.

For OSC52:

- Do not rewrite PuTTY.
- Do not implement kitty's full clipboard protocol.
- Do not add read/query.
- Do not make a new clipboard backend.
- Just support write-only OSC52 through the existing path.

This is a core strength.

Useful arbitrator lesson:

    Identify the smallest useful modernisation that unlocks the workflow.

This is especially important with legacy software.

Small successful patches beat architectural righteousness.

## Pattern 9: He uses AI roles implicitly

Harrison naturally assigns roles across tools:

- ChatGPT / assistant:
  - research
  - framing
  - constraints
  - review
  - memory
  - explanation

- OpenCode / Codex-like agent:
  - mechanical repo edits
  - code generation
  - build iteration
  - file modification

- Human:
  - goal selection
  - taste/judgement
  - real environment testing
  - correction
  - final acceptance

This is an implicit multi-agent architecture.

Useful arbitrator lesson:

    Make the role split explicit.

Potential HSM/arbitrator roles:

- Director: decides goal, scope, and stop conditions.
- Researcher: finds donor patterns and references.
- Spec Writer: produces constrained implementation plan.
- Worker: edits code.
- Reviewer: checks safety, correctness, and missed constraints.
- Operator: runs tests in the real environment.
- Archivist: records final state and lessons.

Harrison currently acts as Director + Operator + taste arbiter.

The assistant often acts as Researcher + Spec Writer + Reviewer + Archivist.

OpenCode acts as Worker.

## Pattern 10: He benefits from adversarial-but-cooperative prompting

Harrison does not blindly accept assistant framing.

He pushes back.

This is not noise. It is part of the control system.

The pushback often identifies:

- wrong assumptions
- overbroad scope
- missing donor code
- missing local context
- wrong difficulty estimate
- wrong environment assumption

Useful arbitrator lesson:

    Build in a challenge phase before final task classification.

Possible prompt pattern:

    Before estimating, list assumptions.
    Ask what existing assets could collapse the difficulty.
    Search for donor implementations.
    Reclassify the task after donor scan.

This prevents conservative hallucination and overengineering.

## Pattern 11: He values exactness at interfaces

Harrison's strongest technical workflows focus on interfaces:

- escape sequence format
- clipboard direction
- build command
- branch/remotes
- binary path
- config checkbox
- test command
- exact commit IDs

This makes AI work coherent because ambiguity is squeezed out at the boundaries.

Useful arbitrator lesson:

    When a task involves systems, identify exact interfaces early.

For OSC52:

- Input protocol: `ESC ] 52 ; c ; BASE64 BEL`
- Parser: `do_osc()` / `case 52`
- Data format: base64 UTF-8
- Output API: `TermWin` clipboard path
- User setting: Terminal / Features checkbox
- Real test: OpenCode mouse-up selection

## Pattern 12: He combines evidence, intuition, and live testing

Harrison often has an intuition that something is possible.

He does not leave it as intuition.

He pushes toward evidence:

- repo inspection
- donor implementations
- build outputs
- commit IDs
- actual running binary
- real workflow confirmation

Useful arbitrator lesson:

    Treat intuition as a search heuristic, not proof.

The workflow is:

    intuition -> targeted investigation -> implementation attempt -> live proof

This is a strong human-AI loop.

## Pattern 13: He converts assistant mistakes into reusable rules

The assistant's overestimate became a process rule:

    When Harrison has a local fork, working build, donor implementations, and a coding agent, do not estimate like greenfield upstream engineering.

This is extremely valuable.

Useful arbitrator lesson:

    Every meaningful assistant error should become a reusable correction rule.

Suggested HSM memory format:

    Error:
      Assistant overestimated OSC52 PuTTY work.

    Cause:
      Treated task as greenfield terminal-emulator feature.
      Failed to weight local fork, existing parser, base64 helpers, clipboard abstraction, donor implementations, and coding-agent execution.

    New rule:
      Reclassify similar tasks as bounded patch loops when existing infrastructure and donors are present.

    Evidence:
      OpenCode completed feature in two commits; real OpenCode selection copied to Windows clipboard.

## Pattern 14: Strong interactions use a convergence ladder

The observed ladder:

1. Complaint / friction.
2. Clarify actual desired behaviour.
3. Locate existing assets.
4. Research donor patterns.
5. Produce constrained spec.
6. Let coding agent implement.
7. Review hardening points.
8. Build and test.
9. Validate real workflow.
10. Document and remember.

This ladder repeatedly produces convergence.

The important part is that each step reduces entropy.

Bad AI loops increase entropy by adding possibilities.

Good Harrison loops reduce entropy by pinning:

- repo
- files
- build command
- protocol
- non-goals
- tests
- result

## Prompt-engineering observations

### Effective prompt pattern: donor-first framing

Useful wording:

    Find existing open-source implementations and extract the shape before designing our version.

Why it works:

- Reduces hallucination.
- Grounds design in working systems.
- Produces better constraints.
- Helps coding agents avoid weird inventions.

### Effective prompt pattern: constraints-first implementation brief

Useful wording:

    Write this up with plenty of constraints to keep a coding agent on task.

Why it works:

- Coding agents are good at local edits.
- They are bad at restraint unless scope is explicit.
- Non-goals prevent feature creep.

### Effective prompt pattern: personal fork framing

Useful wording:

    This is my fork. It only needs to solve my workflow first.

Why it works:

- Avoids upstream-grade paralysis.
- Permits practical tradeoffs.
- Still allows later hardening.

### Effective prompt pattern: real-world success criterion

Useful wording:

    It works when OpenCode selection updates my Windows clipboard.

Why it works:

- Prevents fake success.
- Captures the actual user value.
- Links implementation to lived workflow.

### Effective prompt pattern: after-action memory

Useful wording:

    Remember what was wrong about your estimate and what made this work.

Why it works:

- Converts one success into future strategy.
- Improves task classification.
- Feeds HSM/QuantZhai process memory.

## Process-improvement observations

### 1. Add an explicit "asset inventory" step

Before estimating, collect:

- repo exists?
- local build exists?
- build command known?
- tests exist?
- donor implementations exist?
- coding agent available?
- exact success condition known?

This should happen before difficulty estimate.

### 2. Add a "difficulty collapse" check

Ask:

    What would make this much easier than it sounds?

For OSC52, answers were:

- PuTTY already parses OSC.
- PuTTY already writes clipboard.
- PuTTY already has base64 helpers.
- Others already implemented OSC52.
- OpenCode can edit the repo.

### 3. Add a "smallest useful patch" step

Before designing the full feature, identify the minimum useful subset.

For OSC52:

    write-only, target c/empty, reject query, no primary selection, no MIME, no streaming

### 4. Add a "review after agent" step

Coding agent output should be reviewed for:

- platform coupling
- error handling
- security boundary
- data size limits
- encoding correctness
- documentation
- testability

### 5. Add a "workflow proof" step

After formal tests, prove the real workflow.

For OSC52:

    OpenCode mouse selection updates Windows clipboard

### 6. Add a "memory artifact" step

After success, write:

- README note
- build command
- test script
- commit/tag
- lesson learned

## Arbitrator design implications

An LLM arbitrator for Harrison should not simply answer.

It should manage state across roles.

Suggested arbitrator loop:

1. Parse user friction.
2. Extract desired system behaviour.
3. Inventory assets.
4. Search donor patterns.
5. Classify task difficulty after inventory, not before.
6. Produce constrained implementation brief.
7. Delegate mechanical edits to coding agent.
8. Review coding output.
9. Ask user/operator for real test result.
10. Convert outcome into durable memory and repo docs.

The arbitrator should explicitly track:

- assumptions
- assets
- constraints
- non-goals
- risk gates
- test plan
- acceptance criteria
- observed result
- process lesson

## Failure modes to guard against

### Assistant overcaution

Symptom:

    Treats bounded fork patch as upstream-grade engineering.

Fix:

    Run asset inventory and donor scan before estimating.

### Coding-agent scope creep

Symptom:

    Adds read support, MIME support, streaming protocol, or broad refactor.

Fix:

    Non-goals and red lines in implementation brief.

### Documentation gap

Symptom:

    Feature works, but future user forgets build/test method.

Fix:

    README/build/test notes immediately after success.

### Fake success

Symptom:

    Synthetic test passes but actual workflow still broken.

Fix:

    Require lived workflow proof.

### Uncaptured correction

Symptom:

    Assistant learns nothing from being wrong.

Fix:

    Convert correction into explicit future rule.

## Reusable template: bounded patch loop

Use this template for similar tasks.

### Stage 1: State the friction

    What is annoying or broken?

### Stage 2: Desired behaviour

    What exact path should work?

### Stage 3: Asset inventory

    What code, build, tools, docs, agents, and donor projects already exist?

### Stage 4: Difficulty reclassification

    Is this greenfield, or a bounded transplant?

### Stage 5: Donor scan

    Which existing projects solved this?
    What shape should be borrowed?

### Stage 6: Constrained spec

    What should the coding agent do?
    What must it not do?

### Stage 7: Agent implementation

    Let coding agent produce focused commits.

### Stage 8: Review/harden

    Check safety, encoding, errors, tests, docs.

### Stage 9: Real workflow test

    Does the original pain disappear?

### Stage 10: Archive lesson

    Commit, README, tag, memory note, HSM note.

## Concrete memory candidate

Store this as a reusable rule:

    Harrison's strongest AI workflow is a human-directed arbitrator loop: he supplies goal, taste, environment, and live validation; the assistant performs research, decomposition, constraint writing, review, and memory; coding agents perform bounded mechanical implementation. When a repo/build/donor-pattern/coding-agent stack exists, prefer producing a tight implementation brief and letting the worker agent attempt the patch over conservative speculation.

## Short version

The pattern is:

    pain -> exact I/O path -> asset inventory -> donor scan -> constrained agent brief -> coding agent patch -> assistant review -> live test -> durable note

This is why the workflow converges.

It keeps each actor in its strongest role.

It turns AI from an oracle into an arbitrated toolchain.

