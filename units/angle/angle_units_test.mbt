///|
/// Angle units share the angle dimension and convert through radians.
test "angle unit conversion" {
  assert_true(degree.is_compatible(radian))
  assert_true(turn.is_compatible(radian))
  assert_true(arcminute.is_compatible(degree))
  assert_true(arcsecond.is_compatible(degree))
  assert_eq(degree.conversion_factor(radian).unwrap(), 0.017453292519943295)
  assert_eq(turn.conversion_factor(radian).unwrap(), 6.283185307179586)
  assert_eq(turn.conversion_factor(degree).unwrap(), 360.0)
  assert_eq(arcminute.conversion_factor(degree).unwrap(), 1.0 / 60.0)
  assert_eq(arcsecond.conversion_factor(degree).unwrap(), 1.0 / 3600.0)
}
