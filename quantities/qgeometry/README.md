# Geometry Quantity Constructors

`quantities/qgeometry` provides convenience constructors for common length,
area and volume quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/geometry`.

## Constructors

- Length: `meters`, `millimeters`, `centimeters`, `kilometers`, `inches`,
  `feet`, `miles`
- Area: `square_meters`, `hectares`
- Volume: `cubic_meters`, `liters`, `milliliters`, `gallons`

```moonbit
let trip = @qgeometry.miles(10.0)
let km = trip.to(@geometry.kilometer)
```
