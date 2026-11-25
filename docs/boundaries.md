# Words: model vs renderer

Two contexts share this tool, and a few words mean different things in each. Name code and docs by the context's meaning
([HQ service boundaries](https://github.com/evocaslab/hq/blob/main/practices/service-boundaries.md)). Nothing is split: both
live in one workspace and meet at one published language, the `hq-diagram` model YAML (`atlas export hq-diagram`).

| Word | In the model (`atlas`, format `atlas/0`) | In the renderer (`hq-diagram`) |
| --- | --- | --- |
| element | a box of the architecture: `system`, `container`, `component`, `person`, `external-system`, `store` | not used; the drawn thing is a **node** |
| node | not used | a box in a diagram: `source`, `document`, `datum`, `program`, `operation` |
| relation | an arrow between two elements, id `<from>--<verb>--<to>` | not used; the drawn thing is an **edge** (`from>to`) |
| view | a query over the model (`include`/`exclude` predicates); no positions | a named subset of one diagram model that is drawn (`views:` on nodes) |
| layout | coordinates of one view (`layout/<view-id>.yaml`) | the computed placement (columns, bands, layers); never stored |
| kind | the element type above | the node type above, plus `kinds:` shape settings |
| group / parent | `parent`: containment of elements | `groups:`: a dashed frame around boxes of one column |
| source | a source tag `{kind, ref}` tying an element to real code (`crate`, `file`, `table`) | a data source node with a colour (`kind: source`) |

Rules that follow:

- The model owns meaning (ids, kinds, parents, relations, source tags); the renderer owns pictures (placement, shapes,
  colours). A rendering word never enters `atlas/0`, and a model word is translated once, in the exporter.
- The shared shape (the `hq-diagram` model YAML) has one owner, the renderer's schema; the model side calls it, it does not
  copy it.
- A new word that means two things gets a row here in the commit that introduces it.

Reviewed against the code on 2026-11-10 (`crates/atlas`, `crates/hq-diagram` in evocaslab/hq at b427374f).
