///|
/// Raised when an operation requires two quantities (or a quantity and a target
/// unit) to share the same dimension but they do not.
///
/// The payload stores `(expected, actual)` dimensions.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let mut caught = false
///   try Quantity::new(1.0, m).to(s) |> ignore catch {
///     DimensionMismatch((expected, actual)) => {
///       caught = true
///       assert_true(expected.is_same(@dimension.Dimension::time()))
///       assert_true(actual.is_same(@dimension.Dimension::length()))
///     }
///   }
///   assert_true(caught)
/// }
/// ```
pub suberror DimensionMismatch {
  DimensionMismatch((@dimension.Dimension, @dimension.Dimension))
} derive(Eq, Debug)

///|
/// A physical quantity: a numeric value paired with a unit.
///
/// `Quantity` carries no algebra of its own: addition and conversion go
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
/// Allows `lhs * rhs` as shorthand for `lhs.mul(rhs)`. Quantity multiplication
/// is total: it always composes values and units without dimensional rejection.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let area = Quantity::new(2.0, m) * Quantity::new(3.0, m)
///   assert_eq(area.value(), 6.0)
///   assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
/// }
/// ```
pub impl Mul for Quantity with fn mul(self : Quantity, other : Quantity) -> Quantity {
  { v: self.v * other.v, u: self.u.mul(other.u) }
}

///|
/// Allows `lhs / rhs` as shorthand for `lhs.div(rhs)`. Quantity division is
/// total: it always composes values and units without dimensional rejection.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let speed = Quantity::new(10.0, m) / Quantity::new(2.0, s)
///   assert_eq(speed.value(), 5.0)
///   assert_true(
///     speed
///     .dimension()
///     .is_same(@dimension.Dimension::length().div(@dimension.Dimension::time())),
///   )
/// }
/// ```
pub impl Div for Quantity with fn div(self : Quantity, other : Quantity) -> Quantity {
  { v: self.v / other.v, u: self.u.div(other.u) }
}

///|
/// Allows unary `-quantity`, negating the value while preserving the unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let q = -Quantity::new(3.0, m)
///   assert_eq(q.value(), -3.0)
///   assert_true(q.unit().is_compatible(m))
/// }
/// ```
pub impl Neg for Quantity with fn neg(self : Quantity) -> Quantity {
  { v: -self.v, u: self.u }
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
/// Returns whether this quantity can be converted to `target`.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let km = @unit.Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(1.0, km)
///   assert_true(distance.can_to(m))
///   assert_false(distance.can_to(s))
/// }
/// ```
pub fn Quantity::can_to(self : Quantity, target : @unit.Un) -> Bool {
  self.u.is_compatible(target)
}

///|
/// Converts the quantity to `target`, returning `None` when dimensions differ.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let km = @unit.Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(2.0, km)
///   match distance.checked_to(m) {
///     Some(converted) => assert_eq(converted.value(), 2000.0)
///     None => fail("expected compatible conversion")
///   }
///   assert_true(distance.checked_to(s) is None)
/// }
/// ```
pub fn Quantity::checked_to(self : Quantity, target : @unit.Un) -> Quantity? {
  match self.u.conversion_factor(target) {
    Some(factor) => Some({ v: self.v * factor, u: target })
    None => None
  }
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
///   // An incompatible target unit is rejected (checked_to returns None).
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   assert_true(Quantity::new(1.0, m).checked_to(s) is None)
/// }
/// ```
pub fn Quantity::to(
  self : Quantity,
  target : @unit.Un,
) -> Quantity raise DimensionMismatch {
  match self.checked_to(target) {
    Some(converted) => converted
    None => raise DimensionMismatch((target.dimension(), self.dimension()))
  }
}

///|
/// Returns whether two quantities can be added.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(1.0, m)
///   assert_true(distance.can_add(Quantity::new(2.0, m)))
///   assert_false(distance.can_add(Quantity::new(2.0, s)))
/// }
/// ```
pub fn Quantity::can_add(self : Quantity, other : Quantity) -> Bool {
  self.dimension().is_same(other.dimension())
}

///|
/// Adds two quantities, returning `None` when dimensions differ.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let km = @unit.Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(1.0, m)
///   match distance.checked_add(Quantity::new(1.0, km)) {
///     Some(total) => assert_eq(total.value(), 1001.0)
///     None => fail("expected compatible addition")
///   }
///   assert_true(distance.checked_add(Quantity::new(1.0, s)) is None)
/// }
/// ```
pub fn Quantity::checked_add(self : Quantity, other : Quantity) -> Quantity? {
  match other.checked_to(self.u) {
    Some(converted) => Some({ v: self.v + converted.v, u: self.u })
    None => None
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
///   // Adding incompatible dimensions is rejected (checked_add returns None).
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   assert_true(Quantity::new(1.0, m).checked_add(Quantity::new(1.0, s)) is None)
/// }
/// ```
pub fn Quantity::add(
  self : Quantity,
  other : Quantity,
) -> Quantity raise DimensionMismatch {
  match self.checked_add(other) {
    Some(total) => total
    None => raise DimensionMismatch((self.dimension(), other.dimension()))
  }
}

///|
/// Returns whether one quantity can be subtracted from another.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(5.0, m)
///   assert_true(distance.can_sub(Quantity::new(2.0, m)))
///   assert_false(distance.can_sub(Quantity::new(2.0, s)))
/// }
/// ```
pub fn Quantity::can_sub(self : Quantity, other : Quantity) -> Bool {
  self.dimension().is_same(other.dimension())
}

///|
/// Subtracts `other` from `self`, returning `None` when dimensions differ.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = @unit.Un::base("m", @dimension.Dimension::length())
///   let s = @unit.Un::base("s", @dimension.Dimension::time())
///   let distance = Quantity::new(5.0, m)
///   match distance.checked_sub(Quantity::new(2.0, m)) {
///     Some(result) => assert_eq(result.value(), 3.0)
///     None => fail("expected compatible subtraction")
///   }
///   assert_true(distance.checked_sub(Quantity::new(2.0, s)) is None)
/// }
/// ```
pub fn Quantity::checked_sub(self : Quantity, other : Quantity) -> Quantity? {
  match other.checked_to(self.u) {
    Some(converted) => Some({ v: self.v - converted.v, u: self.u })
    None => None
  }
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
  match self.checked_sub(other) {
    Some(result) => result
    None => raise DimensionMismatch((self.dimension(), other.dimension()))
  }
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

///|
/// Formats a quantity as `<value> <unit>` using compact ASCII unit notation.
///
/// For other notations see [`format_quantity_with`].
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = @unit.Un::base("m", @dimension.Dimension::length())
///   let second = @unit.Un::base("s", @dimension.Dimension::time())
///   let acceleration = Quantity::new(9.8, meter / second.pow(2))
///   assert_eq(format_quantity(acceleration), "9.8 m/s^2")
/// }
/// ```
pub fn format_quantity(quantity : Quantity) -> String {
  format_quantity_with(quantity, @unit.FormatStyle::Ascii)
}

///|
/// Formats a quantity as `<value> <unit>` using the given
/// [`@unit.FormatStyle`].
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = @unit.Un::base("m", @dimension.Dimension::length())
///   let second = @unit.Un::base("s", @dimension.Dimension::time())
///   let acceleration = Quantity::new(9.8, meter / second.pow(2))
///   assert_eq(
///     format_quantity_with(acceleration, @unit.FormatStyle::Si),
///     "9.8 m/s²",
///   )
/// }
/// ```
pub fn format_quantity_with(
  quantity : Quantity,
  style : @unit.FormatStyle,
) -> String {
  "\{quantity.value()} \{@unit.format_unit_with(quantity.unit(), style)}"
}
