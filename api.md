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


## lib/data

[add](#add-1), [get](#get-1), [put](#put-1), [remove](#remove-1), [update](#update-1)

## add

**function**  | [source][8]

```janet
(add tree path v &named key-order)
```

Adds the entries of `v` to the collection at `path` in `tree`

For a struct or table, `v` must be a dictionary and its key-value pairs are
added. For a tuple or array, `v` must be indexed and its elements are
appended. Returns the new tree.

[8]: lib/data.janet#L240


## get

**function**  | [source][9]

```janet
(get tree path &opt dflt)
```

Returns the Janet value at `path` in `tree`

Returns `dflt` (or nil) if `path` is absent. A path present but holding the
value nil is distinguished from an absent path only by `dflt`.

[9]: lib/data.janet#L209


## put

**function**  | [source][10]

```janet
(put tree path v &named key-order)
```

Replaces the value at `path` in `tree` with `v`, returning the new tree

Raises an error if `path` does not resolve to a value.

[10]: lib/data.janet#L221


## remove

**function**  | [source][11]

```janet
(remove tree path)
```

Removes the entry at `path` in `tree`, returning the new tree

The last segment of `path` selects a key (in a struct/table) or an index (in
a tuple/array). Surrounding separators are tidied up.

[11]: lib/data.janet#L264


## update

**function**  | [source][12]

```janet
(update tree path f & args)
```

Replaces the value at `path` in `tree` with `(f current ;args)`

[12]: lib/data.janet#L233


## lib/format

[value-&gt;source](#value-source)

## value-&gt;source

**function**  | [source][13]

```janet
(value->source j indent &named key-order)
```

Renders the Janet value `j` as source text, indented under `indent`

`indent` is the whitespace string already present before the value on its
line; it is used to align any continuation lines. `key-order`, if given, is a
function that takes a dictionary and returns its `[key value]` pairs in the
order they should be emitted (the default sorts by key).

Raises an error if `j` contains a function or abstract value.

[13]: lib/format.janet#L15


## lib/parse

[generate](#generate-1), [parse](#parse-1)

## generate

**function**  | [source][14]

```janet
(generate tree)
```

Generates Janet source from a `tree` produced by `parse`

Returns a string. `(generate (parse src))` reproduces `src` exactly.

[14]: lib/parse.janet#L200


## parse

**function**  | [source][15]

```janet
(parse src &opt start)
```

Parses a string of Janet `src` into a lossless tree

Returns the root node, an array of the form `@[:code & children]`. Whitespace
and comments are preserved as nodes, so that `generate` can reproduce `src`
exactly. An optional `start` index (default 0) sets the byte offset at which
to begin parsing.

Raises an error if `src` cannot be parsed.

[15]: lib/parse.janet#L146


## lib/zip

[append-child](#append-child), [branch?](#branch), [children](#children), [column-of](#column-of), [df-next](#df-next), [down](#down), [down-skip](#down-skip), [edit](#edit), [insert-child](#insert-child), [insert-left](#insert-left), [insert-right](#insert-right), [left](#left), [left-skip](#left-skip), [leftmost](#leftmost), [node](#node), [remove](#remove-2), [replace](#replace), [right](#right), [right-skip](#right-skip), [rightmost](#rightmost), [root](#root), [root?](#root-1), [state](#state), [trivia?](#trivia), [up](#up), [value](#value), [zip](#zip)

## append-child

**function**  | [source][16]

```janet
(append-child zloc a-node)
```

Inserts `a-node` as the rightmost child of `zloc`, without moving

[16]: lib/zip.janet#L268


## branch?

**function**  | [source][17]

```janet
(branch? zloc)
```

Returns true if the node at `zloc` can hold children

[17]: lib/zip.janet#L76


## children

**function**  | [source][18]

```janet
(children zloc)
```

Returns the child nodes of the branch at `zloc`

Raises an error if `zloc` is not a branch.

[18]: lib/zip.janet#L83


## column-of

**function**  | [source][19]

```janet
(column-of zloc)
```

Returns the 1-based column at which the node at `zloc` begins

The column is measured from the generated text to the node's left, so it is
correct even for nodes inserted by edits (which carry no source location).

[19]: lib/zip.janet#L382


## df-next

**function**  | [source][20]

```janet
(df-next zloc)
```

Moves to the next location in a depth-first walk

Returns nil once the walk is exhausted.

[20]: lib/zip.janet#L307


## down

**function**  | [source][21]

```janet
(down zloc)
```

Moves to the leftmost child of `zloc`, or returns nil if there are none

[21]: lib/zip.janet#L103


## down-skip

**function**  | [source][22]

```janet
(down-skip zloc)
```

Moves to the first non-trivia child of `zloc`

Returns nil if there are no such children.

[22]: lib/zip.janet#L360


## edit

**function**  | [source][23]

```janet
(edit zloc f & args)
```

Replaces the node at `zloc` with `(f node ;args)`

[23]: lib/zip.janet#L222


## insert-child

**function**  | [source][24]

```janet
(insert-child zloc a-node)
```

Inserts `a-node` as the leftmost child of `zloc`, without moving

[24]: lib/zip.janet#L261


## insert-left

**function**  | [source][25]

```janet
(insert-left zloc a-node)
```

Inserts `a-node` as the left sibling of `zloc`, without moving

Raises an error if `zloc` is the root.

[25]: lib/zip.janet#L245


## insert-right

**function**  | [source][26]

```janet
(insert-right zloc a-node)
```

Inserts `a-node` as the right sibling of `zloc`, without moving

Raises an error if `zloc` is the root.

[26]: lib/zip.janet#L229


## left

**function**  | [source][27]

```janet
(left zloc)
```

Moves to the left sibling of `zloc`, or returns nil if there is none

[27]: lib/zip.janet#L136


## left-skip

**function**  | [source][28]

```janet
(left-skip zloc)
```

Moves left from `zloc` past any trivia to the previous sibling node

Returns nil if there is no such sibling.

[28]: lib/zip.janet#L348


## leftmost

**function**  | [source][29]

```janet
(leftmost zloc)
```

Moves to the leftmost sibling of `zloc` (or stays put if already there)

[29]: lib/zip.janet#L184


## node

**function**  | [source][30]

```janet
(node zloc)
```

Returns the node at `zloc`

[30]: lib/zip.janet#L62


## remove

**function**  | [source][31]

```janet
(remove zloc)
```

Removes the node at `zloc`

Returns the location that precedes it in a depth-first walk. Raises an error
if `zloc` is the root.

[31]: lib/zip.janet#L275


## replace

**function**  | [source][32]

```janet
(replace zloc a-node)
```

Replaces the node at `zloc` with `a-node`, without moving

[32]: lib/zip.janet#L211


## right

**function**  | [source][33]

```janet
(right zloc)
```

Moves to the right sibling of `zloc`, or returns nil if there is none

[33]: lib/zip.janet#L121


## right-skip

**function**  | [source][34]

```janet
(right-skip zloc)
```

Moves right from `zloc` past any trivia to the next sibling node

Returns nil if there is no such sibling.

[34]: lib/zip.janet#L336


## rightmost

**function**  | [source][35]

```janet
(rightmost zloc)
```

Moves to the rightmost sibling of `zloc` (or stays put if already there)

[35]: lib/zip.janet#L168


## root

**function**  | [source][36]

```janet
(root zloc)
```

Moves all the way up and returns the (possibly edited) root node

[36]: lib/zip.janet#L200


## root?

**function**  | [source][37]

```janet
(root? zloc)
```

Returns true if `zloc` is the root location

[37]: lib/zip.janet#L94


## state

**function**  | [source][38]

```janet
(state zloc)
```

Returns the state struct for `zloc`

[38]: lib/zip.janet#L69


## trivia?

**function**  | [source][39]

```janet
(trivia? zloc)
```

Returns true if the node at `zloc` is whitespace or a comment

[39]: lib/zip.janet#L326


## up

**function**  | [source][40]

```janet
(up zloc)
```

Moves to the parent of `zloc`, or returns nil if `zloc` is the root

[40]: lib/zip.janet#L151


## value

**function**  | [source][41]

```janet
(value zloc)
```

Returns the Janet value represented by the node at `zloc`

The node is generated back to source and parsed, so a `:keyword` node yields a
keyword, a `:struct` node yields a struct, and so on.

[41]: lib/zip.janet#L372


## zip

**function**  | [source][42]

```janet
(zip tree)
```

Returns a zipper location for the root of `tree`

[42]: lib/zip.janet#L55

