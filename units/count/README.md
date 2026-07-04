# Count Units

`units/count` defines discrete-count units on the custom count dimension.

Use this package for entity counts, event counts and throughput examples. It is
not the same as mole and not plain dimensionless.

## Units

- `each`
- `dozen`
- `gross`

```moonbit
let batch = @quantity.Quantity::new(2.0, @count.dozen)
let items = batch.to(@count.each)
```

Convenience constructors live in `quantities/qcount`.
