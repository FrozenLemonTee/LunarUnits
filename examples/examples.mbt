// LunarUnits worked examples. Every `test` below is a runnable, self-checking
// example covering the MVP capabilities: building quantities, arithmetic,
// same-dimension conversion and rejection of invalid operations.

///|
/// Speed is distance divided by time. Dividing quantities composes their units,
/// giving a result in metres per second.
test "speed = distance / time" {
  let distance = @quantity.Quantity::new(100.0, @si.meter)
  let time = @quantity.Quantity::new(10.0, @si.second)
  let speed = distance.div(time)
  assert_eq(speed.value(), 10.0)
  assert_true(speed.unit().is_compatible(@mechanics.meter_per_second))
}

///|
/// Acceleration is a change in velocity over time.
test "acceleration = velocity / time" {
  let velocity = @quantity.Quantity::new(30.0, @mechanics.meter_per_second)
  let time = @quantity.Quantity::new(5.0, @si.second)
  let acceleration = velocity.div(time)
  assert_eq(acceleration.value(), 6.0)
}

///|
/// Newton's second law: F = m * a. Multiplying a mass by an acceleration yields
/// a force whose unit is compatible with the newton.
test "force = mass * acceleration" {
  let mass = @quantity.Quantity::new(2.0, @si.kilogram)
  let acceleration = @quantity.Quantity::new(
    3.0,
    @si.meter.div(@si.second.pow(2)),
  )
  let force = mass.mul(acceleration)
  assert_eq(force.value(), 6.0)
  assert_true(force.unit().is_compatible(@mechanics.newton))
}

///|
/// Work (energy) is force times distance.
test "work = force * distance" {
  let force = @quantity.Quantity::new(10.0, @mechanics.newton)
  let distance = @quantity.Quantity::new(5.0, @si.meter)
  let work = force.mul(distance)
  assert_eq(work.value(), 50.0)
  assert_true(work.unit().is_compatible(@mechanics.joule))
}

///|
/// Same-dimension conversion: 2 kilometres expressed in metres.
test "convert 2 km to metres" {
  let distance = @quantity.Quantity::new(2.0, @geometry.kilometer)
  let in_meters = distance.to(@si.meter)
  assert_eq(in_meters.value(), 2000.0)
}

///|
/// Adding quantities of different dimensions is rejected: `add` raises
/// `DimensionMismatch`, surfaced here as an `Err` via `try?`.
test "adding incompatible dimensions is rejected" {
  let length = @quantity.Quantity::new(1.0, @si.meter)
  let time = @quantity.Quantity::new(1.0, @si.second)
  assert_true((try? length.add(time)) is Err(_))
}
