# LunarUnits

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
  (geometry, mass, mechanics, fluid, thermal, electromagnetism).
- Addition, subtraction, multiplication, division and integer powers, with
  units composed automatically.
- Same-dimension conversion, and runtime rejection of dimensionally invalid
  operations.
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
}
```

## Quick start

```moonbit
// Build quantities from a value and a unit.
let distance = @quantity.Quantity::new(100.0, @si.meter)
let time = @quantity.Quantity::new(10.0, @si.second)

// Arithmetic composes units automatically.
let speed = distance / time // 10 m/s

// Newton's second law: F = m * a.
let mass = @quantity.Quantity::new(2.0, @si.kilogram)
let acceleration = @quantity.Quantity::new(3.0, @si.meter / @si.second.pow(2))
let force = mass * acceleration // 6 N

// Same-dimension conversion keeps the physical magnitude.
let in_meters = @quantity.Quantity::new(2.0, @geometry.kilometer).to(@si.meter)
// in_meters.value() == 2000.0

// Dimensionally invalid operations are rejected: `add`/`sub`/`to` raise
// `DimensionMismatch` when the dimensions do not match.
let total = distance.add(time) // raises DimensionMismatch
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

Error handling follows a deliberate split: low-level *queries* return `Option`
(e.g. `Un::conversion_factor`), while higher-level *operations* raise
(`Quantity::add`/`sub`/`to` raise `DimensionMismatch`).

The unit collections are organized by domain so users import only what they
need; each domain package depends only on `units/si`, with no cross-domain
dependencies.

## Package layout

```
core/
  algebra      normalized symbolic algebra (Expr, Monomial)
  dimension    physical dimensions (Dimension)
  unit         unit definitions and conversion (Un)
  quantity     values with units (Quantity, DimensionMismatch)
units/
  si           SI base units
  geometry     length, area, volume
  mass         mass, density
  mechanics    force, pressure, velocity, energy, power
  fluid        dynamic/kinematic viscosity, permeability
  thermal      heat transfer coefficient, conductivity, specific heat, heat
  electromagnetism  charge, voltage, resistance, capacitance, inductance, flux
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
