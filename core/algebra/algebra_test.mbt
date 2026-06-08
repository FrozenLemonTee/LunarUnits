///|
/// Rule 1 (flatten products) + Rule 4 (combine like terms): a * (a * a) == a^3
test "flatten nested mul and combine like terms" {
  let lhs = normalize(Mul([Symbol("a"), Mul([Symbol("a"), Symbol("a")])]))
  let rhs = normalize(Pow(Symbol("a"), 3))
  assert_eq(lhs, rhs)
}

///|
/// Rule 2 (division as negative power): a / b == a * b^-1
test "division equals multiplication by negative power" {
  let lhs = normalize(Symbol("a")).div(normalize(Symbol("b")))
  let rhs = normalize(Mul([Symbol("a"), Pow(Symbol("b"), -1)]))
  assert_eq(lhs, rhs)
}

///|
/// Rule 3 (power of a power): (a^2)^3 == a^6
test "power of power" {
  let lhs = normalize(Pow(Pow(Symbol("a"), 2), 3))
  let rhs = normalize(Pow(Symbol("a"), 6))
  assert_eq(lhs, rhs)
}

///|
/// Rule 5 (drop trivial factors): a^0 and the One factor are both eliminated,
/// yielding the dimensionless identity.
test "identity elimination" {
  let m = normalize(
    Mul([Pow(Symbol("a"), 0), One, Symbol("b"), Pow(Symbol("b"), -1)]),
  )
  assert_true(m.is_dimensionless())
  assert_eq(m, Monomial::one())
}

///|
/// Rule 6 (canonical sorting / commutativity): a * b == b * a
test "commutativity is canonicalized" {
  let ab = normalize(Mul([Symbol("a"), Symbol("b")]))
  let ba = normalize(Mul([Symbol("b"), Symbol("a")]))
  assert_eq(ab, ba)
}

///|
/// Scalar coefficients: 2 * 3 == 6
test "scalar coefficients multiply" {
  let m = normalize(Mul([Scalar(2.0), Scalar(3.0)]))
  assert_eq(m.coefficient(), 6.0)
  assert_true(m.is_dimensionless())
}

///|
/// same_factors ignores the coefficient: 2*m and 5*m share dimensions, but
/// neither matches m^2.
test "same_factors ignores coefficient" {
  let two_m = normalize(Mul([Scalar(2.0), Symbol("m")]))
  let five_m = normalize(Mul([Scalar(5.0), Symbol("m")]))
  let m_squared = normalize(Pow(Symbol("m"), 2))
  assert_true(two_m.same_factors(five_m))
  assert_false(two_m.same_factors(m_squared))
}

///|
/// Structural snapshot of a normalized monomial (factors sorted by name,
/// coefficient preserved).
test "normalized structure snapshot" {
  let m = normalize(
    Mul([Scalar(1000.0), Symbol("s"), Symbol("m"), Pow(Symbol("s"), -2)]),
  )
  debug_inspect(
    m,
    content=(
      #|{ coeff: 1000, factors: [("m", 1), ("s", -1)] }
    ),
  )
}
