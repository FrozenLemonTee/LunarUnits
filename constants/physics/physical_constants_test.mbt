///|
/// Physical constants carry the expected dimensions.
test "physical constants dimensions" {
  assert_true(speed_of_light.unit().is_compatible(@si.meter / @si.second))
  assert_true(
    standard_gravity.unit().is_compatible(@si.meter / @si.second.pow(2)),
  )
  assert_true(
    gravitational_constant
    .unit()
    .is_compatible(@si.meter.pow(3) / (@si.kilogram * @si.second.pow(2))),
  )
  assert_true(
    planck_constant.unit().is_compatible(@mechanics.joule * @si.second),
  )
  assert_true(avogadro_constant.unit().is_compatible(@si.mole.pow(-1)))
  assert_true(
    boltzmann_constant.unit().is_compatible(@mechanics.joule / @si.kelvin),
  )
}
