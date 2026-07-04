# Mechanics Units

`units/mechanics` defines common mechanics and energy units built from SI base
units.

This package covers force, pressure, speed, energy and power units. It does not
define separate quantity types; all values remain ordinary `@quantity.Quantity`
values.

## Units

- Force: `newton`, `kilonewton`, `dyne`
- Pressure: `pascal`, `kilopascal`, `bar`, `atmosphere`, `psi`
- Speed: `meter_per_second`, `kilometer_per_hour`, `mile_per_hour`
- Energy: `joule`, `kilojoule`, `calorie`, `kilowatt_hour`
- Power: `watt`, `kilowatt`, `horsepower`

```moonbit
let highway = @quantity.Quantity::new(100.0, @mechanics.kilometer_per_hour)
let speed = highway.to(@mechanics.meter_per_second)
```

Convenience constructors live in `quantities/qmechanics`.
