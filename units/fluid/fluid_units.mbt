// ----------------------------------------------------------------------------
// Dynamic viscosity (dimension M·L⁻¹·T⁻¹)
// ----------------------------------------------------------------------------

///|
/// The pascal second (Pa·s), the coherent SI unit of dynamic viscosity.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(pascal_second.scale(), 1.0)
///   let viscosity = @dimension.Dimension::mass()
///     .div(@dimension.Dimension::length())
///     .div(@dimension.Dimension::time())
///   assert_true(pascal_second.dimension().is_same(viscosity))
/// }
/// ```
pub let pascal_second : @unit.Un = @si.kilogram.div(@si.meter).div(@si.second)

///|
/// The poise (P), the CGS unit of dynamic viscosity: 0.1 Pa·s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(poise.scale(), 0.1)
///   assert_true(poise.is_compatible(pascal_second))
/// }
/// ```
pub let poise : @unit.Un = @unit.Un::scaled("P", pascal_second.dimension(), 0.1)

///|
/// The centipoise (cP): 0.001 Pa·s (the dynamic viscosity of water near 20°C).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(centipoise.scale(), 0.001)
///   assert_true(centipoise.is_compatible(pascal_second))
/// }
/// ```
pub let centipoise : @unit.Un = @unit.Un::scaled(
  "cP",
  pascal_second.dimension(),
  0.001,
)

// ----------------------------------------------------------------------------
// Kinematic viscosity (dimension L²·T⁻¹)
// ----------------------------------------------------------------------------

///|
/// The square metre per second (m²/s), the coherent SI unit of kinematic
/// viscosity.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(square_meter_per_second.scale(), 1.0)
///   let viscosity = @dimension.Dimension::length()
///     .pow(2)
///     .div(@dimension.Dimension::time())
///   assert_true(square_meter_per_second.dimension().is_same(viscosity))
/// }
/// ```
pub let square_meter_per_second : @unit.Un = @si.meter.pow(2).div(@si.second)

///|
/// The stokes (St), the CGS unit of kinematic viscosity: 1e-4 m²/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(stokes.scale(), 1.0e-4)
///   assert_true(stokes.is_compatible(square_meter_per_second))
/// }
/// ```
pub let stokes : @unit.Un = @unit.Un::scaled(
  "St",
  square_meter_per_second.dimension(),
  1.0e-4,
)

///|
/// The centistokes (cSt): 1e-6 m²/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(centistokes.scale(), 1.0e-6)
///   assert_true(centistokes.is_compatible(square_meter_per_second))
/// }
/// ```
pub let centistokes : @unit.Un = @unit.Un::scaled(
  "cSt",
  square_meter_per_second.dimension(),
  1.0e-6,
)

// ----------------------------------------------------------------------------
// Permeability (dimension L²)
// ----------------------------------------------------------------------------

///|
/// The darcy (D), a unit of fluid permeability: about 9.869233e-13 m².
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(darcy.scale(), 9.869233e-13)
///   assert_true(darcy.dimension().is_same(@dimension.Dimension::length().pow(2)))
/// }
/// ```
pub let darcy : @unit.Un = @unit.Un::scaled(
  "D",
  @si.meter.pow(2).dimension(),
  9.869233e-13,
)
