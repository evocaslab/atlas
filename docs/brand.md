# Brand book: atlas

Name: `atlas`, for now (R-2611251529-8a7d); the maintainer may still rename it before the first release. Tagline:
"Architecture, checked against the code." Public package names carry the umbrella prefix (`evocaslab-atlas`,
`@evocaslab/atlas`); the binary (command) is `evocaslab-atlas`
(R-2611251919-6aa1; it avoids Ariga's `atlas` CLI), while the display name stays `atlas`. The name is one value, in
[branding/brand.yaml](../branding/brand.yaml) and `brand.config.json`; colours, fonts and assets are there too. Asset
files and usage rules: [branding/README.md](../branding/README.md). Legal use of the name and logo:
[TRADEMARKS.md](../TRADEMARKS.md).

## Mission

Keep a text model of a codebase's architecture next to the code, check it against the code, and export diagrams.

## Vision

Every repo has an architecture map that an agent reads before it changes the code and that fails a check when it drifts.

## Audience

Developers and maintainers who work with AI agents on a codebase and want the architecture written once, in files, and
kept true. Second: agents, which read the model through the CLI.

## Values

1. **Checked, not drawn.** A map that can drift is a picture; this one fails a check.
2. **Text first.** YAML in the repo, reviewed like code; diagrams are exports.
3. **Small.** One format, one CLI, no service.
4. **Honest.** It says what it does not cover.

## Voice

Plain and exact: say what the model says and where. A finding names the element and the file.

| Do | Do not |
| --- | --- |
| Write "element `api` has no path in the repo" | Write "architecture issue detected" |
| Keep the wordmark lower case | Capitalise, stretch, outline or add effects |

## Logo rules

- The mark is the node map: four nodes at the corners of a square frame, top-left filled (ink), bottom-right filled
  (accent), the other two outlined. Never recolour the accent node, add text inside the mark, or rotate it.
- Clear space: half a node (12 units of 100) on every side. Minimum size 16 px; below 24 px use `favicon.svg`.
- On an accent ground use the white `app-icon.svg`; on photos put `mark-light.svg` or `mark-dark.svg` on a plain panel.
- Animate only in loading, splash and the README header (`mark-animated.svg`); never the favicon.

## Colour and type

One accent, teal (`#0F7B6C` light, `#3EC9B0` dark), with ink and a quiet ground; flat fills, no gradients. Contrast pairs
are listed in `brand.yaml`. Type: Space Mono Bold for the wordmark and headings, Source Sans 3 for text.
