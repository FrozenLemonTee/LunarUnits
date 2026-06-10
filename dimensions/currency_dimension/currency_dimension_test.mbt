///|
/// Currency is independent from SI base dimensions and dimensionless ratios.
test "currency dimension is independent" {
  assert_false(currency().is_same(@dimension.Dimension::amount_of_substance()))
  assert_false(currency().is_same(@dimension.Dimension::dimensionless()))
  assert_true(currency().is_same(currency()))
}
