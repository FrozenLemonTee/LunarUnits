///|
/// Information units share the information dimension and convert through bits.
test "information unit conversion" {
  assert_true(byte.is_compatible(bit))
  assert_true(kibibyte.is_compatible(bit))
  assert_true(gigabyte.is_compatible(bit))
  assert_true(byte.conversion_factor(bit) is Some(8.0))
  assert_true(kibibyte.conversion_factor(byte) is Some(1024.0))
  assert_true(gigabyte.conversion_factor(byte) is Some(1.0e9))
}
