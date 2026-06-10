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
/// Creates a mass quantity in grams.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = grams(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.gram))
/// }
/// ```
pub fn grams(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.gram)
}

///|
/// Creates a mass quantity in milligrams.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = milligrams(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.milligram))
/// }
/// ```
pub fn milligrams(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.milligram)
}

///|
/// Creates a mass quantity in tonnes.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = tonnes(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.tonne))
/// }
/// ```
pub fn tonnes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.tonne)
}

///|
/// Creates a mass quantity in pounds.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = pounds(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.pound))
/// }
/// ```
pub fn pounds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.pound)
}

///|
/// Creates a mass quantity in ounces.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = ounces(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.ounce))
/// }
/// ```
pub fn ounces(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.ounce)
}

///|
/// Creates a density quantity in kilograms per cubic metre.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = kilograms_per_cubic_meter(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.kilogram_per_cubic_meter))
/// }
/// ```
pub fn kilograms_per_cubic_meter(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.kilogram_per_cubic_meter)
}

///|
/// Creates a density quantity in grams per cubic centimetre.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = grams_per_cubic_centimeter(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@mass.gram_per_cubic_centimeter))
/// }
/// ```
pub fn grams_per_cubic_centimeter(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.gram_per_cubic_centimeter)
}
