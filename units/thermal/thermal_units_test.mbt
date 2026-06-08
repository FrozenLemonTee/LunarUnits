///|
/// Heat transfer coefficient: M·T⁻³·Θ⁻¹.
test "heat transfer coefficient" {
  let htc = @dimension.Dimension::mass()
    .div(@dimension.Dimension::time().pow(3))
    .div(@dimension.Dimension::temperature())
  assert_true(watt_per_square_meter_kelvin.dimension().is_same(htc))
  assert_eq(watt_per_square_meter_kelvin.scale(), 1.0)
}

///|
/// Thermal conductivity: M·L·T⁻³·Θ⁻¹.
test "thermal conductivity" {
  let conductivity = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length())
    .div(@dimension.Dimension::time().pow(3))
    .div(@dimension.Dimension::temperature())
  assert_true(watt_per_meter_kelvin.dimension().is_same(conductivity))
}

///|
/// Specific heat capacity: L²·T⁻²·Θ⁻¹.
test "specific heat capacity" {
  let specific_heat = @dimension.Dimension::length()
    .pow(2)
    .div(@dimension.Dimension::time().pow(2))
    .div(@dimension.Dimension::temperature())
  assert_true(joule_per_kilogram_kelvin.dimension().is_same(specific_heat))
}

///|
/// The BTU shares the energy dimension and carries its scale.
test "british thermal unit" {
  let energy = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length().pow(2))
    .div(@dimension.Dimension::time().pow(2))
  assert_true(british_thermal_unit.dimension().is_same(energy))
  assert_eq(british_thermal_unit.scale(), 1055.05585262)
}
