# Notation

The `notation` area handles the string side of units: resolving symbols to
units today, and parsing/derived-unit formatting later. It sits outside the core
model and never participates in unit identity.

- `catalog`: `Catalog`, an immutable `symbol -> unit` lookup table. Build it with
  `Catalog::new`, `with_unit` and `with_all`; query it with `lookup` (returns
  `Option`), `contains` and `symbols`; combine catalogs with `merge`. It depends
  only on `core/unit`. Compatibility and conversion stay governed by `Un`'s scale
  and dimension — the catalog only answers "is this symbol known, and which unit
  does it name".
- `preset`: prebuilt catalogs, one builder per `units/*` package (`si`,
  `geometry`, `mass`, `mechanics`, `fluid`, `thermal`, `electromagnetism`,
  `angle`, `solid_angle`, `information`, `currency`, `count`), each covering all
  of its package's units. `all()` returns the collision-free union of every
  package. This package concentrates the dependency on the unit libraries so the
  generic `catalog` type stays decoupled from any particular unit set.

```moonbit
// Resolve a symbol, then extend a catalog with your own (the original is
// unchanged — catalogs are immutable).
let catalog = @preset.all()
let newton = catalog.lookup("N").unwrap()
let extended = catalog.with_unit("USD", @currency.dollar)
```

A string parser (`symbol/operator -> Un`) builds on `catalog.lookup`, and
derived-unit recognition in the formatter (`Un -> preferred symbol`) are planned
follow-ups.
