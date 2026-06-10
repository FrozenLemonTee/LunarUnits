///|
/// The bit (bit), the base unit of information in this extension package.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(bit.scale(), 1.0)
///   assert_true(bit.dimension().is_same(byte.dimension()))
/// }
/// ```
pub let bit : @unit.Un = @unit.Un::base(
  "bit",
  @information_dimension.information(),
)

///|
/// The byte (B): 8 bits.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(byte.scale(), 8.0)
///   assert_true(byte.is_compatible(bit))
/// }
/// ```
pub let byte : @unit.Un = @unit.Un::scaled("B", bit.dimension(), 8.0)

///|
/// The kilobyte (KB): 1000 bytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kilobyte.scale(), 8000.0)
///   assert_true(kilobyte.is_compatible(byte))
/// }
/// ```
pub let kilobyte : @unit.Un = @unit.Un::scaled("KB", bit.dimension(), 8000.0)

///|
/// The megabyte (MB): 1000 kilobytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(megabyte.scale(), 8.0e6)
///   assert_true(megabyte.is_compatible(byte))
/// }
/// ```
pub let megabyte : @unit.Un = @unit.Un::scaled("MB", bit.dimension(), 8.0e6)

///|
/// The gigabyte (GB): 1000 megabytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gigabyte.scale(), 8.0e9)
///   assert_true(gigabyte.is_compatible(byte))
/// }
/// ```
pub let gigabyte : @unit.Un = @unit.Un::scaled("GB", bit.dimension(), 8.0e9)

///|
/// The kibibyte (KiB): 1024 bytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(kibibyte.scale(), 8192.0)
///   assert_true(kibibyte.is_compatible(byte))
/// }
/// ```
pub let kibibyte : @unit.Un = @unit.Un::scaled("KiB", bit.dimension(), 8192.0)

///|
/// The mebibyte (MiB): 1024 kibibytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(mebibyte.scale(), 8388608.0)
///   assert_true(mebibyte.is_compatible(byte))
/// }
/// ```
pub let mebibyte : @unit.Un = @unit.Un::scaled(
  "MiB",
  bit.dimension(),
  8388608.0,
)

///|
/// The gibibyte (GiB): 1024 mebibytes.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(gibibyte.scale(), 8589934592.0)
///   assert_true(gibibyte.is_compatible(byte))
/// }
/// ```
pub let gibibyte : @unit.Un = @unit.Un::scaled(
  "GiB",
  bit.dimension(),
  8589934592.0,
)
