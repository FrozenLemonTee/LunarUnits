# Solid Angle Quantity Constructors

`quantities/qsolidangle` provides convenience constructors for solid-angle
quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/solid_angle`.

## Constructors

- `steradians`
- `square_degrees`
- `spats`

```moonbit
let sphere = @qsolidangle.spats(1.0)
let steradians = sphere.to(@solid_angle.steradian)
```
