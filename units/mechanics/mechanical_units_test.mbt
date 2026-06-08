///|
/// The five coherent units are scale 1 and carry the right dimension.
test "coherent units" {
  assert_eq(newton.scale(), 1.0)
  assert_eq(pascal.scale(), 1.0)
  assert_eq(meter_per_second.scale(), 1.0)
  assert_eq(joule.scale(), 1.0)
  assert_eq(watt.scale(), 1.0)
  let force = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length())
    .div(@dimension.Dimension::time().pow(2))
  assert_true(newton.dimension().is_same(force))
}

///|
/// Non-SI units convert to their coherent unit by their scale factor.
test "conversion factors to coherent units" {
  assert_true(kilonewton.conversion_factor(newton) is Some(1000.0))
  assert_true(bar.conversion_factor(pascal) is Some(100000.0))
  assert_true(atmosphere.conversion_factor(pascal) is Some(101325.0))
  assert_true(kilowatt_hour.conversion_factor(joule) is Some(3.6e6))
  assert_true(horsepower.conversion_factor(watt) is Some(745.6998715822702))
}

///|
/// Units within a kind are mutually compatible; units across kinds are not.
test "compatibility within and across kinds" {
  // all pressures are compatible
  assert_true(bar.is_compatible(atmosphere))
  assert_true(psi.is_compatible(kilopascal))
  // force and power are not compatible
  assert_false(newton.is_compatible(watt))
  assert_true(newton.conversion_factor(watt) is None)
}
