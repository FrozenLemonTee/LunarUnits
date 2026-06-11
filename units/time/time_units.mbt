// ----------------------------------------------------------------------------
// Time durations (dimension T) — fixed multiples of the second.
//
// The second itself lives in `units/si`. Months, years and longer are excluded:
// their length is not constant, so they are not simple scaled units.
// ----------------------------------------------------------------------------

///|
/// The minute (min): 60 s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(minute.scale(), 60.0)
///   assert_true(minute.dimension().is_same(@dimension.Dimension::time()))
/// }
/// ```
pub let minute : @unit.Un = @unit.Un::scaled(
  "min",
  @si.second.dimension(),
  60.0,
)

///|
/// The hour (h): 3600 s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(hour.scale(), 3600.0)
///   assert_true(hour.is_compatible(@si.second))
/// }
/// ```
pub let hour : @unit.Un = @unit.Un::scaled("h", @si.second.dimension(), 3600.0)

///|
/// The day (d): 86400 s (exactly 24 hours; no leap seconds).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(day.scale(), 86400.0)
///   assert_true(day.is_compatible(@si.second))
/// }
/// ```
pub let day : @unit.Un = @unit.Un::scaled("d", @si.second.dimension(), 86400.0)

///|
/// The millisecond (ms): 1e-3 s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(millisecond.scale(), 1.0e-3)
///   assert_true(millisecond.is_compatible(@si.second))
/// }
/// ```
pub let millisecond : @unit.Un = @unit.Un::scaled(
  "ms",
  @si.second.dimension(),
  1.0e-3,
)

///|
/// The microsecond (µs): 1e-6 s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(microsecond.scale(), 1.0e-6)
///   assert_true(microsecond.is_compatible(@si.second))
/// }
/// ```
pub let microsecond : @unit.Un = @unit.Un::scaled(
  "µs",
  @si.second.dimension(),
  1.0e-6,
)

///|
/// The nanosecond (ns): 1e-9 s.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(nanosecond.scale(), 1.0e-9)
///   assert_true(nanosecond.is_compatible(@si.second))
/// }
/// ```
pub let nanosecond : @unit.Un = @unit.Un::scaled(
  "ns",
  @si.second.dimension(),
  1.0e-9,
)
