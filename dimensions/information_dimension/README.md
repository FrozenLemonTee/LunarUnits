# Information Dimension

`dimensions/information_dimension` provides the custom information dimension
used by `units/information`.

It keeps bytes, bits and binary/decimal byte multiples separate from plain
dimensionless numbers.

## Main API

- `information()` returns `@dimension.Dimension::custom("information")`.

```moonbit
let transfer_rate_dim =
  @information_dimension.information() / @dimension.Dimension::time()
```

Use `units/information` for concrete bit and byte units.
