///|
/// The canonical normalized form: `coeff * Π (symbol ^ exp)`.
///
/// Invariants:
///   - `factors` is always sorted by symbol name in ascending order;
///   - no factor has `exp == 0`.
///
/// Thanks to these invariants, the structural equality from `derive(Eq)` is
/// exactly "equality as canonical forms": two `Expr` values are equivalent iff
/// their normalized `Monomial` results are equal.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = normalize(Mul([Scalar(2.0), Symbol("m"), Pow(Symbol("s"), -1)]))
///   assert_eq(m.coefficient(), 2.0)
///   debug_inspect(m.terms(), content="[(\"m\", 1), (\"s\", -1)]")
/// }
/// ```
pub struct Monomial {
  coeff : Double
  factors : Array[(String, Int)]
} derive(Eq, Debug)

///|
/// Manual `Show` implementation (`assert_eq` needs it to print diffs on
/// failure).
pub impl Show for Monomial with fn output(self, logger) {
  logger.write_string("{coeff: \{self.coeff}, factors: [")
  for idx, pair in self.factors {
    if idx > 0 {
      logger.write_string(", ")
    }
    let (name, exp) = pair
    logger.write_string("(\{name}, \{exp})")
  }
  logger.write_string("]}")
}

///|
/// The multiplicative identity `1`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(Monomial::one().is_dimensionless())
///   assert_eq(Monomial::one().coefficient(), 1.0)
/// }
/// ```
pub fn Monomial::one() -> Monomial {
  { coeff: 1.0, factors: [] }
}

///|
/// Returns the scalar coefficient (the unit layer uses it to carry the scale
/// factor relative to base units).
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = normalize(Mul([Scalar(1000.0), Symbol("m")]))
///   assert_eq(m.coefficient(), 1000.0)
/// }
/// ```
pub fn Monomial::coefficient(self : Monomial) -> Double {
  self.coeff
}

///|
/// Returns the sorted exponent factors.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = normalize(Mul([Symbol("s"), Symbol("m")]))
///   debug_inspect(m.terms(), content="[(\"m\", 1), (\"s\", 1)]")
/// }
/// ```
pub fn Monomial::terms(self : Monomial) -> Array[(String, Int)] {
  self.factors
}

///|
/// Returns whether the monomial has no symbolic factors.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(normalize(Scalar(5.0)).is_dimensionless())
///   assert_false(normalize(Symbol("m")).is_dimensionless())
/// }
/// ```
pub fn Monomial::is_dimensionless(self : Monomial) -> Bool {
  self.factors.is_empty()
}

///|
/// Compares only the exponent part, ignoring the coefficient. This is the
/// backbone of the dimension layer's "same dimension" test.
///
/// # Example
///
/// ```mbt check
/// test {
///   let two_m = normalize(Mul([Scalar(2.0), Symbol("m")]))
///   let five_m = normalize(Mul([Scalar(5.0), Symbol("m")]))
///   assert_true(two_m.same_factors(five_m))
///   assert_false(two_m.same_factors(normalize(Pow(Symbol("m"), 2))))
/// }
/// ```
pub fn Monomial::same_factors(self : Monomial, other : Monomial) -> Bool {
  self.factors == other.factors
}

///|
/// Merges two factor lists that are already sorted and free of zero exponents:
/// like symbols add their exponents; the result drops zero exponents and keeps
/// ascending order.
fn merge_factors(
  a : Array[(String, Int)],
  b : Array[(String, Int)],
) -> Array[(String, Int)] {
  let result : Array[(String, Int)] = []
  let mut i = 0
  let mut j = 0
  while i < a.length() && j < b.length() {
    let (ka, va) = a[i]
    let (kb, vb) = b[j]
    if ka < kb {
      result.push((ka, va))
      i += 1
    } else if ka > kb {
      result.push((kb, vb))
      j += 1
    } else {
      let sum = va + vb
      if sum != 0 {
        result.push((ka, sum))
      }
      i += 1
      j += 1
    }
  }
  while i < a.length() {
    result.push(a[i])
    i += 1
  }
  while j < b.length() {
    result.push(b[j])
    j += 1
  }
  result
}

///|
/// Computes an integer power of a `Double` (avoids the rounding error of a
/// floating-point `pow` on integer exponents).
fn pow_double(base : Double, n : Int) -> Double {
  if n == 0 {
    return 1.0
  }
  let mut acc = 1.0
  let mut k = if n < 0 { -n } else { n }
  while k > 0 {
    acc = acc * base
    k -= 1
  }
  if n < 0 {
    1.0 / acc
  } else {
    acc
  }
}

///|
/// Multiplies two monomials: coefficients multiply and like symbols add their
/// exponents.
///
/// # Example
///
/// ```mbt check
/// test {
///   let a = normalize(Symbol("a"))
///   assert_eq(a.mul(a), normalize(Pow(Symbol("a"), 2)))
/// }
/// ```
pub fn Monomial::mul(self : Monomial, other : Monomial) -> Monomial {
  {
    coeff: self.coeff * other.coeff,
    factors: merge_factors(self.factors, other.factors),
  }
}

///|
/// Inverts a monomial: the coefficient is reciprocated and every exponent is
/// negated.
///
/// # Example
///
/// ```mbt check
/// test {
///   let i = normalize(Mul([Scalar(2.0), Symbol("m")])).inv()
///   assert_eq(i.coefficient(), 0.5)
///   debug_inspect(i.terms(), content="[(\"m\", -1)]")
/// }
/// ```
pub fn Monomial::inv(self : Monomial) -> Monomial {
  let factors : Array[(String, Int)] = []
  for pair in self.factors {
    let (k, v) = pair
    factors.push((k, -v))
  }
  { coeff: 1.0 / self.coeff, factors }
}

///|
/// Divides one monomial by another: equivalent to multiplying by the inverse.
///
/// # Example
///
/// ```mbt check
/// test {
///   let a = normalize(Symbol("a"))
///   let b = normalize(Symbol("b"))
///   assert_eq(a.div(b), normalize(Mul([Symbol("a"), Pow(Symbol("b"), -1)])))
/// }
/// ```
pub fn Monomial::div(self : Monomial, other : Monomial) -> Monomial {
  self.mul(other.inv())
}

///|
/// Raises a monomial to an integer power: the coefficient is taken to the
/// `n`-th power and every exponent is multiplied by `n`; `n == 0` returns the
/// identity.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = normalize(Pow(Symbol("a"), 2))
///   assert_eq(m.pow(3), normalize(Pow(Symbol("a"), 6)))
///   assert_eq(m.pow(0), Monomial::one())
/// }
/// ```
pub fn Monomial::pow(self : Monomial, n : Int) -> Monomial {
  if n == 0 {
    return Monomial::one()
  }
  let factors : Array[(String, Int)] = []
  for pair in self.factors {
    let (k, v) = pair
    factors.push((k, v * n))
  }
  { coeff: pow_double(self.coeff, n), factors }
}

///|
/// Normalizes a syntactic `Expr` into its unique canonical `Monomial`.
///
/// This is a total function (it never fails). The six normalization rules from
/// the design draft are satisfied automatically by the merge semantics of
/// `mul` / `pow`: flatten products, division as negative power, power of a
/// power, combine like terms, drop trivial factors, and canonical sorting.
///
/// # Example
///
/// ```mbt check
/// test {
///   // a * (a * a) normalizes to a^3
///   let nested = normalize(Mul([Symbol("a"), Mul([Symbol("a"), Symbol("a")])]))
///   assert_eq(nested, normalize(Pow(Symbol("a"), 3)))
/// }
/// ```
pub fn normalize(e : Expr) -> Monomial {
  match e {
    Scalar(c) => { coeff: c, factors: [] }
    One => Monomial::one()
    Symbol(s) => { coeff: 1.0, factors: [(s, 1)] }
    Mul(xs) => {
      let mut acc = Monomial::one()
      for x in xs {
        acc = acc.mul(normalize(x))
      }
      acc
    }
    Pow(x, n) => normalize(x).pow(n)
  }
}
