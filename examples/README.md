# Examples

Runnable, self-checking examples for LunarUnits. Each example is a `test` in
[`examples.mbt`](examples.mbt), so `moon test` runs and verifies them all.
Several examples use the `quantities/*` constructor packages so the convenience
API is verified alongside direct `Quantity::new` usage.
The examples use `*` and `/` for total unit and quantity composition, while
dimension-checked addition remains explicit through `.add(...)`.

Covered:

- Speed = distance / time.
- Acceleration = velocity / time.
- Newton's second law: force = mass × acceleration.
- Work (energy) = force × distance.
- Same-dimension conversion (kilometres to metres).
- Rejection of dimensionally invalid operations (length + time).
- Extension dimensions: information, angle, currency, count, frequency.
- Formatting one quantity in ASCII, SI (Unicode) and LaTeX notations.
- Resolving unit symbols through a preset catalog and extending it.

Run them with:

```bash
moon test examples
```
