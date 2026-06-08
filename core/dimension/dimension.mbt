///|
/// A physical dimension expressed over the seven SI base dimensions:
/// length (L), mass (M), time (T), electric current (I), thermodynamic
/// temperature (Θ), amount of substance (N) and luminous intensity (J).
///
/// A `Dimension` reuses the algebra layer's `Monomial`: the symbols are the
/// base-dimension tags and the coefficient is always 1 (dimensions carry no
/// scale). Two dimensions are equal exactly when their exponent vectors match,
/// which is the foundation of dimensional checking in the quantity layer.
///
/// # Example
///
/// ```mbt check
/// test {
///   // Velocity has dimension length / time.
///   let velocity = Dimension::length().div(Dimension::time())
///   let acceleration = velocity.div(Dimension::time())
///   assert_eq(acceleration, Dimension::length().div(Dimension::time().pow(2)))
/// }
/// ```
pub struct Dimension {
  repr : @algebra.Monomial
} derive(Eq, Debug)

///|
/// Manual `Show` (so `assert_eq` can print diffs on failure), delegating to the
/// underlying monomial.
pub impl Show for Dimension with fn output(self, logger) {
  Show::output(self.repr, logger)
}

///|
/// Builds a base dimension from its single-letter tag.
fn base(symbol : String) -> Dimension {
  { repr: @algebra.Monomial::symbol(symbol) }
}

///|
/// The length dimension (L).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(Dimension::length() == Dimension::mass())
/// }
/// ```
pub fn Dimension::length() -> Dimension {
  base("L")
}

///|
/// The mass dimension (M).
///
/// # Example
///
/// ```mbt check
/// test {
///   // Momentum has dimension mass * length / time.
///   let momentum = Dimension::mass()
///     .mul(Dimension::length())
///     .div(Dimension::time())
///   assert_false(momentum.is_dimensionless())
/// }
/// ```
pub fn Dimension::mass() -> Dimension {
  base("M")
}

///|
/// The time dimension (T).
///
/// # Example
///
/// ```mbt check
/// test {
///   // Frequency has dimension 1 / time.
///   let frequency = Dimension::dimensionless().div(Dimension::time())
///   assert_eq(frequency, Dimension::time().pow(-1))
/// }
/// ```
pub fn Dimension::time() -> Dimension {
  base("T")
}

///|
/// The electric current dimension (I).
///
/// # Example
///
/// ```mbt check
/// test {
///   // Electric charge has dimension current * time.
///   let charge = Dimension::electric_current().mul(Dimension::time())
///   assert_false(charge.is_dimensionless())
/// }
/// ```
pub fn Dimension::electric_current() -> Dimension {
  base("I")
}

///|
/// The thermodynamic temperature dimension (Θ).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(Dimension::temperature() == Dimension::mass())
/// }
/// ```
pub fn Dimension::temperature() -> Dimension {
  base("Θ")
}

///|
/// The amount-of-substance dimension (N).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(Dimension::amount_of_substance() == Dimension::length())
/// }
/// ```
pub fn Dimension::amount_of_substance() -> Dimension {
  base("N")
}

///|
/// The luminous-intensity dimension (J).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_false(Dimension::luminous_intensity() == Dimension::time())
/// }
/// ```
pub fn Dimension::luminous_intensity() -> Dimension {
  base("J")
}

///|
/// The dimensionless quantity (no base dimensions).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(Dimension::dimensionless().is_dimensionless())
///   // A ratio of like dimensions is dimensionless.
///   assert_eq(
///     Dimension::length().div(Dimension::length()),
///     Dimension::dimensionless(),
///   )
/// }
/// ```
pub fn Dimension::dimensionless() -> Dimension {
  { repr: @algebra.Monomial::one() }
}

///|
/// Multiplies two dimensions (adds their exponent vectors).
///
/// # Example
///
/// ```mbt check
/// test {
///   // Area is length * length.
///   assert_eq(
///     Dimension::length().mul(Dimension::length()),
///     Dimension::length().pow(2),
///   )
/// }
/// ```
pub fn Dimension::mul(self : Dimension, other : Dimension) -> Dimension {
  { repr: self.repr.mul(other.repr) }
}

///|
/// Divides one dimension by another (subtracts exponent vectors).
///
/// # Example
///
/// ```mbt check
/// test {
///   // Velocity is length / time; multiplying back by time gives length.
///   let v = Dimension::length().div(Dimension::time())
///   assert_eq(v.mul(Dimension::time()), Dimension::length())
/// }
/// ```
pub fn Dimension::div(self : Dimension, other : Dimension) -> Dimension {
  { repr: self.repr.div(other.repr) }
}

///|
/// Raises a dimension to an integer power.
///
/// # Example
///
/// ```mbt check
/// test {
///   // Volume is length^3.
///   let volume = Dimension::length().pow(3)
///   assert_eq(
///     volume,
///     Dimension::length().mul(Dimension::length()).mul(Dimension::length()),
///   )
/// }
/// ```
pub fn Dimension::pow(self : Dimension, n : Int) -> Dimension {
  { repr: self.repr.pow(n) }
}

///|
/// Returns whether this is the dimensionless quantity.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(Dimension::length().div(Dimension::length()).is_dimensionless())
///   assert_false(Dimension::length().is_dimensionless())
/// }
/// ```
pub fn Dimension::is_dimensionless(self : Dimension) -> Bool {
  self.repr.is_dimensionless()
}

///|
/// Returns whether two dimensions are the same physical dimension. This is the
/// check the quantity layer uses to allow addition and subtraction.
///
/// # Example
///
/// ```mbt check
/// test {
///   // Two ways of building the force dimension agree.
///   let f1 = Dimension::mass()
///     .mul(Dimension::length())
///     .div(Dimension::time().pow(2))
///   let f2 = Dimension::mass().mul(
///     Dimension::length().div(Dimension::time().pow(2)),
///   )
///   assert_true(f1.is_same(f2))
/// }
/// ```
pub fn Dimension::is_same(self : Dimension, other : Dimension) -> Bool {
  self.repr.same_factors(other.repr)
}
