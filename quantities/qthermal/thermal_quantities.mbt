///|
/// Creates a heat-transfer-coefficient quantity in W/(m²·K).
pub fn watts_per_square_meter_kelvin(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.watt_per_square_meter_kelvin)
}

///|
/// Creates a thermal-conductivity quantity in W/(m·K).
pub fn watts_per_meter_kelvin(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.watt_per_meter_kelvin)
}

///|
/// Creates a specific-heat-capacity quantity in J/(kg·K).
pub fn joules_per_kilogram_kelvin(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.joule_per_kilogram_kelvin)
}

///|
/// Creates a heat quantity in British thermal units.
pub fn british_thermal_units(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @thermal.british_thermal_unit)
}
