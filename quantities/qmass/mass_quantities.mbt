///|
/// Creates a mass quantity in kilograms.
pub fn kilograms(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @si.kilogram)
}

///|
/// Creates a mass quantity in grams.
pub fn grams(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.gram)
}

///|
/// Creates a mass quantity in milligrams.
pub fn milligrams(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.milligram)
}

///|
/// Creates a mass quantity in tonnes.
pub fn tonnes(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.tonne)
}

///|
/// Creates a mass quantity in pounds.
pub fn pounds(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.pound)
}

///|
/// Creates a mass quantity in ounces.
pub fn ounces(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.ounce)
}

///|
/// Creates a density quantity in kilograms per cubic metre.
pub fn kilograms_per_cubic_meter(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.kilogram_per_cubic_meter)
}

///|
/// Creates a density quantity in grams per cubic centimetre.
pub fn grams_per_cubic_centimeter(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @mass.gram_per_cubic_centimeter)
}
