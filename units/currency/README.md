# Currency Units

`units/currency` defines same-currency units on the custom currency dimension.

The built-in units use the dollar as the base currency. Cross-currency exchange
rates are not global state; callers inject them with `at_rate`.

## Units

- `dollar`
- `cent`
- `kilodollar`
- `megadollar`
- `at_rate(symbol, rate_to_dollar)`

```moonbit
let budget = @quantity.Quantity::new(2.0, @currency.kilodollar)
let dollars = budget.to(@currency.dollar)
let euro = @currency.at_rate("EUR", 1.08)
```

Convenience constructors live in `quantities/qcurrency`.
