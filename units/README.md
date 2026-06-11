# Unit Libraries

The `units` area is reserved for built-in unit packages.

- `si`: SI base units for the MVP.
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
provided by `notation/preset` (one catalog per package, plus `all()`). Broader
engineering units and a string parser belong to later milestones.
