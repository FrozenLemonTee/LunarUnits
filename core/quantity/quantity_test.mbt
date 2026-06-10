///|
/// Helper: a fresh metre unit.
fn meter() -> @unit.Un {
  @unit.Un::base("m", @dimension.Dimension::length())
}

///|
/// Helper: a fresh second unit.
fn second() -> @unit.Un {
  @unit.Un::base("s", @dimension.Dimension::time())
}

///|
/// Helper: a fresh kilometre unit.
fn kilometer() -> @unit.Un {
  @unit.Un::scaled("km", @dimension.Dimension::length(), 1000.0)
}

///|
/// A quantity exposes its value, unit and dimension.
test "accessors" {
  let length = Quantity::new(5.0, meter())
  assert_eq(length.value(), 5.0)
  assert_true(length.dimension().is_same(@dimension.Dimension::length()))
  assert_eq(length.unit().scale(), 1.0)
}

///|
/// Adding same-unit quantities adds their values.
test "add same unit" {
  let total = Quantity::new(1.0, meter()).add(Quantity::new(2.0, meter()))
  assert_eq(total.value(), 3.0)
}

///|
/// Adding compatible units converts the other operand into self's unit first.
test "add converts compatible units" {
  let total = Quantity::new(1.0, meter()).add(Quantity::new(1.0, kilometer()))
  assert_eq(total.value(), 1001.0)
}

///|
/// checked_add returns Some for compatible dimensions and None otherwise.
test "checked add" {
  let total = Quantity::new(1.0, meter()).checked_add(
    Quantity::new(1.0, kilometer()),
  )
  assert_true(total is Some(_))
  assert_eq(total.unwrap().value(), 1001.0)
  assert_true(
    Quantity::new(1.0, meter()).checked_add(Quantity::new(1.0, second()))
    is None,
  )
}

///|
/// Adding incompatible dimensions raises DimensionMismatch.
test "add incompatible raises" {
  let result = try? Quantity::new(1.0, meter()).add(
    Quantity::new(1.0, second()),
  )
  assert_true(result is Err(_))
  match result {
    Err(DimensionMismatch((expected, actual))) => {
      assert_true(expected.is_same(@dimension.Dimension::length()))
      assert_true(actual.is_same(@dimension.Dimension::time()))
    }
    _ => fail("expected DimensionMismatch")
  }
}

///|
/// Subtraction works in self's unit.
test "sub" {
  let result = Quantity::new(5.0, meter()).sub(Quantity::new(2.0, meter()))
  assert_eq(result.value(), 3.0)
}

///|
/// checked_sub returns None for incompatible dimensions.
test "checked sub" {
  assert_true(Quantity::new(5.0, meter()).can_sub(Quantity::new(2.0, meter())))
  assert_false(
    Quantity::new(5.0, meter()).can_sub(Quantity::new(2.0, second())),
  )
  let result = Quantity::new(5.0, meter()).checked_sub(
    Quantity::new(2.0, meter()),
  )
  assert_true(result is Some(_))
  assert_eq(result.unwrap().value(), 3.0)
  assert_true(
    Quantity::new(5.0, meter()).checked_sub(Quantity::new(2.0, second()))
    is None,
  )
}

///|
/// Conversion preserves the physical magnitude.
test "to converts value" {
  let in_m = Quantity::new(2.0, kilometer()).to(meter())
  assert_eq(in_m.value(), 2000.0)
}

///|
/// checked_to returns Some for compatible units and None otherwise.
test "checked to" {
  let length = Quantity::new(2.0, kilometer())
  assert_true(length.can_to(meter()))
  assert_false(length.can_to(second()))
  assert_true(length.checked_to(meter()) is Some(_))
  assert_eq(length.checked_to(meter()).unwrap().value(), 2000.0)
  assert_true(length.checked_to(second()) is None)
}

///|
/// Conversion to an incompatible unit raises.
test "to incompatible raises" {
  let result = try? Quantity::new(1.0, meter()).to(second())
  assert_true(result is Err(_))
  match result {
    Err(DimensionMismatch((expected, actual))) => {
      assert_true(expected.is_same(@dimension.Dimension::time()))
      assert_true(actual.is_same(@dimension.Dimension::length()))
    }
    _ => fail("expected DimensionMismatch")
  }
}

///|
/// Multiplication composes values and dimensions.
test "mul composes" {
  let area = Quantity::new(2.0, meter()).mul(Quantity::new(3.0, meter()))
  assert_eq(area.value(), 6.0)
  assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
}

///|
/// Multiplication and division operators are shorthands for total quantity
/// composition. Addition and subtraction stay as explicit raising methods.
test "operators compose quantities" {
  let distance = Quantity::new(10.0, meter())
  let time = Quantity::new(2.0, second())
  let speed = distance / time
  assert_eq(speed, distance.div(time))
  assert_eq(speed.value(), 5.0)
  let area = distance * Quantity::new(3.0, meter())
  assert_eq(area.value(), 30.0)
  assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
}

///|
/// Unary negation flips the value while preserving the unit and dimension.
test "neg preserves unit" {
  let distance = Quantity::new(10.0, meter())
  let negated = -distance
  assert_eq(negated.value(), -10.0)
  assert_eq(negated.unit(), distance.unit())
  assert_true(negated.dimension().is_same(distance.dimension()))
}

///|
/// Division composes values and dimensions (speed = distance / time).
test "div composes" {
  let speed = Quantity::new(10.0, meter()).div(Quantity::new(2.0, second()))
  assert_eq(speed.value(), 5.0)
  let expected = @dimension.Dimension::length().div(
    @dimension.Dimension::time(),
  )
  assert_true(speed.dimension().is_same(expected))
}

///|
/// Power composes value and dimension.
test "pow composes" {
  let volume = Quantity::new(2.0, meter()).pow(3)
  assert_eq(volume.value(), 8.0)
  assert_true(volume.dimension().is_same(@dimension.Dimension::length().pow(3)))
}

///|
/// Newton's second law: F = m * a, then convert via composite reasoning.
test "newtons second law" {
  let kg = @unit.Un::base("kg", @dimension.Dimension::mass())
  let mass = Quantity::new(2.0, kg)
  let accel = Quantity::new(3.0, meter().div(second().pow(2)))
  let force = mass.mul(accel)
  assert_eq(force.value(), 6.0)
  let force_dim = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length())
    .div(@dimension.Dimension::time().pow(2))
  assert_true(force.dimension().is_same(force_dim))
}

///|
/// Quantity formatter combines the value with ASCII unit formatting.
test "format quantity ascii" {
  let acceleration = Quantity::new(9.8, meter() / second().pow(2))
  assert_eq(format_quantity(acceleration), "9.8 m/s^2")
}
