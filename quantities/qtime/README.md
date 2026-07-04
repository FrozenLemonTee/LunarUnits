# Time Quantity Constructors

`quantities/qtime` provides convenience constructors for fixed-length time
quantities.

Each function returns `@quantity.Quantity` using the matching unit from
`units/time`.

## Constructors

- `nanoseconds`
- `microseconds`
- `milliseconds`
- `minutes`
- `hours`
- `days`

```moonbit
let elapsed = @qtime.hours(2.0)
let seconds = elapsed.to(@si.second)
```
