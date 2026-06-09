# Quantity Constructors

The `quantities` area provides convenience constructors for common physical
quantities. These packages do not introduce new quantity types; every function
returns `@quantity.Quantity` built from the corresponding unit package.

- `qsi`: SI base quantity constructors.
- `qgeometry`: length, area and volume constructors.
- `qmass`: mass and density constructors.
- `qmechanics`: force, pressure, velocity, energy and power constructors.
- `qfluid`: viscosity and permeability constructors.
- `qthermal`: thermal-property and heat constructors.
- `qelectromagnetism`: electrical and magnetic quantity constructors.

The core runtime model remains unchanged: dimensional checks still happen in
`core/quantity`.
