///|
/// The count (discrete entity) dimension.
///
/// Counts of discrete items sit deliberately outside the SI base dimensions,
/// and in particular are distinct from amount of substance (the mole). Modeling
/// counts as their own dimension lets LunarUnits express engineering rates such
/// as throughput (count / time) and defect density (count / area) without
/// collapsing them into plain dimensionless numbers.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(count().is_same(@dimension.Dimension::dimensionless()))
///   assert_true(count().is_same(count()))
/// }
/// ```
pub fn count() -> @dimension.Dimension {
  @dimension.Dimension::custom("Count")
}
