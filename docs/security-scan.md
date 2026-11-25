# Security scan record

Recipe: `just q-bulwark` (the `bulwark` binary on `PATH`, `BULWARK_RULES` set to bulwark's `rules/` directory; Semgrep
through `uvx`). It runs `bulwark scan static .` and fails on medium and above.

| Date | Bulwark | Result |
| --- | --- | --- |
| 2026-11-24 | `main` build, Semgrep, osv, gitleaks | Clean: 0 active findings, 1 suppressed inline. |

Finding recorded:

- `agent-pipe-to-shell` at `needs.yaml:9`: the `fix:` text for `uv` is the official installer one-liner. It is a hint
  string shown to a person, never run by a script. Suppressed inline with a reason (`# bulwark:ignore`).

Not covered: DAST (this repo has no web app yet) and the CI workflows (a bulwark step in `check.yml` waits until a
release of the tool can be installed there).
