///|
/// Information quantity constructors attach compatible information units.
test "information quantity constructors" {
  assert_true(bits(8.0).unit().is_compatible(@information.bit))
  assert_true(bytes(1.0).unit().is_compatible(@information.bit))
  assert_eq(bytes(1.0).to(@information.bit).value(), 8.0)
  assert_eq(kibibytes(1.0).to(@information.byte).value(), 1024.0)
  assert_eq(gigabytes(1.0).to(@information.byte).value(), 1.0e9)
}
