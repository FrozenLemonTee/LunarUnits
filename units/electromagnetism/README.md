# Electromagnetism Units

`units/electromagnetism` defines common electrical and magnetic units derived
from SI base dimensions.

## Units

- `coulomb`
- `volt`
- `ohm`
- `siemens`
- `farad`
- `henry`
- `weber`
- `tesla`
- `ampere_hour`

```moonbit
let current = @quantity.Quantity::new(2.0, @si.ampere)
let resistance = @quantity.Quantity::new(5.0, @electromagnetism.ohm)
let voltage = current * resistance
```

Convenience constructors live in `quantities/qelectromagnetism`.
