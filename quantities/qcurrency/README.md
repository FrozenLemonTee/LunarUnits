# Currency Quantity Constructors

`quantities/qcurrency` provides convenience constructors for same-currency
amounts.

Each function returns `@quantity.Quantity` using the matching unit from
`units/currency`.

## Constructors

- `dollars`
- `cents`
- `kilodollars`
- `megadollars`

```moonbit
let budget = @qcurrency.kilodollars(2.0)
let dollars = budget.to(@currency.dollar)
```

For cross-currency units, create a unit with `@currency.at_rate` and pass it to
`@quantity.Quantity::new`.
