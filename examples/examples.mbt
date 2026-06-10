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
/// Adding quantities of different dimensions is rejected: `add` raises
/// `DimensionMismatch`, surfaced here as an `Err` via `try?`.
test "adding incompatible dimensions is rejected" {
  let length = @quantity.Quantity::new(1.0, @si.meter)
  let time = @quantity.Quantity::new(1.0, @si.second)
  assert_true((try? length.add(time)) is Err(_))
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
