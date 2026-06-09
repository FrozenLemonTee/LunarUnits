///|
/// Creates a dynamic-viscosity quantity in pascal seconds.
pub fn pascal_seconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.pascal_second)
}

///|
/// Creates a dynamic-viscosity quantity in poise.
pub fn poise(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.poise)
}

///|
/// Creates a dynamic-viscosity quantity in centipoise.
pub fn centipoise(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.centipoise)
}

///|
/// Creates a kinematic-viscosity quantity in square metres per second.
pub fn square_meters_per_second(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.square_meter_per_second)
}

///|
/// Creates a kinematic-viscosity quantity in stokes.
pub fn stokes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.stokes)
}

///|
/// Creates a kinematic-viscosity quantity in centistokes.
pub fn centistokes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.centistokes)
}

///|
/// Creates a permeability quantity in darcy.
pub fn darcies(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @fluid.darcy)
}
