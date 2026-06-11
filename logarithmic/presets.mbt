// Common logarithmic scales and units. Power and root-power (field) decibels
// are distinct scales (factor 10 vs 20); the neper uses the natural logarithm.

///|
/// Power decibels: `value = 10 * log10(P / P_ref)`. Use for power-like
/// quantities (power, intensity).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(decibel_power.factor(), 10.0)
///   assert_eq(decibel_power.log_base(), 10.0)
/// }
/// ```
pub let decibel_power : LogScale = LogScale::new("dB", 10.0, 10.0)

///|
/// Root-power (field) decibels: `value = 20 * log10(X / X_ref)`. Use for
/// root-power quantities (voltage, current, pressure), since power is
/// proportional to their square.
///
/// # Example
///
/// ```mbt check
/// test {
///   // A field gain of 20 dB is a ten-fold amplitude ratio.
///   assert_eq(Gain::new(20.0, decibel_field).ratio(), 10.0)
/// }
/// ```
pub let decibel_field : LogScale = LogScale::new("dB", 20.0, 10.0)

///|
/// Nepers: natural-logarithm root-power ratios, `value = ln(X / X_ref)`.
///
/// # Example
///
/// ```mbt check
/// test {
///   // 1 Np is a ratio of e.
///   assert_eq(Gain::new(1.0, neper).ratio(), @math.exp(1.0))
/// }
/// ```
pub let neper : LogScale = LogScale::new("Np", 1.0, @math.exp(1.0))

///|
/// dBm: power level referenced to 1 mW.
///
/// # Example
///
/// ```mbt check
/// test {
///   // 30 dBm is 1 W.
///   let watts = Level::new(30.0, dbm()).to_linear()
///   assert_true(watts.unit().is_compatible(@mechanics.watt))
/// }
/// ```
pub fn dbm() -> LogUnit {
  LogUnit::new(
    "dBm",
    @quantity.Quantity::new(0.001, @mechanics.watt),
    decibel_power,
  )
}

///|
/// dBW: power level referenced to 1 W.
///
/// # Example
///
/// ```mbt check
/// test {
///   // 0 dBW is 1 W (exact).
///   assert_eq(Level::new(0.0, dbw()).to_linear().value(), 1.0)
/// }
/// ```
pub fn dbw() -> LogUnit {
  LogUnit::new(
    "dBW",
    @quantity.Quantity::new(1.0, @mechanics.watt),
    decibel_power,
  )
}

///|
/// dBV: root-power (field) level referenced to 1 V.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(dbv().symbol(), "dBV")
///   assert_true(dbv().scale() == decibel_field)
/// }
/// ```
pub fn dbv() -> LogUnit {
  LogUnit::new(
    "dBV",
    @quantity.Quantity::new(1.0, @electromagnetism.volt),
    decibel_field,
  )
}
