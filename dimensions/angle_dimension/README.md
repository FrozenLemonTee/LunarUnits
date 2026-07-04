# Angle Dimension

`dimensions/angle_dimension` provides the custom plane-angle dimension used by
`units/angle`.

LunarUnits treats angle as an explicit extension dimension rather than plain
dimensionless. This lets the library distinguish torque (`energy / angle`) from
energy, and frequency in cycles per second from ordinary scalar rates.

## Main API

- `angle()` returns `@dimension.Dimension::custom("angle")`.

```moonbit
let angular_velocity = @angle_dimension.angle() / @dimension.Dimension::time()
```

Use `units/angle` for concrete units such as radian, degree, turn and hertz.
