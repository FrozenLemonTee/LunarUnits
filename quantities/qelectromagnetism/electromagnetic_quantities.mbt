///|
/// Creates an electric-charge quantity in coulombs.
pub fn coulombs(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.coulomb)
}

///|
/// Creates an electric-charge quantity in ampere hours.
pub fn ampere_hours(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.ampere_hour)
}

///|
/// Creates an electric-potential quantity in volts.
pub fn volts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.volt)
}

///|
/// Creates an electric-resistance quantity in ohms.
pub fn ohms(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.ohm)
}

///|
/// Creates an electric-conductance quantity in siemens.
pub fn siemens(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.siemens)
}

///|
/// Creates a capacitance quantity in farads.
pub fn farads(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.farad)
}

///|
/// Creates an inductance quantity in henries.
pub fn henries(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.henry)
}

///|
/// Creates a magnetic-flux quantity in webers.
pub fn webers(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.weber)
}

///|
/// Creates a magnetic-flux-density quantity in teslas.
pub fn teslas(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.tesla)
}
