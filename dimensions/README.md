# Dimension Extensions

The `dimensions` area contains optional extension dimensions that do not belong
to the seven SI base dimensions in `core/dimension`.

- `information_dimension`: information as an extension dimension for computer
  science and engineering units.
- `angle_dimension`: plane angle as an extension dimension, kept separate from
  plain dimensionless ratios.
- `solid_angle_dimension`: solid angle as an extension dimension, pairing with
  the plane angle dimension for radiometry and photometry.
- `currency_dimension`: money as an extension dimension for engineering
  economics (unit prices and cost rates).
- `count_dimension`: counts of discrete items, distinct from amount of
  substance (the mole), for throughput and density rates.

Extension dimensions should depend on `core/dimension`; existing `units/*` and
`quantities/*` packages should not depend back on them unless they are the
matching extension packages.
