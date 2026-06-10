///|
/// Creates a count quantity in items (the each unit).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = counts(5.0)
///   assert_eq(q.value(), 5.0)
///   assert_true(q.unit().is_compatible(@count.each))
/// }
/// ```
pub fn counts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @count.each)
}

///|
/// Creates a count quantity in dozens.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = dozens(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_eq(q.to(@count.each).value(), 12.0)
/// }
/// ```
pub fn dozens(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @count.dozen)
}

///|
/// Creates a count quantity in grosses (144 items).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = grosses(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_eq(q.to(@count.each).value(), 144.0)
/// }
/// ```
pub fn grosses(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @count.gross)
}
