# honeycut API

[add](#add), [get](#get), [parse](#parse), [put](#put), [remove](#remove), [render](#render), [update](#update)

## add

**function**  | [source][1]

```janet
(add tree path v &named key-order)
```

Adds the entries of `v` to the collection at `path` in `tree`, returning the
new tree

If `path` resolves to a struct or table, `v` must also be a dictionary and
its key-value pairs are added. If `path` resolves to an array or tuple, `v`
must be an indexed collection and its elements are appended. The optional
`:key-order` hook maps any dictionary in `v` to its ordered `[key value]`
pairs, setting the order in which dictionary keys are emitted when the
returned tree is rendered (the default sorts them).

Raises an error if `path` does not resolve to a collection or if `v` is not
of a matching type.

[1]: lib/data.janet#L244


## get

**function**  | [source][2]

```janet
(get tree path &opt dflt)
```

Returns the Janet value at `path` in `tree`

Returns `dflt` (or nil) if `path` is absent. A path present but holding the
value nil is distinguished from an absent path only by `dflt`.

[2]: lib/data.janet#L209


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

The optional `:key-order` hook maps any dictionary in `v` to its ordered
`[key value]` pairs, setting the order in which dictionary keys are emitted
when the returned tree is rendered (the default sorts them).

Raises an error if `path` does not resolve to a value.

[4]: lib/data.janet#L221


## remove

**function**  | [source][5]

```janet
(remove tree path)
```

Removes the entry at `path` in `tree`, returning the new tree

The last key of `path` identifies the entry: a key in a struct/table or an
index in a tuple/array. Surrounding separators are tidied up.

Raises an error if `path` is empty or does not resolve to an entry.

[5]: lib/data.janet#L275


## render

**function**  | [source][6]

```janet
(render tree)
```

Renders Janet source from a `tree` produced by `parse`

Returns a string. `(render (parse src))` reproduces `src` exactly.

[6]: lib/parser.janet#L179


## update

**function**  | [source][7]

```janet
(update tree path f & args)
```

Replaces the value at `path` in `tree` with `(f current ;args)`

[7]: lib/data.janet#L237

