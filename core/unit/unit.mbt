///|
/// A unit of measurement: a unit-symbol monomial paired with the physical
/// dimension it measures.
///
/// The type is named `Un` (short for "unit").
///
/// The monomial's symbols are unit symbols (e.g. "m", "s") and its coefficient
/// is the scale relative to the coherent base unit of that dimension — one of
/// this unit equals `scale` base units. Composite units (e.g. m/s) arise from
/// `mul` / `div` / `pow`, which keep the symbol structure, the scale and the
/// dimension in sync.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = Un::base("m", @dimension.Dimension::length())
///   let second = Un::base("s", @dimension.Dimension::time())
///   let mps = meter.div(second)
///   let expected = @dimension.Dimension::length().div(
///     @dimension.Dimension::time(),
///   )
///   assert_true(mps.dimension().is_same(expected))
/// }
/// ```
pub struct Un {
  repr : @algebra.Monomial
  dim : @dimension.Dimension
} derive(Eq, Debug)

///|
/// Manual `Show` (so `assert_eq` can print diffs on failure).
pub impl Show for Un with fn output(self, logger) {
  logger.write_string("Un(")
  Show::output(self.repr, logger)
  logger.write_string(", ")
  Show::output(self.dim, logger)
  logger.write_string(")")
}

///|
/// Allows `lhs * rhs` as shorthand for `lhs.mul(rhs)`.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let area = m * m
///   assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
/// }
/// ```
pub impl Mul for Un with fn mul(self : Un, other : Un) -> Un {
  { repr: self.repr.mul(other.repr), dim: self.dim.mul(other.dim) }
}

///|
/// Allows `lhs / rhs` as shorthand for `lhs.div(rhs)`.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let s = Un::base("s", @dimension.Dimension::time())
///   assert_true((m / s).dimension().is_same(m.div(s).dimension()))
/// }
/// ```
pub impl Div for Un with fn div(self : Un, other : Un) -> Un {
  { repr: self.repr.div(other.repr), dim: self.dim.div(other.dim) }
}

///|
/// Defines a coherent base unit (scale 1) with the given symbol and dimension.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = Un::base("m", @dimension.Dimension::length())
///   assert_eq(meter.scale(), 1.0)
///   assert_true(meter.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub fn Un::base(symbol : String, dim : @dimension.Dimension) -> Un {
  { repr: @algebra.Monomial::symbol(symbol), dim }
}

///|
/// Defines a scaled unit: one of it equals `scale` coherent base units (e.g. a
/// kilometre is 1000 metres).
///
/// # Example
///
/// ```mbt check
/// test {
///   let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   assert_eq(km.scale(), 1000.0)
/// }
/// ```
pub fn Un::scaled(
  symbol : String,
  dim : @dimension.Dimension,
  scale : Double,
) -> Un {
  {
    repr: @algebra.Monomial::scalar(scale).mul(
      @algebra.Monomial::symbol(symbol),
    ),
    dim,
  }
}

///|
/// Returns the scale factor to the coherent base unit (one unit equals `scale`
/// base units).
///
/// # Example
///
/// ```mbt check
/// test {
///   let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   assert_eq(km.scale(), 1000.0)
/// }
/// ```
pub fn Un::scale(self : Un) -> Double {
  self.repr.coefficient()
}

///|
/// Returns the physical dimension this unit measures.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = Un::base("m", @dimension.Dimension::length())
///   assert_true(meter.dimension().is_same(@dimension.Dimension::length()))
/// }
/// ```
pub fn Un::dimension(self : Un) -> @dimension.Dimension {
  self.dim
}

///|
/// Multiplies two units, composing both their symbol structure and their
/// dimensions.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let area = m.mul(m)
///   assert_true(area.dimension().is_same(@dimension.Dimension::length().pow(2)))
/// }
/// ```
pub fn Un::mul(self : Un, other : Un) -> Un {
  { repr: self.repr.mul(other.repr), dim: self.dim.mul(other.dim) }
}

///|
/// Divides one unit by another, composing both their symbol structure and their
/// dimensions.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let s = Un::base("s", @dimension.Dimension::time())
///   let velocity = m.div(s)
///   let expected = @dimension.Dimension::length().div(
///     @dimension.Dimension::time(),
///   )
///   assert_true(velocity.dimension().is_same(expected))
/// }
/// ```
pub fn Un::div(self : Un, other : Un) -> Un {
  { repr: self.repr.div(other.repr), dim: self.dim.div(other.dim) }
}

///|
/// Raises a unit to an integer power.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let volume = m.pow(3)
///   assert_true(volume.dimension().is_same(@dimension.Dimension::length().pow(3)))
/// }
/// ```
pub fn Un::pow(self : Un, n : Int) -> Un {
  { repr: self.repr.pow(n), dim: self.dim.pow(n) }
}

///|
/// Returns whether two units measure the same dimension (and can therefore be
/// converted into one another).
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   let s = Un::base("s", @dimension.Dimension::time())
///   assert_true(m.is_compatible(km))
///   assert_false(m.is_compatible(s))
/// }
/// ```
pub fn Un::is_compatible(self : Un, other : Un) -> Bool {
  self.dim.is_same(other.dim)
}

///|
/// Returns the factor that converts a value expressed in `self` into one
/// expressed in `target`: `value_in_target = value_in_self * factor`. Returns
/// `None` when the units are not dimensionally compatible.
///
/// # Example
///
/// ```mbt check
/// test {
///   let m = Un::base("m", @dimension.Dimension::length())
///   let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
///   // 1 km equals 1000 m; 1 m equals 0.001 km.
///   assert_true(km.conversion_factor(m) is Some(1000.0))
///   assert_true(m.conversion_factor(km) is Some(0.001))
///   // Incompatible dimensions cannot be converted.
///   let s = Un::base("s", @dimension.Dimension::time())
///   assert_true(m.conversion_factor(s) is None)
/// }
/// ```
pub fn Un::conversion_factor(self : Un, target : Un) -> Double? {
  if self.is_compatible(target) {
    Some(self.scale() / target.scale())
  } else {
    None
  }
}

///|
/// Formats one unit factor in ASCII notation.
fn format_factor(symbol : String, exponent : Int) -> String {
  if exponent == 1 {
    symbol
  } else {
    "\{symbol}^\{exponent}"
  }
}

///|
/// Joins already-formatted factors with `*`.
fn join_factors(factors : Array[String]) -> String {
  if factors.is_empty() {
    return ""
  }
  let mut result = factors[0]
  for i in 1..<factors.length() {
    result = "\{result}*\{factors[i]}"
  }
  result
}

///|
/// Adds parentheses when a denominator contains multiple factors.
fn format_denominator(factors : Array[String]) -> String {
  let denominator = join_factors(factors)
  if factors.length() == 1 {
    denominator
  } else {
    "(\{denominator})"
  }
}

///|
/// Returns whether a symbol has a conventional display priority.
fn has_display_priority(symbol : String) -> Bool {
  symbol == "kg" ||
  symbol == "m" ||
  symbol == "s" ||
  symbol == "A" ||
  symbol == "K" ||
  symbol == "mol" ||
  symbol == "cd"
}

///|
/// Adds priority factors in conventional SI display order.
fn push_priority_factors(
  output : Array[String],
  factors : Array[(String, String)],
) -> Unit {
  let priority = ["kg", "m", "s", "A", "K", "mol", "cd"]
  for target in priority {
    for pair in factors {
      let (symbol, formatted) = pair
      if symbol == target {
        output.push(formatted)
      }
    }
  }
}

///|
/// Adds all factors from `source` to `output`.
fn push_all_factors(output : Array[String], source : Array[String]) -> Unit {
  for factor in source {
    output.push(factor)
  }
}

///|
/// Splits factors into numerator and denominator while scanning terms once.
fn split_format_factors(
  terms : Array[(String, Int)],
) -> (Array[String], Array[String]) {
  let numerator_priority : Array[(String, String)] = []
  let denominator_priority : Array[(String, String)] = []
  let numerator_other : Array[String] = []
  let denominator_other : Array[String] = []
  for pair in terms {
    let (symbol, exponent) = pair
    if exponent > 0 {
      let formatted = format_factor(symbol, exponent)
      if has_display_priority(symbol) {
        numerator_priority.push((symbol, formatted))
      } else {
        numerator_other.push(formatted)
      }
    } else {
      let formatted = format_factor(symbol, -exponent)
      if has_display_priority(symbol) {
        denominator_priority.push((symbol, formatted))
      } else {
        denominator_other.push(formatted)
      }
    }
  }
  let numerator : Array[String] = []
  let denominator : Array[String] = []
  push_priority_factors(numerator, numerator_priority)
  push_all_factors(numerator, numerator_other)
  push_priority_factors(denominator, denominator_priority)
  push_all_factors(denominator, denominator_other)
  (numerator, denominator)
}

///|
/// Formats a unit in compact ASCII notation for user-facing display.
///
/// Positive exponents are printed in the numerator and negative exponents in
/// the denominator. Unit scale factors are not printed; the symbolic unit name
/// chosen at construction time is used instead.
///
/// # Example
///
/// ```mbt check
/// test {
///   let meter = Un::base("m", @dimension.Dimension::length())
///   let second = Un::base("s", @dimension.Dimension::time())
///   assert_eq(format_unit(meter / second.pow(2)), "m/s^2")
///   assert_eq(format_unit(meter.pow(2)), "m^2")
/// }
/// ```
pub fn format_unit(unit : Un) -> String {
  let terms = unit.repr.terms()
  let (numerator, denominator) = split_format_factors(terms)
  if denominator.is_empty() {
    return if numerator.is_empty() { "1" } else { join_factors(numerator) }
  }
  let denominator_text = format_denominator(denominator)
  if numerator.is_empty() {
    "1/\{denominator_text}"
  } else {
    "\{join_factors(numerator)}/\{denominator_text}"
  }
}
