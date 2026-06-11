///|
/// `si` registers exactly the seven SI base symbols, each a coherent base unit.
test "si has the seven base units" {
  let catalog = si()
  let symbols = ["m", "kg", "s", "A", "K", "mol", "cd"]
  assert_eq(catalog.symbols().length(), symbols.length())
  for symbol in symbols {
    assert_eq(catalog.lookup(symbol).unwrap().scale(), 1.0)
  }
  assert_true(catalog.lookup("N") is None)
}

///|
/// Each per-package catalog binds its conventional symbols to the matching
/// units and stays scoped to its own package.
test "per-package catalogs map their symbols" {
  assert_eq(geometry().lookup("km").unwrap(), @geometry.kilometer)
  assert_eq(geometry().lookup("m²").unwrap(), @geometry.square_meter)
  assert_eq(mass().lookup("lb").unwrap(), @mass.pound)
  assert_eq(mass().lookup("kg/m³").unwrap(), @mass.kilogram_per_cubic_meter)
  assert_eq(mechanics().lookup("N").unwrap(), @mechanics.newton)
  assert_eq(mechanics().lookup("hp").unwrap(), @mechanics.horsepower)
  assert_eq(fluid().lookup("Pa·s").unwrap(), @fluid.pascal_second)
  assert_eq(
    thermal().lookup("W/(m·K)").unwrap(),
    @thermal.watt_per_meter_kelvin,
  )
  assert_eq(electromagnetism().lookup("Ω").unwrap(), @electromagnetism.ohm)
  assert_eq(electromagnetism().lookup("Wb").unwrap(), @electromagnetism.weber)
  assert_eq(angle().lookup("Hz").unwrap(), @angle.hertz)
  assert_eq(solid_angle().lookup("sr").unwrap(), @solid_angle.steradian)
  assert_eq(information().lookup("KiB").unwrap(), @information.kibibyte)
  assert_eq(currency().lookup("$").unwrap(), @currency.dollar)
  assert_eq(count().lookup("doz").unwrap(), @count.dozen)
}

///|
/// Each catalog includes every unit exported by its package.
test "per-package catalogs are complete" {
  assert_eq(si().symbols().length(), 7)
  assert_eq(geometry().symbols().length(), 12)
  assert_eq(mass().symbols().length(), 7)
  assert_eq(mechanics().symbols().length(), 18)
  assert_eq(fluid().symbols().length(), 7)
  assert_eq(thermal().symbols().length(), 4)
  assert_eq(electromagnetism().symbols().length(), 9)
  assert_eq(angle().symbols().length(), 7)
  assert_eq(solid_angle().symbols().length(), 3)
  assert_eq(information().symbols().length(), 8)
  assert_eq(currency().symbols().length(), 4)
  assert_eq(count().symbols().length(), 3)
}

///|
/// A per-package catalog stays scoped: it does not leak symbols from others.
test "per-package catalogs are scoped" {
  assert_true(angle().lookup("N") is None)
  assert_true(mechanics().lookup("Hz") is None)
  assert_true(si().lookup("$") is None)
}

///|
/// `all` merges every per-package catalog with no symbol collisions, so the
/// merged size equals the sum of the parts.
test "all spans every package without collisions" {
  let catalog = all()
  for
    symbol in [
      "m", "km", "lb", "N", "Pa·s", "BTU", "Ω", "Hz", "sr", "GiB", "k$", "gr",
    ] {
    assert_true(catalog.lookup(symbol) is Some(_))
  }
  let expected = si().symbols().length() +
    geometry().symbols().length() +
    mass().symbols().length() +
    mechanics().symbols().length() +
    fluid().symbols().length() +
    thermal().symbols().length() +
    electromagnetism().symbols().length() +
    angle().symbols().length() +
    solid_angle().symbols().length() +
    information().symbols().length() +
    currency().symbols().length() +
    count().symbols().length()
  assert_eq(catalog.symbols().length(), expected)
}

///|
/// A preset catalog can be extended with user-defined symbols.
test "presets are extensible" {
  let dollar = @unit.Un::base("USD", @dimension.Dimension::custom("money"))
  let catalog = all().with_unit("USD", dollar)
  assert_eq(catalog.lookup("USD").unwrap(), dollar)
  assert_true(catalog.lookup("N") is Some(_))
}
