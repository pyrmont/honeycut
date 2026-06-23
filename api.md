# honeycut API

[add](#add), [get](#get), [parse](#parse), [put](#put), [remove](#remove), [render](#render), [sort](#sort), [update](#update)

## add

**function**  | [source][1]

```janet
(add tree path v &named key-order)
```

Adds the entries of `v` to the collection at `path` in `tree`, returning the
new tree

If `path` resolves to a struct or table, `v` must also be a dictionary and
its key-value pairs are added. If `path` resolves to an array or tuple, `v`
must be an indexed collection and its elements are appended.

As in `put`, the optional `:key-order` hook sets the order in which
dictionary keys are emitted as `v` is rendered: it maps `v`, and every
dictionary nested within it, to its ordered `[key value]` pairs (the default
sorts them). It governs only this freshly rendered text. The added entries
follow those already at `path`, which keep their order; use `sort` to
reorder a collection already in the tree.

A key in `v` that is already present in the dictionary at `path` is added a
second time rather than overwriting the existing entry; use `put` to replace
a value in place.

Raises an error if `path` does not resolve to a collection or if `v` is not
of a matching type.

[1]: lib/data.janet#L383


## get

**function**  | [source][2]

```janet
(get tree path &opt dflt)
```

Returns the Janet value at `path` in `tree`

Returns `dflt` (or nil) if `path` is absent. A path present but holding the
value nil is distinguished from an absent path only by `dflt`.

[2]: lib/data.janet#L345


## parse

**function**  | [source][3]

```janet
(parse src &opt start)
```

Parses a string of Janet `src` into a lossless tree

Returns the root node, an array of the form `@[:code & children]`. Whitespace
and comments are preserved as nodes, so that `render` can reproduce `src`
exactly. An optional `start` index (default 0) sets the byte offset at which
to begin parsing.

Raises an error if `src` cannot be parsed.

[3]: lib/parser.janet#L125


## put

**function**  | [source][4]

```janet
(put tree path v &named key-order)
```

Replaces the value at `path` in `tree` with `v`, returning the new tree

As in `add`, the optional `:key-order` hook sets the order in which
dictionary keys are emitted as `v` is rendered: it maps `v`, and every
dictionary nested within it, to its ordered `[key value]` pairs (the default
sorts them). It governs only this freshly rendered text; entries already in
`tree` keep their order. Use `sort` to reorder a collection already in the
tree.

Raises an error if `path` does not resolve to a value.

[4]: lib/data.janet#L357


## remove

**function**  | [source][5]

```janet
(remove tree path)
```

Removes the entry at `path` in `tree`, returning the new tree

The last key of `path` identifies the entry: a key in a struct/table or an
index in a tuple/array. Surrounding separators are tidied up.

Raises an error if `path` is empty or does not resolve to an entry.

[5]: lib/data.janet#L455


## render

**function**  | [source][6]

```janet
(render tree)
```

Renders Janet source from a `tree` produced by `parse`

Returns a string. `(render (parse src))` reproduces `src` exactly.

[6]: lib/parser.janet#L179


## sort

**function**  | [source][7]

```janet
(sort tree path &named by)
```

Reorders the entries of the collection at `path` in `tree`, returning the
new tree

Entries are ordered by applying the optional `:by` hook and sorting on the
result. For a struct or table `:by` receives each entry's key; for a tuple or
array it receives each element. The default is the identity, so dictionaries
sort by key and indexed collections sort by element.

This rearranges entries already in the tree and touches only the collection
at `path`; nested collections are left as they are. By contrast, the
`:key-order` hook of `add` and `put` sets the order of dictionaries — nested
ones included — only as fresh values are rendered.

A comment travels with the entry it documents: an own-line comment moves with
the entry it sits above, and a same-line trailing comment moves with the entry
it follows. A comment cut off from the next entry by a blank line is treated
as free-standing and keeps its position, as does the blank-line layout itself.

Raises an error if `path` does not resolve to a collection.

[7]: lib/data.janet#L422


## update

**function**  | [source][8]

```janet
(update tree path f & args)
```

Replaces the value at `path` in `tree` with `(f current ;args)`

[8]: lib/data.janet#L376

