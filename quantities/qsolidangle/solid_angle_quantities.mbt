///|
/// Creates a solid angle quantity in steradians.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = steradians(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@solid_angle.steradian))
/// }
/// ```
pub fn steradians(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @solid_angle.steradian)
}

///|
/// Creates a solid angle quantity in square degrees.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = square_degrees(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_true(q.unit().is_compatible(@solid_angle.steradian))
/// }
/// ```
pub fn square_degrees(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @solid_angle.square_degree)
}

///|
/// Creates a solid angle quantity in spats (full spheres).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = spats(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_true(q.unit().is_compatible(@solid_angle.steradian))
/// }
/// ```
pub fn spats(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @solid_angle.spat)
}
