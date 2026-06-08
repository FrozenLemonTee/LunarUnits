// ----------------------------------------------------------------------------
// Mass (dimension M). The coherent SI unit is the kilogram (in si).
// ----------------------------------------------------------------------------

///|
/// The gram (g): 0.001 kg.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gram.scale(), 0.001)
///   assert_true(gram.dimension().is_same(@dimension.Dimension::mass()))
/// }
/// ```
pub let gram : @unit.Un = @unit.Un::scaled("g", @si.kilogram.dimension(), 0.001)

///|
/// The milligram (mg): 1e-6 kg.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(milligram.scale(), 1.0e-6)
///   assert_true(milligram.dimension().is_same(@dimension.Dimension::mass()))
/// }
/// ```
pub let milligram : @unit.Un = @unit.Un::scaled(
  "mg",
  @si.kilogram.dimension(),
  1.0e-6,
)

///|
/// The tonne (t): 1000 kg.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(tonne.scale(), 1000.0)
///   assert_true(tonne.dimension().is_same(@dimension.Dimension::mass()))
/// }
/// ```
pub let tonne : @unit.Un = @unit.Un::scaled(
  "t",
  @si.kilogram.dimension(),
  1000.0,
)

///|
/// The pound (lb): exactly 0.45359237 kg.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(pound.scale(), 0.45359237)
///   assert_true(pound.dimension().is_same(@dimension.Dimension::mass()))
/// }
/// ```
pub let pound : @unit.Un = @unit.Un::scaled(
  "lb",
  @si.kilogram.dimension(),
  0.45359237,
)

///|
/// The ounce (oz): exactly 0.028349523125 kg.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(ounce.scale(), 0.028349523125)
///   assert_true(ounce.dimension().is_same(@dimension.Dimension::mass()))
/// }
/// ```
pub let ounce : @unit.Un = @unit.Un::scaled(
  "oz",
  @si.kilogram.dimension(),
  0.028349523125,
)

// ----------------------------------------------------------------------------
// Density (dimension M·L⁻³)
// ----------------------------------------------------------------------------

///|
/// The kilogram per cubic metre (kg/m³), the coherent SI unit of density.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilogram_per_cubic_meter.scale(), 1.0)
///   let density = @dimension.Dimension::mass().div(
///     @dimension.Dimension::length().pow(3),
///   )
///   assert_true(kilogram_per_cubic_meter.dimension().is_same(density))
/// }
/// ```
pub let kilogram_per_cubic_meter : @unit.Un = @si.kilogram.div(@si.meter.pow(3))

///|
/// The gram per cubic centimetre (g/cm³): 1000 kg/m³.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gram_per_cubic_centimeter.scale(), 1000.0)
///   assert_true(gram_per_cubic_centimeter.is_compatible(kilogram_per_cubic_meter))
/// }
/// ```
pub let gram_per_cubic_centimeter : @unit.Un = @unit.Un::scaled(
  "g/cm³",
  kilogram_per_cubic_meter.dimension(),
  1000.0,
)
