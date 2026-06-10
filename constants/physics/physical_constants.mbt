///|
/// Speed of light in vacuum: exactly 299792458 m/s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(speed_of_light.value(), 299792458.0)
///   assert_true(speed_of_light.unit().is_compatible(@si.meter / @si.second))
/// }
/// ```
pub let speed_of_light : @quantity.Quantity = @quantity.Quantity::new(
  299792458.0,
  @si.meter / @si.second,
)

///|
/// Standard gravity: exactly 9.80665 m/s^2.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(standard_gravity.value(), 9.80665)
///   assert_true(
///     standard_gravity.unit().is_compatible(@si.meter / @si.second.pow(2)),
///   )
/// }
/// ```
pub let standard_gravity : @quantity.Quantity = @quantity.Quantity::new(
  9.80665,
  @si.meter / @si.second.pow(2),
)

///|
/// Newtonian constant of gravitation: 6.67430e-11 m^3/(kg*s^2).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gravitational_constant.value(), 6.67430e-11)
///   let expected = @si.meter.pow(3) / (@si.kilogram * @si.second.pow(2))
///   assert_true(gravitational_constant.unit().is_compatible(expected))
/// }
/// ```
pub let gravitational_constant : @quantity.Quantity = @quantity.Quantity::new(
  6.67430e-11,
  @si.meter.pow(3) / (@si.kilogram * @si.second.pow(2)),
)

///|
/// Planck constant: exactly 6.62607015e-34 J*s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(planck_constant.value(), 6.62607015e-34)
///   assert_true(
///     planck_constant.unit().is_compatible(@mechanics.joule * @si.second),
///   )
/// }
/// ```
pub let planck_constant : @quantity.Quantity = @quantity.Quantity::new(
  6.62607015e-34,
  @mechanics.joule * @si.second,
)

///|
/// Avogadro constant: exactly 6.02214076e23 mol^-1.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(avogadro_constant.value(), 6.02214076e23)
///   assert_true(avogadro_constant.unit().is_compatible(@si.mole.pow(-1)))
/// }
/// ```
pub let avogadro_constant : @quantity.Quantity = @quantity.Quantity::new(
  6.02214076e23,
  @si.mole.pow(-1),
)

///|
/// Boltzmann constant: exactly 1.380649e-23 J/K.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(boltzmann_constant.value(), 1.380649e-23)
///   assert_true(
///     boltzmann_constant.unit().is_compatible(@mechanics.joule / @si.kelvin),
///   )
/// }
/// ```
pub let boltzmann_constant : @quantity.Quantity = @quantity.Quantity::new(
  1.380649e-23,
  @mechanics.joule / @si.kelvin,
)
