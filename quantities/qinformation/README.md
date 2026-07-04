# Information Quantity Constructors

`quantities/qinformation` provides convenience constructors for information
quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/information`.

## Constructors

- `bits`
- `bytes`
- Decimal byte units: `kilobytes`, `megabytes`, `gigabytes`
- Binary byte units: `kibibytes`, `mebibytes`, `gibibytes`

```moonbit
let payload = @qinformation.megabytes(1.0)
let bytes = payload.to(@information.byte)
```
