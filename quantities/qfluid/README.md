# Fluid Quantity Constructors

`quantities/qfluid` provides convenience constructors for viscosity and
permeability quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/fluid`.

## Constructors

- Dynamic viscosity: `pascal_seconds`, `poise`, `centipoise`
- Kinematic viscosity: `square_meters_per_second`, `stokes`, `centistokes`
- Permeability: `darcies`

```moonbit
let water = @qfluid.centipoise(1.0)
let si_value = water.to(@fluid.pascal_second)
```
