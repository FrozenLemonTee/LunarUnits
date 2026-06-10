///|
/// The solid angle dimension.
///
/// SI treats the steradian as dimensionless, but this extension dimension keeps
/// solid angles distinct from plain ratios. It pairs naturally with the plane
/// angle dimension for radiometry and photometry APIs (for example luminous
/// flux as luminous intensity times solid angle).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(solid_angle().is_same(@dimension.Dimension::dimensionless()))
///   assert_true(solid_angle().is_same(solid_angle()))
/// }
/// ```
pub fn solid_angle() -> @dimension.Dimension {
  @dimension.Dimension::custom("SolidAngle")
}
