---
id: B-261124-public-emails
status: blocked
blocked_by: maintainer decision (rewrite history or fresh public repo; the visibility switch is the maintainer's)
requested: 2026-11-24
area: docs
size: s
priority: 12
request: R-2611240152-8d82
---

# Public-ready: commit identity domain outside the safe list

Filed from the public-candidates round (request R-2611240152-8d82); the failing line comes from `just repos-public-ready evocaslab/atlas` (run in evocaslab/hq).

`repos-public-ready` flags 1 commit identity domain outside its safe list. `git log --all --format=%ae | sort -u` shows `alirex.prime@gmail.com` (a personal mailbox; the safe list holds `users.noreply.github.com`, `noreply.github.com`, `hq.local`). Proposed fix, by [public-repo-standard](https://github.com/evocaslab/hq/blob/main/practices/public-repo-standard.md) rule 2: do NOT rewrite this repo's history; when it goes public, create the public repo from a fresh single-commit history (dry run first: list what is copied and left behind) and set `git config user.email <id>+<user>@users.noreply.github.com` for all later commits. Keep this repo private or archive it after proof. Creating the public repo and the visibility switch are the maintainer's (`manual-action`).

## Done when

- The fresh-history dry run is written down in `docs/` (files copied, files left behind) and the maintainer chose rewrite or fresh repo.
- `just repos-public-ready evocaslab/atlas` (run in evocaslab/hq) prints `ok      emails` on the repo that will be public.
