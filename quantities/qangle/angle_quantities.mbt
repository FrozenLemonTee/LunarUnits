///|
/// Creates a plane angle quantity in radians.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = radians(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@angle.radian))
/// }
/// ```
pub fn radians(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.radian)
}

///|
/// Creates a plane angle quantity in degrees.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = degrees(180.0)
///   assert_eq(q.value(), 180.0)
///   assert_true(q.unit().is_compatible(@angle.degree))
/// }
/// ```
pub fn degrees(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.degree)
}

///|
/// Creates a plane angle quantity in turns.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = turns(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_true(q.unit().is_compatible(@angle.turn))
/// }
/// ```
pub fn turns(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.turn)
}

///|
/// Creates a plane angle quantity in arcminutes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = arcminutes(60.0)
///   assert_eq(q.value(), 60.0)
///   assert_true(q.unit().is_compatible(@angle.arcminute))
/// }
/// ```
pub fn arcminutes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.arcminute)
}

///|
/// Creates a plane angle quantity in arcseconds.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = arcseconds(3600.0)
///   assert_eq(q.value(), 3600.0)
///   assert_true(q.unit().is_compatible(@angle.arcsecond))
/// }
/// ```
pub fn arcseconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.arcsecond)
}

///|
/// Creates a plane angle quantity in cycles (full turns).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = cycles(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_eq(q.to(@angle.radian).value(), 6.283185307179586)
/// }
/// ```
pub fn cycles(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.cycle)
}

///|
/// Creates a frequency quantity in hertz (cycles per second).
///
/// The unit lives in the angle/time dimension, so the result converts against
/// radians per second, with 1 Hz = 2*pi rad/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = hertz(50.0)
///   assert_eq(q.value(), 50.0)
///   assert_true(q.unit().is_compatible(@angle.hertz))
/// }
/// ```
pub fn hertz(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @angle.hertz)
}
