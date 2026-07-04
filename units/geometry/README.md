# Geometry Units

`units/geometry` defines common length, area and volume units on the SI length
dimension.

Use this package when you need everyday engineering units beyond `@si.meter`.

## Units

- Length: `millimeter`, `centimeter`, `kilometer`, `inch`, `foot`, `mile`
- Area: `square_meter`, `hectare`
- Volume: `cubic_meter`, `liter`, `milliliter`, `gallon`

```moonbit
let trip = @quantity.Quantity::new(10.0, @geometry.mile)
let km = trip.to(@geometry.kilometer)
```

Convenience constructors live in `quantities/qgeometry`.
