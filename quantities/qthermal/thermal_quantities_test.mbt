///|
/// Thermal constructors attach representative thermal dimensions.
test "thermal constructors" {
  let conductivity = watts_per_meter_kelvin(1.0)
  let conductivity_dim = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length())
    .div(@dimension.Dimension::time().pow(3))
    .div(@dimension.Dimension::temperature())
  assert_true(conductivity.dimension().is_same(conductivity_dim))
  let heat = british_thermal_units(1.0)
  let energy_dim = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length().pow(2))
    .div(@dimension.Dimension::time().pow(2))
  assert_true(heat.dimension().is_same(energy_dim))
}
