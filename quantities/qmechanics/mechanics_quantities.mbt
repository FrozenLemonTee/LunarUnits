///|
/// Creates a force quantity in newtons.
pub fn newtons(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.newton)
}

///|
/// Creates a force quantity in kilonewtons.
pub fn kilonewtons(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilonewton)
}

///|
/// Creates a force quantity in dynes.
pub fn dynes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.dyne)
}

///|
/// Creates a pressure quantity in pascals.
pub fn pascals(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.pascal)
}

///|
/// Creates a pressure quantity in kilopascals.
pub fn kilopascals(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilopascal)
}

///|
/// Creates a pressure quantity in bar.
pub fn bars(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.bar)
}

///|
/// Creates a pressure quantity in standard atmospheres.
pub fn atmospheres(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.atmosphere)
}

///|
/// Creates a pressure quantity in pounds per square inch.
pub fn psi(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.psi)
}

///|
/// Creates a velocity quantity in metres per second.
pub fn meters_per_second(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.meter_per_second)
}

///|
/// Creates a velocity quantity in kilometres per hour.
pub fn kilometers_per_hour(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilometer_per_hour)
}

///|
/// Creates a velocity quantity in miles per hour.
pub fn miles_per_hour(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.mile_per_hour)
}

///|
/// Creates an energy quantity in joules.
pub fn joules(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.joule)
}

///|
/// Creates an energy quantity in kilojoules.
pub fn kilojoules(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilojoule)
}

///|
/// Creates an energy quantity in kilowatt hours.
pub fn kilowatt_hours(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilowatt_hour)
}

///|
/// Creates an energy quantity in thermochemical calories.
pub fn calories(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.calorie)
}

///|
/// Creates a power quantity in watts.
pub fn watts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.watt)
}

///|
/// Creates a power quantity in kilowatts.
pub fn kilowatts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilowatt)
}

///|
/// Creates a power quantity in mechanical horsepower.
pub fn horsepower(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.horsepower)
}
