# Atlas format `atlas/0` and the `atlas` CLI

Status: implemented in `crates/atlas` (in [evocaslab/hq](https://github.com/evocaslab/hq) until the move). Design and
reasoning: [architecture-workbench.md](https://github.com/evocaslab/hq/blob/main/docs/design/architecture-workbench.md); prior art and the first format draft:
[architecture-workbench-prior-art.md](https://github.com/evocaslab/hq/blob/main/docs/research/architecture-workbench-prior-art.md). The format is `0`: it may
still change.

## Layout of a workspace

```text
atlas.yaml                       manifest: format, workspace, sources, imports, exports
elements/<id>.yaml               one element (a box)
relations/<from>--<verb>--<to>.yaml   one relation (an arrow)
views/<id>.yaml                  one view (a query over the model)
layout/<view-id>.yaml            positions of one view (coordinates only)
```

Ids use only `a-z 0-9 . -`; the file name is the id. Every struct denies unknown keys, so a typo is an error naming the
file. Samples: `docs/research/architecture-workbench-samples/` (`hq`, `report-bot`, `optiomni`); copies are the test
fixtures in `crates/atlas/tests/samples/`.

- Element: `id`, `kind` (`system`, `container`, `component`, `person`, `external-system`, `store`), `name`, optional
  `parent`, `tech`, `tags`, `sources`, `links`, `description`.
- Source tag: `{kind, ref}` with kind `repo`, `crate`, `folder`, `file`, `systemd-unit`, `compose-service`, `table`,
  `symbol`.
- Relation: `id`, `from`, `to`, optional `label`, `tech`, `async`. An end may be `alias:id` of an import.
- View: `id`, `title`, `include`, `exclude`, optional `direction` (`LR RL TB BT`), optional `covers`.
- `covers` (added in `atlas/0` by the implementation): `[{kind, match}]`, a name pattern with `*`. Every code thing of
  that kind matching the pattern needs an element with a source tag for it (the reverse drift check).

View predicates (one string per list entry; the view is the union of `include` minus the union of `exclude`):
`parent = <id>`, `kind = <kind>`, `tag = <tag>`, `neighbours(<predicate>)` (linked to a match, without the matches),
`depends-on(<id>)` (everything reachable through relations, without the id).

## Strict YAML

Atlas files are read with `hq_core::yaml::from_str_strict` (serde-saphyr 2.0.0; reasoning in
`docs/research/data-file-formats.md` on main, 8ae1130): only `true` and `false` are booleans
(`strict_booleans`), unquoted values that read as numbers or booleans are refused where text is expected (`no_schema`),
duplicate keys and merge keys (`<<`) are errors, anchors and aliases are refused (`max_aliases` and `max_anchors` 0),
and a file holds one document (`max_documents` 1). Ids that YAML 1.1 reads as a boolean or null (`y n yes no on off
true false null nil none`) are refused even when quoted. `crates/atlas/tests/atlas.rs` holds a failing fixture for each
rule. Compose and `infra/services.yaml` files that `check-tags` reads keep the lenient `from_str`.

## Commands

| Command | What it does |
| --- | --- |
| `atlas check [dir] [--strict] [--repo-root p] [--services f]` | the drift hook in one command: `validate`, `check-tags` and the cross-context drift check (every undeclared coupling is an error); one exit code, so one hook line in any repo |
| `atlas init [repo] [-o dir] [--name n] [--force]` | drafts a first model of a repo (see "Draft a first model"); writes `<repo>/docs/atlas` with `draft: true` |
| `atlas query depends-on\|used-by\|impact <id> [dir] [--json]` | what `<id>` reaches through relations, what reaches it, or what a change to it (and its children) can break; transitive, sorted by id, `id (kind, name)` per line |
| `atlas summary <view> [dir]` | a short text for one view: title, members with kind, tech and parent, and the relations among them; read it before changing the code a view covers |
| `atlas diff <rev-a> <rev-b> [dir] [--json] [--render <out-dir>]` | added, removed and changed elements, relations and views between two git revisions of the workspace folder (blobs read from git, no checkout); `changed views` are the views whose definition, members or relations differ; `--render` writes only those, from `rev-b`, as `<out-dir>/<view>.svg` |
| `atlas validate [dir] [--strict]` | ids, file names, duplicates, references, parent cycles, relation id shape, view predicates, layouts, import aliases, exports |
| `atlas check-tags [dir] [--strict] [--repo-root p] [--services f]` | resolves source tags against the real repo; warns for code a view `covers` that has no element |
| `atlas export mermaid [dir] [--view id]` | one flowchart per view (the repo's colour classes) |
| `atlas export likec4 [dir] [--view id]` | one `.c4` file: specification, model, relations, views |
| `atlas export hq-diagram <view> [dir] [-o file]` | one view as an `hq-diagram` model YAML (render it with `hq-diagram render`) |

The default `dir` is `docs/atlas`. Exit codes: 0 clean, 1 errors (or warnings with `--strict`, or an unreadable
workspace), 2 bad arguments. Export refuses to run while `validate` has errors. Every message names the file and the
fix. Just recipes: `just docs-atlas-validate|docs-atlas-check-tags [dir] [flags]`, `just docs-atlas-export
mermaid|likec4 [dir] [--view id]`; the default is the HQ sample.

Tag checks: `repo` (manifest source, `repos/<ref>`, or registry/shared), `crate` (`crates/<name>`), `folder`, `file`
(`~/` expands to `$HOME`), `systemd-unit` (`units[].name` in `infra/services.yaml`), `compose-service` (compose files up
to three levels deep). `table` and `symbol` are counted as not checkable yet.

## Agent queries and diff

Short answers an agent reads before it changes code; they need a model that passes `validate`.

- `atlas query <depends-on|used-by|impact> <id> [dir] [--json]`: `depends-on` follows relations out of `<id>`, `used-by`
  follows them into it, `impact` is everything that reaches `<id>` or any of its children (the subtree itself left out).
  All are transitive and sorted by id; text prints `id (kind, name)` per line, `--json` an object with `question`, `id` and
  `found` (a list of `id`, `kind`, `name`, `tech`). An unknown id is an error that lists some ids that exist.
- `atlas summary <view> [dir]`: title, members (kind, tech, parent) and the relations among them for one view.
- `atlas diff <rev-a> <rev-b> [dir] [--json] [--render <out-dir>]`: compares the workspace folder at two git revisions,
  reading blobs from git (no checkout), and lists added, removed and changed elements, relations and views. A view is
  changed when its definition, its members or their relations differ. `--render` writes only the changed views, from
  `rev-b`, as `<out-dir>/<view>.svg`, for a landing note or PR description.

## Drift check (`atlas check`)

`atlas check [dir]` runs three checks with one exit code, so a repo needs one hook line (and, if it wants, one CI job):
`validate` (the model), `check-tags` (every source tag points at something real; the repo root is the nearest parent
with a `.git`, or `--repo-root`) and the cross-context drift check (code that refers from one context to another with no
relation; it finds nothing in a model without `context` elements). Errors and warnings go to stderr, one summary line to
stdout; exit 0 clean, 1 on any error (`--strict`: warnings too).

```yaml
repos:
  - repo: local
    hooks:
      - id: atlas-check
        name: atlas check (model, tags, drift)
        entry: atlas check docs/atlas
        language: system
        files: ^(docs/atlas/|crates/|src/|Cargo\.(toml|lock)$|(docker-)?compose[^/]*\.ya?ml$)
        pass_filenames: false
```

CI: `cargo install --locked --git <HQ repo URL> --package atlas`, then `atlas check docs/atlas --strict`.

## Draft a first model (`atlas init`)

`atlas init [repo] [-o dir] [--name n] [--force]` reads a repo and writes a first model to `<repo>/docs/atlas` (or `-o`):

- **Cargo workspace:** `[workspace] members` of the root `Cargo.toml` (`dir/*` expands to folders with a `Cargo.toml`; a
  root `[package]` is a member too). A member with `src/main.rs` or `src/bin` is a `container`, others are `component`s;
  tag `{kind: crate, ref: <dir>}`. A dependency named like another member is a `depends-on` relation. `.route("/path"`
  calls in a crate's `src` are listed in its description.
- **Compose files** (`compose.*`, `docker-compose.*`, up to three folders deep): each service is an element tagged
  `{kind: compose-service}`; the image is the `tech`, and postgres, mysql, mariadb, redis, mongo, sqlite, rabbitmq or
  memcached images make it a `store`. `depends_on` (list or map) gives `depends-on` relations.
- **SQL:** `CREATE TABLE` statements in `.sql` files (four folders deep) become `store` elements tagged
  `{kind: table}` and `{kind: file}`.
- **SQLAlchemy models:** `__tablename__ = "x"` or `table_name("app", "x")` (read as `app_x`) in `.py` files (six folders
  deep) become `store` elements (tech `SQLAlchemy table`); other expressions are skipped. A table found in SQL and in a
  model is one element.
- One `system` element (the workspace name) holds them all, and a view `overview` shows its children.

The manifest gets `draft: true`: `render` ignores it and `validate` reports a note (never a failure, even with
`--strict`) until a human checks names, kinds and relations and removes the flag. Output is sorted and holds no time or
machine path, so two runs write the same files. It refuses to write when the folder already has an `atlas.yaml`;
`--force` empties `elements/`, `relations/` and `views/` first (`layout/` stays). It fails with "nothing to draft" when
it finds no member, service or table. It is a heuristic (it reads text, not types): other frameworks' routes, other ORMs
and dependencies through workspace inheritance are not read.

## hq-diagram export

`atlas export hq-diagram <view>` writes a model that `hq-diagram validate` accepts (a test loads every sample view with
its loader and renders it). Mapping:

- A member that has members inside it becomes a `groups:` frame (nested by `parent`); relations that end at it are not
  drawn (listed in a header comment and on stderr), because `hq-diagram` edges join boxes.
- Boxes: `store` is a `datum` (`kinds:` shape database), a `person` or `external-system` that only receives is an
  `operation` consumer (shape actor), everything else a `program` (shape component); people and externals carry an
  icon, every box carries its atlas kind and tags as `tags:`, and tech and source tags go to `detail:`.
- Column role from the relations: no incoming relation is a collector, a sink person or external system a consumer,
  the rest outputs. A collector store says `unknown: true` (the source rule); `hq-diagram`'s `kind: source` is not used
  because its sources cannot be the end of an edge.
- Relation: an edge with `label [tech]`; `async: true` is `style: dotted`.
- The layout sidecar is not mapped: atlas `x`/`y` are absolute, `pos: {dx, dy}` is a grid offset from the automatic
  place (24 px steps, at most 480).

Known fit problems (the Columns layout is built for data flow, not containment) are in the
[bridge item](https://github.com/evocaslab/hq/blob/main/docs/backlog/B-261107-atlas-hq-diagram-bridge.md) in HQ.

## Not done

- No gate hook runs atlas yet; only the recipes do. `file` tags under `~/` resolve only on the machine that has the file.
- The LikeC4 export was not opened in LikeC4; golden files in `crates/atlas/tests/golden/` pin its text.
- Package imports and exports are validated for shape only (no fetching, no version check).
