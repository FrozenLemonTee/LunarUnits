# Quantity Core

`core/quantity` defines `Quantity`, a numeric value paired with a `@unit.Un`.
It is the main runtime value users calculate with.

Addition, subtraction and conversion require compatible dimensions. Multiplying,
dividing and integer powers are always defined and combine the units.

## Main API

- `Quantity::new(value, unit)` builds a quantity.
- `add`, `sub` and `to` raise `DimensionMismatch` on incompatible dimensions.
- `checked_add`, `checked_sub` and `checked_to` return `Option`.
- `can_add`, `can_sub` and `can_to` provide non-throwing checks.
- `mul`, `div`, `pow`, `scale` and unary negation support algebraic operations.
- `format_quantity` and `format_quantity_with` render user-facing output.

```moonbit
let distance = @quantity.Quantity::new(100.0, @si.meter)
let time = @quantity.Quantity::new(9.58, @si.second)
let speed = distance / time
let mph = speed.to(@mechanics.mile_per_hour)
```

Convenience constructors under `quantities/*` return this same `Quantity` type;
they do not introduce separate quantity classes.
