///|
/// Charge: coulomb has dimension I·T and the ampere hour converts to 3600 C.
test "electric charge" {
  let charge = @dimension.Dimension::electric_current().mul(
    @dimension.Dimension::time(),
  )
  assert_true(coulomb.dimension().is_same(charge))
  assert_true(ampere_hour.conversion_factor(coulomb) is Some(3600.0))
}

///|
/// Ohm's law V = I·R is dimensionally consistent: a volt matches an ohm times
/// an ampere.
test "ohms law is dimensionally consistent" {
  assert_true(volt.is_compatible(ohm.mul(@si.ampere)))
}

///|
/// Electric power P = V·I has the dimension of power (M·L²·T⁻³).
test "voltage times current is power" {
  let power = @dimension.Dimension::mass()
    .mul(@dimension.Dimension::length().pow(2))
    .div(@dimension.Dimension::time().pow(3))
  assert_true(volt.mul(@si.ampere).dimension().is_same(power))
}

///|
/// Reciprocal and product relations among the derived units.
test "reciprocal and product relations" {
  // siemens is the reciprocal of the ohm
  assert_true(siemens.is_compatible(ohm.pow(-1)))
  // a farad times an ohm is a time (the RC time constant)
  assert_true(farad.mul(ohm).dimension().is_same(@dimension.Dimension::time()))
  // a henry over an ohm is a time (the L/R time constant)
  assert_true(henry.div(ohm).dimension().is_same(@dimension.Dimension::time()))
}
