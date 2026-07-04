# Mass Quantity Constructors

`quantities/qmass` provides convenience constructors for mass and density
quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/mass` or `units/si`.

## Constructors

- Mass: `kilograms`, `grams`, `milligrams`, `pounds`, `ounces`, `tonnes`
- Density: `kilograms_per_cubic_meter`, `grams_per_cubic_centimeter`

```moonbit
let load = @qmass.pounds(2.2)
let kg = load.to(@si.kilogram)
```
