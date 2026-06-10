///|
/// The steradian (sr), the base unit of solid angle in this extension package.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(steradian.scale(), 1.0)
///   assert_true(steradian.dimension().is_same(square_degree.dimension()))
/// }
/// ```
pub let steradian : @unit.Un = @unit.Un::base(
  "sr",
  @solid_angle_dimension.solid_angle(),
)

///|
/// The square degree (deg^2): (pi / 180)^2 steradians.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(square_degree.is_compatible(steradian))
///   assert_eq(
///     square_degree.conversion_factor(steradian).unwrap(),
///     0.00030461741978670857,
///   )
/// }
/// ```
pub let square_degree : @unit.Un = @unit.Un::scaled(
  "deg^2",
  steradian.dimension(),
  0.00030461741978670857,
)

///|
/// The spat (sp): the full sphere, 4*pi steradians.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(spat.scale(), 12.566370614359172)
///   assert_true(spat.is_compatible(steradian))
/// }
/// ```
pub let spat : @unit.Un = @unit.Un::scaled(
  "sp",
  steradian.dimension(),
  12.566370614359172,
)
