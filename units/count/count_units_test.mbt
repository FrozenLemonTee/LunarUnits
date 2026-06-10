///|
/// Count units share the count dimension and convert through the each unit.
test "count unit conversion" {
  assert_true(dozen.is_compatible(each))
  assert_true(gross.is_compatible(each))
  assert_eq(dozen.conversion_factor(each).unwrap(), 12.0)
  assert_eq(gross.conversion_factor(each).unwrap(), 144.0)
  assert_eq(gross.conversion_factor(dozen).unwrap(), 12.0)
}
