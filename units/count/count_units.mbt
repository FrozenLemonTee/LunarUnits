///|
/// The each (ea), the base unit of count: a single discrete item.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(each.scale(), 1.0)
///   assert_true(each.dimension().is_same(dozen.dimension()))
/// }
/// ```
pub let each : @unit.Un = @unit.Un::base("ea", @count_dimension.count())

///|
/// The dozen (doz): 12 items.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(dozen.scale(), 12.0)
///   assert_true(dozen.is_compatible(each))
/// }
/// ```
pub let dozen : @unit.Un = @unit.Un::scaled("doz", each.dimension(), 12.0)

///|
/// The gross (gr): 144 items, a dozen dozen.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gross.scale(), 144.0)
///   assert_eq(gross.conversion_factor(dozen).unwrap(), 12.0)
/// }
/// ```
pub let gross : @unit.Un = @unit.Un::scaled("gr", each.dimension(), 144.0)
