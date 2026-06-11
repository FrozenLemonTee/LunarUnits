///|
/// What went wrong combining logarithmic quantities.
pub suberror LogError {
  ScaleMismatch
  ReferenceMismatch
  IncompatibleDimension
} derive(Eq)

///|
/// A logarithmic scale: `value = factor * log_base(ratio)`.
///
/// `factor` is 10 for power-like decibels, 20 for root-power (field) decibels,
/// and 1 for nepers; `log_base` is 10 for decibels and e for nepers. Power and
/// root-power scales are distinct and never silently converted into one another.
/// `symbol` is used only for display.
pub struct LogScale {
  symbol : String
  factor : Double
  log_base : Double
} derive(Eq)

///|
/// Defines a logarithmic scale.
///
/// # Example
///
/// ```mbt check
/// test {
///   let scale = LogScale::new("dB", 10.0, 10.0)
///   assert_eq(scale.factor(), 10.0)
/// }
/// ```
pub fn LogScale::new(
  symbol : String,
  factor : Double,
  log_base : Double,
) -> LogScale {
  { symbol, factor, log_base }
}

///|
/// The display symbol (e.g. `dB`, `Np`).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(decibel_power.symbol(), "dB")
/// }
/// ```
pub fn LogScale::symbol(self : LogScale) -> String {
  self.symbol
}

///|
/// The `factor` (10 power, 20 root-power, 1 neper).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(decibel_field.factor(), 20.0)
/// }
/// ```
pub fn LogScale::factor(self : LogScale) -> Double {
  self.factor
}

///|
/// The logarithm base (10 for decibel, e for neper).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(decibel_power.log_base(), 10.0)
/// }
/// ```
pub fn LogScale::log_base(self : LogScale) -> Double {
  self.log_base
}

///|
/// A gain (or attenuation): a pure logarithmic ratio with no reference, e.g.
/// `3 dB`. Adding gains multiplies the underlying linear ratios.
pub struct Gain {
  value : Double
  scale : LogScale
}

///|
/// Creates a gain reading `value` on `scale`.
///
/// # Example
///
/// ```mbt check
/// test {
///   let g = Gain::new(3.0, decibel_power)
///   assert_eq(g.value(), 3.0)
/// }
/// ```
pub fn Gain::new(value : Double, scale : LogScale) -> Gain {
  { value, scale }
}

///|
/// The gain reading (e.g. `3.0` for `3 dB`).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Gain::new(6.0, decibel_power).value(), 6.0)
/// }
/// ```
pub fn Gain::value(self : Gain) -> Double {
  self.value
}

///|
/// The gain's scale.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(Gain::new(6.0, decibel_power).scale() == decibel_power)
/// }
/// ```
pub fn Gain::scale(self : Gain) -> LogScale {
  self.scale
}

///|
/// The linear ratio this gain represents: `log_base ^ (value / factor)`.
///
/// # Example
///
/// ```mbt check
/// test {
///   // A 10 dB power gain is a ten-fold ratio.
///   assert_eq(Gain::new(10.0, decibel_power).ratio(), 10.0)
/// }
/// ```
pub fn Gain::ratio(self : Gain) -> Double {
  @math.pow(self.scale.log_base, self.value / self.scale.factor)
}

///|
/// Builds a gain from a linear ratio: `factor * log_base(ratio)`.
///
/// # Example
///
/// ```mbt check
/// test {
///   // A ten-fold power ratio is 10 dB.
///   assert_eq(Gain::from_ratio(10.0, decibel_power).value(), 10.0)
/// }
/// ```
pub fn Gain::from_ratio(ratio : Double, scale : LogScale) -> Gain {
  Gain::new(scale.factor * @math.ln(ratio) / @math.ln(scale.log_base), scale)
}

///|
/// Composes two gains on the same scale (their ratios multiply, so the readings
/// add). Raises `ScaleMismatch` when the scales differ.
///
/// # Example
///
/// ```mbt check
/// test {
///   let total = Gain::new(20.0, decibel_power).add(Gain::new(20.0, decibel_power))
///   assert_eq(total.value(), 40.0)
/// }
/// ```
pub fn Gain::add(self : Gain, other : Gain) -> Gain raise LogError {
  guard self.scale == other.scale else { raise ScaleMismatch }
  Gain::new(self.value + other.value, self.scale)
}

///|
/// The inverse gain (attenuation), whose ratio is the reciprocal.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Gain::new(3.0, decibel_power).negate().value(), -3.0)
/// }
/// ```
pub fn Gain::negate(self : Gain) -> Gain {
  Gain::new(-self.value, self.scale)
}

///|
/// A logarithmic unit: a reference quantity paired with a scale (e.g. `dBm` is
/// `1 mW` on the power decibel scale). `symbol` is used only for display.
pub struct LogUnit {
  symbol : String
  reference : @quantity.Quantity
  scale : LogScale
} derive(Eq)

///|
/// Defines a logarithmic unit from a reference quantity and a scale.
///
/// # Example
///
/// ```mbt check
/// test {
///   let unit = LogUnit::new(
///     "dBW",
///     @quantity.Quantity::new(1.0, @mechanics.watt),
///     decibel_power,
///   )
///   assert_eq(unit.symbol(), "dBW")
/// }
/// ```
pub fn LogUnit::new(
  symbol : String,
  reference : @quantity.Quantity,
  scale : LogScale,
) -> LogUnit {
  { symbol, reference, scale }
}

///|
/// The display symbol (e.g. `dBm`).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(dbm().symbol(), "dBm")
/// }
/// ```
pub fn LogUnit::symbol(self : LogUnit) -> String {
  self.symbol
}

///|
/// The reference quantity the level is measured against (e.g. `1 mW`).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(dbm().reference().value(), 0.001)
/// }
/// ```
pub fn LogUnit::reference(self : LogUnit) -> @quantity.Quantity {
  self.reference
}

///|
/// The logarithmic scale.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(dbm().scale() == decibel_power)
/// }
/// ```
pub fn LogUnit::scale(self : LogUnit) -> LogScale {
  self.scale
}

///|
/// An absolute level on a logarithmic unit, e.g. `30 dBm`.
pub struct Level {
  value : Double
  unit : LogUnit
}

///|
/// Creates a level reading `value` on `unit`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Level::new(30.0, dbm()).value(), 30.0)
/// }
/// ```
pub fn Level::new(value : Double, unit : LogUnit) -> Level {
  { value, unit }
}

///|
/// The level reading (e.g. `30.0` for `30 dBm`).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Level::new(10.0, dbm()).value(), 10.0)
/// }
/// ```
pub fn Level::value(self : Level) -> Double {
  self.value
}

///|
/// The level's unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Level::new(10.0, dbm()).unit().symbol(), "dBm")
/// }
/// ```
pub fn Level::unit(self : Level) -> LogUnit {
  self.unit
}

///|
/// The absolute linear quantity this level represents:
/// `reference * log_base ^ (value / factor)` (e.g. `30 dBm` -> `1 W`).
///
/// # Example
///
/// ```mbt check
/// test {
///   let power = Level::new(30.0, dbm()).to_linear()
///   assert_true(power.unit().is_compatible(@mechanics.watt))
/// }
/// ```
pub fn Level::to_linear(self : Level) -> @quantity.Quantity {
  let factor = @math.pow(
    self.unit.scale.log_base,
    self.value / self.unit.scale.factor,
  )
  @quantity.Quantity::new(
    self.unit.reference.value() * factor,
    self.unit.reference.unit(),
  )
}

///|
/// Builds a level from a linear quantity: `factor * log_base(q / reference)`.
/// Raises `IncompatibleDimension` when `q` and the unit's reference differ in
/// dimension.
///
/// # Example
///
/// ```mbt check
/// test {
///   // 1 W referenced to 1 W is 0 dBW.
///   let watt = @quantity.Quantity::new(1.0, @mechanics.watt)
///   assert_eq(Level::from_linear(watt, dbw()).value(), 0.0)
/// }
/// ```
pub fn Level::from_linear(
  q : @quantity.Quantity,
  unit : LogUnit,
) -> Level raise LogError {
  let converted = q.to(unit.reference.unit()) catch {
    _ => raise IncompatibleDimension
  }
  let ratio = converted.value() / unit.reference.value()
  Level::new(
    unit.scale.factor * @math.ln(ratio) / @math.ln(unit.scale.log_base),
    unit,
  )
}

///|
/// Shifts a level by a gain (e.g. `30 dBm` + `3 dB` = `33 dBm`). Raises
/// `ScaleMismatch` when the gain's scale differs from the level's.
///
/// # Example
///
/// ```mbt check
/// test {
///   let louder = Level::new(30.0, dbm()).shift(Gain::new(3.0, decibel_power))
///   assert_eq(louder.value(), 33.0)
/// }
/// ```
pub fn Level::shift(self : Level, gain : Gain) -> Level raise LogError {
  guard gain.scale == self.unit.scale else { raise ScaleMismatch }
  Level::new(self.value + gain.value, self.unit)
}

///|
/// The gain from `other` up to `self`, i.e. their ratio in dB (e.g.
/// `33 dBm` relative to `30 dBm` is `3 dB`). Raises `ScaleMismatch` or
/// `ReferenceMismatch` when the units do not match.
///
/// # Example
///
/// ```mbt check
/// test {
///   let g = Level::new(33.0, dbm()).gain(Level::new(30.0, dbm()))
///   assert_eq(g.value(), 3.0)
/// }
/// ```
pub fn Level::gain(self : Level, other : Level) -> Gain raise LogError {
  guard self.unit.scale == other.unit.scale else { raise ScaleMismatch }
  guard self.unit.reference == other.unit.reference else {
    raise ReferenceMismatch
  }
  Gain::new(self.value - other.value, self.unit.scale)
}

///|
/// Combines two levels by adding their linear quantities (e.g. two incoherent
/// `20 dBm` sources sum to about `23.01 dBm`, not `40 dBm`). Raises on unit
/// mismatch.
///
/// # Example
///
/// ```mbt check
/// test {
///   let total = Level::new(20.0, dbm()).combine(Level::new(20.0, dbm()))
///   assert_true(total.value() > 23.0 && total.value() < 23.1)
/// }
/// ```
pub fn Level::combine(self : Level, other : Level) -> Level raise LogError {
  guard self.unit.scale == other.unit.scale else { raise ScaleMismatch }
  guard self.unit.reference == other.unit.reference else {
    raise ReferenceMismatch
  }
  let total = self.to_linear().add(other.to_linear()) catch {
      _ => raise IncompatibleDimension
    }
  Level::from_linear(total, self.unit)
}

///|
/// Formats a level as `<reading> <symbol>`, e.g. `30 dBm`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(format_level(Level::new(30.0, dbm())), "30 dBm")
/// }
/// ```
pub fn format_level(level : Level) -> String {
  "\{level.value} \{level.unit.symbol}"
}

///|
/// Formats a gain as `<reading> <symbol>`, e.g. `3 dB`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(format_gain(Gain::new(3.0, decibel_power)), "3 dB")
/// }
/// ```
pub fn format_gain(gain : Gain) -> String {
  "\{gain.value} \{gain.scale.symbol}"
}

///|
/// Debug-oriented display (mirrors `format_level`).
pub impl Show for Level with fn output(self, logger) {
  logger.write_string(format_level(self))
}

///|
/// Debug-oriented display (mirrors `format_gain`).
pub impl Show for Gain with fn output(self, logger) {
  logger.write_string(format_gain(self))
}
