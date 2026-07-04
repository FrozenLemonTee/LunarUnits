# Solid Angle Dimension

`dimensions/solid_angle_dimension` provides the custom solid-angle dimension
used by `units/solid_angle`.

Solid angle is modeled separately from plane angle and from dimensionless
scalars, which keeps photometry and geometry examples explicit.

## Main API

- `solid_angle()` returns `@dimension.Dimension::custom("solid_angle")`.

```moonbit
let luminous_flux_dim =
  @dimension.Dimension::luminous_intensity() * @solid_angle_dimension.solid_angle()
```

Use `units/solid_angle` for steradian, square degree and spat.
