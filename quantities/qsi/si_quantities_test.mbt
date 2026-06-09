///|
/// SI base constructors attach the corresponding base dimensions.
test "si base constructors" {
  assert_true(meters(1.0).dimension().is_same(@dimension.Dimension::length()))
  assert_true(kilograms(1.0).dimension().is_same(@dimension.Dimension::mass()))
  assert_true(seconds(1.0).dimension().is_same(@dimension.Dimension::time()))
  assert_true(
    amperes(1.0).dimension().is_same(@dimension.Dimension::electric_current()),
  )
  assert_true(
    kelvins(1.0).dimension().is_same(@dimension.Dimension::temperature()),
  )
  assert_true(
    moles(1.0).dimension().is_same(@dimension.Dimension::amount_of_substance()),
  )
  assert_true(
    candelas(1.0)
    .dimension()
    .is_same(@dimension.Dimension::luminous_intensity()),
  )
}
