# Preset Catalogs

`notation/preset` builds ready-to-use catalogs for the built-in unit packages.

This package concentrates dependencies on `units/*` so the generic
`notation/catalog` package stays independent of any specific unit library.

## Catalog builders

- `si`
- `time`
- `geometry`
- `mass`
- `mechanics`
- `fluid`
- `thermal`
- `electromagnetism`
- `angle`
- `solid_angle`
- `information`
- `currency`
- `count`
- `all`

```moonbit
let catalog = @preset.all()
let acceleration = @parser.parse_unit(catalog, "m/s^2")
let energy = @parser.parse_quantity(catalog, "1 kWh")
```

Use package-specific builders when you want a smaller accepted symbol set.
