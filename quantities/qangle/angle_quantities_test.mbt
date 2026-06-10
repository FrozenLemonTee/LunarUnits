///|
/// Angle quantity constructors attach compatible angle units.
test "angle quantity constructors" {
  assert_true(radians(1.0).unit().is_compatible(@angle.radian))
  assert_true(degrees(180.0).unit().is_compatible(@angle.radian))
  assert_eq(degrees(180.0).to(@angle.radian).value(), 3.141592653589793)
  assert_eq(turns(1.0).to(@angle.degree).value(), 360.0)
  assert_eq(arcminutes(60.0).to(@angle.degree).value(), 1.0)
  assert_eq(arcseconds(3600.0).to(@angle.degree).value(), 1.0)
}

///|
/// Cycle and hertz constructors attach the matching angle-derived units.
test "cycle and hertz quantity constructors" {
  assert_eq(cycles(1.0).to(@angle.radian).value(), 6.283185307179586)
  assert_true(hertz(50.0).unit().is_compatible(@angle.hertz))
}
