# atlas: instructions for AI agents

Seed repo for the architecture-model tool (name `atlas` for now, R-2611251529-8a7d). Read [README.md](README.md) and [docs/extraction.md](docs/extraction.md).

- General practices live in HQ (`~/dev/hq/practices/`, index `README.md`); this repo's rules win where they differ.
- Until the code moves here, change the crates in HQ, not in this repo.
- Backlog: `docs/backlog/B-YYMMDD-slug.md`, one file per item, as in HQ's `docs/backlog/README.md`.
- Needs: `needs.yaml` states what the repo needs per context; add a new need in the commit that introduces it, then run `scripts/needs.py lint` and `render` (the README table is generated; never copy a pinned version into it; [HQ needs-by-context](https://github.com/evocaslab/hq/blob/main/practices/needs-by-context.md)).
- Push every commit right away; keep `main` equal to `origin/main`.
- The README is the front door: it starts with how to run the repo and is updated in the same commit as any change to a command, recipe, config key, check or layout; run its Quick start once before landing ([HQ docs-match-code](https://github.com/evocaslab/hq/blob/main/practices/docs-match-code.md#the-readme-is-the-front-door)).
- Change repo files with the Edit and Write tools, never `cat >`, `sed -i` or a heredoc through Bash: the command guard denies them and every denial costs a turn. For a change in many files, Write a script and run it. Reasons: [practices/agent-instructions.md](https://github.com/evocaslab/hq/blob/main/practices/agent-instructions.md).
- Conformance: edit-rule-present
- Refactoring ([HQ page](https://github.com/evocaslab/hq/blob/main/practices/refactoring-and-smells.md)): a refactor is its own commit ("refactor: <technique>"), tests and golden files stay byte-identical, and code without a test gets a characterization test first. A real smell the lints do not count is a backlog item here, not a drive-by edit.
- TDD ([HQ page](https://github.com/evocaslab/hq/blob/main/practices/tdd.md)): an item's Done-when lines are the test list; a behaviour change names one test per line in the hand-back. Output of the model, exporters and renderer is pinned by golden files; a changed golden needs a behaviour commit with its own reason.
- Boundaries ([HQ page](https://github.com/evocaslab/hq/blob/main/practices/service-boundaries.md)): [docs/boundaries.md](docs/boundaries.md) says what a word means in the model vs the renderer; a word with two meanings gets a row there in the commit that adds it. The two stay one workspace until a reason from the HQ page holds.
