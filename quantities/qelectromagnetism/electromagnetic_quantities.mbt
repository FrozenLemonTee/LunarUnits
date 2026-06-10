///|
/// Creates an electric-charge quantity in coulombs.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = coulombs(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.coulomb))
/// }
/// ```
pub fn coulombs(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.coulomb)
}

///|
/// Creates an electric-charge quantity in ampere hours.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = ampere_hours(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.ampere_hour))
/// }
/// ```
pub fn ampere_hours(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.ampere_hour)
}

///|
/// Creates an electric-potential quantity in volts.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = volts(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.volt))
/// }
/// ```
pub fn volts(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.volt)
}

///|
/// Creates an electric-resistance quantity in ohms.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = ohms(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.ohm))
/// }
/// ```
pub fn ohms(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.ohm)
}

///|
/// Creates an electric-conductance quantity in siemens.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = siemens(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.siemens))
/// }
/// ```
pub fn siemens(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.siemens)
}

///|
/// Creates a capacitance quantity in farads.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = farads(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.farad))
/// }
/// ```
pub fn farads(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.farad)
}

///|
/// Creates an inductance quantity in henries.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = henries(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.henry))
/// }
/// ```
pub fn henries(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.henry)
}

///|
/// Creates a magnetic-flux quantity in webers.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = webers(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.weber))
/// }
/// ```
pub fn webers(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.weber)
}

///|
/// Creates a magnetic-flux-density quantity in teslas.
///
/// # Example
///
/// ```mbt check
/// test {
///   let q = teslas(2.0)
///   assert_eq(q.value(), 2.0)
///   assert_true(q.unit().is_compatible(@electromagnetism.tesla))
/// }
/// ```
pub fn teslas(value : Double) -> @quantity.Quantity {
  @quantity.Quantity::new(value, @electromagnetism.tesla)
}
