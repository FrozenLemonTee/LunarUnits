# Notation Parser

`notation/parser` parses unit and quantity strings on top of an explicit
`@catalog.Catalog`.

The parser does not contain a global unit table. Callers choose the catalog,
which keeps parsing deterministic and testable.

## Main API

- `parse_unit(catalog, text)` parses a unit expression and raises `ParseError`.
- `parse_quantity(catalog, text)` parses a numeric value followed by a unit.
- `quantity(catalog, value, unit_text)` parses a unit and pairs it with a value.
- `parse_unit_opt`, `parse_quantity_opt` and `quantity_opt` return `Option`.
- `ParseError` classifies unknown units, empty input, trailing input and syntax
  errors.

Supported unit syntax includes `*`, `/`, `^`, integer powers and parentheses.

```moonbit
let catalog = @preset.all()
let accel_unit = @parser.parse_unit(catalog, "m/s^2")
let accel = @parser.parse_quantity(catalog, "9.8 m/s^2")
let force = @parser.quantity(catalog, 12.0, "N")
```

Compound aliases such as `km/h` are parsed as expressions, not as multi-token
catalog keys.
