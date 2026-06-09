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

## MVP Boundary

The first implementation phase should focus on:

- `Quantity`
- base dimensions
- SI base units
- common derived units
- addition, subtraction, multiplication, and division
- same-dimension conversion
- invalid dimension operation tests

The MVP should not include parser, formatter, symbol preservation, or custom
unit registration unless the core model is already stable.
