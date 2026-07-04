# Unit Core

`core/unit` defines `Un`, the runtime unit value. A unit combines a symbol, a
dimension and a linear scale factor relative to that dimension's canonical base.

Offsets and logarithmic semantics are deliberately excluded. Use `affine` for
absolute affine points such as Celsius, and `logarithmic` for dB/Np levels.

## Main API

- `Un::base(symbol, dimension)` creates a base unit for a dimension.
- `Un::scaled(symbol, dimension, scale)` creates a linear scaled unit.
- `mul`, `div` and `pow` build compound units.
- `is_compatible` and `conversion_factor` compare units by dimension.
- `format_unit` and `format_unit_with` render ASCII, SI and LaTeX styles.

```moonbit
let meter = @unit.Un::base("m", @dimension.Dimension::length())
let second = @unit.Un::base("s", @dimension.Dimension::time())
let speed = meter / second
let accel = speed / second
```

Built-in unit packages under `units/*` provide the usual named units on top of
this core type.
