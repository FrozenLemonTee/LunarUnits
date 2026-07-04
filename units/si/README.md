# SI Base Units

`units/si` defines the seven SI base units used throughout LunarUnits.

These units are the linear anchors for most derived units and quantities.

## Units

- `meter`
- `kilogram`
- `second`
- `ampere`
- `kelvin`
- `mole`
- `candela`

```moonbit
let force_unit = @si.kilogram * @si.meter / @si.second.pow(2)
let distance = @quantity.Quantity::new(3.0, @si.meter)
```

Convenience constructors for SI quantities live in `quantities/qsi`.
