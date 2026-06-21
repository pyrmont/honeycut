# Honeycut

[![Test Status][icon]][status]

[icon]: https://github.com/pyrmont/honeycut/workflows/test/badge.svg
[status]: https://github.com/pyrmont/honeycut/actions?query=workflow%3Atest

Honeycut operates on [Janet][] source code losslessly.

[Janet]: https://janet-lang.org

## Rationale

As a homoiconic language, Janet source code can be parsed by the Janet parser
into Janet data structures. Unfortunately, if you print this back out again,
you'll have lost all of the non-semantic information. Well, non-semantic from
the perspective of Janet's parser. Us humans might consider that
'non-semantic' information (comments and whitespace) quite semantic.

Enter Honeycut. Using the power of zippers, Honeycut can get, put and update
all without losing any of that precious 'non-semantic' information.

## Library

### Installation

Add the dependency to your `info.jdn` file:

```janet
  :dependencies ["https://github.com/pyrmont/honeycut"]
```

### Usage

Honeycut's retrieval and insertion API deliberately shadows core names like
`get` and `put`, so import it with a prefix:

```janet
(import honeycut :as h)

(def src "{:name \"honeycut\"\n :version \"0.1.0\"}\n")
(def tree (h/parse src))

# read a value by path
(h/get tree [:version])
# => "0.1.0"

# edit a value and write the tree back to text
(-> tree
    (h/put [:version] "0.2.0")
    (h/render))
# => "{:name \"honeycut\"\n :version \"0.2.0\"}\n"
```

Parsing and rendering (`h/parse` and `h/render`) is lossless:
`(h/render (h/parse src))` reproduces `src` exactly. Data retrieval
and insertion (`h/get`, `h/put`, `h/update`, `h/add` and `h/remove`) reads and
edits the tree by key path, where a path segment is a key inside a struct/table
or a 0-based index inside a tuple/array.

Check out the [API document](api.md) for more information.

## Bugs

Found a bug? I'd love to know about it. The best way is to report your bug in
the [Issues][] section on GitHub.

[Issues]: https://github.com/pyrmont/honeycut/issues

## Credits

Honeycut drew significant inspiration from @sogaiu's [jipper][] library. It was
written with the assistance of LLM-based coding agents like Claude Code. The
name of the library is an intentional [mondegreen][] of the character Captain
B.J. Hunnicutt.

[jipper]: https://github.com/sogaiu/jipper
[mondegreen]: https://en.wikipedia.org/wiki/Mondegreen

## Licence

Honeycut is licensed under the MIT Licence. See [LICENSE][] for more
details.

[LICENSE]: https://github.com/pyrmont/honeycut/blob/master/LICENSE
