///|
/// Length constructors preserve the value and attach length-compatible units.
test "length constructors" {
  let distance = kilometers(2.0)
  assert_eq(distance.value(), 2.0)
  assert_true(distance.unit().is_compatible(@si.meter))
  assert_eq(distance.to(@si.meter).value(), 2000.0)
}

///|
/// Area constructors attach area units.
test "area constructors" {
  let area = hectares(1.0)
  assert_eq(area.value(), 1.0)
  assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
  assert_eq(area.to(@geometry.square_meter).value(), 10000.0)
}

///|
/// Volume constructors attach volume units.
test "volume constructors" {
  let volume = liters(2.0)
  assert_eq(volume.value(), 2.0)
  assert_true(volume.dimension().is_same(@dimension.Dimension::length().pow(3)))
  assert_eq(volume.to(@geometry.cubic_meter).value(), 0.002)
}
