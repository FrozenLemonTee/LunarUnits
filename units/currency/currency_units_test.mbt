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
