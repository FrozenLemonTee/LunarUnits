# Information Units

`units/information` defines bit, byte and common decimal/binary byte units on
the custom information dimension.

This keeps storage quantities separate from dimensionless scalars.

## Units

- `bit`
- `byte`
- Decimal byte units: `kilobyte`, `megabyte`, `gigabyte`
- Binary byte units: `kibibyte`, `mebibyte`, `gibibyte`

```moonbit
let payload = @quantity.Quantity::new(1.0, @information.megabyte)
let bytes = payload.to(@information.byte)
```

Convenience constructors live in `quantities/qinformation`.
