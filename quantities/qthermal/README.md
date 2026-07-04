# Thermal Quantity Constructors

`quantities/qthermal` provides convenience constructors for linear thermal
quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/thermal`.

## Constructors

- `british_thermal_units`
- `joules_per_kilogram_kelvin`
- `watts_per_meter_kelvin`
- `watts_per_square_meter_kelvin`

```moonbit
let heat_capacity = @qthermal.joules_per_kilogram_kelvin(4186.0)
let heat = @qsi.kilograms(1.0) * heat_capacity * @qsi.kelvins(10.0)
```
