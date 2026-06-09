///|
/// Force constructors preserve values and attach force-compatible units.
test "force constructors" {
  let force = kilonewtons(2.0)
  assert_eq(force.value(), 2.0)
  assert_true(force.unit().is_compatible(@mechanics.newton))
  assert_eq(force.to(@mechanics.newton).value(), 2000.0)
}

///|
/// Pressure constructors attach pressure units.
test "pressure constructors" {
  let pressure = bars(1.0)
  assert_eq(pressure.value(), 1.0)
  assert_true(pressure.unit().is_compatible(@mechanics.pascal))
  assert_eq(pressure.to(@mechanics.pascal).value(), 100000.0)
}

///|
/// Velocity constructors attach L/T units.
test "velocity constructors" {
  let velocity = meters_per_second(3.0)
  let expected = @dimension.Dimension::length().div(
    @dimension.Dimension::time(),
  )
  assert_true(velocity.dimension().is_same(expected))
}

///|
/// Energy and power constructors attach their expected dimensions.
test "energy and power constructors" {
  let energy = kilojoules(3.0)
  assert_true(energy.unit().is_compatible(@mechanics.joule))
  assert_eq(energy.to(@mechanics.joule).value(), 3000.0)
  let power = watts(4.0)
  assert_true(power.unit().is_compatible(@mechanics.watt))
}
