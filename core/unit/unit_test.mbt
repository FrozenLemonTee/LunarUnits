///|
/// A base unit has scale 1 and the dimension it was given.
test "base unit has unit scale" {
  let meter = Un::base("m", @dimension.Dimension::length())
  assert_eq(meter.scale(), 1.0)
  assert_true(meter.dimension().is_same(@dimension.Dimension::length()))
}

///|
/// A scaled unit carries its scale factor.
test "scaled unit carries scale" {
  let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
  assert_eq(km.scale(), 1000.0)
  assert_true(km.is_compatible(Un::base("m", @dimension.Dimension::length())))
}

///|
/// Composite units combine both scale and dimension.
test "composite unit combines scale and dimension" {
  let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
  let hour = Un::scaled("h", @dimension.Dimension::time(), 3600.0)
  let kmph = km.div(hour)
  assert_eq(kmph.scale(), 1000.0 / 3600.0)
  let expected = @dimension.Dimension::length().div(
    @dimension.Dimension::time(),
  )
  assert_true(kmph.dimension().is_same(expected))
}

///|
/// Multiplication and division operators are shorthands for unit algebra.
test "operators compose units" {
  let m = Un::base("m", @dimension.Dimension::length())
  let s = Un::base("s", @dimension.Dimension::time())
  let mps = m / s
  assert_eq(mps, m.div(s))
  assert_true(
    mps
    .dimension()
    .is_same(@dimension.Dimension::length() / @dimension.Dimension::time()),
  )
  assert_eq(m * m, m.pow(2))
}

///|
/// Powers compose dimensions: m^3 is a volume.
test "power composes dimension" {
  let m = Un::base("m", @dimension.Dimension::length())
  let volume = m.pow(3)
  assert_true(volume.dimension().is_same(@dimension.Dimension::length().pow(3)))
}

///|
/// Compatibility tracks dimension, not scale.
test "compatibility tracks dimension" {
  let m = Un::base("m", @dimension.Dimension::length())
  let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
  let s = Un::base("s", @dimension.Dimension::time())
  assert_true(m.is_compatible(km))
  assert_false(m.is_compatible(s))
}

///|
/// Conversion between compatible units; None for incompatible ones.
test "conversion factor" {
  let m = Un::base("m", @dimension.Dimension::length())
  let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
  let s = Un::base("s", @dimension.Dimension::time())
  assert_true(km.conversion_factor(m) is Some(1000.0))
  assert_true(m.conversion_factor(km) is Some(0.001))
  assert_true(m.conversion_factor(s) is None)
}

///|
/// 36 km/h equals 10 m/s via the conversion factor.
test "km per hour to m per s" {
  let m = Un::base("m", @dimension.Dimension::length())
  let s = Un::base("s", @dimension.Dimension::time())
  let km = Un::scaled("km", @dimension.Dimension::length(), 1000.0)
  let hour = Un::scaled("h", @dimension.Dimension::time(), 3600.0)
  let kmph = km.div(hour)
  let mps = m.div(s)
  let factor = kmph.conversion_factor(mps).unwrap()
  assert_eq(36.0 * factor, 10.0)
}

///|
/// Structural snapshot of the m/s unit (symbol monomial plus dimension).
test "velocity unit structure snapshot" {
  let m = Un::base("m", @dimension.Dimension::length())
  let s = Un::base("s", @dimension.Dimension::time())
  let mps = m.div(s)
  debug_inspect(
    mps,
    content=(
      #|{
      #|  repr: { coeff: 1, factors: [("m", 1), ("s", -1)] },
      #|  dim: { repr: { coeff: 1, factors: [("L", 1), ("T", -1)] } },
      #|}
    ),
  )
}

///|
/// ASCII formatter separates numerator and denominator exponents.
test "format unit ascii" {
  let m = Un::base("m", @dimension.Dimension::length())
  let s = Un::base("s", @dimension.Dimension::time())
  let kg = Un::base("kg", @dimension.Dimension::mass())
  assert_eq(format_unit(m / s.pow(2)), "m/s^2")
  assert_eq(format_unit(kg * m / s.pow(2)), "kg*m/s^2")
  assert_eq(format_unit(m.pow(2)), "m^2")
  assert_eq(format_unit(m / (kg * s.pow(2))), "m/(kg*s^2)")
  assert_eq(format_unit(m / m), "1")
}

///|
/// SI style prints superscript exponents and a middle-dot separator.
test "format unit si" {
  let m = Un::base("m", @dimension.Dimension::length())
  let s = Un::base("s", @dimension.Dimension::time())
  let kg = Un::base("kg", @dimension.Dimension::mass())
  assert_eq(format_unit_with(m / s.pow(2), FormatStyle::Si), "m/s²")
  assert_eq(format_unit_with(kg * m / s.pow(2), FormatStyle::Si), "kg·m/s²")
  assert_eq(format_unit_with(m.pow(2), FormatStyle::Si), "m²")
  assert_eq(
    format_unit_with(m / (kg * s.pow(2)), FormatStyle::Si),
    "m/(kg·s²)",
  )
  assert_eq(format_unit_with(m.pow(10), FormatStyle::Si), "m¹⁰")
  assert_eq(format_unit_with(m / m, FormatStyle::Si), "1")
}

///|
/// LaTeX style wraps symbols in `\mathrm` and braces exponents.
test "format unit latex" {
  let m = Un::base("m", @dimension.Dimension::length())
  let s = Un::base("s", @dimension.Dimension::time())
  let kg = Un::base("kg", @dimension.Dimension::mass())
  assert_eq(
    format_unit_with(m / s.pow(2), FormatStyle::Latex),
    "\\mathrm{m}/\\mathrm{s}^{2}",
  )
  assert_eq(
    format_unit_with(kg * m, FormatStyle::Latex),
    "\\mathrm{kg}\\cdot \\mathrm{m}",
  )
  assert_eq(
    format_unit_with(m / (kg * s.pow(2)), FormatStyle::Latex),
    "\\mathrm{m}/(\\mathrm{kg}\\cdot \\mathrm{s}^{2})",
  )
}
