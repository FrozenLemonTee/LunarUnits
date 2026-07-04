# Angle Quantity Constructors

`quantities/qangle` provides convenience constructors for plane-angle quantities
and cyclic frequency.

Each function returns `@quantity.Quantity` using the matching unit from
`units/angle`.

## Constructors

- `radians`
- `degrees`
- `turns`
- `arcminutes`
- `arcseconds`
- `cycles`
- `hertz`

```moonbit
let phase = @qangle.degrees(90.0)
let rad = phase.to(@angle.radian)
let omega = @qangle.hertz(1.0).to(@angle.radian / @si.second)
```
