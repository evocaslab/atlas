# User stories

One entry per goal a person or agent reaches with atlas, with the Given/When/Then lines that confirm it. Status:
`built` (every line names a test in this repo), `partial`, `planned`, `gap`. The code and its tests still live outside
this repo until the move ([extraction plan](extraction.md)), so every entry here is `planned`; an entry becomes
`built` when its tests move here.

Not stories (yet): editing the model in a GUI; hosted storage; real-time collaboration.

## Index

| Id | Goal | Actor | Status |
| --- | --- | --- | --- |
| US-1 | keep the model beside the code | developer | planned |
| US-2 | fail the gate when the model and the code drift | reviewer | planned |
| US-3 | learn the boundaries before changing the code | AI agent | planned |
| US-4 | export a view without drawing by hand | team lead | planned |
| US-5 | see a view rendered in the browser | reader of a web page | planned |
| US-6 | see what changed between two versions of a model | maintainer | planned |

## US-1: keep the model beside the code

```yaml
schema: 1
id: US-1
actor: developer
goal: keep the model beside the code
why: so that a change to a service and its map land in one commit
status: planned
accept:
  - gwt: Given atlas.yaml and element files in the repo, when evocaslab-atlas validate runs, then it exits 0 for a valid model and names the file of an invalid one.
```

## US-2: fail the gate when the model and the code drift

```yaml
schema: 1
id: US-2
actor: reviewer
goal: fail the gate when the model and the code drift
why: so that a stale map is caught in review, not by a reader
status: planned
accept:
  - gwt: Given an element that names a crate or file that is gone, when evocaslab-atlas check runs, then it prints a failing line and exits 1.
  - gwt: Given code that matches a covers rule and has no element, when evocaslab-atlas check runs, then it prints a failing line and exits 1.
```

## US-3: learn the boundaries before changing the code

```yaml
schema: 1
id: US-3
actor: AI agent
goal: learn the boundaries before changing the code
why: so that it knows the neighbours of what it touches without reading the whole repo
status: planned
accept:
  - gwt: Given a model, when the agent runs evocaslab-atlas summary and evocaslab-atlas query on an element, then it gets the element, its parent and its relations.
```

## US-4: export a view without drawing by hand

```yaml
schema: 1
id: US-4
actor: team lead
goal: export a view without drawing by hand
why: so that a README or a review shows a diagram that matches the model
status: planned
accept:
  - gwt: Given a view, when evocaslab-atlas export mermaid or likec4 runs, then it writes text the other tool renders, with the same elements and relations.
```

## US-5: see a view rendered in the browser

```yaml
schema: 1
id: US-5
actor: reader of a web page
goal: see a view rendered in the browser
why: so that the page shows the same model as the repo, not a copied picture
status: planned
accept:
  - gwt: Given a view exported for the renderer, when the page loads it, then it draws the view as SVG.
```

## US-6: see what changed between two versions of a model

```yaml
schema: 1
id: US-6
actor: maintainer
goal: see what changed between two versions of a model
why: so that a review of the architecture reads a short list, not a file diff
status: planned
accept:
  - gwt: Given two versions of a model, when evocaslab-atlas diff runs, then it lists the added, removed and changed elements and relations.
```
