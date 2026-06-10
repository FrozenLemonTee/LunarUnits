///|
/// Information is independent from the SI base dimensions.
test "information dimension is independent" {
  assert_false(information().is_same(@dimension.Dimension::length()))
  assert_false(information().is_same(@dimension.Dimension::time()))
  assert_true(information().is_same(information()))
}
