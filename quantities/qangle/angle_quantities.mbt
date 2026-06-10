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
