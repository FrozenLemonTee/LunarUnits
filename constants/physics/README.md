# Physics Constants

`constants/physics` provides common physical constants as `@quantity.Quantity`
values.

Constants are ordinary quantities, so they participate in the same dimension
checks, conversions and formatting as user-created values.

## Constants

- `speed_of_light`
- `standard_gravity`
- `gravitational_constant`
- `planck_constant`
- `boltzmann_constant`
- `avogadro_constant`

```moonbit
let distance = @physics.speed_of_light * @qsi.seconds(1.0)
let km = distance.to(@geometry.kilometer)
```

Use these constants in examples and calculations where their dimensions should
remain explicit.
