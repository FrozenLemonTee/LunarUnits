///|
/// Angle is independent from both SI base dimensions and plain dimensionless
/// ratios.
test "angle dimension is independent" {
  assert_false(angle().is_same(@dimension.Dimension::length()))
  assert_false(angle().is_same(@dimension.Dimension::dimensionless()))
  assert_true(angle().is_same(angle()))
}
