# Time Units

`units/time` defines fixed-length time units as linear multiples of
`@si.second`.

Calendar units such as months and years are intentionally excluded because their
length is context-dependent. Absolute instants and calendars are outside this
linear unit package.

## Units

- `nanosecond`
- `microsecond`
- `millisecond`
- `minute`
- `hour`
- `day`

```moonbit
let duration = @quantity.Quantity::new(2.0, @time.hour)
let seconds = duration.to(@si.second)
```

Convenience constructors live in `quantities/qtime`.
