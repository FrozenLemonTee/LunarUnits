# LunarUnits Architecture

This document records the initial package structure before implementation code
is added.

## Core Direction

The MVP core follows a layered model:

1. Algebra layer for normalized symbolic expressions.
2. Dimension layer for physical dimension relations.
3. Unit layer for unit definitions and conversion metadata.
4. Quantity layer for numeric values with unit references.

The dependency direction should stay one-way. Higher layers may depend on lower
layers, but lower layers should not know about higher-level concepts.

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
