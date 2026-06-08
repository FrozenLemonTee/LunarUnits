///|
/// Length units share the length dimension and have the expected scale.
test "length units" {
  let lengths = [kilometer, centimeter, millimeter, inch, foot, mile]
  for u in lengths {
    assert_true(u.dimension().is_same(@dimension.Dimension::length()))
  }
  // Exact conversions to the coherent metre (scale 1).
  assert_true(kilometer.conversion_factor(@si.meter) is Some(1000.0))
  assert_true(inch.conversion_factor(@si.meter) is Some(0.0254))
  assert_true(mile.conversion_factor(@si.meter) is Some(1609.344))
}

///|
/// Area units share the L² dimension.
test "area units" {
  assert_true(
    square_meter.dimension().is_same(@dimension.Dimension::length().pow(2)),
  )
  assert_true(hectare.is_compatible(square_meter))
  assert_true(hectare.conversion_factor(square_meter) is Some(10000.0))
}

///|
/// Volume units share the L³ dimension.
test "volume units" {
  assert_true(
    cubic_meter.dimension().is_same(@dimension.Dimension::length().pow(3)),
  )
  assert_true(liter.is_compatible(cubic_meter))
  assert_true(gallon.conversion_factor(cubic_meter) is Some(0.003785411784))
}
