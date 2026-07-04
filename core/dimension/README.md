# Dimension Core

`core/dimension` defines the runtime dimension model used by LunarUnits.
Dimensions are multiplicative symbolic values built on top of `core/algebra`.

This package models dimension identity only. Unit scale factors, symbols and
quantity values live in `core/unit` and `core/quantity`.

## Main API

- SI base dimensions: `length`, `mass`, `time`, `electric_current`,
  `temperature`, `amount_of_substance`, `luminous_intensity`.
- `dimensionless()` for scalar quantities.
- `custom(symbol)` for extension dimensions such as angle, information,
  currency and count.
- `mul`, `div` and `pow` for derived dimensions.
- `is_same` and `is_dimensionless` for runtime checks.

```moonbit
let velocity = @dimension.Dimension::length() / @dimension.Dimension::time()
let force = @dimension.Dimension::mass() * velocity / @dimension.Dimension::time()
```

Use `custom` in extension packages rather than adding new base dimensions to the
core.
