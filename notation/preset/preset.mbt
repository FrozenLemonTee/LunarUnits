// One catalog builder per `units/*` package. Each function is self-contained
// (only its own package's symbols); compose them with `merge`, or use `all` for
// the union. Symbols match each unit's conventional display symbol so that
// parsing and formatting stay consistent.

///|
/// The seven SI base unit symbols: `m`, `kg`, `s`, `A`, `K`, `mol`, `cd`.
///
/// # Example
///
/// ```mbt check
/// test {
///   let catalog = si()
///   assert_true(catalog.lookup("m") is Some(_))
///   assert_true(catalog.lookup("cd") is Some(_))
///   assert_true(catalog.lookup("N") is None)
/// }
/// ```
pub fn si() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("m", @si.meter),
    ("kg", @si.kilogram),
    ("s", @si.second),
    ("A", @si.ampere),
    ("K", @si.kelvin),
    ("mol", @si.mole),
    ("cd", @si.candela),
  ])
}

///|
/// Time-duration units: `min`, `h`, `d`, `ms`, `µs`, `ns`. The second's symbol
/// `s` is provided by `si()`.
pub fn time() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("min", @time.minute),
    ("h", @time.hour),
    ("d", @time.day),
    ("ms", @time.millisecond),
    ("µs", @time.microsecond),
    ("ns", @time.nanosecond),
  ])
}

///|
/// Length, area and volume units: `km`, `cm`, `mm`, `in`, `ft`, `mi`, `m²`,
/// `ha`, `m³`, `L`, `mL`, `gal`.
pub fn geometry() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("km", @geometry.kilometer),
    ("cm", @geometry.centimeter),
    ("mm", @geometry.millimeter),
    ("in", @geometry.inch),
    ("ft", @geometry.foot),
    ("mi", @geometry.mile),
    ("m²", @geometry.square_meter),
    ("ha", @geometry.hectare),
    ("m³", @geometry.cubic_meter),
    ("L", @geometry.liter),
    ("mL", @geometry.milliliter),
    ("gal", @geometry.gallon),
  ])
}

///|
/// Mass and density units: `g`, `mg`, `t`, `lb`, `oz`, `kg/m³`, `g/cm³`.
pub fn mass() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("g", @mass.gram),
    ("mg", @mass.milligram),
    ("t", @mass.tonne),
    ("lb", @mass.pound),
    ("oz", @mass.ounce),
    ("kg/m³", @mass.kilogram_per_cubic_meter),
    ("g/cm³", @mass.gram_per_cubic_centimeter),
  ])
}

///|
/// Force, pressure, velocity, energy and power units: `N`, `kN`, `dyn`, `Pa`,
/// `kPa`, `bar`, `atm`, `psi`, `m/s`, `km/h`, `mph`, `J`, `kJ`, `kWh`, `cal`,
/// `W`, `kW`, `hp`.
pub fn mechanics() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("N", @mechanics.newton),
    ("kN", @mechanics.kilonewton),
    ("dyn", @mechanics.dyne),
    ("Pa", @mechanics.pascal),
    ("kPa", @mechanics.kilopascal),
    ("bar", @mechanics.bar),
    ("atm", @mechanics.atmosphere),
    ("psi", @mechanics.psi),
    ("m/s", @mechanics.meter_per_second),
    ("km/h", @mechanics.kilometer_per_hour),
    ("mph", @mechanics.mile_per_hour),
    ("J", @mechanics.joule),
    ("kJ", @mechanics.kilojoule),
    ("kWh", @mechanics.kilowatt_hour),
    ("cal", @mechanics.calorie),
    ("W", @mechanics.watt),
    ("kW", @mechanics.kilowatt),
    ("hp", @mechanics.horsepower),
  ])
}

///|
/// Dynamic and kinematic viscosity, and permeability units: `Pa·s`, `P`, `cP`,
/// `m²/s`, `St`, `cSt`, `D`.
pub fn fluid() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("Pa·s", @fluid.pascal_second),
    ("P", @fluid.poise),
    ("cP", @fluid.centipoise),
    ("m²/s", @fluid.square_meter_per_second),
    ("St", @fluid.stokes),
    ("cSt", @fluid.centistokes),
    ("D", @fluid.darcy),
  ])
}

///|
/// Heat-transfer and specific-heat units: `W/(m²·K)`, `W/(m·K)`, `J/(kg·K)`,
/// `BTU`.
pub fn thermal() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("W/(m²·K)", @thermal.watt_per_square_meter_kelvin),
    ("W/(m·K)", @thermal.watt_per_meter_kelvin),
    ("J/(kg·K)", @thermal.joule_per_kilogram_kelvin),
    ("BTU", @thermal.british_thermal_unit),
  ])
}

///|
/// Electromagnetism units: `C`, `Ah`, `V`, `Ω`, `S`, `F`, `H`, `Wb`, `T`.
pub fn electromagnetism() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("C", @electromagnetism.coulomb),
    ("Ah", @electromagnetism.ampere_hour),
    ("V", @electromagnetism.volt),
    ("Ω", @electromagnetism.ohm),
    ("S", @electromagnetism.siemens),
    ("F", @electromagnetism.farad),
    ("H", @electromagnetism.henry),
    ("Wb", @electromagnetism.weber),
    ("T", @electromagnetism.tesla),
  ])
}

///|
/// Plane-angle and frequency units: `rad`, `deg`, `turn`, `arcmin`, `arcsec`,
/// `cycle`, `Hz`.
pub fn angle() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("rad", @angle.radian),
    ("deg", @angle.degree),
    ("turn", @angle.turn),
    ("arcmin", @angle.arcminute),
    ("arcsec", @angle.arcsecond),
    ("cycle", @angle.cycle),
    ("Hz", @angle.hertz),
  ])
}

///|
/// Solid-angle units: `sr`, `deg^2`, `sp`.
pub fn solid_angle() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("sr", @solid_angle.steradian),
    ("deg^2", @solid_angle.square_degree),
    ("sp", @solid_angle.spat),
  ])
}

///|
/// Information units: `bit`, `B`, decimal `KB`/`MB`/`GB` and binary
/// `KiB`/`MiB`/`GiB`.
pub fn information() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("bit", @information.bit),
    ("B", @information.byte),
    ("KB", @information.kilobyte),
    ("MB", @information.megabyte),
    ("GB", @information.gigabyte),
    ("KiB", @information.kibibyte),
    ("MiB", @information.mebibyte),
    ("GiB", @information.gibibyte),
  ])
}

///|
/// Currency units: `$`, `cent`, `k$`, `M$`.
///
/// Cross-currency symbols are intentionally omitted: exchange rates vary over
/// time, so callers build foreign currencies with `@currency.at_rate` and add
/// them via `with_unit` when needed.
pub fn currency() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("$", @currency.dollar),
    ("cent", @currency.cent),
    ("k$", @currency.kilodollar),
    ("M$", @currency.megadollar),
  ])
}

///|
/// Discrete-count units: `ea`, `doz`, `gr`.
pub fn count() -> @catalog.Catalog {
  @catalog.Catalog::new().with_all([
    ("ea", @count.each),
    ("doz", @count.dozen),
    ("gr", @count.gross),
  ])
}

///|
/// The union of every per-package catalog: a one-stop catalog spanning all
/// built-in unit packages. The built-in symbols do not collide across packages.
///
/// # Example
///
/// ```mbt check
/// test {
///   let catalog = all()
///   assert_true(catalog.lookup("N") is Some(_))
///   assert_true(catalog.lookup("Ω") is Some(_))
///   assert_true(catalog.lookup("Hz") is Some(_))
///   assert_true(catalog.lookup("KiB") is Some(_))
///   assert_true(catalog.lookup("$") is Some(_))
/// }
/// ```
pub fn all() -> @catalog.Catalog {
  si()
  .merge(time())
  .merge(geometry())
  .merge(mass())
  .merge(mechanics())
  .merge(fluid())
  .merge(thermal())
  .merge(electromagnetism())
  .merge(angle())
  .merge(solid_angle())
  .merge(information())
  .merge(currency())
  .merge(count())
}
