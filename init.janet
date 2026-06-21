### Honeycut — edit Janet source as data, losslessly
###
### Honeycut parses Janet source into a tree that preserves every byte (whitespace
### and comments included), lets you read and edit it by key path the way
### `get-in` / `put-in` / `update-in` work on live data, and writes it back out
### with only the intended changes.
###
### This module re-exports the two everyday tiers:
###
###   - parsing  - `parse` and `generate` (the lossless reader/writer)
###   - data     - `get`, `put`, `update`, `add` and `remove` (editing by path)
###
### The lower-level zipper that powers the data tier lives in `lib/zip`, and the
### value pretty-printer in `lib/format`, for callers that need direct
### structural control.

(import ./lib/parse :prefix "" :export true)
(import ./lib/data :prefix "" :export true)
