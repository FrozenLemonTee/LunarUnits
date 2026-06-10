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
/// Creates a mass quantity in kilograms.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilograms(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.kilogram))
/// }
/// ```
pub fn kilograms(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.kilogram)
}

///|
/// Creates a time quantity in seconds.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = seconds(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.second))
/// }
/// ```
pub fn seconds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.second)
}

///|
/// Creates an electric-current quantity in amperes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = amperes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.ampere))
/// }
/// ```
pub fn amperes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.ampere)
}

///|
/// Creates a thermodynamic-temperature quantity in kelvins.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kelvins(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.kelvin))
/// }
/// ```
pub fn kelvins(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.kelvin)
}

///|
/// Creates an amount-of-substance quantity in moles.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = moles(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.mole))
/// }
/// ```
pub fn moles(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.mole)
}

///|
/// Creates a luminous-intensity quantity in candelas.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = candelas(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@si.candela))
/// }
/// ```
pub fn candelas(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.candela)
}
