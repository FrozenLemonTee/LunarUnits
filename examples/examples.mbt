// LunarUnits worked examples. Every `test` below is a runnable, self-checking
// example covering the MVP capabilities: building quantities, arithmetic,
// same-dimension conversion and rejection of invalid operations.

///|
/// Speed is distance divided by time. Dividing quantities composes their units,
/// giving a result in metres per second.
test "speed = distance / time" {
  let distance = @qgeometry.meters(100.0)
  let time = @quantity.Quantity::new(10.0, @si.second)
  let speed = distance / time
  assert_eq(speed.value(), 10.0)
  assert_true(speed.unit().is_compatible(@mechanics.meter_per_second))
}

///|
/// Acceleration is a change in velocity over time.
test "acceleration = velocity / time" {
  let velocity = @qmechanics.meters_per_second(30.0)
  let time = @quantity.Quantity::new(5.0, @si.second)
  let acceleration = velocity / time
  assert_eq(acceleration.value(), 6.0)
}

///|
/// Newton's second law: F = m * a. Multiplying a mass by an acceleration yields
/// a force whose unit is compatible with the newton.
test "force = mass * acceleration" {
  let mass = @quantity.Quantity::new(2.0, @si.kilogram)
  let acceleration = @quantity.Quantity::new(3.0, @si.meter / @si.second.pow(2))
  let force = mass * acceleration
  assert_eq(force.value(), 6.0)
  assert_true(force.unit().is_compatible(@mechanics.newton))
}

///|
/// Work (energy) is force times distance.
test "work = force * distance" {
  let force = @qmechanics.newtons(10.0)
  let distance = @qgeometry.meters(5.0)
  let work = force * distance
  assert_eq(work.value(), 50.0)
  assert_true(work.unit().is_compatible(@mechanics.joule))
}

///|
/// Same-dimension conversion: 2 kilometres expressed in metres.
test "convert 2 km to metres" {
  let distance = @qgeometry.kilometers(2.0)
  let in_meters = distance.to(@si.meter)
  assert_eq(in_meters.value(), 2000.0)
}

///|
/// Adding quantities of different dimensions is rejected: the non-raising
/// `checked_add` returns `None` instead of a value.
test "adding incompatible dimensions is rejected" {
  let length = @quantity.Quantity::new(1.0, @si.meter)
  let time = @quantity.Quantity::new(1.0, @si.second)
  assert_true(length.checked_add(time) is None)
}

///|
/// Physical constants are ordinary quantities. Multiplying the speed of light
/// by a time gives a distance.
test "distance travelled by light in one second" {
  let one_second = @quantity.Quantity::new(1.0, @si.second)
  let distance = @physics.speed_of_light * one_second
  assert_eq(distance.value(), 299792458.0)
  assert_true(distance.unit().is_compatible(@si.meter))
}

///|
/// Information units live in an extension dimension outside the SI core.
test "information quantity conversion" {
  let memory = @qinformation.kibibytes(1.0)
  let as_bytes = memory.to(@information.byte)
  assert_eq(as_bytes.value(), 1024.0)
}

///|
/// Angle is modeled as an extension dimension, so degrees and radians convert
/// to each other without becoming interchangeable with plain dimensionless
/// ratios.
test "angle quantity conversion" {
  let half_turn = @qangle.degrees(180.0)
  let radians = half_turn.to(@angle.radian)
  assert_eq(radians.value(), 3.141592653589793)
  assert_false(
    radians.dimension().is_same(@dimension.Dimension::dimensionless()),
  )
}

///|
/// Currency is an extension dimension. Exchange rates vary over time, so the
/// library never bundles them: the caller injects the current rate with
/// `at_rate` (here 1 EUR = 1.25 USD) to convert across currencies.
test "cross-currency conversion with an injected exchange rate" {
  let euro = @currency.at_rate("EUR", 1.25)
  let price = @qcurrency.dollars(250.0)
  let in_euros = price.to(euro)
  assert_eq(in_euros.value(), 200.0)
}

///|
/// A cost rate is money divided by time. Dividing quantities composes their
/// units into a currency / time dimension, distinct from a plain money amount.
test "cost rate = money / time" {
  let cost = @qcurrency.dollars(45.0)
  let time = @quantity.Quantity::new(3.0, @si.second)
  let rate = cost / time
  assert_eq(rate.value(), 15.0)
  assert_false(rate.dimension().is_same(cost.dimension()))
}

///|
/// A unit price is money divided by a count. Multiplying it back by a count
/// cancels the count dimension and recovers a money amount, so a dozen items at
/// the same unit price bills in dollars.
test "unit price = money / count" {
  let total = @qcurrency.dollars(120.0)
  let items = @qcount.counts(40.0)
  let unit_price = total / items
  assert_eq(unit_price.value(), 3.0)
  let bill = unit_price * @qcount.dozens(1.0)
  assert_true(bill.unit().is_compatible(@currency.dollar))
  assert_eq(bill.to(@currency.dollar).value(), 36.0)
}

///|
/// Because angle is an extension dimension, frequency (hertz) and angular
/// frequency (radians per second) share the angle/time dimension and convert
/// into each other: 1 Hz = 2*pi rad/s. Mains power at 50 Hz is about 314 rad/s.
test "frequency converts to angular frequency (1 Hz = 2 pi rad/s)" {
  let mains = @qangle.hertz(50.0)
  let rad_per_second = @angle.radian / @si.second
  assert_true(mains.unit().is_compatible(rad_per_second))
  let omega = mains.to(rad_per_second)
  assert_eq(omega.value(), 314.1592653589793)
}

///|
/// The same quantity can be rendered for different audiences: compact ASCII for
/// logs, Unicode/SI for human-readable output, and LaTeX for documents. The
/// numerator/denominator layout is shared; only the notation changes.
test "format an acceleration in ASCII, SI and LaTeX" {
  let acceleration = @quantity.Quantity::new(9.8, @si.meter / @si.second.pow(2))
  assert_eq(@quantity.format_quantity(acceleration), "9.8 m/s^2")
  assert_eq(
    @quantity.format_quantity_with(acceleration, @unit.FormatStyle::Si),
    "9.8 m/s²",
  )
  assert_eq(
    @quantity.format_quantity_with(acceleration, @unit.FormatStyle::Latex),
    "9.8 \\mathrm{m}/\\mathrm{s}^{2}",
  )
}

///|
/// A catalog maps unit symbols to units — the basis for parsing and for
/// user-defined extensions. The preset `all()` catalog spans every built-in
/// unit package; catalogs are immutable, so extending one leaves the original
/// untouched.
test "resolve unit symbols through a preset catalog" {
  let catalog = @preset.all()
  // Known symbols from any domain resolve to a unit, e.g. force and frequency.
  assert_true(catalog.lookup("N") is Some(_))
  assert_true(catalog.lookup("Hz") is Some(_))
  // Unknown symbols return None instead of raising.
  assert_true(catalog.lookup("zzz") is None)
  // Register your own symbol (here an alias for the newton); the receiver is
  // unchanged, since catalogs are immutable.
  let extended = catalog.with_unit("force", @mechanics.newton)
  assert_true(extended.contains("force"))
  assert_false(catalog.contains("force"))
}

///|
/// The parser turns strings into units and quantities, resolving symbols
/// through a catalog and composing `*`, `/`, `^` and parentheses. It never
/// panics: the `*_opt` variants return None on a parse error.
test "parse units and quantities from strings" {
  let catalog = @preset.all()
  // A unit expression composes operators and exponents.
  let accel = @parser.parse_unit(catalog, "m/s^2")
  assert_true(accel.is_compatible(@si.meter / @si.second.pow(2)))
  // A quantity is a number followed by a unit.
  let q = @parser.parse_quantity(catalog, "9.8 m/s^2")
  assert_eq(q.value(), 9.8)
  // When the value is already a Double, attach the unit from a string.
  assert_eq(@parser.quantity(catalog, 9.8, "m/s^2").unit(), accel)
  // An unknown symbol yields None rather than raising.
  assert_true(@parser.parse_unit_opt(catalog, "m/zz") is None)
}

///|
/// Temperature is an affine scale: an absolute point (°C, °F, K) converts with
/// scale AND offset, while a temperature difference is an ordinary linear
/// quantity. The two are different types, so the classic "absolute vs interval"
/// mistake is impossible.
test "absolute temperatures and intervals" {
  // An absolute point converts with scale and offset: 100 °C is 373.15 K.
  let boiling = @affine.Point::new(100.0, @affine.celsius)
  assert_eq(boiling.to_base().value(), 373.15)
  // Cross-scale conversion: 212 °F is 100 °C.
  assert_eq(
    @affine.Point::new(212.0, @affine.fahrenheit).to(@affine.celsius).value(),
    100.0,
  )
  // The difference between two points is a plain Quantity in kelvin (the
  // offset cancels): 100 °C minus 20 °C is 80 K.
  assert_eq(
    boiling.difference(@affine.Point::new(20.0, @affine.celsius)).value(),
    80.0,
  )
  // Shifting a point by an interval yields another point: 20 °C + 5 K = 25 °C.
  let warmed = @affine.Point::new(20.0, @affine.celsius).shift(
    @quantity.Quantity::new(5.0, @si.kelvin),
  )
  assert_eq(warmed.value(), 25.0)
}

///|
/// Time durations are ordinary linear units (fixed multiples of the second),
/// distinct from absolute instants. A duration converts across units like any
/// quantity; an instant is an affine point on a seconds-from-epoch scale, and
/// the difference of two instants is a duration.
test "time durations and instants" {
  // A duration is a plain quantity: 2 hours is 120 minutes.
  assert_eq(@qtime.hours(2.0).to(@time.minute).value(), 120.0)
  // Instants are affine points; their difference is a duration in seconds,
  // which converts to any time unit.
  let epoch = @affine.AffineUn::new("s", @si.second, 1.0, 0.0)
  let start = @affine.Point::new(0.0, epoch)
  let finish = @affine.Point::new(7200.0, epoch)
  assert_eq(finish.difference(start).to(@time.hour).value(), 2.0)
}

///|
/// Decibels are a logarithmic scale: a Level is absolute (it carries a
/// reference, e.g. dBm = 1 mW) while a Gain is a pure ratio. A level bridges to
/// a linear quantity, a gain shifts it, and combining two equal power levels
/// adds about 3 dB (power doubling), not 6 dB.
test "decibel levels and gains" {
  // 30 dBm is 1 W.
  let power = @logarithmic.Level::new(30.0, @logarithmic.dbm()).to_linear()
  assert_true(power.unit().is_compatible(@mechanics.watt))
  // A 3 dB gain shifts 30 dBm to 33 dBm.
  let amplified = @logarithmic.Level::new(30.0, @logarithmic.dbm()).shift(
    @logarithmic.Gain::new(3.0, @logarithmic.decibel_power),
  )
  assert_eq(amplified.value(), 33.0)
  // Two incoherent 20 dBm sources combine to ~23 dBm (power adds), not 40 dBm.
  let combined = @logarithmic.Level::new(20.0, @logarithmic.dbm()).combine(
    @logarithmic.Level::new(20.0, @logarithmic.dbm()),
  )
  assert_true(combined.value() > 23.0 && combined.value() < 23.1)
}
