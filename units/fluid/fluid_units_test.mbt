///|
/// Dynamic viscosity units share the M·L⁻¹·T⁻¹ dimension.
test "dynamic viscosity" {
  let viscosity = @dimension.Dimension::mass()
    .div(@dimension.Dimension::length())
    .div(@dimension.Dimension::time())
  assert_true(pascal_second.dimension().is_same(viscosity))
  assert_true(poise.conversion_factor(pascal_second) is Some(0.1))
  assert_true(centipoise.conversion_factor(pascal_second) is Some(0.001))
}

///|
/// Kinematic viscosity units share the L²·T⁻¹ dimension.
test "kinematic viscosity" {
  let viscosity = @dimension.Dimension::length()
    .pow(2)
    .div(@dimension.Dimension::time())
  assert_true(square_meter_per_second.dimension().is_same(viscosity))
  assert_true(stokes.conversion_factor(square_meter_per_second) is Some(1.0e-4))
}

///|
/// Permeability has the dimension of area (L²).
test "permeability" {
  assert_true(darcy.dimension().is_same(@dimension.Dimension::length().pow(2)))
  assert_eq(darcy.scale(), 9.869233e-13)
}
