///|
/// A length base unit, used as a sample registration value.
fn meter() -> @unit.Un {
  @unit.Un::base("m", @dimension.Dimension::length())
}

///|
/// A time base unit, used as a sample registration value.
fn second() -> @unit.Un {
  @unit.Un::base("s", @dimension.Dimension::time())
}

///|
/// An empty catalog knows no symbols.
test "empty catalog" {
  let catalog = Catalog::new()
  assert_true(catalog.lookup("m") is None)
  assert_false(catalog.contains("m"))
  assert_eq(catalog.symbols().length(), 0)
}

///|
/// A registered symbol resolves to its unit; lookups are exact.
test "with then lookup" {
  let catalog = Catalog::new().with_unit("m", meter())
  assert_true(catalog.contains("m"))
  assert_eq(catalog.lookup("m").unwrap(), meter())
  assert_true(catalog.lookup("s") is None)
}

///|
/// `with` has value semantics: the receiver is unchanged.
test "with does not mutate the receiver" {
  let base = Catalog::new()
  let extended = base.with_unit("m", meter())
  assert_false(base.contains("m"))
  assert_true(extended.contains("m"))
}

///|
/// Re-binding a symbol overrides the previous unit (last write wins).
test "with overrides on conflict" {
  let catalog = Catalog::new().with_unit("u", meter()).with_unit("u", second())
  assert_eq(catalog.lookup("u").unwrap(), second())
}

///|
/// `with_all` registers many pairs; later pairs override earlier ones.
test "with_all bulk and override" {
  let catalog = Catalog::new().with_all([
    ("m", meter()),
    ("s", second()),
    ("m", second()),
  ])
  assert_eq(catalog.lookup("s").unwrap(), second())
  assert_eq(catalog.lookup("m").unwrap(), second())
}

///|
/// Lookups are case sensitive: `m` and `M` are distinct symbols.
test "lookup is case sensitive" {
  let catalog = Catalog::new().with_unit("m", meter())
  assert_true(catalog.contains("m"))
  assert_false(catalog.contains("M"))
}

///|
/// `merge` takes the union; the other catalog wins on conflict.
test "merge prefers other on conflict" {
  let left = Catalog::new().with_unit("m", meter()).with_unit("x", meter())
  let right = Catalog::new().with_unit("s", second()).with_unit("x", second())
  let merged = left.merge(right)
  assert_true(merged.contains("m"))
  assert_true(merged.contains("s"))
  assert_eq(merged.lookup("x").unwrap(), second())
}

///|
/// `symbols` reports every registered symbol.
test "symbols lists all registrations" {
  let catalog = Catalog::new().with_unit("m", meter()).with_unit("s", second())
  let symbols = catalog.symbols()
  assert_eq(symbols.length(), 2)
  assert_true(symbols.contains("m"))
  assert_true(symbols.contains("s"))
}
