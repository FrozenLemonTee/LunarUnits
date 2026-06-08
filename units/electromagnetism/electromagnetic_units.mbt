// ----------------------------------------------------------------------------
// Electric charge (dimension I·T)
// ----------------------------------------------------------------------------

///|
/// The coulomb (C), the coherent SI unit of electric charge: A·s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(coulomb.scale(), 1.0)
///   let charge = @dimension.Dimension::electric_current().mul(
///     @dimension.Dimension::time(),
///   )
///   assert_true(coulomb.dimension().is_same(charge))
/// }
/// ```
pub let coulomb : @unit.Un = @si.ampere.mul(@si.second)

///|
/// The ampere hour (Ah): 3600 C.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(ampere_hour.scale(), 3600.0)
///   assert_true(ampere_hour.is_compatible(coulomb))
/// }
/// ```
pub let ampere_hour : @unit.Un = @unit.Un::scaled(
  "Ah",
  coulomb.dimension(),
  3600.0,
)

// ----------------------------------------------------------------------------
// Electric potential (dimension M·L²·T⁻³·I⁻¹)
// ----------------------------------------------------------------------------

///|
/// The volt (V), the coherent SI unit of electric potential: W/A.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(volt.scale(), 1.0)
///   let potential = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(3))
///     .div(@dimension.Dimension::electric_current())
///   assert_true(volt.dimension().is_same(potential))
/// }
/// ```
pub let volt : @unit.Un = @si.kilogram
  .mul(@si.meter.pow(2))
  .div(@si.second.pow(3))
  .div(@si.ampere)

// ----------------------------------------------------------------------------
// Electric resistance (dimension M·L²·T⁻³·I⁻²)
// ----------------------------------------------------------------------------

///|
/// The ohm (Ω), the coherent SI unit of electric resistance: V/A.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(ohm.scale(), 1.0)
///   let resistance = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(3))
///     .div(@dimension.Dimension::electric_current().pow(2))
///   assert_true(ohm.dimension().is_same(resistance))
/// }
/// ```
pub let ohm : @unit.Un = @si.kilogram
  .mul(@si.meter.pow(2))
  .div(@si.second.pow(3))
  .div(@si.ampere.pow(2))

// ----------------------------------------------------------------------------
// Electric conductance (dimension M⁻¹·L⁻²·T³·I²)
// ----------------------------------------------------------------------------

///|
/// The siemens (S), the coherent SI unit of electric conductance: 1/Ω.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(siemens.scale(), 1.0)
///   assert_true(siemens.is_compatible(ohm.pow(-1)))
/// }
/// ```
pub let siemens : @unit.Un = @si.ampere
  .pow(2)
  .mul(@si.second.pow(3))
  .div(@si.kilogram)
  .div(@si.meter.pow(2))

// ----------------------------------------------------------------------------
// Capacitance (dimension M⁻¹·L⁻²·T⁴·I²)
// ----------------------------------------------------------------------------

///|
/// The farad (F), the coherent SI unit of capacitance: C/V.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(farad.scale(), 1.0)
///   let capacitance = @dimension.Dimension::electric_current()
///     .pow(2)
///     .mul(@dimension.Dimension::time().pow(4))
///     .div(@dimension.Dimension::mass())
///     .div(@dimension.Dimension::length().pow(2))
///   assert_true(farad.dimension().is_same(capacitance))
/// }
/// ```
pub let farad : @unit.Un = @si.ampere
  .pow(2)
  .mul(@si.second.pow(4))
  .div(@si.kilogram)
  .div(@si.meter.pow(2))

// ----------------------------------------------------------------------------
// Inductance (dimension M·L²·T⁻²·I⁻²)
// ----------------------------------------------------------------------------

///|
/// The henry (H), the coherent SI unit of inductance: V·s/A.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(henry.scale(), 1.0)
///   let inductance = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(2))
///     .div(@dimension.Dimension::electric_current().pow(2))
///   assert_true(henry.dimension().is_same(inductance))
/// }
/// ```
pub let henry : @unit.Un = @si.kilogram
  .mul(@si.meter.pow(2))
  .div(@si.second.pow(2))
  .div(@si.ampere.pow(2))

// ----------------------------------------------------------------------------
// Magnetic flux (dimension M·L²·T⁻²·I⁻¹)
// ----------------------------------------------------------------------------

///|
/// The weber (Wb), the coherent SI unit of magnetic flux: V·s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(weber.scale(), 1.0)
///   let flux = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(2))
///     .div(@dimension.Dimension::electric_current())
///   assert_true(weber.dimension().is_same(flux))
/// }
/// ```
pub let weber : @unit.Un = @si.kilogram
  .mul(@si.meter.pow(2))
  .div(@si.second.pow(2))
  .div(@si.ampere)

// ----------------------------------------------------------------------------
// Magnetic flux density (dimension M·T⁻²·I⁻¹)
// ----------------------------------------------------------------------------

///|
/// The tesla (T), the coherent SI unit of magnetic flux density: Wb/m².
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(tesla.scale(), 1.0)
///   let flux_density = @dimension.Dimension::mass()
///     .div(@dimension.Dimension::time().pow(2))
///     .div(@dimension.Dimension::electric_current())
///   assert_true(tesla.dimension().is_same(flux_density))
/// }
/// ```
pub let tesla : @unit.Un = @si.kilogram.div(@si.second.pow(2)).div(@si.ampere)
