///|
/// Solid angle units share the solid angle dimension and convert through
/// steradians.
test "solid angle unit conversion" {
  assert_true(square_degree.is_compatible(steradian))
  assert_true(spat.is_compatible(steradian))
  assert_eq(spat.conversion_factor(steradian).unwrap(), 12.566370614359172)
  assert_eq(
    square_degree.conversion_factor(steradian).unwrap(),
    0.00030461741978670857,
  )
}
