///|
/// The SI base unit of length: the metre (m).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(meter.scale(), 1.0)
///   assert_true(meter.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub let meter : @unit.Un = @unit.Un::base("m", @dimension.Dimension::length())

///|
/// The SI base unit of mass: the kilogram (kg). Note that the kilogram, not the
/// gram, is the coherent SI base unit of mass.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilogram.scale(), 1.0)
///   assert_true(kilogram.dimension().is_same(@dimension.Dimension::mass()))
/// }
/// ```
pub let kilogram : @unit.Un = @unit.Un::base("kg", @dimension.Dimension::mass())

///|
/// The SI base unit of time: the second (s).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(second.scale(), 1.0)
///   assert_true(second.dimension().is_same(@dimension.Dimension::time()))
/// }
/// ```
pub let second : @unit.Un = @unit.Un::base("s", @dimension.Dimension::time())

///|
/// The SI base unit of electric current: the ampere (A).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(ampere.scale(), 1.0)
///   assert_true(
///     ampere.dimension().is_same(@dimension.Dimension::electric_current()),
///   )
/// }
/// ```
pub let ampere : @unit.Un = @unit.Un::base(
  "A",
  @dimension.Dimension::electric_current(),
)

///|
/// The SI base unit of thermodynamic temperature: the kelvin (K).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kelvin.scale(), 1.0)
///   assert_true(kelvin.dimension().is_same(@dimension.Dimension::temperature()))
/// }
/// ```
pub let kelvin : @unit.Un = @unit.Un::base(
  "K",
  @dimension.Dimension::temperature(),
)

///|
/// The SI base unit of amount of substance: the mole (mol).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(mole.scale(), 1.0)
///   assert_true(
///     mole.dimension().is_same(@dimension.Dimension::amount_of_substance()),
///   )
/// }
/// ```
pub let mole : @unit.Un = @unit.Un::base(
  "mol",
  @dimension.Dimension::amount_of_substance(),
)

///|
/// The SI base unit of luminous intensity: the candela (cd).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(candela.scale(), 1.0)
///   assert_true(
///     candela.dimension().is_same(@dimension.Dimension::luminous_intensity()),
///   )
/// }
/// ```
pub let candela : @unit.Un = @unit.Un::base(
  "cd",
  @dimension.Dimension::luminous_intensity(),
)
