# User stories

1. **A developer** keeps `atlas.yaml` and element files beside the code, so a change to a service and its map land in
   one commit.
2. **A reviewer** runs `atlas check` in the gate and gets a failing line when an element names a crate or file that is
   gone, or code that matches a `covers` rule has no element.
3. **An AI agent** reads `atlas summary` and `atlas query` before it changes the code, so it knows the boundaries and
   the neighbours of what it touches, without reading the whole repo.
4. **A team lead** exports a view to Mermaid or LikeC4 for a README or a review, without drawing by hand.
5. **A reader of a web page** sees a view rendered to SVG in the browser from the same model.
6. **A maintainer** compares two versions of a model with `atlas diff` to see which elements and relations changed.

Not stories (yet): editing the model in a GUI; hosted storage; real-time collaboration.
