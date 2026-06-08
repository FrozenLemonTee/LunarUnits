// ----------------------------------------------------------------------------
// Force (dimension M·L·T⁻²)
// ----------------------------------------------------------------------------

///|
/// The newton (N), the coherent SI unit of force: kg·m/s².
///
/// # Example
///
/// ```mbt check
/// test {
///   let force = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length())
///     .div(@dimension.Dimension::time().pow(2))
///   assert_true(newton.dimension().is_same(force))
///   assert_eq(newton.scale(), 1.0)
/// }
/// ```
pub let newton : @unit.Un = @si.kilogram.mul(@si.meter).div(@si.second.pow(2))

///|
/// The kilonewton (kN): 1000 N.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilonewton.scale(), 1000.0)
///   assert_true(kilonewton.is_compatible(newton))
/// }
/// ```
pub let kilonewton : @unit.Un = @unit.Un::scaled(
  "kN",
  newton.dimension(),
  1000.0,
)

///|
/// The dyne (dyn), the CGS unit of force: 1e-5 N.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(dyne.scale(), 1.0e-5)
///   assert_true(dyne.is_compatible(newton))
/// }
/// ```
pub let dyne : @unit.Un = @unit.Un::scaled("dyn", newton.dimension(), 1.0e-5)

// ----------------------------------------------------------------------------
// Pressure (dimension M·L⁻¹·T⁻²)
// ----------------------------------------------------------------------------

///|
/// The pascal (Pa), the coherent SI unit of pressure: N/m².
///
/// # Example
///
/// ```mbt check
/// test {
///   let pressure = @dimension.Dimension::mass()
///     .div(@dimension.Dimension::length())
///     .div(@dimension.Dimension::time().pow(2))
///   assert_true(pascal.dimension().is_same(pressure))
///   assert_eq(pascal.scale(), 1.0)
/// }
/// ```
pub let pascal : @unit.Un = newton.div(@si.meter.pow(2))

///|
/// The kilopascal (kPa): 1000 Pa.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilopascal.scale(), 1000.0)
///   assert_true(kilopascal.is_compatible(pascal))
/// }
/// ```
pub let kilopascal : @unit.Un = @unit.Un::scaled(
  "kPa",
  pascal.dimension(),
  1000.0,
)

///|
/// The bar: 100000 Pa.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(bar.scale(), 100000.0)
///   assert_true(bar.is_compatible(pascal))
/// }
/// ```
pub let bar : @unit.Un = @unit.Un::scaled("bar", pascal.dimension(), 100000.0)

///|
/// The standard atmosphere (atm): 101325 Pa.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(atmosphere.scale(), 101325.0)
///   assert_true(atmosphere.is_compatible(pascal))
/// }
/// ```
pub let atmosphere : @unit.Un = @unit.Un::scaled(
  "atm",
  pascal.dimension(),
  101325.0,
)

///|
/// The pound per square inch (psi): about 6894.757 Pa.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(psi.scale(), 6894.757293168361)
///   assert_true(psi.is_compatible(pascal))
/// }
/// ```
pub let psi : @unit.Un = @unit.Un::scaled(
  "psi",
  pascal.dimension(),
  6894.757293168361,
)

// ----------------------------------------------------------------------------
// Velocity (dimension L·T⁻¹)
// ----------------------------------------------------------------------------

///|
/// The metre per second (m/s), the coherent SI unit of velocity.
///
/// # Example
///
/// ```mbt check
/// test {
///   let velocity = @dimension.Dimension::length().div(
///     @dimension.Dimension::time(),
///   )
///   assert_true(meter_per_second.dimension().is_same(velocity))
///   assert_eq(meter_per_second.scale(), 1.0)
/// }
/// ```
pub let meter_per_second : @unit.Un = @si.meter.div(@si.second)

///|
/// The kilometre per hour (km/h): 1000/3600 m/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilometer_per_hour.scale(), 1000.0 / 3600.0)
///   assert_true(kilometer_per_hour.is_compatible(meter_per_second))
/// }
/// ```
pub let kilometer_per_hour : @unit.Un = @unit.Un::scaled(
  "km/h",
  meter_per_second.dimension(),
  1000.0 / 3600.0,
)

///|
/// The mile per hour (mph): 1609.344/3600 m/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(mile_per_hour.scale(), 1609.344 / 3600.0)
///   assert_true(mile_per_hour.is_compatible(meter_per_second))
/// }
/// ```
pub let mile_per_hour : @unit.Un = @unit.Un::scaled(
  "mph",
  meter_per_second.dimension(),
  1609.344 / 3600.0,
)

// ----------------------------------------------------------------------------
// Energy (dimension M·L²·T⁻²)
// ----------------------------------------------------------------------------

///|
/// The joule (J), the coherent SI unit of energy: N·m.
///
/// # Example
///
/// ```mbt check
/// test {
///   let energy = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(2))
///   assert_true(joule.dimension().is_same(energy))
///   assert_eq(joule.scale(), 1.0)
/// }
/// ```
pub let joule : @unit.Un = newton.mul(@si.meter)

///|
/// The kilojoule (kJ): 1000 J.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilojoule.scale(), 1000.0)
///   assert_true(kilojoule.is_compatible(joule))
/// }
/// ```
pub let kilojoule : @unit.Un = @unit.Un::scaled("kJ", joule.dimension(), 1000.0)

///|
/// The kilowatt hour (kWh): 3.6e6 J.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilowatt_hour.scale(), 3.6e6)
///   assert_true(kilowatt_hour.is_compatible(joule))
/// }
/// ```
pub let kilowatt_hour : @unit.Un = @unit.Un::scaled(
  "kWh",
  joule.dimension(),
  3.6e6,
)

///|
/// The thermochemical calorie (cal): 4.184 J.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(calorie.scale(), 4.184)
///   assert_true(calorie.is_compatible(joule))
/// }
/// ```
pub let calorie : @unit.Un = @unit.Un::scaled("cal", joule.dimension(), 4.184)

// ----------------------------------------------------------------------------
// Power (dimension M·L²·T⁻³)
// ----------------------------------------------------------------------------

///|
/// The watt (W), the coherent SI unit of power: J/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   let power = @dimension.Dimension::mass()
///     .mul(@dimension.Dimension::length().pow(2))
///     .div(@dimension.Dimension::time().pow(3))
///   assert_true(watt.dimension().is_same(power))
///   assert_eq(watt.scale(), 1.0)
/// }
/// ```
pub let watt : @unit.Un = joule.div(@si.second)

///|
/// The kilowatt (kW): 1000 W.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilowatt.scale(), 1000.0)
///   assert_true(kilowatt.is_compatible(watt))
/// }
/// ```
pub let kilowatt : @unit.Un = @unit.Un::scaled("kW", watt.dimension(), 1000.0)

///|
/// The mechanical horsepower (hp): about 745.7 W.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(horsepower.scale(), 745.6998715822702)
///   assert_true(horsepower.is_compatible(watt))
/// }
/// ```
pub let horsepower : @unit.Un = @unit.Un::scaled(
  "hp",
  watt.dimension(),
  745.6998715822702,
)
