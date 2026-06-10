///|
/// The plane angle dimension.
///
/// SI treats the radian as dimensionless, but this extension dimension keeps
/// angles distinct from plain ratios for safer engineering APIs.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(angle().is_same(@dimension.Dimension::dimensionless()))
///   assert_true(angle().is_same(angle()))
/// }
/// ```
pub fn angle() -> @dimension.Dimension {
  @dimension.Dimension::custom("Angle")
}
