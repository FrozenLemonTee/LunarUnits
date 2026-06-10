///|
/// Count is independent from amount of substance and from dimensionless ratios.
test "count dimension is independent" {
  assert_false(count().is_same(@dimension.Dimension::amount_of_substance()))
  assert_false(count().is_same(@dimension.Dimension::dimensionless()))
  assert_true(count().is_same(count()))
}
