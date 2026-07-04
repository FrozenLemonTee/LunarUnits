# Currency Dimension

`dimensions/currency_dimension` provides the custom currency dimension used by
`units/currency`.

Currency is modeled as an extension dimension so that total money, unit price
and cost rates are checked by the same runtime dimension system as physical
quantities.

## Main API

- `currency()` returns `@dimension.Dimension::custom("currency")`.

```moonbit
let price_dim =
  @currency_dimension.currency() / @dimension.Dimension::length()
```

Concrete currency units live in `units/currency`. Cross-currency exchange rates
are injected by users, not built into the dimension.
