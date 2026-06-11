# LunarUnits

[![CI](https://github.com/FrozenLemonTee/LunarUnits/actions/workflows/ci.yml/badge.svg)](https://github.com/FrozenLemonTee/LunarUnits/actions/workflows/ci.yml)

**English** | [简体中文](README_zh.md)

LunarUnits is a runtime dimension-checked physical quantity and unit system for
[MoonBit](https://www.moonbitlang.com). It helps engineering, scientific,
teaching and data-processing code avoid unit errors by modelling dimensions and
unit conversions explicitly.

Unit mistakes are a common source of bugs in scientific and engineering
computation. LunarUnits attaches a unit to every value, checks dimensional
consistency during operations, and rejects nonsensical combinations (such as
adding a length to a time) instead of silently producing wrong numbers. The MVP
performs these checks at runtime rather than through a compile-time dimensional
type system.

## Features

- `Quantity` — a numeric value paired with a unit.
- Seven base dimensions and a minimal normalized symbolic algebra behind them.
- SI base units and a growing set of common units grouped by domain
  (geometry, mass, mechanics, fluid, thermal, electromagnetism, angle,
  solid_angle, information, currency, count).
- Addition, subtraction, multiplication, division and integer powers, with
  units composed automatically.
- Same-dimension conversion, and runtime rejection of dimensionally invalid
  operations.
- `checked_*` APIs for non-raising addition, subtraction and conversion paths.
- Formatters for units and quantities in ASCII (`m/s^2`), SI/Unicode (`m/s²`)
  and LaTeX (`\mathrm{m}/\mathrm{s}^{2}`) notations.
- Immutable symbol catalogs (`notation/catalog`) with prebuilt per-domain
  catalogs (`notation/preset`) for resolving and extending unit symbols.
- A string parser (`notation/parser`) for unit and quantity expressions
  (`m/s^2`, `9.8 m/s^2`), with classified, non-panicking errors.
- Convenience quantity constructors for built-in unit domains.
- Extension dimensions and common physical constants.
- Every public API ships with a runnable documentation example.

## Installation

```bash
moon add FrozenLemonTee/LunarUnits
```

Then import the packages you need in your `moon.pkg`, for example:

```
import {
  "FrozenLemonTee/LunarUnits/core/quantity",
  "FrozenLemonTee/LunarUnits/units/si",
  "FrozenLemonTee/LunarUnits/constants/physics",
  "FrozenLemonTee/LunarUnits/notation/preset",
  "FrozenLemonTee/LunarUnits/notation/parser",
  "FrozenLemonTee/LunarUnits/quantities/qgeometry",
  "FrozenLemonTee/LunarUnits/quantities/qinformation",
  "FrozenLemonTee/LunarUnits/quantities/qmechanics",
}
```

## Quick start

```moonbit
// Build quantities with convenience constructors or directly from a unit.
let distance = @qgeometry.meters(100.0)
let time = @quantity.Quantity::new(10.0, @si.second)

// Arithmetic composes units automatically.
let speed = distance / time // 10 m/s
let speed_text = @quantity.format_quantity(speed) // "10 m/s"

// Newton's second law: F = m * a.
let mass = @quantity.Quantity::new(2.0, @si.kilogram)
let acceleration = @quantity.Quantity::new(3.0, @si.meter / @si.second.pow(2))
let force = mass * acceleration // 6 N

// Same-dimension conversion keeps the physical magnitude.
let in_meters = @qgeometry.kilometers(2.0).to(@si.meter)
// in_meters.value() == 2000.0

// Domain constructors are just shorthand for Quantity::new(value, unit).
let load = @qmechanics.newtons(6.0)

// Constants and extension dimensions are ordinary quantities too.
let light_second = @physics.speed_of_light * @quantity.Quantity::new(1.0, @si.second)
let memory = @qinformation.kibibytes(1.0)

// Resolve unit symbols through a catalog, or parse whole expressions.
let catalog = @preset.all()
let newton_unit = catalog.lookup("N").unwrap() // the newton, from its symbol
let accel_unit = @parser.parse_unit(catalog, "m/s^2") // composed from a string
let g = @parser.parse_quantity(catalog, "9.8 m/s^2") // value 9.8, unit m/s^2

// Dimensionally invalid operations are rejected: `add`/`sub`/`to` raise
// `DimensionMismatch` when the dimensions do not match. Use `checked_*`
// variants when you prefer `None` over raising.
let total = distance.add(time) // raises DimensionMismatch
let maybe_total = distance.checked_add(time) // None
```

More worked examples (speed, acceleration, force, energy, conversion and
invalid-operation rejection) live in [`examples/`](examples/examples.mbt) and
run under `moon test`.

## Design

LunarUnits is built as a one-way dependency stack; higher layers depend on lower
layers, never the other way around.

1. **`core/algebra`** — a minimal normalized symbolic algebra. Because units and
   dimensions only ever multiply, divide and take integer powers, the algebra is
   a free abelian group over symbols: every expression normalizes to a unique
   *monomial* (a coefficient times a product of `symbol^exponent` terms). This
   makes comparison, simplification and canonical ordering automatic.
2. **`core/dimension`** — the seven SI base dimensions (length, mass, time,
   electric current, temperature, amount of substance, luminous intensity)
   expressed as monomials. Two dimensions are equal exactly when their exponent
   vectors match, which is the basis of dimensional checking.
3. **`core/unit`** — `Un`, a unit symbol monomial paired with a dimension. The
   coefficient carries the scale relative to the coherent SI unit, so composite
   units (e.g. m/s) and conversions fall out of the algebra automatically.
4. **`core/quantity`** — `Quantity`, a value plus a unit. Addition/subtraction
   and conversion are dimensionally checked; multiplication and division compose
   units. `Dimension`, `Un`, and `Quantity` support `*` and `/` as shorthand for
   total algebraic composition; integer powers remain explicit via `.pow(n)`.

Formatting is intentionally separate from `Show`: `Show` stays useful for debug
diffs, while `format_unit`/`format_quantity` (and their `*_with` variants)
render user-facing strings in ASCII, SI/Unicode or LaTeX notation.

Symbol resolution lives in a separate `notation/` layer: `notation/catalog`
provides an immutable `symbol -> unit` lookup table that never participates in
core unit identity, and `notation/preset` ships one ready-made catalog per unit
package (plus `all()` for the union). On top of those, `notation/parser` parses
unit and quantity strings — atomic symbols come from the catalog while the
parser handles `*`, `/`, `^`, integer exponents and parentheses, returning
classified `ParseError`s (or `None` from the `*_opt` variants) instead of
panicking.

Error handling follows a deliberate split: low-level *queries* and recoverable
paths return `Option` (e.g. `Un::conversion_factor`,
`Quantity::checked_add`/`checked_sub`/`checked_to`), while higher-level
operations raise (`Quantity::add`/`sub`/`to` raise `DimensionMismatch` with the
expected and actual dimensions).

The unit collections are organized by domain so users import only what they
need. Extension packages can introduce additional dimensions without making the
SI-oriented core or existing unit domains depend on those dimensions.

## Package layout

```
core/
  algebra      normalized symbolic algebra (Expr, Monomial)
  dimension    physical dimensions (Dimension)
  unit         unit definitions and conversion (Un)
  quantity     values with units (Quantity, DimensionMismatch)
dimensions/
  angle_dimension        extension dimension for plane angle
  solid_angle_dimension  extension dimension for solid angle
  information_dimension  extension dimension for information
  currency_dimension     extension dimension for money
  count_dimension        extension dimension for discrete counts
units/
  si           SI base units
  angle        radian, degree, turn, arcminute, arcsecond, cycle, hertz
  solid_angle  steradian, square degree, spat
  geometry     length, area, volume
  mass         mass, density
  mechanics    force, pressure, velocity, energy, power
  fluid        dynamic/kinematic viscosity, permeability
  thermal      heat transfer coefficient, conductivity, specific heat, heat
  electromagnetism  charge, voltage, resistance, capacitance, inductance, flux
  information  bit, byte and common decimal/binary byte units
  currency     dollar, cent, k$, M$ (same-currency only)
  count        each, dozen, gross
quantities/
  qangle       plane angle constructors, plus cycle and hertz (frequency)
  qsolidangle  solid angle quantity constructors
  qsi          SI base quantity constructors
  qgeometry    geometry quantity constructors
  qmass        mass and density quantity constructors
  qmechanics   mechanics quantity constructors
  qfluid       fluid quantity constructors
  qthermal     thermal quantity constructors
  qelectromagnetism  electrical and magnetic quantity constructors
  qinformation information quantity constructors
  qcurrency    currency quantity constructors
  qcount       discrete-count quantity constructors
constants/
  physics      common physical constants as quantities
notation/
  catalog      immutable symbol -> unit lookup table (Catalog)
  preset       prebuilt catalogs, one per unit package, plus all()
  parser       parse unit/quantity strings (parse_unit, parse_quantity)
examples/      runnable, self-checking examples
docs/          design and roadmap notes
```

> Temperature currently provides only the kelvin: affine units (°C, °F) need
> offset support, which is planned alongside richer temperature semantics.

## Development

- Tests live next to the package they validate (`_test.mbt` for black-box,
  `_wbtest.mbt` for white-box). Public APIs also carry runnable doc examples.
- Run `moon test` to build and verify everything (including doc examples).
- Run `moon info && moon fmt` before reviewing diffs.

## License

Apache-2.0. See [LICENSE](LICENSE).
