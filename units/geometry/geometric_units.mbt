// ----------------------------------------------------------------------------
// Length (dimension L)
// ----------------------------------------------------------------------------

///|
/// The kilometre (km): 1000 m.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilometer.scale(), 1000.0)
///   assert_true(kilometer.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let kilometer : @unit.Un = @unit.Un::scaled(
  "km",
  @si.meter.dimension(),
  1000.0,
)

///|
/// The centimetre (cm): 0.01 m.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(centimeter.scale(), 0.01)
///   assert_true(centimeter.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let centimeter : @unit.Un = @unit.Un::scaled(
  "cm",
  @si.meter.dimension(),
  0.01,
)

///|
/// The millimetre (mm): 0.001 m.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(millimeter.scale(), 0.001)
///   assert_true(millimeter.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let millimeter : @unit.Un = @unit.Un::scaled(
  "mm",
  @si.meter.dimension(),
  0.001,
)

///|
/// The inch (in): exactly 0.0254 m.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(inch.scale(), 0.0254)
///   assert_true(inch.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let inch : @unit.Un = @unit.Un::scaled("in", @si.meter.dimension(), 0.0254)

///|
/// The foot (ft): exactly 0.3048 m.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(foot.scale(), 0.3048)
///   assert_true(foot.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let foot : @unit.Un = @unit.Un::scaled("ft", @si.meter.dimension(), 0.3048)

///|
/// The mile (mi): exactly 1609.344 m.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(mile.scale(), 1609.344)
///   assert_true(mile.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let mile : @unit.Un = @unit.Un::scaled(
  "mi",
  @si.meter.dimension(),
  1609.344,
)

// ----------------------------------------------------------------------------
// Area (dimension L²)
// ----------------------------------------------------------------------------

///|
/// The square metre (m²), the coherent SI unit of area.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(square_meter.scale(), 1.0)
///   assert_true(
///     square_meter.dimension().is_same(@dimension.Dimension::length().pow(2)),
///   )
/// }
/// ```
pub let square_meter : @unit.Un = @si.meter.pow(2)

///|
/// The hectare (ha): 10000 m².
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(hectare.scale(), 10000.0)
///   assert_true(hectare.is_compatible(square_meter))
/// }
/// ```
pub let hectare : @unit.Un = @unit.Un::scaled(
  "ha",
  square_meter.dimension(),
  10000.0,
)

// ----------------------------------------------------------------------------
// Volume (dimension L³)
// ----------------------------------------------------------------------------

///|
/// The cubic metre (m³), the coherent SI unit of volume.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(cubic_meter.scale(), 1.0)
///   assert_true(
///     cubic_meter.dimension().is_same(@dimension.Dimension::length().pow(3)),
///   )
/// }
/// ```
pub let cubic_meter : @unit.Un = @si.meter.pow(3)

///|
/// The litre (L): 0.001 m³.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(liter.scale(), 0.001)
///   assert_true(liter.is_compatible(cubic_meter))
/// }
/// ```
pub let liter : @unit.Un = @unit.Un::scaled("L", cubic_meter.dimension(), 0.001)

///|
/// The millilitre (mL): 1e-6 m³.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(milliliter.scale(), 1.0e-6)
///   assert_true(milliliter.is_compatible(cubic_meter))
/// }
/// ```
pub let milliliter : @unit.Un = @unit.Un::scaled(
  "mL",
  cubic_meter.dimension(),
  1.0e-6,
)

///|
/// The US gallon (gal): exactly 0.003785411784 m³.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gallon.scale(), 0.003785411784)
///   assert_true(gallon.is_compatible(cubic_meter))
/// }
/// ```
pub let gallon : @unit.Un = @unit.Un::scaled(
  "gal",
  cubic_meter.dimension(),
  0.003785411784,
)
