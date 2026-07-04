# Angle Units

`units/angle` defines plane-angle units on the custom angle dimension.

Angle is not treated as plain dimensionless. This keeps torque, angular
velocity and cyclic frequency explicit while still allowing conversions such as
`1 Hz = 2*pi rad/s`.

## Units

- `radian`
- `degree`
- `turn`
- `arcminute`
- `arcsecond`
- `cycle`
- `hertz` (`cycle / second`)

```moonbit
let one_turn = @quantity.Quantity::new(1.0, @angle.turn)
let radians = one_turn.to(@angle.radian)
let omega = @quantity.Quantity::new(1.0, @angle.hertz).to(@angle.radian / @si.second)
```

Convenience constructors live in `quantities/qangle`.
