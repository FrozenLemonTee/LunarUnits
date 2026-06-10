///|
/// Creates a heat-transfer-coefficient quantity in W/(m^2*K).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = watts_per_square_meter_kelvin(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@thermal.watt_per_square_meter_kelvin))
/// }
/// ```
pub fn watts_per_square_meter_kelvin(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.watt_per_square_meter_kelvin)
}

///|
/// Creates a thermal-conductivity quantity in W/(m*K).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = watts_per_meter_kelvin(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@thermal.watt_per_meter_kelvin))
/// }
/// ```
pub fn watts_per_meter_kelvin(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.watt_per_meter_kelvin)
}

///|
/// Creates a specific-heat-capacity quantity in J/(kg*K).
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = joules_per_kilogram_kelvin(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@thermal.joule_per_kilogram_kelvin))
/// }
/// ```
pub fn joules_per_kilogram_kelvin(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.joule_per_kilogram_kelvin)
}

///|
/// Creates a heat quantity in British thermal units.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = british_thermal_units(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@thermal.british_thermal_unit))
/// }
/// ```
pub fn british_thermal_units(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.british_thermal_unit)
}
