// Temperature presets: the affine units on the thermodynamic-temperature
// dimension, anchored to the kelvin. These are the first users of the generic
// `AffineUn`/`Point` machinery; callers can define their own affine scales the
// same way with `AffineUn::new`.

///|
/// The kelvin (K): the absolute base scale (scale 1, offset 0). Using it as an
/// affine unit makes kelvin readings interoperate with celsius/fahrenheit
/// points.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(273.15, kelvin).to(celsius).value(), 0.0)
/// }
/// ```
pub let kelvin : AffineUn = AffineUn::new("K", @si.kelvin, 1.0, 0.0)

///|
/// Degrees Celsius (°C): same size as a kelvin, with `0 °C = 273.15 K`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(0.0, celsius).to_base().value(), 273.15)
/// }
/// ```
pub let celsius : AffineUn = AffineUn::new("°C", @si.kelvin, 1.0, 273.15)

///|
/// Degrees Fahrenheit (°F): `T_K = (T_F - 32) * 5/9 + 273.15`, i.e. scale 5/9
/// and offset `273.15 - 32 * 5/9`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(32.0, fahrenheit).to_base().value(), 273.15)
///   assert_eq(Point::new(212.0, fahrenheit).to(celsius).value(), 100.0)
/// }
/// ```
pub let fahrenheit : AffineUn = AffineUn::new(
  "°F",
  @si.kelvin,
  5.0 / 9.0,
  273.15 - 32.0 * 5.0 / 9.0,
)

///|
/// Degrees Rankine (°R): an absolute scale with Fahrenheit-sized degrees
/// (scale 5/9, offset 0), so `0 °R = 0 K = absolute zero`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(0.0, rankine).to_base().value(), 0.0)
/// }
/// ```
pub let rankine : AffineUn = AffineUn::new("°R", @si.kelvin, 5.0 / 9.0, 0.0)
