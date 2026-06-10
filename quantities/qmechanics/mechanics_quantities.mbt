///|
/// Creates a force quantity in newtons.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = newtons(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.newton))
/// }
/// ```
pub fn newtons(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.newton)
}

///|
/// Creates a force quantity in kilonewtons.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilonewtons(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.kilonewton))
/// }
/// ```
pub fn kilonewtons(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilonewton)
}

///|
/// Creates a force quantity in dynes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = dynes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.dyne))
/// }
/// ```
pub fn dynes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.dyne)
}

///|
/// Creates a pressure quantity in pascals.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = pascals(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.pascal))
/// }
/// ```
pub fn pascals(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.pascal)
}

///|
/// Creates a pressure quantity in kilopascals.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilopascals(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.kilopascal))
/// }
/// ```
pub fn kilopascals(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilopascal)
}

///|
/// Creates a pressure quantity in bar.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = bars(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.bar))
/// }
/// ```
pub fn bars(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.bar)
}

///|
/// Creates a pressure quantity in standard atmospheres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = atmospheres(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.atmosphere))
/// }
/// ```
pub fn atmospheres(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.atmosphere)
}

///|
/// Creates a pressure quantity in pounds per square inch.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = psi(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.psi))
/// }
/// ```
pub fn psi(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.psi)
}

///|
/// Creates a velocity quantity in metres per second.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = meters_per_second(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.meter_per_second))
/// }
/// ```
pub fn meters_per_second(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.meter_per_second)
}

///|
/// Creates a velocity quantity in kilometres per hour.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilometers_per_hour(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.kilometer_per_hour))
/// }
/// ```
pub fn kilometers_per_hour(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilometer_per_hour)
}

///|
/// Creates a velocity quantity in miles per hour.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = miles_per_hour(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.mile_per_hour))
/// }
/// ```
pub fn miles_per_hour(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.mile_per_hour)
}

///|
/// Creates an energy quantity in joules.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = joules(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.joule))
/// }
/// ```
pub fn joules(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.joule)
}

///|
/// Creates an energy quantity in kilojoules.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilojoules(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.kilojoule))
/// }
/// ```
pub fn kilojoules(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilojoule)
}

///|
/// Creates an energy quantity in kilowatt hours.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilowatt_hours(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.kilowatt_hour))
/// }
/// ```
pub fn kilowatt_hours(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilowatt_hour)
}

///|
/// Creates an energy quantity in thermochemical calories.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = calories(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.calorie))
/// }
/// ```
pub fn calories(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.calorie)
}

///|
/// Creates a power quantity in watts.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = watts(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.watt))
/// }
/// ```
pub fn watts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.watt)
}

///|
/// Creates a power quantity in kilowatts.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilowatts(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.kilowatt))
/// }
/// ```
pub fn kilowatts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.kilowatt)
}

///|
/// Creates a power quantity in mechanical horsepower.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = horsepower(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mechanics.horsepower))
/// }
/// ```
pub fn horsepower(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mechanics.horsepower)
}
