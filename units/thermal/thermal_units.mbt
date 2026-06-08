// ----------------------------------------------------------------------------
// Heat transfer coefficient (dimension M·T⁻³·Θ⁻¹), i.e. W/(m²·K)
// ----------------------------------------------------------------------------

///|
/// The watt per square metre kelvin (W/(m²·K)), the coherent SI unit of heat
/// transfer coefficient.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(watt_per_square_meter_kelvin.scale(), 1.0)
///   let htc = @dimension.Dimension::mass()
///     .div(@dimension.Dimension::time().pow(3))
///     .div(@dimension.Dimension::temperature())
///   assert_true(watt_per_square_meter_kelvin.dimension().is_same(htc))
/// }
/// ```
pub let watt_per_square_meter_kelvin : @unit.Un = @si.kilogram
  .div(@si.second.pow(3))
  .div(@si.kelvin)

// ----------------------------------------------------------------------------
// Thermal conductivity (dimension M·L·T⁻³·Θ⁻¹), i.e. W/(m·K)
// ----------------------------------------------------------------------------

///|
/// The watt per metre kelvin (W/(m·K)), the coherent SI unit of thermal
/// conductivity.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(watt_per_meter_kelvin.scale(), 1.0)
///   let conductivity = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length())
///     .div(@dimension.Dimension::time().pow(3))
///     .div(@dimension.Dimension::temperature())
///   assert_true(watt_per_meter_kelvin.dimension().is_same(conductivity))
/// }
/// ```
pub let watt_per_meter_kelvin : @unit.Un = @si.kilogram
  .mul(@si.meter)
  .div(@si.second.pow(3))
  .div(@si.kelvin)

// ----------------------------------------------------------------------------
// Specific heat capacity (dimension L²·T⁻²·Θ⁻¹), i.e. J/(kg·K)
// ----------------------------------------------------------------------------

///|
/// The joule per kilogram kelvin (J/(kg·K)), the coherent SI unit of specific
/// heat capacity.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(joule_per_kilogram_kelvin.scale(), 1.0)
///   let specific_heat = @dimension.Dimension::length()
///     .pow(2)
///     .div(@dimension.Dimension::time().pow(2))
///     .div(@dimension.Dimension::temperature())
///   assert_true(joule_per_kilogram_kelvin.dimension().is_same(specific_heat))
/// }
/// ```
pub let joule_per_kilogram_kelvin : @unit.Un = @si.meter
  .pow(2)
  .div(@si.second.pow(2))
  .div(@si.kelvin)

// ----------------------------------------------------------------------------
// Heat / energy (dimension M·L²·T⁻²)
// ----------------------------------------------------------------------------

///|
/// The British thermal unit (BTU), a unit of heat: about 1055.06 J.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(british_thermal_unit.scale(), 1055.05585262)
///   let energy = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(2))
///   assert_true(british_thermal_unit.dimension().is_same(energy))
/// }
/// ```
pub let british_thermal_unit : @unit.Un = @unit.Un::scaled(
  "BTU",
  @si.kilogram.mul(@si.meter.pow(2)).div(@si.second.pow(2)).dimension(),
  1055.05585262,
)
