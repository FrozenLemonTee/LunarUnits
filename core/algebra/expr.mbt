///|
/// A syntactic expression tree (SymPy-style nodes) used only for construction.
///
/// Every `Expr` collapses into a unique canonical `Monomial` after `normalize`;
/// upper layers only consume `Monomial`. This algebra layer handles
/// multiplication, division and powers only (a free abelian group over
/// symbols) — addition belongs to the dimension-checked quantity layer.
///
/// # Example
///
/// ```mbt check
/// test {
///   // "a * a" and "a^2" are two ways to write the same thing.
///   let lhs = normalize(Mul([Symbol("a"), Symbol("a")]))
///   let rhs = normalize(Pow(Symbol("a"), 2))
///   assert_eq(lhs, rhs)
/// }
/// ```
pub(all) enum Expr {
  /// A numeric constant, e.g. 1, 2, 3.5.
  Scalar(Double)
  /// An atomic symbol, e.g. "meter", "second".
  Symbol(String)
  /// The multiplicative identity (an empty expression).
  One
  /// A product of subexpressions.
  Mul(Array[Expr])
  /// An integer power (Int for the MVP; rational powers may come later).
  Pow(Expr, Int)
} derive(Eq, Debug)
