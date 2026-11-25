---
id: B-261110-large-modules-in-moved-crates
status: blocked
blocked_by: the crates are extracted into this repo (docs/extraction.md); until then they change in evocaslab/hq
requested: 2026-11-10
area: review
size: m
priority: -5
request: R-2611100211-6888
---

# Large modules in the crates that move here

Smell scan of 2026-11-10 (refactoring practice, smell-to-rule table) over `crates/atlas`, `crates/hq-diagram` and
`crates/hq-diagram-wasm` in evocaslab/hq at b427374f, read-only. The countable smells (long function, many arguments,
cognitive complexity, boolean flags) are lints the workspace already warns on and the gate denies (clippy pedantic and
nursery); no suppression of `too_many_lines`, `too_many_arguments` or `cognitive_complexity` exists. The one finding no
rule counts is file size: `hq-diagram/src/flow.rs` 2459 lines, `patch.rs` 1836, `layout.rs` 1667, `svg.rs` 1432,
`html.rs` 1140, `atlas/src/export.rs` 836.

Deliberately not refactored now: the code still lives in HQ (AGENTS.md: change the crates there) and a size is a reason
to look, not a defect.

## Done when

- After extraction, each file above is read once with the "Structure" lens (divergent change via `git log --stat`); a file
  that changes for two unrelated reasons is split by technique (Move, Extract), one step per commit.
- Before any split, the goldens (the SVG ones and `hq-diagram/tests/golden.rs`: HTML, PlantUML, diff, landed in HQ 2f522d76) pass unchanged and stay byte-identical.
