# Core Packages

The `core` area contains LunarUnits' runtime model: symbolic algebra,
dimensions, units and quantities. Higher-level packages build on this layer but
do not change its identity rules.

Dependency direction:

1. `core/algebra`
2. `core/dimension`
3. `core/unit`
4. `core/quantity`

Keep these packages focused on the internal model and runtime behavior. Built-in
unit libraries, quantity constructors, parser/catalog support, examples and
domain documentation belong outside this area.
