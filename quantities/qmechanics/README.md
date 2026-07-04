# Mechanics Quantity Constructors

`quantities/qmechanics` provides convenience constructors for force, pressure,
speed, energy and power quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/mechanics`.

## Constructors

- Force: `newtons`, `kilonewtons`, `dynes`
- Pressure: `pascals`, `kilopascals`, `bars`, `atmospheres`, `psi`
- Speed: `meters_per_second`, `kilometers_per_hour`, `miles_per_hour`
- Energy: `joules`, `kilojoules`, `calories`, `kilowatt_hours`
- Power: `watts`, `kilowatts`, `horsepower`

```moonbit
let speed = @qmechanics.kilometers_per_hour(100.0)
let meters_per_second = speed.to(@mechanics.meter_per_second)
```
