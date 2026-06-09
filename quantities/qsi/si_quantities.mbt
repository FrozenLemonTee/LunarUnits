///|
/// Creates a length quantity in metres.
pub fn meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.meter)
}

///|
/// Creates a mass quantity in kilograms.
pub fn kilograms(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.kilogram)
}

///|
/// Creates a time quantity in seconds.
pub fn seconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.second)
}

///|
/// Creates an electric-current quantity in amperes.
pub fn amperes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.ampere)
}

///|
/// Creates a thermodynamic-temperature quantity in kelvins.
pub fn kelvins(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.kelvin)
}

///|
/// Creates an amount-of-substance quantity in moles.
pub fn moles(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.mole)
}

///|
/// Creates a luminous-intensity quantity in candelas.
pub fn candelas(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.candela)
}
