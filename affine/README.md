# Affine Scales

The `affine` package models **absolute points** on scales whose conversion is
`value * scale + offset` — most familiarly temperature. These are deliberately
kept out of the multiplicative core: `Un` carries no offset, and `Point` is a
separate type from a linear `Quantity`.

The mechanism is generic. Temperature is just the shipped preset; you can define
any affine scale with `AffineUn::new`.

## Types

- `AffineUn(symbol, base : Un, scale, offset)` — an affine unit. `base_value =
  reading * scale + offset`, with the offset expressed in the linear `base` unit.
- `Point(value, unit : AffineUn)` — an absolute reading, e.g. `20 °C`.

## Point vs. interval

Following the affine-space convention (boost.units, Pint), a point is a position
and an interval is a vector. An **interval is just an ordinary
`@quantity.Quantity`** on the base dimension (the offset cancels), so only the
absolute point needs a dedicated type. This is what tells `20 °C` (absolute,
293.15 K) apart from a `20 °C` interval (20 K).

| Operation | Result |
|-----------|--------|
| `point.to(unit)` | `Point` (affine conversion, e.g. `212 °F → 100 °C`) |
| `point.to_base()` | `Quantity` (absolute value in the base unit, e.g. `293.15 K`) |
| `a.difference(b)` | `Quantity` interval in the base unit (e.g. `10 K`) |
| `point.shift(interval)` | `Point` (subtract by passing a negative interval) |
| `point + point`, `point * scalar` | not provided — the classic affine mistakes |

`to` / `shift` / `difference` raise `@quantity.DimensionMismatch` on incompatible
dimensions; `checked_*` variants return `Option`.

## Temperature presets

`kelvin`, `celsius`, `fahrenheit`, `rankine`, all anchored to `@si.kelvin`.

```moonbit
let body = @affine.Point::new(37.0, @affine.celsius)
let body_k = body.to_base()                 // 310.15 K (a linear Quantity)
let interval = @affine.Point::new(30.0, @affine.celsius)
  .difference(@affine.Point::new(20.0, @affine.celsius)) // 10 K
```

## Other affine scales

The machinery is generic. An absolute time instant, for example, is an affine
point on a seconds-from-epoch scale, and the difference of two instants is a
duration (a linear `Quantity`, convertible with `units/time`):

```moonbit
let epoch = @affine.AffineUn::new("s", @si.second, 1.0, 0.0)
let elapsed = @affine.Point::new(7200.0, epoch)
  .difference(@affine.Point::new(0.0, epoch)) // 7200 s, i.e. 2 hours
```

Calendar dates (months, years, time zones, leap seconds) are deliberately out of
scope — their units are not fixed-length, so they are not a simple affine scale.

## Note

Conversions through the 5/9 factor (Fahrenheit/Rankine) are floating-point and
not bit-exact; compare with a tolerance.

Logarithmic scales (decibel, neper) are handled separately by the
`logarithmic` package, which uses its own `Level` and `Gain` types.
