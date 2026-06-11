///|
/// What went wrong while parsing. The variants distinguish unknown units from
/// syntax, number and exponent errors; offsets are character indices into the
/// input.
pub suberror ParseError {
  UnknownUnit(String)
  UnexpectedChar(Char, Int)
  UnexpectedEnd
  InvalidNumber(String)
  InvalidExponent(String)
  EmptyInput
  TrailingInput(Int)
} derive(Eq)

///|
/// Human-readable error messages.
pub impl Show for ParseError with fn output(self, logger) {
  let message = match self {
    UnknownUnit(symbol) => "unknown unit symbol \"\{symbol}\""
    UnexpectedChar(c, pos) => "unexpected '\{c}' at position \{pos}"
    UnexpectedEnd => "unexpected end of input"
    InvalidNumber(text) => "invalid number \"\{text}\""
    InvalidExponent(text) => "invalid exponent \"\{text}\""
    EmptyInput => "empty input"
    TrailingInput(pos) => "unexpected trailing input at position \{pos}"
  }
  logger.write_string(message)
}

///|
/// Mutable cursor over the input characters, shared by the recursive-descent
/// routines.
priv struct Parser {
  chars : Array[Char]
  mut pos : Int
  catalog : @catalog.Catalog
}

///|
/// Builds a parser over `input`, decoding it into characters once.
fn make_parser(catalog : @catalog.Catalog, input : String) -> Parser {
  let chars : Array[Char] = []
  input.iter().each(fn(c) { chars.push(c) })
  { chars, pos: 0, catalog }
}

///|
/// Returns whether `c` is one of the expression operators.
fn is_operator(c : Char) -> Bool {
  c == '*' || c == '/' || c == '^' || c == '(' || c == ')'
}

///|
/// Returns whether `c` is inline whitespace.
fn is_space(c : Char) -> Bool {
  c == ' ' || c == '\t'
}

///|
/// Returns whether `c` is an ASCII digit.
fn is_digit(c : Char) -> Bool {
  c >= '0' && c <= '9'
}

///|
/// Returns the current character without consuming it.
fn Parser::peek(self : Parser) -> Char? {
  if self.pos < self.chars.length() {
    Some(self.chars[self.pos])
  } else {
    None
  }
}

///|
/// Returns whether the cursor is at the end of input.
fn Parser::at_end(self : Parser) -> Bool {
  self.pos >= self.chars.length()
}

///|
/// Advances over any inline whitespace.
fn Parser::skip_ws(self : Parser) -> Unit {
  while self.pos < self.chars.length() && is_space(self.chars[self.pos]) {
    self.pos += 1
  }
}

///|
/// Reads a maximal run of non-operator, non-space characters as a unit symbol.
fn Parser::read_symbol(self : Parser) -> String {
  let buffer : Array[Char] = []
  while self.pos < self.chars.length() {
    let c = self.chars[self.pos]
    if is_operator(c) || is_space(c) {
      break
    }
    buffer.push(c)
    self.pos += 1
  }
  String::from_array(buffer)
}

///|
/// Parses a factor: a parenthesized expression, the dimensionless `1`, or a
/// symbol resolved through the catalog.
fn Parser::factor(self : Parser) -> @unit.Un raise ParseError {
  self.skip_ws()
  match self.peek() {
    None => raise UnexpectedEnd
    Some('(') => {
      self.pos = self.pos + 1
      let inner = self.unit_expr()
      self.skip_ws()
      match self.peek() {
        Some(')') => {
          self.pos += 1
          inner
        }
        None => raise UnexpectedEnd
        Some(c) => raise UnexpectedChar(c, self.pos)
      }
    }
    Some(c) =>
      if is_operator(c) {
        raise UnexpectedChar(c, self.pos)
      } else {
        let symbol = self.read_symbol()
        if symbol == "1" {
          dimensionless()
        } else {
          match self.catalog.lookup(symbol) {
            Some(unit) => unit
            None => raise UnknownUnit(symbol)
          }
        }
      }
  }
}

///|
/// Parses a term: a factor with an optional integer exponent (`^` binds tighter
/// than `*` and `/`).
fn Parser::term(self : Parser) -> @unit.Un raise ParseError {
  let base = self.factor()
  self.skip_ws()
  match self.peek() {
    Some('^') => {
      self.pos = self.pos + 1
      base.pow(self.exponent())
    }
    _ => base
  }
}

///|
/// Parses a (possibly signed) integer exponent.
fn Parser::exponent(self : Parser) -> Int raise ParseError {
  self.skip_ws()
  let buffer : Array[Char] = []
  match self.peek() {
    Some('-') | Some('+') => {
      buffer.push(self.chars[self.pos])
      self.pos += 1
    }
    _ => ()
  }
  let digit_start = self.pos
  while self.pos < self.chars.length() && is_digit(self.chars[self.pos]) {
    buffer.push(self.chars[self.pos])
    self.pos += 1
  }
  let text = String::from_array(buffer)
  if self.pos == digit_start {
    raise InvalidExponent(text)
  }
  @string.parse_int(text) catch {
    _ => raise InvalidExponent(text)
  }
}

///|
/// Parses a unit expression: terms combined left-to-right by `*` and `/`.
fn Parser::unit_expr(self : Parser) -> @unit.Un raise ParseError {
  let mut acc = self.term()
  while true {
    self.skip_ws()
    match self.peek() {
      Some('*') => {
        self.pos += 1
        acc = acc.mul(self.term())
      }
      Some('/') => {
        self.pos += 1
        acc = acc.div(self.term())
      }
      _ => break
    }
  }
  acc
}

///|
/// Parses a numeric literal (sign, integer part, optional fraction and
/// exponent) into a `Double`.
fn Parser::number(self : Parser) -> Double raise ParseError {
  self.skip_ws()
  let buffer : Array[Char] = []
  match self.peek() {
    Some('-') | Some('+') => {
      buffer.push(self.chars[self.pos])
      self.pos += 1
    }
    _ => ()
  }
  let mut digits = 0
  while self.pos < self.chars.length() && is_digit(self.chars[self.pos]) {
    buffer.push(self.chars[self.pos])
    self.pos += 1
    digits = digits + 1
  }
  if self.pos < self.chars.length() && self.chars[self.pos] == '.' {
    buffer.push('.')
    self.pos += 1
    while self.pos < self.chars.length() && is_digit(self.chars[self.pos]) {
      buffer.push(self.chars[self.pos])
      self.pos += 1
      digits = digits + 1
    }
  }
  if digits == 0 {
    raise InvalidNumber(String::from_array(buffer))
  }
  // Consume an exponent only when `e`/`E` is followed by an optional sign and a
  // digit, so unit symbols starting with `e` are not mistaken for exponents.
  if self.pos < self.chars.length() &&
    (self.chars[self.pos] == 'e' || self.chars[self.pos] == 'E') &&
    self.has_exponent_digits() {
    buffer.push(self.chars[self.pos])
    self.pos += 1
    if self.pos < self.chars.length() &&
      (self.chars[self.pos] == '-' || self.chars[self.pos] == '+') {
      buffer.push(self.chars[self.pos])
      self.pos += 1
    }
    while self.pos < self.chars.length() && is_digit(self.chars[self.pos]) {
      buffer.push(self.chars[self.pos])
      self.pos += 1
    }
  }
  let text = String::from_array(buffer)
  @string.parse_double(text) catch {
    _ => raise InvalidNumber(text)
  }
}

///|
/// Looks ahead from an `e`/`E` to check it begins a valid exponent.
fn Parser::has_exponent_digits(self : Parser) -> Bool {
  let mut i = self.pos + 1
  if i < self.chars.length() && (self.chars[i] == '-' || self.chars[i] == '+') {
    i = i + 1
  }
  i < self.chars.length() && is_digit(self.chars[i])
}

///|
/// A scale-1 unit with the dimensionless dimension and an empty symbol monomial.
fn dimensionless() -> @unit.Un {
  @unit.Un::base("1", @dimension.Dimension::dimensionless()).pow(0)
}

///|
/// Parses a unit expression such as `m/s^2` or `kg*m/s^2`.
///
/// Atomic symbols are resolved through `catalog`; `*`, `/`, `^`, integer
/// exponents and parentheses are handled by the parser. The literal `1` denotes
/// the dimensionless unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   let catalog = @preset.all()
///   let accel = @parser.parse_unit(catalog, "m/s^2")
///   assert_true(accel.is_compatible(@si.meter / @si.second.pow(2)))
/// }
/// ```
pub fn parse_unit(
  catalog : @catalog.Catalog,
  input : String,
) -> @unit.Un raise ParseError {
  let parser = make_parser(catalog, input)
  parser.skip_ws()
  if parser.at_end() {
    raise EmptyInput
  }
  let unit = parser.unit_expr()
  parser.skip_ws()
  if !parser.at_end() {
    raise TrailingInput(parser.pos)
  }
  unit
}

///|
/// Parses a `<number> <unit>` quantity such as `9.8 m/s^2`. A bare number with
/// no unit yields a dimensionless quantity.
///
/// # Example
///
/// ```mbt check
/// test {
///   let catalog = @preset.all()
///   let q = @parser.parse_quantity(catalog, "9.8 m/s^2")
///   assert_eq(q.value(), 9.8)
/// }
/// ```
pub fn parse_quantity(
  catalog : @catalog.Catalog,
  input : String,
) -> @quantity.Quantity raise ParseError {
  let parser = make_parser(catalog, input)
  parser.skip_ws()
  if parser.at_end() {
    raise EmptyInput
  }
  let value = parser.number()
  parser.skip_ws()
  let unit = if parser.at_end() {
    dimensionless()
  } else {
    let parsed = parser.unit_expr()
    parser.skip_ws()
    if !parser.at_end() {
      raise TrailingInput(parser.pos)
    }
    parsed
  }
  @quantity.Quantity::new(value, unit)
}

///|
/// Builds a quantity from a numeric `value` and a unit given as a string. The
/// unit string is parsed via [`parse_unit`]; the value is taken as-is. Use this
/// when you already hold a `Double` and only need to attach a unit.
///
/// # Example
///
/// ```mbt check
/// test {
///   let catalog = @preset.all()
///   let q = @parser.quantity(catalog, 9.8, "m/s^2")
///   assert_eq(q.value(), 9.8)
/// }
/// ```
pub fn quantity(
  catalog : @catalog.Catalog,
  value : Double,
  unit : String,
) -> @quantity.Quantity raise ParseError {
  @quantity.Quantity::new(value, parse_unit(catalog, unit))
}

///|
/// Non-raising [`parse_unit`]: `None` on any parse error.
pub fn parse_unit_opt(catalog : @catalog.Catalog, input : String) -> @unit.Un? {
  Some(parse_unit(catalog, input)) catch {
    _ => None
  }
}

///|
/// Non-raising [`parse_quantity`]: `None` on any parse error.
pub fn parse_quantity_opt(
  catalog : @catalog.Catalog,
  input : String,
) -> @quantity.Quantity? {
  Some(parse_quantity(catalog, input)) catch {
    _ => None
  }
}

///|
/// Non-raising [`quantity`]: `None` when the unit string fails to parse.
pub fn quantity_opt(
  catalog : @catalog.Catalog,
  value : Double,
  unit : String,
) -> @quantity.Quantity? {
  Some(quantity(catalog, value, unit)) catch {
    _ => None
  }
}
