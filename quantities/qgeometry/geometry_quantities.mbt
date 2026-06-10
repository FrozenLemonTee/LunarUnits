///|
/// Creates a length quantity in metres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = meters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.meter))
/// }
/// ```
pub fn meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.meter)
}

///|
/// Creates a length quantity in kilometres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilometers(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.kilometer))
/// }
/// ```
pub fn kilometers(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.kilometer)
}

///|
/// Creates a length quantity in centimetres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = centimeters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.centimeter))
/// }
/// ```
pub fn centimeters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.centimeter)
}

///|
/// Creates a length quantity in millimetres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = millimeters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.millimeter))
/// }
/// ```
pub fn millimeters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.millimeter)
}

///|
/// Creates a length quantity in inches.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = inches(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.inch))
/// }
/// ```
pub fn inches(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.inch)
}

///|
/// Creates a length quantity in feet.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = feet(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.foot))
/// }
/// ```
pub fn feet(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.foot)
}

///|
/// Creates a length quantity in miles.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = miles(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.mile))
/// }
/// ```
pub fn miles(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.mile)
}

///|
/// Creates an area quantity in square metres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = square_meters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.square_meter))
/// }
/// ```
pub fn square_meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.square_meter)
}

///|
/// Creates an area quantity in hectares.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = hectares(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.hectare))
/// }
/// ```
pub fn hectares(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.hectare)
}

///|
/// Creates a volume quantity in cubic metres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = cubic_meters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.cubic_meter))
/// }
/// ```
pub fn cubic_meters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.cubic_meter)
}

///|
/// Creates a volume quantity in litres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = liters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.liter))
/// }
/// ```
pub fn liters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.liter)
}

///|
/// Creates a volume quantity in millilitres.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = milliliters(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.milliliter))
/// }
/// ```
pub fn milliliters(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.milliliter)
}

///|
/// Creates a volume quantity in US gallons.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = gallons(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@geometry.gallon))
/// }
/// ```
pub fn gallons(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @geometry.gallon)
}
