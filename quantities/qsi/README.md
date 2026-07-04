# SI Quantity Constructors

`quantities/qsi` provides convenience constructors for quantities expressed in
SI base units.

Each function returns `@quantity.Quantity`; no new quantity types are introduced.

## Constructors

- `meters`
- `kilograms`
- `seconds`
- `amperes`
- `kelvins`
- `moles`
- `candelas`

```moonbit
let distance = @qsi.meters(100.0)
let time = @qsi.seconds(9.58)
let speed = distance / time
```
