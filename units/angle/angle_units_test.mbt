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

///|
/// Cycle and hertz derive from the angle dimension: a cycle is a full turn
/// (2*pi rad), and hertz is cycles per second, convertible to radians per
/// second with 1 Hz = 2*pi rad/s.
test "cycle and hertz derive from the angle dimension" {
  assert_true(cycle.is_compatible(radian))
  assert_eq(cycle.conversion_factor(radian).unwrap(), 6.283185307179586)
  assert_eq(cycle.conversion_factor(turn).unwrap(), 1.0)
  let rad_per_second = radian / @si.second
  assert_true(hertz.is_compatible(rad_per_second))
  assert_eq(hertz.conversion_factor(rad_per_second).unwrap(), 6.283185307179586)
}
