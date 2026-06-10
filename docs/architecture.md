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

The initial formatter is deliberately ASCII-only. SI-superscript and LaTeX
styles can be added later without changing the debug representation.

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
