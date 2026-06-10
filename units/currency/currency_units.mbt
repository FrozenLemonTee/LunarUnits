///|
/// The dollar ($), the base unit of currency in this extension package.
///
/// The dollar is an arbitrary unit of account: it anchors the fixed
/// subdivisions below. To work in another currency, define its base unit with
/// `@unit.Un::base` and relate currencies with `@unit.Un::scaled` using a
/// current exchange rate.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(dollar.scale(), 1.0)
///   assert_true(dollar.dimension().is_same(cent.dimension()))
/// }
/// ```
pub let dollar : @unit.Un = @unit.Un::base("$", @currency_dimension.currency())

///|
/// The cent: 1 / 100 dollar.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(cent.scale(), 0.01)
///   assert_eq(dollar.conversion_factor(cent).unwrap(), 100.0)
/// }
/// ```
pub let cent : @unit.Un = @unit.Un::scaled("cent", dollar.dimension(), 0.01)

///|
/// The kilodollar (k$): 1000 dollars, a common engineering-budget unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilodollar.scale(), 1000.0)
///   assert_true(kilodollar.is_compatible(dollar))
/// }
/// ```
pub let kilodollar : @unit.Un = @unit.Un::scaled(
  "k$",
  dollar.dimension(),
  1000.0,
)

///|
/// The megadollar (M$): one million dollars.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(megadollar.scale(), 1.0e6)
///   assert_true(megadollar.is_compatible(dollar))
/// }
/// ```
pub let megadollar : @unit.Un = @unit.Un::scaled(
  "M$",
  dollar.dimension(),
  1.0e6,
)
