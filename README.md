# LunarUnits

LunarUnits is planned as a type-safe physical quantity and unit system for
MoonBit.

The repository is currently in the architecture setup stage. The template code
has been removed so the first implementation pass can start from the real
package layout.

## Initial Package Layout

- `core/algebra`: internal normalized symbolic expression layer.
- `core/dimension`: physical dimension model and dimension relations.
- `core/unit`: unit definitions and conversion metadata.
- `core/quantity`: values with unit references and quantity-level operations.
- `units/si`: SI base units.
- `units/derived`: common derived units.
- `examples`: runnable examples added with feature milestones.
- `docs`: public design, roadmap, comparison, and release notes.

## Development Notes

- Keep MoonBit tests next to the package they validate.
- Use `_test.mbt` for blackbox tests and `_wbtest.mbt` for whitebox tests.
- Run `moon info && moon fmt` before checking diffs.
- Run `moon test` before handing off implementation changes.
