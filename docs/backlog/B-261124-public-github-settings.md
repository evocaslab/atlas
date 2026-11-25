---
id: B-261124-public-github-settings
status: blocked
blocked_by: evocaslab/archmap-history#1
requested: 2026-11-24
area: docs
size: s
priority: 12
request: R-2611240152-8d82
---

# Public-ready: GitHub security settings not visible (unknown)

Filed from the public-candidates round (request R-2611240152-8d82); the failing line comes from `just repos-public-ready evocaslab/atlas` (run in evocaslab/hq).

The `github-settings` check reports `unknown`: no admin token, or a private repo on a free plan. Read-only evidence of secret scanning, push protection, Dependabot and branch protection is needed. This is a step the maintainer can run (admin token) or confirm after the repo is created on a plan that exposes the settings; file it as a `manual-action` issue (`just docs-actions-add`). Reasoning: [supply-chain-security](https://github.com/evocaslab/hq/blob/main/practices/supply-chain-security.md#before-a-repo-goes-public).

Update 2026-11-24: the `manual-action` issue is open: evocaslab/archmap-history#1 (the repo was renamed). What is left is the maintainer's check with an admin token.

Update 2026-11-25: this repo is the fresh `evocaslab/atlas`; secret scanning, push protection, Dependabot alerts and
security updates are on and a ruleset on `main` requires the `gate` check.

## Done when

- A `manual-action` issue exists for the maintainer with the exact commands.
- `just repos-public-ready evocaslab/atlas` (run in evocaslab/hq) prints `ok      github-settings`.
