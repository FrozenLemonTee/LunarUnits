///|
/// An affine unit: it maps a reading on its scale to an absolute value on a
/// linear base unit by `base_value = reading * scale + offset` (the offset is
/// expressed in base units).
///
/// Affine units are deliberately **not** part of the multiplicative unit
/// algebra: `Un` carries no offset, so absolute points cannot be multiplied or
/// added the way linear quantities can. The type is generic — temperature is
/// just the first user (see the shipped `celsius`/`fahrenheit`/... presets), and
/// callers can define their own scales with `AffineUn::new`.
pub struct AffineUn {
  symbol : String
  base : @unit.Un
  scale : Double
  offset : Double
} derive(Eq)

///|
/// Defines an affine unit: one reading equals `reading * scale + offset` of the
/// linear `base` unit. `symbol` is used only for display.
///
/// # Example
///
/// ```mbt check
/// test {
///   // Degrees Celsius: same size as a kelvin, shifted by 273.15.
///   let c = AffineUn::new("°C", @si.kelvin, 1.0, 273.15)
///   assert_eq(c.offset(), 273.15)
/// }
/// ```
pub fn AffineUn::new(
  symbol : String,
  base : @unit.Un,
  scale : Double,
  offset : Double,
) -> AffineUn {
  { symbol, base, scale, offset }
}

///|
/// The display symbol of the unit (e.g. `°C`).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(celsius.symbol(), "°C")
/// }
/// ```
pub fn AffineUn::symbol(self : AffineUn) -> String {
  self.symbol
}

///|
/// The linear base unit the affine scale is anchored to (e.g. the kelvin).
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(celsius.base().is_compatible(@si.kelvin))
/// }
/// ```
pub fn AffineUn::base(self : AffineUn) -> @unit.Un {
  self.base
}

///|
/// The multiplicative factor relative to the base unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(celsius.scale(), 1.0)
/// }
/// ```
pub fn AffineUn::scale(self : AffineUn) -> Double {
  self.scale
}

///|
/// The additive offset, expressed in base units.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(celsius.offset(), 273.15)
/// }
/// ```
pub fn AffineUn::offset(self : AffineUn) -> Double {
  self.offset
}

///|
/// An absolute point on an affine scale: a reading paired with its affine unit
/// (e.g. `20 °C`).
///
/// A point supports only the operations that make physical sense: affine
/// conversion (`to`), bridging to a linear `Quantity` (`to_base`), shifting by
/// an interval (`shift`), and taking the difference of two points
/// (`difference`). It deliberately offers no `point + point` or `point * scalar`
/// — those are the classic affine-unit mistakes. An interval/difference is an
/// ordinary linear `@quantity.Quantity` on the base dimension.
pub struct Point {
  value : Double
  unit : AffineUn
}

///|
/// Creates a point reading `value` on `unit`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(20.0, celsius).value(), 20.0)
/// }
/// ```
pub fn Point::new(value : Double, unit : AffineUn) -> Point {
  { value, unit }
}

///|
/// The reading in the point's own unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(37.0, celsius).value(), 37.0)
/// }
/// ```
pub fn Point::value(self : Point) -> Double {
  self.value
}

///|
/// The point's affine unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(Point::new(37.0, celsius).unit().symbol(), "°C")
/// }
/// ```
pub fn Point::unit(self : Point) -> AffineUn {
  self.unit
}

///|
/// The absolute value as an ordinary linear `Quantity` on the base unit
/// (e.g. `20 °C` -> `293.15 K`). This is the bridge into the multiplicative
/// core.
///
/// # Example
///
/// ```mbt check
/// test {
///   let boiling = Point::new(100.0, celsius)
///   assert_eq(boiling.to_base().value(), 373.15)
/// }
/// ```
pub fn Point::to_base(self : Point) -> @quantity.Quantity {
  @quantity.Quantity::new(
    self.value * self.unit.scale + self.unit.offset,
    self.unit.base,
  )
}

///|
/// Converts the point to another affine unit on the same base dimension
/// (e.g. `20 °C` -> `68 °F`). Raises `DimensionMismatch` when the base units are
/// dimensionally incompatible.
///
/// # Example
///
/// ```mbt check
/// test {
///   let boiling = Point::new(212.0, fahrenheit)
///   assert_eq(boiling.to(celsius).value(), 100.0)
/// }
/// ```
pub fn Point::to(
  self : Point,
  target : AffineUn,
) -> Point raise @quantity.DimensionMismatch {
  let absolute = self.to_base().to(target.base)
  Point::new((absolute.value() - target.offset) / target.scale, target)
}

///|
/// Non-raising `to`: `None` when the base units are incompatible.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_true(Point::new(0.0, celsius).checked_to(kelvin) is Some(_))
/// }
/// ```
pub fn Point::checked_to(self : Point, target : AffineUn) -> Point? {
  Some(self.to(target)) catch {
    _ => None
  }
}

///|
/// Shifts the point by an interval, returning another point of the same unit
/// (`20 °C` shifted by `5 K` is `25 °C`). The interval is an ordinary linear
/// `Quantity` on the base dimension; subtract by passing a negative interval.
/// Raises `DimensionMismatch` when the interval's dimension does not match.
///
/// # Example
///
/// ```mbt check
/// test {
///   let warmed = Point::new(20.0, celsius).shift(
///     @quantity.Quantity::new(5.0, @si.kelvin),
///   )
///   assert_eq(warmed.value(), 25.0)
/// }
/// ```
pub fn Point::shift(
  self : Point,
  interval : @quantity.Quantity,
) -> Point raise @quantity.DimensionMismatch {
  let delta = interval.to(self.unit.base).value()
  Point::new(self.value + delta / self.unit.scale, self.unit)
}

///|
/// Non-raising `shift`: `None` when the interval's dimension is incompatible.
///
/// # Example
///
/// ```mbt check
/// test {
///   let warmed = Point::new(20.0, celsius).checked_shift(
///     @quantity.Quantity::new(5.0, @si.kelvin),
///   )
///   assert_true(warmed is Some(_))
/// }
/// ```
pub fn Point::checked_shift(
  self : Point,
  interval : @quantity.Quantity,
) -> Point? {
  Some(self.shift(interval)) catch {
    _ => None
  }
}

///|
/// The difference between two points, as a linear interval `Quantity` on the
/// base unit (`30 °C` minus `20 °C` is `10 K`). Raises `DimensionMismatch` when
/// the points live on incompatible base dimensions.
///
/// # Example
///
/// ```mbt check
/// test {
///   let interval = Point::new(30.0, celsius).difference(Point::new(20.0, celsius))
///   assert_eq(interval.value(), 10.0)
/// }
/// ```
pub fn Point::difference(
  self : Point,
  other : Point,
) -> @quantity.Quantity raise @quantity.DimensionMismatch {
  let other_base = other.to_base().to(self.unit.base)
  @quantity.Quantity::new(
    self.to_base().value() - other_base.value(),
    self.unit.base,
  )
}

///|
/// Non-raising `difference`: `None` when the base dimensions are incompatible.
///
/// # Example
///
/// ```mbt check
/// test {
///   let interval = Point::new(30.0, celsius).checked_difference(
///     Point::new(20.0, celsius),
///   )
///   assert_true(interval is Some(_))
/// }
/// ```
pub fn Point::checked_difference(
  self : Point,
  other : Point,
) -> @quantity.Quantity? {
  Some(self.difference(other)) catch {
    _ => None
  }
}

///|
/// Formats a point as `<reading> <symbol>`, e.g. `20 °C`.
///
/// # Example
///
/// ```mbt check
/// test {
///   assert_eq(format_point(Point::new(20.0, celsius)), "20 °C")
/// }
/// ```
pub fn format_point(point : Point) -> String {
  "\{point.value} \{point.unit.symbol}"
}

///|
/// Debug-oriented display (mirrors `format_point`).
pub impl Show for Point with fn output(self, logger) {
  logger.write_string(format_point(self))
}
