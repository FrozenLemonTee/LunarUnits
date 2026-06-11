///|
/// All time units share the time dimension and scale to the second.
test "time units scale to the second" {
  assert_eq(minute.scale(), 60.0)
  assert_eq(hour.scale(), 3600.0)
  assert_eq(day.scale(), 86400.0)
  assert_eq(millisecond.scale(), 1.0e-3)
  assert_eq(microsecond.scale(), 1.0e-6)
  assert_eq(nanosecond.scale(), 1.0e-9)
  for unit in [minute, hour, day, millisecond, microsecond, nanosecond] {
    assert_true(unit.dimension().is_same(@dimension.Dimension::time()))
  }
}

///|
/// Conversions between time units follow the second-relative scales.
test "convert between time units" {
  // 2 hours is 7200 seconds.
  let two_hours = @quantity.Quantity::new(2.0, hour)
  assert_eq(two_hours.to(@si.second).value(), 7200.0)
  // 90 minutes is 1.5 hours.
  let ninety_min = @quantity.Quantity::new(90.0, minute)
  assert_eq(ninety_min.to(hour).value(), 1.5)
  // 1 day is 24 hours.
  assert_eq(@quantity.Quantity::new(1.0, day).to(hour).value(), 24.0)
}
