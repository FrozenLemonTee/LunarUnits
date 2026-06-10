///|
/// The currency dimension.
///
/// Money is not an SI dimension, but treating it as an extension dimension lets
/// LunarUnits catch errors in engineering-economics APIs, such as confusing a
/// total cost with a unit price (money / quantity) or a cost rate
/// (money / time).
///
/// Conversions between units of the *same* currency (for example dollars and
/// cents) are fixed and modeled here. Exchange rates between *different*
/// currencies are time-varying and intentionally not built in; inject a current
/// rate with `@unit.Un::scaled` when one is needed.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(currency().is_same(@dimension.Dimension::dimensionless()))
///   assert_true(currency().is_same(currency()))
/// }
/// ```
pub fn currency() -> @dimension.Dimension {
  @dimension.Dimension::custom("Currency")
}
