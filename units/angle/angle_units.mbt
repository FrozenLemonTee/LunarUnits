///|
/// The radian (rad), the base unit of plane angle in this extension package.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(radian.scale(), 1.0)
///   assert_true(radian.dimension().is_same(degree.dimension()))
/// }
/// ```
pub let radian : @unit.Un = @unit.Un::base("rad", @angle_dimension.angle())

///|
/// The degree (deg): pi / 180 radians.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(degree.scale(), 0.017453292519943295)
///   assert_true(degree.is_compatible(radian))
/// }
/// ```
pub let degree : @unit.Un = @unit.Un::scaled(
  "deg",
  radian.dimension(),
  0.017453292519943295,
)

///|
/// The full turn (turn): 2*pi radians.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(turn.scale(), 6.283185307179586)
///   assert_true(turn.is_compatible(radian))
/// }
/// ```
pub let turn : @unit.Un = @unit.Un::scaled(
  "turn",
  radian.dimension(),
  6.283185307179586,
)

///|
/// The arcminute (arcmin): 1 / 60 degree.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(arcminute.is_compatible(degree))
///   assert_eq(arcminute.conversion_factor(degree).unwrap(), 1.0 / 60.0)
/// }
/// ```
pub let arcminute : @unit.Un = @unit.Un::scaled(
  "arcmin",
  radian.dimension(),
  0.0002908882086657216,
)

///|
/// The arcsecond (arcsec): 1 / 3600 degree.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(arcsecond.is_compatible(degree))
///   assert_eq(arcsecond.conversion_factor(degree).unwrap(), 1.0 / 3600.0)
/// }
/// ```
pub let arcsecond : @unit.Un = @unit.Un::scaled(
  "arcsec",
  radian.dimension(),
  0.00000484813681109536,
)
