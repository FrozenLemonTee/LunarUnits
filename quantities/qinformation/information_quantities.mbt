///|
/// Creates an information quantity in bits.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = bits(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.bit))
/// }
/// ```
pub fn bits(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.bit)
}

///|
/// Creates an information quantity in bytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = bytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.byte))
/// }
/// ```
pub fn bytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.byte)
}

///|
/// Creates an information quantity in kilobytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilobytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.kilobyte))
/// }
/// ```
pub fn kilobytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.kilobyte)
}

///|
/// Creates an information quantity in megabytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = megabytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.megabyte))
/// }
/// ```
pub fn megabytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.megabyte)
}

///|
/// Creates an information quantity in gigabytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = gigabytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.gigabyte))
/// }
/// ```
pub fn gigabytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.gigabyte)
}

///|
/// Creates an information quantity in kibibytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kibibytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.kibibyte))
/// }
/// ```
pub fn kibibytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.kibibyte)
}

///|
/// Creates an information quantity in mebibytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = mebibytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.mebibyte))
/// }
/// ```
pub fn mebibytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.mebibyte)
}

///|
/// Creates an information quantity in gibibytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = gibibytes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@information.gibibyte))
/// }
/// ```
pub fn gibibytes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @information.gibibyte)
}
