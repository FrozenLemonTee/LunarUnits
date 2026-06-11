///|
/// Constructors produce quantities on the time dimension that convert by their
/// second-relative scales.
test "time constructors compose and convert" {
  assert_eq(hours(2.0).to(@time.minute).value(), 120.0)
  assert_eq(days(1.0).to(@time.hour).value(), 24.0)
  assert_eq(minutes(90.0).to(@time.hour).value(), 1.5)
  assert_eq(milliseconds(250.0).value(), 250.0)
  assert_true(nanoseconds(1.0).unit().is_compatible(@time.hour))
}
