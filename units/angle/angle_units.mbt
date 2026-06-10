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

///|
/// One cycle (cycle): a full revolution, 2*pi radians. This is the same angle
/// as `turn`, named separately for frequency contexts where "cycles per second"
/// (hertz) is the natural reading.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(cycle.scale(), 6.283185307179586)
///   assert_eq(cycle.conversion_factor(radian).unwrap(), 6.283185307179586)
///   assert_eq(cycle.conversion_factor(turn).unwrap(), 1.0)
/// }
/// ```
pub let cycle : @unit.Un = @unit.Un::scaled(
  "cycle",
  radian.dimension(),
  6.283185307179586,
)

///|
/// The hertz (Hz): one cycle per second.
///
/// Because angle is an extension dimension here, hertz lives in the angle/time
/// dimension rather than plain 1/time. That is deliberate: a frequency then
/// converts against radians per second, with 1 Hz = 2*pi rad/s, so a frequency
/// f and the angular frequency omega relate by omega = 2*pi*f as an ordinary
/// conversion. Pure event rates and sample rates do not belong here; model
/// those with count/time or a dimensionless rate instead.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(hertz.is_compatible(radian / @si.second))
///   assert_eq(
///     hertz.conversion_factor(radian / @si.second).unwrap(),
///     6.283185307179586,
///   )
/// }
/// ```
pub let hertz : @unit.Un = @unit.Un::scaled(
  "Hz",
  radian.dimension() / @si.second.dimension(),
  6.283185307179586,
)
