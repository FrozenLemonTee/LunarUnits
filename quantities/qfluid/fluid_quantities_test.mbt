///|
/// Dynamic-viscosity constructors attach compatible units.
test "dynamic viscosity constructors" {
  let viscosity = centipoise(1.0)
  assert_true(viscosity.unit().is_compatible(@fluid.pascal_second))
  assert_eq(viscosity.to(@fluid.pascal_second).value(), 0.001)
}

///|
/// Kinematic-viscosity and permeability constructors attach the expected dimensions.
test "kinematic viscosity and permeability constructors" {
  let kinematic = centistokes(1.0)
  let kinematic_dim = @dimension.Dimension::length()
    .pow(2)
    .div(@dimension.Dimension::time())
  assert_true(kinematic.dimension().is_same(kinematic_dim))
  let permeability = darcies(1.0)
  assert_true(
    permeability.dimension().is_same(@dimension.Dimension::length().pow(2)),
  )
}
