///|
/// Charge constructors convert through compatible units.
test "charge constructors" {
  let charge = ampere_hours(1.0)
  assert_true(charge.unit().is_compatible(@electromagnetism.coulomb))
  assert_eq(charge.to(@electromagnetism.coulomb).value(), 3600.0)
}

///|
/// Electrical and magnetic constructors attach compatible units.
test "electrical and magnetic constructors" {
  assert_true(volts(1.0).unit().is_compatible(@electromagnetism.volt))
  assert_true(ohms(1.0).unit().is_compatible(@electromagnetism.ohm))
  assert_true(farads(1.0).unit().is_compatible(@electromagnetism.farad))
  assert_true(teslas(1.0).unit().is_compatible(@electromagnetism.tesla))
}
