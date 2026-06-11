# Logarithmic Scales

The `logarithmic` package models **decibels and nepers** — logarithmic ratios
and levels. Like the `affine` package, these are non-linear and kept out of the
multiplicative core; they bridge to linear `Quantity` values only at explicit
boundaries.

Following Unitful.jl, it distinguishes two types:

- `Level(value, unit : LogUnit)` — an **absolute** level that carries a
  reference, e.g. `30 dBm` (referenced to 1 mW).
- `Gain(value, scale : LogScale)` — a **pure ratio** with no reference, e.g.
  `3 dB`.

## Scales and units

- `LogScale(symbol, factor, log_base)`: `value = factor * log_base(ratio)`.
  Presets: `decibel_power` (10, 10), `decibel_field` (20, 10), `neper` (1, e).
- `LogUnit(symbol, reference : Quantity, scale)`. Presets: `dbm()` (1 mW),
  `dbw()` (1 W), `dbv()` (1 V).

Power and root-power (field) quantities use different scales (factor 10 vs 20),
since power is proportional to the square of a field quantity. The two are
**never auto-converted** into each other.

## Operations

| Operation | Result |
|-----------|--------|
| `level.to_linear()` | `Quantity` (e.g. `30 dBm → 1 W`) |
| `Level::from_linear(q, unit)` | `Level` (raises `IncompatibleDimension`) |
| `level.shift(gain)` | `Level` (`30 dBm + 3 dB = 33 dBm`) |
| `a.gain(b)` | `Gain` (difference of two levels) |
| `a.combine(b)` | `Level` (adds linear powers: `20 dBm + 20 dBm ≈ 23.01 dBm`) |
| `gain.ratio()` / `Gain::from_ratio(r, scale)` | linear ratio ↔ gain |
| `g1.add(g2)` | `Gain` (ratios multiply, readings add) |

Cross-scale (`dB` vs `Np`) or cross-reference operations raise `LogError`
(`ScaleMismatch` / `ReferenceMismatch` / `IncompatibleDimension`).

```moonbit
let p = @logarithmic.Level::new(30.0, @logarithmic.dbm()).to_linear() // 1 W
let louder = @logarithmic.Level::new(30.0, @logarithmic.dbm())
  .shift(@logarithmic.Gain::new(3.0, @logarithmic.decibel_power))     // 33 dBm
```

## Note

Logarithms are floating-point; compare results with a tolerance. dBA-style
acoustic weightings and octave/decade ratios are out of scope.
