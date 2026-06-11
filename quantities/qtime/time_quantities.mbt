///|
/// Creates a duration in minutes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = minutes(90.0)
///   assert_eq(q.value(), 90.0)
///   assert_true(q.unit().is_compatible(@time.hour))
/// }
/// ```
pub fn minutes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @time.minute)
}

///|
/// Creates a duration in hours.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(hours(2.0).value(), 2.0)
/// }
/// ```
pub fn hours(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @time.hour)
}

///|
/// Creates a duration in days.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(days(1.0).value(), 1.0)
/// }
/// ```
pub fn days(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @time.day)
}

///|
/// Creates a duration in milliseconds.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(milliseconds(250.0).value(), 250.0)
/// }
/// ```
pub fn milliseconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @time.millisecond)
}

///|
/// Creates a duration in microseconds.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(microseconds(5.0).value(), 5.0)
/// }
/// ```
pub fn microseconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @time.microsecond)
}

///|
/// Creates a duration in nanoseconds.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(nanoseconds(40.0).value(), 40.0)
/// }
/// ```
pub fn nanoseconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @time.nanosecond)
}
