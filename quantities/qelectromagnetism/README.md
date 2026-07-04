# Electromagnetism Quantity Constructors

`quantities/qelectromagnetism` provides convenience constructors for electrical
and magnetic quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/electromagnetism`.

## Constructors

- `coulombs`
- `volts`
- `ohms`
- `siemens`
- `farads`
- `henries`
- `webers`
- `teslas`
- `ampere_hours`

```moonbit
let voltage = @qsi.amperes(2.0) * @qelectromagnetism.ohms(5.0)
let as_volts = voltage.to(@electromagnetism.volt)
```
