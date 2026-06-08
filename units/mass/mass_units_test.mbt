///|
/// Mass units share the mass dimension and convert exactly to the kilogram.
test "mass units" {
  let masses = [gram, milligram, tonne, pound, ounce]
  for u in masses {
    assert_true(u.dimension().is_same(@dimension.Dimension::mass()))
  }
  assert_true(tonne.conversion_factor(@si.kilogram) is Some(1000.0))
  assert_true(pound.conversion_factor(@si.kilogram) is Some(0.45359237))
}

///|
/// Density units share the M·L⁻³ dimension.
test "density units" {
  let density = @dimension.Dimension::mass().div(
    @dimension.Dimension::length().pow(3),
  )
  assert_true(kilogram_per_cubic_meter.dimension().is_same(density))
  assert_true(
    gram_per_cubic_centimeter.conversion_factor(kilogram_per_cubic_meter)
    is Some(1000.0),
  )
}
