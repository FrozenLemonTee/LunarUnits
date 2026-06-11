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
- `parser`: parses unit and quantity strings. `parse_unit`, `parse_quantity` and
  `quantity(value, unit_string)` resolve atomic symbols through a catalog and
  compose `*`, `/`, `^`, integer exponents and parentheses; they raise a
  classified `ParseError`, while the `*_opt` variants return `Option`. Depends on
  `core/unit`, `core/quantity` and `catalog`, not on any `units/*` package.

```moonbit
// Resolve a symbol, extend a catalog, or parse a whole expression.
let catalog = @preset.all()
let newton = catalog.lookup("N").unwrap()
let extended = catalog.with_unit("USD", @currency.dollar)
let accel = @parser.parse_unit(catalog, "m/s^2")
let g = @parser.parse_quantity(catalog, "9.8 m/s^2")
```

Derived-unit recognition in the formatter (`Un -> preferred symbol`), SI-prefix
handling, and recombining multi-token catalog keys (e.g. `km/h`) are planned
follow-ups.
