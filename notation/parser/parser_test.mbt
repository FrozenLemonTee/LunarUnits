///|
/// The catalog used across these tests: every built-in unit symbol.
fn cat() -> @catalog.Catalog {
  @preset.all()
}

///|
/// A single registered symbol resolves to its unit.
test "parse an atomic unit" {
  assert_eq(parse_unit(cat(), "m"), @si.meter)
  assert_eq(parse_unit(cat(), "kg"), @si.kilogram)
}

///|
/// Division and exponent compose into m/s^2.
test "parse a composite unit" {
  assert_eq(parse_unit(cat(), "m/s^2"), @si.meter / @si.second.pow(2))
}

///|
/// `*`/`/` are left-associative and `^` binds tighter, so kg*m/s^2 matches the
/// newton.
test "operator precedence matches the newton" {
  let force = parse_unit(cat(), "kg*m/s^2")
  assert_eq(force, @si.kilogram * @si.meter / @si.second.pow(2))
  assert_true(force.is_compatible(@mechanics.newton))
}

///|
/// Parentheses regroup the denominator, matching the formatter's output shape.
test "parse parenthesized denominator" {
  assert_eq(
    parse_unit(cat(), "m/(kg*s^2)"),
    @si.meter / (@si.kilogram * @si.second.pow(2)),
  )
}

///|
/// Exponents may be negative or zero.
test "parse signed and zero exponents" {
  assert_eq(parse_unit(cat(), "s^-1"), @si.second.pow(-1))
  assert_true(parse_unit(cat(), "m^0").is_compatible(@si.meter / @si.meter))
}

///|
/// The literal `1` is the dimensionless unit (and round-trips the formatter).
test "parse the dimensionless unit" {
  assert_true(parse_unit(cat(), "1").is_compatible(@si.meter / @si.meter))
}

///|
/// Whitespace around operators is ignored.
test "whitespace is insignificant" {
  assert_eq(parse_unit(cat(), " kg * m / s^2 "), parse_unit(cat(), "kg*m/s^2"))
}

///|
/// Parsing round-trips the ASCII formatter for plain atomic compositions.
test "round-trips the ASCII formatter" {
  for text in ["m/s^2", "kg*m/s^2", "m/(kg*s^2)"] {
    assert_eq(@unit.format_unit(parse_unit(cat(), text)), text)
  }
}

///|
/// A number and a unit parse into a quantity.
test "parse a quantity" {
  let q = parse_quantity(cat(), "9.8 m/s^2")
  assert_eq(q.value(), 9.8)
  assert_true(q.unit().is_compatible(@si.meter / @si.second.pow(2)))
}

///|
/// Numbers accept a sign and scientific notation; a unit may follow without a
/// space.
test "parse signed and scientific quantities" {
  let q = parse_quantity(cat(), "-3.2e3 N")
  assert_eq(q.value(), -3200.0)
  assert_true(q.unit().is_compatible(@mechanics.newton))
}

///|
/// A bare number is a dimensionless quantity.
test "parse a dimensionless quantity" {
  let q = parse_quantity(cat(), "42")
  assert_eq(q.value(), 42.0)
  assert_true(q.unit().is_compatible(@si.meter / @si.meter))
}

///|
/// `quantity` attaches a unit string to a value already held as a Double, and
/// agrees with `parse_quantity`.
test "build a quantity from value and unit string" {
  let a = quantity(cat(), 9.8, "m/s^2")
  let b = parse_quantity(cat(), "9.8 m/s^2")
  assert_eq(a.value(), b.value())
  assert_eq(a.unit(), b.unit())
}

///|
/// The non-raising variants return None on any error and Some on success.
test "opt variants" {
  assert_true(parse_unit_opt(cat(), "m/s^2") is Some(_))
  assert_true(parse_unit_opt(cat(), "zz") is None)
  assert_true(parse_unit_opt(cat(), "m/") is None)
  assert_true(parse_quantity_opt(cat(), "9.8 m/s^2") is Some(_))
  assert_true(parse_quantity_opt(cat(), "m/s^2") is None) // no leading number
  assert_true(quantity_opt(cat(), 1.0, "zz") is None)
}

///|
/// Errors are classified: unknown unit, syntax, exponent and number.
test "error classification" {
  assert_true(capture(() => parse_unit(cat(), "zz")) is Some(UnknownUnit("zz")))
  assert_true(capture(() => parse_unit(cat(), "m/")) is Some(UnexpectedEnd))
  assert_true(
    capture(() => parse_unit(cat(), "*m")) is Some(UnexpectedChar(_, _)),
  )
  assert_true(
    capture(() => parse_unit(cat(), "m^x")) is Some(InvalidExponent(_)),
  )
  assert_true(
    capture(() => parse_unit(cat(), "m extra")) is Some(TrailingInput(_)),
  )
  assert_true(capture(() => parse_unit(cat(), "")) is Some(EmptyInput))
  assert_true(
    capture(() => parse_quantity(cat(), "+ m")) is Some(InvalidNumber(_)),
  )
}

///|
/// Runs a parse and captures any `ParseError` it raises.
fn[T] capture(f : () -> T raise ParseError) -> ParseError? {
  try {
    let _ = f()
    None
  } catch {
    error => Some(error)
  }
}
