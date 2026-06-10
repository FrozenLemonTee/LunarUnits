///|
/// Same-currency units share the currency dimension and convert through
/// dollars.
test "currency unit conversion" {
  assert_true(cent.is_compatible(dollar))
  assert_true(kilodollar.is_compatible(dollar))
  assert_true(megadollar.is_compatible(dollar))
  assert_eq(dollar.conversion_factor(cent).unwrap(), 100.0)
  assert_eq(kilodollar.conversion_factor(dollar).unwrap(), 1000.0)
  assert_eq(megadollar.conversion_factor(kilodollar).unwrap(), 1000.0)
}

///|
/// `at_rate` always produces a currency-dimension unit: compatible with the
/// built-in currency units, but never with a unit of another dimension.
test "at_rate stays in the currency dimension" {
  let euro = at_rate("EUR", 1.08)
  assert_true(euro.is_compatible(dollar))
  assert_true(euro.is_compatible(cent))
  assert_eq(euro.conversion_factor(dollar).unwrap(), 1.08)
  // A unit in another dimension is never compatible with a currency unit.
  let meter = @unit.Un::base("m", @dimension.Dimension::length())
  assert_false(euro.is_compatible(meter))
}
