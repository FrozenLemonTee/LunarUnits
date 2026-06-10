///|
/// Solid angle is independent from SI base dimensions, dimensionless ratios and
/// the plane angle dimension.
test "solid angle dimension is independent" {
  assert_false(solid_angle().is_same(@dimension.Dimension::length()))
  assert_false(solid_angle().is_same(@dimension.Dimension::dimensionless()))
  assert_true(solid_angle().is_same(solid_angle()))
}
