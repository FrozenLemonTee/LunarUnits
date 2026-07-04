# Fluid Units

`units/fluid` defines common viscosity and permeability units.

It is separate from mechanics to keep fluid-specific units discoverable without
expanding the mechanics package further.

## Units

- Dynamic viscosity: `pascal_second`, `poise`, `centipoise`
- Kinematic viscosity: `square_meter_per_second`, `stokes`, `centistokes`
- Permeability: `darcy`

```moonbit
let viscosity = @quantity.Quantity::new(1.0, @fluid.centipoise)
let si_value = viscosity.to(@fluid.pascal_second)
```

Convenience constructors live in `quantities/qfluid`.
