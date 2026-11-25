# atlas branding

The name is `atlas` for now (R-2611251529-8a7d; may change before the first release); the mark is final: the maintainer
chose the **node map** (R-2611071421-75b4, R-2611071422-e6c5). Replace "atlas" in `wordmark.svg` if the name changes; the mark has no text.

| File | Use |
| --- | --- |
| `mark.svg` | README, docs; takes the text colour (`currentColor`) plus the accent square |
| `mark-light.svg`, `mark-dark.svg` | where `currentColor` does not work (image tags, social cards) |
| `favicon.svg` | browser tab; follows `prefers-color-scheme` |
| `app-icon.svg` | rounded accent tile, white mark: web app header, installed app, widget |
| `wordmark.svg` | mark plus the name in Space Mono Bold; needs the font or falls back to monospace |

## Colour

| Token | Light | Dark | Use |
| --- | --- | --- | --- |
| ink | `#14201c` | `#e6efec` | mark, text |
| accent | `#0f7b6c` | `#3ec9b0` | the one filled square, links, active state |
| ground | `#f3f5f4` | `#0e1513` | page background |
| line | `#cfd8d4` | `#27352f` | borders |

## Type

Display and wordmark: Space Mono (Bold). Body: Source Sans 3. Both from Google Fonts, with `ui-monospace` and `system-ui` fallbacks.

## Rules

- The mark is four nodes at the corners of a square frame: top-left filled (ink), bottom-right filled (accent), the other two outlined. Never recolour the accent node, never add text inside the mark, never rotate it.
- Clear space: half a node (12 units of 100) on every side. Minimum size: 16 px (use `favicon.svg` below 24 px).
- The wordmark is lower case. Do not stretch, outline or add effects.
- On an accent ground use the white `app-icon.svg`; on photos use `mark-light.svg` or `mark-dark.svg` on a plain panel.

## Animated variant

`mark-animated.svg` (R-2611071424-c622): the four nodes pop in, the frame draws around them, then the accent node pulses
every 3 s. Pure CSS inside the SVG (no script), follows `prefers-color-scheme`, and shows the finished static mark under
`prefers-reduced-motion`. Use it for loading and splash screens, the web app's first paint and the README header; use the
static `mark.svg` everywhere else, and never animate the favicon. The motion is tied to the mark: do not reuse it on other shapes.
