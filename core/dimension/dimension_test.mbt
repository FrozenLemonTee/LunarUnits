///|
/// The seven base dimensions are all distinct from one another.
test "base dimensions are distinct" {
  let bases = [
    Dimension::length(),
    Dimension::mass(),
    Dimension::time(),
    Dimension::electric_current(),
    Dimension::temperature(),
    Dimension::amount_of_substance(),
    Dimension::luminous_intensity(),
  ]
  for i in 0..<bases.length() {
    for j in (i + 1)..<bases.length() {
      assert_false(bases[i] == bases[j])
    }
  }
}

///|
/// Velocity = length / time, acceleration = velocity / time = length / time^2.
test "velocity and acceleration" {
  let velocity = Dimension::length().div(Dimension::time())
  let acceleration = velocity.div(Dimension::time())
  assert_eq(acceleration, Dimension::length().div(Dimension::time().pow(2)))
}

///|
/// Force = mass * acceleration; energy = force * length. Built two ways they
/// must agree.
test "force and energy compose" {
  let force = Dimension::mass()
    .mul(Dimension::length())
    .div(Dimension::time().pow(2))
  let energy = force.mul(Dimension::length())
  let energy_expected = Dimension::mass()
    .mul(Dimension::length().pow(2))
    .div(Dimension::time().pow(2))
  assert_eq(energy, energy_expected)
}

///|
/// Powers: area is length^2, volume is length^3.
test "area and volume via powers" {
  assert_eq(
    Dimension::length().pow(2),
    Dimension::length().mul(Dimension::length()),
  )
  assert_eq(
    Dimension::length().pow(3),
    Dimension::length().mul(Dimension::length()).mul(Dimension::length()),
  )
}

///|
/// A ratio of like dimensions collapses to the dimensionless quantity.
test "ratio is dimensionless" {
  let strain = Dimension::length().div(Dimension::length())
  assert_true(strain.is_dimensionless())
  assert_eq(strain, Dimension::dimensionless())
}

///|
/// is_same agrees with structural equality and is independent of construction
/// order.
test "is_same is order independent" {
  let f1 = Dimension::mass()
    .mul(Dimension::length())
    .div(Dimension::time().pow(2))
  let f2 = Dimension::length()
    .div(Dimension::time().pow(2))
    .mul(Dimension::mass())
  assert_true(f1.is_same(f2))
  assert_eq(f1, f2)
}

///|
/// Structural snapshot of the force dimension (factors sorted by tag).
test "force dimension structure snapshot" {
  let force = Dimension::mass()
    .mul(Dimension::length())
    .div(Dimension::time().pow(2))
  debug_inspect(
    force,
    content=(
      #|{ repr: { coeff: 1, factors: [("L", 1), ("M", 1), ("T", -2)] } }
    ),
  )
}
