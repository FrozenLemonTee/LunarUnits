# Solid Angle Units

`units/solid_angle` defines solid-angle units on the custom solid-angle
dimension.

## Units

- `steradian`
- `square_degree`
- `spat`

```moonbit
let full_sphere = @quantity.Quantity::new(1.0, @solid_angle.spat)
let sr = full_sphere.to(@solid_angle.steradian)
```

Convenience constructors live in `quantities/qsolidangle`.
