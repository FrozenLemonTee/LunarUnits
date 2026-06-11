///|
/// Celsius/Fahrenheit/Kelvin/Rankine all anchor to the same absolute scale.
test "absolute conversions to kelvin" {
  assert_eq(Point::new(0.0, celsius).to_base().value(), 273.15)
  assert_eq(Point::new(100.0, celsius).to_base().value(), 373.15)
  assert_eq(Point::new(32.0, fahrenheit).to_base().value(), 273.15)
  assert_eq(Point::new(0.0, kelvin).to_base().value(), 0.0)
  assert_eq(Point::new(0.0, rankine).to_base().value(), 0.0)
}

///|
/// Approximate equality, since conversions through the 5/9 factor are not exact
/// in floating point.
fn close(actual : Double, expected : Double) -> Bool {
  let diff = actual - expected
  (if diff < 0.0 { -diff } else { diff }) < 1.0e-9
}

///|
/// Affine conversion between scales applies scale and offset.
test "affine conversion between scales" {
  assert_true(close(Point::new(100.0, celsius).to(fahrenheit).value(), 212.0))
  assert_true(close(Point::new(212.0, fahrenheit).to(celsius).value(), 100.0))
  assert_eq(Point::new(0.0, celsius).to(kelvin).value(), 273.15)
  // -40 is the scale crossing point.
  assert_true(close(Point::new(-40.0, celsius).to(fahrenheit).value(), -40.0))
}

///|
/// Subtracting two points yields a linear interval in kelvin; the offset
/// cancels, so a 100 °C span and a 100 K span are equal.
test "difference is a linear interval" {
  let interval = Point::new(30.0, celsius).difference(Point::new(20.0, celsius))
  assert_eq(interval.value(), 10.0)
  assert_true(interval.unit().is_compatible(@si.kelvin))
  // Cross-unit: 100 °C minus 32 °F is 100 K (both absolute, difference linear).
  let span = Point::new(100.0, celsius).difference(Point::new(32.0, fahrenheit))
  assert_eq(span.value(), 100.0)
}

///|
/// Shifting a point by an interval keeps it a point; a negative interval cools.
test "shift by an interval" {
  assert_eq(
    Point::new(20.0, celsius)
    .shift(@quantity.Quantity::new(5.0, @si.kelvin))
    .value(),
    25.0,
  )
  assert_eq(
    Point::new(25.0, celsius)
    .shift(@quantity.Quantity::new(-5.0, @si.kelvin))
    .value(),
    20.0,
  )
  // The interval size is in kelvin regardless of the point's unit: +9 K on a
  // Fahrenheit point.
  assert_eq(
    Point::new(50.0, fahrenheit)
    .shift(@quantity.Quantity::new(5.0, @si.kelvin))
    .value(),
    59.0,
  )
}

///|
/// Formatting uses the affine unit's symbol.
test "format a point" {
  assert_eq(format_point(Point::new(20.0, celsius)), "20 °C")
  assert_eq(format_point(Point::new(293.15, kelvin)), "293.15 K")
}

///|
/// A user-defined affine scale on a non-temperature dimension works the same
/// way, and converting across incompatible base dimensions is rejected.
test "generic and incompatible scales" {
  // An arbitrary affine length scale: readings offset by 10 m from the metre.
  let datum = AffineUn::new("d", @si.meter, 1.0, 10.0)
  assert_eq(Point::new(0.0, datum).to_base().value(), 10.0)
  // A length point cannot convert to a temperature scale.
  assert_true(Point::new(0.0, datum).checked_to(celsius) is None)
  // Nor can it be shifted by a temperature interval.
  assert_true(
    Point::new(0.0, datum).checked_shift(
      @quantity.Quantity::new(1.0, @si.kelvin),
    )
    is None,
  )
}
