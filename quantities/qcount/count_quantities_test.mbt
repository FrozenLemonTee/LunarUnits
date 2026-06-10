///|
/// Count quantity constructors attach compatible count units.
test "count quantity constructors" {
  assert_true(counts(1.0).unit().is_compatible(@count.each))
  assert_eq(dozens(1.0).to(@count.each).value(), 12.0)
  assert_eq(grosses(1.0).to(@count.each).value(), 144.0)
  assert_eq(grosses(1.0).to(@count.dozen).value(), 12.0)
}
