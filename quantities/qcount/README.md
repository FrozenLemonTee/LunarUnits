# Count Quantity Constructors

`quantities/qcount` provides convenience constructors for discrete counts.

Each function returns `@quantity.Quantity` using the matching unit from
`units/count`.

## Constructors

- `counts`
- `dozens`
- `grosses`

```moonbit
let batch = @qcount.dozens(2.0)
let each = batch.to(@count.each)
```
