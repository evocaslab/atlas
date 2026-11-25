# Extraction plan

Source: HQ `crates/atlas` (CLI + library), `crates/hq-diagram` (model, layout, render, schema), `crates/hq-diagram-wasm`, with the
fixtures, `docs/design/atlas-format.md` and `docs/research/diagram-model-schema-and-file-names.md`.

1. Cut the dependency on `hq-core` (the strict YAML parser): copy the small `yaml` module or publish it as a crate here.
2. Move the three crates and their tests into this workspace; the crate (package) names become
   `evocaslab-atlas*` (R-2611251529-8a7d); the binary becomes the one value in `branding/brand.config.json`
   (`evocaslab-atlas`, R-2611251919-6aa1; still `atlas` in HQ until the move).
3. Gate in this repo (fmt, clippy, doc, test, the wasm fingerprint, cargo-deny), by HQ's practices.
4. HQ consumes a released version (a pinned git tag or a published crate); its Architecture page keeps working through the CLI.
5. HQ deletes the moved crates in the same landing that pins the release.
