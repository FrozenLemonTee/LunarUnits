# Thermal Units

`units/thermal` defines linear thermal units used in heat-transfer examples.

Absolute temperature scales with offsets are not defined here. Use `affine` for
absolute temperature points such as Celsius and Fahrenheit.

## Units

- `british_thermal_unit`
- `joule_per_kilogram_kelvin`
- `watt_per_meter_kelvin`
- `watt_per_square_meter_kelvin`

```moonbit
let specific_heat = @quantity.Quantity::new(4186.0, @thermal.joule_per_kilogram_kelvin)
let heat = @quantity.Quantity::new(1.0, @si.kilogram) * specific_heat *
  @quantity.Quantity::new(10.0, @si.kelvin)
```

Convenience constructors live in `quantities/qthermal`.
