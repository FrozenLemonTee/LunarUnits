///|
/// Currency quantity constructors attach compatible currency units.
test "currency quantity constructors" {
  assert_true(dollars(1.0).unit().is_compatible(@currency.dollar))
  assert_eq(cents(100.0).to(@currency.dollar).value(), 1.0)
  assert_eq(kilodollars(1.0).to(@currency.dollar).value(), 1000.0)
  assert_eq(megadollars(1.0).to(@currency.dollar).value(), 1.0e6)
}
