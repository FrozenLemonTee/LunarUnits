///|
/// The information dimension.
///
/// This extension dimension is intentionally outside `core/dimension`, so the
/// core SI dimension model stays focused on the seven SI base dimensions while
/// domain packages can still define additional dimensions.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(information().is_same(@dimension.Dimension::length()))
///   assert_true(information().is_same(information()))
/// }
/// ```
pub fn information() -> @dimension.Dimension {
  @dimension.Dimension::custom("Info")
}
