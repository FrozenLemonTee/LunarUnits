///|
/// All seven SI base units are coherent (scale 1).
test "base units are coherent" {
  let units = [meter, kilogram, second, ampere, kelvin, mole, candela]
  for u in units {
    assert_eq(u.scale(), 1.0)
  }
}

///|
/// Each base unit carries the dimension it is meant to measure.
test "base units map to their dimensions" {
  assert_true(meter.dimension().is_same(@dimension.Dimension::length()))
  assert_true(kilogram.dimension().is_same(@dimension.Dimension::mass()))
  assert_true(second.dimension().is_same(@dimension.Dimension::time()))
  assert_true(
    ampere.dimension().is_same(@dimension.Dimension::electric_current()),
  )
  assert_true(kelvin.dimension().is_same(@dimension.Dimension::temperature()))
  assert_true(
    mole.dimension().is_same(@dimension.Dimension::amount_of_substance()),
  )
  assert_true(
    candela.dimension().is_same(@dimension.Dimension::luminous_intensity()),
  )
}

///|
/// Base units compose into derived units (e.g. velocity = m / s).
test "base units compose into derived units" {
  let velocity = meter.div(second)
  let expected = @dimension.Dimension::length().div(
    @dimension.Dimension::time(),
  )
  assert_true(velocity.dimension().is_same(expected))
}
