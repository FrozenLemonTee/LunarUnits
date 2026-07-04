# Algebra Core

`core/algebra` is the smallest symbolic layer in LunarUnits. It normalizes a
product of named factors and integer powers into a canonical monomial.

This package is intentionally generic. It does not know about SI dimensions,
units, quantities, parsing, or formatting.

## Main API

- `Monomial::one()` and `Monomial::scalar(value)` build dimensionless values.
- `Monomial::symbol(name)` creates one named factor.
- `mul`, `div`, `pow` and `inv` implement the multiplicative algebra.
- `same_factors` compares only the symbolic factors, ignoring the coefficient.
- `normalize(expr)` turns an expression tree into a canonical `Monomial`.

```moonbit
let length = @algebra.Monomial::symbol("length")
let area = length.pow(2)
let speed = length / @algebra.Monomial::symbol("time")
```

Higher layers use this package to make dimension and unit expressions stable
under ordering, multiplication and cancellation.
