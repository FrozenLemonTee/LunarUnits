///|
/// Mass constructors preserve values and convert through their unit scales.
test "mass constructors" {
  let m = grams(500.0)
  assert_eq(m.value(), 500.0)
  assert_true(m.dimension().is_same(@dimension.Dimension::mass()))
  assert_eq(m.to(@si.kilogram).value(), 0.5)
}

///|
/// Density constructors attach density units.
test "density constructors" {
  let density = grams_per_cubic_centimeter(1.0)
  let expected = @dimension.Dimension::mass().div(
    @dimension.Dimension::length().pow(3),
  )
  assert_true(density.dimension().is_same(expected))
  assert_eq(density.to(@mass.kilogram_per_cubic_meter).value(), 1000.0)
}
