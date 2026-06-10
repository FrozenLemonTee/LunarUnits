# Quantity Constructors

The `quantities` area provides convenience constructors for common physical
quantities. These packages do not introduce new quantity types; every function
returns `@quantity.Quantity` built from the corresponding unit package.

- `qsi`: SI base quantity constructors.
- `qangle`: plane angle constructors, plus `cycles` and `hertz` (frequency).
- `qgeometry`: length, area and volume constructors.
- `qmass`: mass and density constructors.
- `qmechanics`: force, pressure, velocity, energy and power constructors.
- `qfluid`: viscosity and permeability constructors.
- `qthermal`: thermal-property and heat constructors.
- `qelectromagnetism`: electrical and magnetic quantity constructors.
- `qinformation`: information quantity constructors for bit, byte and common
  decimal/binary byte units.
- `qsolidangle`: solid angle constructors for steradian, square degree and spat.
- `qcurrency`: currency constructors for dollar, cent, kilodollar and megadollar.
- `qcount`: discrete-count constructors for each, dozen and gross.

The core runtime model remains unchanged: dimensional checks still happen in
`core/quantity`.
