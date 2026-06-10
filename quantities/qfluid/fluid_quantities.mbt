///|
/// Creates a dynamic-viscosity quantity in pascal seconds.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = pascal_seconds(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.pascal_second))
/// }
/// ```
pub fn pascal_seconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.pascal_second)
}

///|
/// Creates a dynamic-viscosity quantity in poise.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = poise(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.poise))
/// }
/// ```
pub fn poise(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.poise)
}

///|
/// Creates a dynamic-viscosity quantity in centipoise.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = centipoise(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.centipoise))
/// }
/// ```
pub fn centipoise(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.centipoise)
}

///|
/// Creates a kinematic-viscosity quantity in square metres per second.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = square_meters_per_second(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.square_meter_per_second))
/// }
/// ```
pub fn square_meters_per_second(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.square_meter_per_second)
}

///|
/// Creates a kinematic-viscosity quantity in stokes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = stokes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.stokes))
/// }
/// ```
pub fn stokes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.stokes)
}

///|
/// Creates a kinematic-viscosity quantity in centistokes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = centistokes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.centistokes))
/// }
/// ```
pub fn centistokes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.centistokes)
}

///|
/// Creates a permeability quantity in darcy.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = darcies(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@fluid.darcy))
/// }
/// ```
pub fn darcies(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.darcy)
}
