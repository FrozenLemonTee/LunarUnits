# Mass Units

`units/mass` defines common mass units and density units.

Mass units are compatible with `@si.kilogram`. Density units have dimension
`mass / length^3`.

## Units

- Mass: `milligram`, `gram`, `pound`, `ounce`, `tonne`
- Density: `kilogram_per_cubic_meter`, `gram_per_cubic_centimeter`

```moonbit
let load = @quantity.Quantity::new(2.2, @mass.pound)
let kg = load.to(@si.kilogram)
```

Convenience constructors live in `quantities/qmass`.
