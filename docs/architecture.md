# LunarUnits Architecture

This document records the current MVP package structure and the public API
boundaries that should stay stable as the project grows.

## Core Direction

The MVP core follows a layered model:

1. Algebra layer for normalized symbolic expressions.
2. Dimension layer for physical dimension relations.
3. Unit layer for unit definitions and conversion metadata.
4. Quantity layer for numeric values with unit references.
5. Optional convenience layers for built-in units and quantity constructors.

The dependency direction should stay one-way. Higher layers may depend on lower
layers, but lower layers should not know about higher-level concepts.

The `units/*` packages expose unit values (`Un`). The `quantities/*` packages
expose convenience constructors that return `Quantity`; they do not introduce
new quantity types or change the runtime dimension-checking model.

The `dimensions/*` packages are optional extension dimensions. They may use the
generic `Dimension::custom(...)` constructor, but `core/dimension` does not know
about any specific extension domain. Matching extension unit and quantity
packages, such as angle and information units, depend on those extension
dimensions.

The `constants/*` packages expose reusable `Quantity` values. Constants do not
need special runtime behavior: they compose with the same unit algebra and
dimension checks as user-created quantities.

## Operator Policy

LunarUnits uses operators only where the operation is total and has the same
meaning as the underlying algebra:

- `Dimension`, `Un`, and `Quantity` support `*` and `/` as shorthand for
  `.mul(...)` and `.div(...)`.
- `Quantity` supports unary `-`, which negates the numeric value and keeps the
  unit unchanged.
- Integer powers remain explicit through `.pow(n)` because MoonBit's `^`
  operator currently maps to a same-type bitwise-xor trait rather than
  `Self ^ Int`.
- `Quantity` addition, subtraction, and conversion remain explicit methods
  (`.add(...)`, `.sub(...)`, `.to(...)`) because they may raise
  `DimensionMismatch`.

## Error Boundary

The quantity layer exposes both raising and non-raising APIs:

- `.add(...)`, `.sub(...)`, and `.to(...)` raise `DimensionMismatch` when
  dimensions differ. The error carries the expected and actual dimensions.
- `.checked_add(...)`, `.checked_sub(...)`, and `.checked_to(...)` return
  `None` instead of raising.
- `.can_add(...)`, `.can_sub(...)`, and `.can_to(...)` provide lightweight
  compatibility checks for control-flow decisions.

## Formatting Boundary

`Show` remains a debug-oriented representation for assertion diffs and
structural inspection. User-facing display goes through explicit formatter
functions:

- `format_unit(unit)` returns compact ASCII unit notation such as `m/s^2`.
- `format_quantity(quantity)` returns `<value> <unit>`, such as `9.8 m/s^2`.
- `format_unit_with(unit, style)` and `format_quantity_with(quantity, style)`
  render the same value in a `FormatStyle` of `Ascii`, `Si` (Unicode
  superscripts and `·`, e.g. `m/s²`) or `Latex` (e.g. `\mathrm{m}/\mathrm{s}^{2}`).

The numerator/denominator split and SI ordering are style-independent and shared
across styles; only symbol, exponent and separator rendering differ. None of
this changes the debug `Show` representation.

## Notation Boundary

Symbol resolution lives in a separate `notation/` layer, kept out of the core
model:

- `notation/catalog` defines `Catalog`, an immutable `symbol -> unit` lookup
  table. It is built with `new`/`with_unit`/`with_all`, queried with
  `lookup` (returns `Option`)/`contains`/`symbols`, and combined with `merge`.
  A catalog never participates in core unit identity: compatibility and
  conversion stay governed by `Un`'s scale and dimension. It depends only on
  `core/unit`.
- `notation/preset` ships one prebuilt catalog per `units/*` package (`si`,
  `geometry`, `mass`, `mechanics`, `fluid`, `thermal`, `electromagnetism`,
  `angle`, `solid_angle`, `information`, `currency`, `count`), each covering all
  of its package's units, plus `all()` for the collision-free union. This
  package concentrates the dependency on the unit libraries so `notation/catalog`
  stays decoupled from any particular unit set.

The catalog is the forward (`symbol -> unit`) half needed to unblock a future
parser. Reverse lookup (`unit -> preferred symbol`, for derived-unit
recognition in the formatter) and SI-prefix handling are deferred.

## Extension Boundary

Extension dimensions should stay outside the SI core unless they are part of
the seven SI base dimensions. For example, extension domains are modeled as:

- `dimensions/angle_dimension`: defines the plane angle dimension.
- `units/angle`: defines radian, degree, turn, arcminute, arcsecond, plus cycle
  and hertz (cycles per second) in the angle/time dimension.
- `quantities/qangle`: defines plane angle quantity constructors.
- `dimensions/information_dimension`: defines the information dimension.
- `units/information`: defines bit, byte and decimal/binary byte units.
- `quantities/qinformation`: defines information quantity constructors.

Existing SI-oriented packages must not depend back on extension dimensions.

## MVP Boundary

The first implementation phase should focus on:

- `Quantity`
- base dimensions
- SI base units
- common derived units
- addition, subtraction, multiplication, and division
- same-dimension conversion
- invalid dimension operation tests

The MVP should not include parser or custom unit registration unless the core
model is already stable. The post-MVP formatter layer is an explicit display
API and should stay separate from `Show`.
