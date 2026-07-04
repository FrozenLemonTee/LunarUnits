# Count Dimension

`dimensions/count_dimension` provides the custom discrete-count dimension used
by `units/count`.

It separates entity counts from plain dimensionless scalars and from mole. This
is useful for throughput, event rates and engineering counts.

## Main API

- `count()` returns `@dimension.Dimension::custom("count")`.

```moonbit
let throughput_dim =
  @count_dimension.count() / @dimension.Dimension::time()
```

Use `units/count` for concrete count units such as each, dozen and gross.
