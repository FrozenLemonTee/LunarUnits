///|
/// Raised when an operation requires two quantities (or a quantity and a target
/// unit) to share the same dimension but they do not.
pub suberror DimensionMismatch

///|
/// A physical quantity: a numeric value paired with a unit.
///
/// `Quantity` carries no algebra of its own — addition and conversion go
/// through the unit layer's dimensional checks, while multiplication and
/// division compose units via the unit (and ultimately algebra) layer.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(100.0, m)
///   let time = Quantity::new(10.0, s)
///   let speed = distance.div(time)
///   assert_eq(speed.value(), 10.0)
/// }
/// ```
pub struct Quantity {
  v : Double
  u : @unit.Un
} derive(Eq, Debug)

///|
/// Manual `Show` (so `assert_eq` can print diffs on failure).
pub impl Show for Quantity with fn output(self, logger) {
  logger.write_string("Quantity(\{self.v}, ")
  Show::output(self.u, logger)
  logger.write_string(")")
}

///|
/// Integer power of a `Double` without the rounding error of a floating-point
/// `pow` on integer exponents.
fn double_pow(base : Double, n : Int) -> Double {
  if n == 0 {
    return 1.0
  }
  let mut acc = 1.0
  let mut k = if n < 0 { -n } else { n }
  while k > 0 {
    acc = acc * base
    k -= 1
  }
  if n < 0 {
    1.0 / acc
  } else {
    acc
  }
}

///|
/// Creates a quantity from a value and a unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let length = Quantity::new(5.0, m)
///   assert_eq(length.value(), 5.0)
/// }
/// ```
pub fn Quantity::new(value : Double, unit : @unit.Un) -> Quantity {
  { v: value, u: unit }
}

///|
/// Returns the numeric value (in the quantity's current unit).
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   assert_eq(Quantity::new(5.0, m).value(), 5.0)
/// }
/// ```
pub fn Quantity::value(self : Quantity) -> Double {
  self.v
}

///|
/// Returns the quantity's unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   assert_true(
///     Quantity::new(5.0, m)
///     .unit()
///     .dimension()
///     .is_same(@dimension.Dimension::length()),
///   )
/// }
/// ```
pub fn Quantity::unit(self : Quantity) -> @unit.Un {
  self.u
}

///|
/// Returns the physical dimension of the quantity.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   assert_true(
///     Quantity::new(5.0, m).dimension().is_same(@dimension.Dimension::length()),
///   )
/// }
/// ```
pub fn Quantity::dimension(self : Quantity) -> @dimension.Dimension {
  self.u.dimension()
}

///|
/// Converts the quantity to `target`, keeping the same physical magnitude.
/// Raises `DimensionMismatch` if the target unit has a different dimension.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let km = @unit.Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   let in_m = Quantity::new(1.0, km).to(m)
///   assert_eq(in_m.value(), 1000.0)
///   // Converting to an incompatible unit raises.
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   assert_true((try? Quantity::new(1.0, m).to(s)) is Err(_))
/// }
/// ```
pub fn Quantity::to(
  self : Quantity,
  target : @unit.Un,
) -> Quantity raise DimensionMismatch {
  match self.u.conversion_factor(target) {
    Some(factor) => { v: self.v * factor, u: target }
    None => raise DimensionMismatch
  }
}

///|
/// Adds two quantities, returning the result in `self`'s unit. Raises
/// `DimensionMismatch` if the dimensions differ.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let km = @unit.Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   // 1 m + 1 km = 1001 m (result in self's unit).
///   let total = Quantity::new(1.0, m).add(Quantity::new(1.0, km))
///   assert_eq(total.value(), 1001.0)
///   // Adding incompatible dimensions raises.
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   assert_true((try? Quantity::new(1.0, m).add(Quantity::new(1.0, s))) is Err(_))
/// }
/// ```
pub fn Quantity::add(
  self : Quantity,
  other : Quantity,
) -> Quantity raise DimensionMismatch {
  let converted = other.to(self.u)
  { v: self.v + converted.v, u: self.u }
}

///|
/// Subtracts `other` from `self`, returning the result in `self`'s unit. Raises
/// `DimensionMismatch` if the dimensions differ.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let result = Quantity::new(5.0, m).sub(Quantity::new(2.0, m))
///   assert_eq(result.value(), 3.0)
/// }
/// ```
pub fn Quantity::sub(
  self : Quantity,
  other : Quantity,
) -> Quantity raise DimensionMismatch {
  let converted = other.to(self.u)
  { v: self.v - converted.v, u: self.u }
}

///|
/// Multiplies two quantities, composing both their values and their units. No
/// dimensional check is needed.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let area = Quantity::new(2.0, m).mul(Quantity::new(3.0, m))
///   assert_eq(area.value(), 6.0)
///   assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
/// }
/// ```
pub fn Quantity::mul(self : Quantity, other : Quantity) -> Quantity {
  { v: self.v * other.v, u: self.u.mul(other.u) }
}

///|
/// Divides `self` by `other`, composing both their values and their units. No
/// dimensional check is needed.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let speed = Quantity::new(10.0, m).div(Quantity::new(2.0, s))
///   assert_eq(speed.value(), 5.0)
///   let expected = @dimension.Dimension::length().div(
///     @dimension.Dimension::time(),
///   )
///   assert_true(speed.dimension().is_same(expected))
/// }
/// ```
pub fn Quantity::div(self : Quantity, other : Quantity) -> Quantity {
  { v: self.v / other.v, u: self.u.div(other.u) }
}

///|
/// Raises a quantity to an integer power, composing both value and unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let volume = Quantity::new(2.0, m).pow(3)
///   assert_eq(volume.value(), 8.0)
///   assert_true(volume.dimension().is_same(@dimension.Dimension::length().pow(3)))
/// }
/// ```
pub fn Quantity::pow(self : Quantity, n : Int) -> Quantity {
  { v: double_pow(self.v, n), u: self.u.pow(n) }
}

///|
/// Scales a quantity by a dimensionless factor (value only; unit unchanged).
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let doubled = Quantity::new(3.0, m).scale(2.0)
///   assert_eq(doubled.value(), 6.0)
/// }
/// ```
pub fn Quantity::scale(self : Quantity, factor : Double) -> Quantity {
  { v: self.v * factor, u: self.u }
}
