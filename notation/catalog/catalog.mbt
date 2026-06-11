///|
/// An immutable `symbol -> unit` lookup table for parsing, formatting and
/// user-defined unit extensions.
///
/// A catalog never participates in core unit identity: whether two units are
/// compatible, and how one converts into another, stays governed by
/// `@unit.Un`'s scale and dimension. The catalog only answers "is this symbol
/// known, and which unit does it name".
///
/// Instances are immutable. `with`, `with_all` and `merge` return a new catalog
/// and leave the receiver unchanged.
pub struct Catalog {
  entries : Map[String, @unit.Un]
}

///|
/// Copies the entries of a catalog into a fresh map, so callers can mutate the
/// result without affecting the receiver.
fn Catalog::copy_entries(self : Catalog) -> Map[String, @unit.Un] {
  let copy : Map[String, @unit.Un] = Map([])
  self.entries.each(fn(symbol, unit) { copy[symbol] = unit })
  copy
}

///|
/// Creates an empty catalog.
///
/// # Example
///
/// ```mbt check
/// test {
///   let catalog = Catalog::new()
///   assert_false(catalog.contains("m"))
///   assert_eq(catalog.symbols().length(), 0)
/// }
/// ```
pub fn Catalog::new() -> Catalog {
  { entries: Map([]) }
}

///|
/// Returns a new catalog with `symbol` bound to `unit`.
///
/// Last write wins: binding a symbol that already exists overrides the previous
/// unit. The receiver is left unchanged.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = @unit.Un::base("m", @dimension.Dimension::length())
///   let catalog = Catalog::new().with_unit("m", meter)
///   assert_true(catalog.contains("m"))
///   assert_true(catalog.lookup("m") is Some(_))
/// }
/// ```
pub fn Catalog::with_unit(
  self : Catalog,
  symbol : String,
  unit : @unit.Un,
) -> Catalog {
  let entries = self.copy_entries()
  entries[symbol] = unit
  { entries, }
}

///|
/// Returns a new catalog with every `(symbol, unit)` pair added. Later pairs
/// override earlier ones on conflict.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = @unit.Un::base("m", @dimension.Dimension::length())
///   let second = @unit.Un::base("s", @dimension.Dimension::time())
///   let catalog = Catalog::new().with_all([("m", meter), ("s", second)])
///   assert_true(catalog.contains("m"))
///   assert_true(catalog.contains("s"))
/// }
/// ```
pub fn Catalog::with_all(
  self : Catalog,
  pairs : Array[(String, @unit.Un)],
) -> Catalog {
  let entries = self.copy_entries()
  for pair in pairs {
    let (symbol, unit) = pair
    entries[symbol] = unit
  }
  { entries, }
}

///|
/// Looks up a symbol, returning `None` when it is not registered.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = @unit.Un::base("m", @dimension.Dimension::length())
///   let catalog = Catalog::new().with_unit("m", meter)
///   assert_true(catalog.lookup("m") is Some(_))
///   assert_true(catalog.lookup("s") is None)
/// }
/// ```
pub fn Catalog::lookup(self : Catalog, symbol : String) -> @unit.Un? {
  self.entries.get(symbol)
}

///|
/// Returns whether a symbol is registered.
pub fn Catalog::contains(self : Catalog, symbol : String) -> Bool {
  self.entries.contains(symbol)
}

///|
/// Returns all registered symbols, in unspecified order. Useful for diagnostics
/// and "did you mean" hints in a parser.
pub fn Catalog::symbols(self : Catalog) -> Array[String] {
  let result : Array[String] = []
  self.entries.each(fn(symbol, _unit) { result.push(symbol) })
  result
}

///|
/// Combines two catalogs. On conflicting symbols, `other`'s binding wins.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = @unit.Un::base("m", @dimension.Dimension::length())
///   let second = @unit.Un::base("s", @dimension.Dimension::time())
///   let a = Catalog::new().with_unit("m", meter)
///   let b = Catalog::new().with_unit("s", second)
///   let merged = a.merge(b)
///   assert_true(merged.contains("m"))
///   assert_true(merged.contains("s"))
/// }
/// ```
pub fn Catalog::merge(self : Catalog, other : Catalog) -> Catalog {
  let entries = self.copy_entries()
  other.entries.each(fn(symbol, unit) { entries[symbol] = unit })
  { entries, }
}
