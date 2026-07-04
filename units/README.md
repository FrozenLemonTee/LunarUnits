# Unit Libraries

The `units` area contains built-in linear unit packages. Every exported unit is
an ordinary `@unit.Un`; quantity constructors live separately in
`quantities/*`.

- `si`: SI base units.
- `time`: fixed-length time durations (minute, hour, day, milli/micro/nanosecond)
  as linear multiples of the second. Calendar units (month and up) are excluded
  because their length is not constant; absolute instants are an affine concern
  handled by the `affine` package.
- `angle`: plane angle units such as radian, degree, turn, arcminute and
  arcsecond, plus `cycle` and `hertz` (cycles per second) in the angle/time
  dimension, so frequency and angular frequency share a dimension
  (1 Hz = 2*pi rad/s).
- domain packages such as `geometry`, `mechanics`, `fluid`, `thermal` and
  `electromagnetism`: common coherent and non-SI units grouped by physical
  domain.
- `information`: information units such as bit, byte, KB, GB, KiB and MiB.
- `solid_angle`: solid angle units such as steradian, square degree and spat.
- `currency`: same-currency units such as dollar, cent, k$ and M$
  (cross-currency rates are injected by the caller, not built in).
- `count`: discrete-count units such as each, dozen and gross.

Quantity constructors live in `quantities/*`. Symbol lookup for these units is
provided by `notation/preset` (one catalog per package, plus `all()`), and
`notation/parser` parses unit/quantity strings on top of a catalog. Non-linear
scales such as Celsius and decibels live in `affine` and `logarithmic`, not in
linear unit packages.
