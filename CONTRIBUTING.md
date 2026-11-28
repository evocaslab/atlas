# Contributing

atlas is a small hobby project with one maintainer: there is no SLA or support contract, a first answer is meant to
come within a week, and a closed issue is not a verdict on you. Forks are welcome.

The code has not moved here yet ([docs/extraction.md](docs/extraction.md)); until it does, this repo holds the format,
the docs and the brand. A change to the format starts as an issue.

## Set up and check

```bash
just q-check   # the prek hooks on all files: whitespace, YAML, JSON, needs.yaml, zizmor
```

CI runs the same hooks on every pull request; the `gate` job must be green before a merge.

## Pull requests

Keep a change small and focused. Sign off your commits (`git commit -s`, the
[DCO](https://developercertificate.org/)). Say in the pull request if an AI tool wrote part of the change; you must
understand and be able to explain all of it. A vulnerability goes through [SECURITY.md](SECURITY.md), not an issue.
