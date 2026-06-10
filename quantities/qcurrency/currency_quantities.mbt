///|
/// Creates a currency quantity in dollars.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = dollars(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@currency.dollar))
/// }
/// ```
pub fn dollars(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @currency.dollar)
}

///|
/// Creates a currency quantity in cents.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = cents(100.0)
///   assert_eq(q.value(), 100.0)
///   assert_eq(q.to(@currency.dollar).value(), 1.0)
/// }
/// ```
pub fn cents(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @currency.cent)
}

///|
/// Creates a currency quantity in kilodollars (k$).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilodollars(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_eq(q.to(@currency.dollar).value(), 1000.0)
/// }
/// ```
pub fn kilodollars(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @currency.kilodollar)
}

///|
/// Creates a currency quantity in megadollars (M$).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = megadollars(1.0)
///   assert_eq(q.value(), 1.0)
///   assert_eq(q.to(@currency.dollar).value(), 1.0e6)
/// }
/// ```
pub fn megadollars(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @currency.megadollar)
}
