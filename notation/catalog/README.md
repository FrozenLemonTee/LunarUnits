# Notation Catalog

`notation/catalog` defines `Catalog`, an immutable lookup table from textual
symbols to `@unit.Un` values.

The catalog is a notation layer only. It does not determine unit identity or
conversion compatibility; those remain properties of `Un` and `Dimension`.

## Main API

- `Catalog::new()` creates an empty catalog.
- `with_unit(symbol, unit)` adds or replaces one symbol.
- `with_all(entries)` adds a list of entries.
- `lookup(symbol)` returns `Option[Un]`.
- `contains(symbol)` checks whether a symbol is known.
- `symbols()` returns the known symbol list.
- `merge(other)` combines two catalogs.

```moonbit
let catalog = @catalog.Catalog::new()
  .with_unit("m", @si.meter)
  .with_unit("s", @si.second)
let meter = catalog.lookup("m").unwrap()
```

Use `notation/preset` when you want catalogs for the built-in unit packages.
