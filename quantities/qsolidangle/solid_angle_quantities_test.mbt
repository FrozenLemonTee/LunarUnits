///|
/// Solid angle quantity constructors attach compatible solid angle units.
test "solid angle quantity constructors" {
  assert_true(steradians(1.0).unit().is_compatible(@solid_angle.steradian))
  assert_true(spats(1.0).unit().is_compatible(@solid_angle.steradian))
  assert_eq(spats(1.0).to(@solid_angle.steradian).value(), 12.566370614359172)
  assert_eq(
    square_degrees(1.0).to(@solid_angle.steradian).value(),
    0.00030461741978670857,
  )
}
