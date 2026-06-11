///|
/// Approximate equality for floating-point logarithms.
fn close(actual : Double, expected : Double) -> Bool {
  let diff = actual - expected
  (if diff < 0.0 { -diff } else { diff }) < 1.0e-9
}

///|
/// A power level converts to and from a linear quantity through its reference.
test "level to and from linear" {
  // 30 dBm is 1 W; 0 dBm is 1 mW.
  assert_true(close(Level::new(30.0, dbm()).to_linear().value(), 1.0))
  assert_true(close(Level::new(0.0, dbm()).to_linear().value(), 0.001))
  // Round-trip back to dBm.
  let one_watt = @quantity.Quantity::new(1.0, @mechanics.watt)
  assert_true(close(Level::from_linear(one_watt, dbm()).value(), 30.0))
  // dBW references 1 W, so 1 W is 0 dBW.
  assert_true(close(Level::from_linear(one_watt, dbw()).value(), 0.0))
}

///|
/// A gain is a pure ratio; composing gains multiplies the ratios.
test "gains compose as ratios" {
  assert_true(close(Gain::new(10.0, decibel_power).ratio(), 10.0))
  assert_true(close(Gain::new(20.0, decibel_power).ratio(), 100.0))
  // 20 dB + 20 dB = 40 dB (ratios 100 * 100 = 10000).
  let sum = Gain::new(20.0, decibel_power).add(Gain::new(20.0, decibel_power))
  assert_true(close(sum.value(), 40.0))
  assert_true(close(sum.ratio(), 10000.0))
  // from_ratio inverts ratio.
  assert_true(close(Gain::from_ratio(1000.0, decibel_power).value(), 30.0))
}

///|
/// Adding a gain to a level shifts it; the level's reference is unchanged.
test "shift a level by a gain" {
  let shifted = Level::new(30.0, dbm()).shift(Gain::new(3.0, decibel_power))
  assert_true(close(shifted.value(), 33.0))
  // A mismatched scale (field gain on a power level) is rejected.
  assert_true(
    capture(() => Level::new(30.0, dbm()).shift(Gain::new(3.0, decibel_field)))
    is Some(ScaleMismatch),
  )
}

///|
/// The difference of two levels (same unit) is a gain.
test "level difference is a gain" {
  let g = Level::new(33.0, dbm()).gain(Level::new(30.0, dbm()))
  assert_true(close(g.value(), 3.0))
  assert_true(g.scale() == decibel_power)
  // Different references cannot be compared directly.
  assert_true(
    capture_gain(() => Level::new(0.0, dbm()).gain(Level::new(0.0, dbw())))
    is Some(ReferenceMismatch),
  )
}

///|
/// Combining levels adds their linear powers: 20 dBm + 20 dBm ~= 23.01 dBm.
test "combine levels adds power" {
  let total = Level::new(20.0, dbm()).combine(Level::new(20.0, dbm()))
  // 100 mW + 100 mW = 200 mW = 10*log10(200) dBm.
  assert_true(close(total.value(), 10.0 * @math.log10(200.0)))
  assert_true(close(total.to_linear().value(), 0.2))
}

///|
/// Nepers use the natural logarithm.
test "neper uses natural log" {
  // ln-based: a gain of 1 Np is a ratio of e.
  assert_true(close(Gain::new(1.0, neper).ratio(), @math.exp(1.0)))
}

///|
/// Formatting uses the unit/scale symbol.
test "format levels and gains" {
  assert_eq(format_level(Level::new(30.0, dbm())), "30 dBm")
  assert_eq(format_gain(Gain::new(3.0, decibel_power)), "3 dB")
  assert_eq(format_gain(Gain::new(1.0, neper)), "1 Np")
}

///|
/// Captures a `LogError` raised while producing a `Level`.
fn capture(f : () -> Level raise LogError) -> LogError? {
  try {
    let _ = f()
    None
  } catch {
    error => Some(error)
  }
}

///|
/// Captures a `LogError` raised while producing a `Gain`.
fn capture_gain(f : () -> Gain raise LogError) -> LogError? {
  try {
    let _ = f()
    None
  } catch {
    error => Some(error)
  }
}
