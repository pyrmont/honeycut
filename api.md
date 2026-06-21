# honeycut API

[add](#add), [generate](#generate), [get](#get), [parse](#parse), [put](#put), [remove](#remove), [update](#update)

## add

**function**  | [source][1]

```janet
(add tree path v &named key-order)
```

Adds the entries of `v` to the collection at `path` in `tree`

For a struct or table, `v` must be a dictionary and its key-value pairs are
added. For a tuple or array, `v` must be indexed and its elements are
appended. Returns the new tree.

[1]: lib/data.janet#L240


## generate

**function**  | [source][2]

```janet
(generate tree)
```

Generates Janet source from a `tree` produced by `parse`

Returns a string. `(generate (parse src))` reproduces `src` exactly.

[2]: lib/parse.janet#L200


## get

**function**  | [source][3]

```janet
(get tree path &opt dflt)
```

Returns the Janet value at `path` in `tree`

Returns `dflt` (or nil) if `path` is absent. A path present but holding the
value nil is distinguished from an absent path only by `dflt`.

[3]: lib/data.janet#L209


## parse

**function**  | [source][4]

```janet
(parse src &opt start)
```

Parses a string of Janet `src` into a lossless tree

Returns the root node, an array of the form `@[:code & children]`. Whitespace
and comments are preserved as nodes, so that `generate` can reproduce `src`
exactly. An optional `start` index (default 0) sets the byte offset at which
to begin parsing.

Raises an error if `src` cannot be parsed.

[4]: lib/parse.janet#L146


## put

**function**  | [source][5]

```janet
(put tree path v &named key-order)
```

Replaces the value at `path` in `tree` with `v`, returning the new tree

Raises an error if `path` does not resolve to a value.

[5]: lib/data.janet#L221


## remove

**function**  | [source][6]

```janet
(remove tree path)
```

Removes the entry at `path` in `tree`, returning the new tree

The last segment of `path` selects a key (in a struct/table) or an index (in
a tuple/array). Surrounding separators are tidied up.

[6]: lib/data.janet#L264


## update

**function**  | [source][7]

```janet
(update tree path f & args)
```

Replaces the value at `path` in `tree` with `(f current ;args)`

[7]: lib/data.janet#L233

