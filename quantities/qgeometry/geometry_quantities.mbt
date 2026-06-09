///|
/// Creates a length quantity in metres.
pub fn meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.meter)
}

///|
/// Creates a length quantity in kilometres.
pub fn kilometers(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.kilometer)
}

///|
/// Creates a length quantity in centimetres.
pub fn centimeters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.centimeter)
}

///|
/// Creates a length quantity in millimetres.
pub fn millimeters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.millimeter)
}

///|
/// Creates a length quantity in inches.
pub fn inches(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.inch)
}

///|
/// Creates a length quantity in feet.
pub fn feet(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.foot)
}

///|
/// Creates a length quantity in miles.
pub fn miles(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.mile)
}

///|
/// Creates an area quantity in square metres.
pub fn square_meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.square_meter)
}

///|
/// Creates an area quantity in hectares.
pub fn hectares(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.hectare)
}

///|
/// Creates a volume quantity in cubic metres.
pub fn cubic_meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.cubic_meter)
}

///|
/// Creates a volume quantity in litres.
pub fn liters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.liter)
}

///|
/// Creates a volume quantity in millilitres.
pub fn milliliters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.milliliter)
}

///|
/// Creates a volume quantity in US gallons.
pub fn gallons(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.gallon)
}
