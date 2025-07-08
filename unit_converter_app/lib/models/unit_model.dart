class Unit {
  final String name;
  final double Function(double) toBase;
  final double Function(double) fromBase;

  Unit({required this.name, required this.toBase, required this.fromBase});
}

class UnitCategory {
  final String name;
  final List<Unit> units;

  UnitCategory({required this.name, required this.units});
}

final lengthUnits = UnitCategory(
  name: 'Panjang',
  units: [
    Unit(
      name: 'Meter',
      toBase: (v) => v,
      fromBase: (v) => v,
    ),
    Unit(
      name: 'Kilometer',
      toBase: (v) => v * 1000,
      fromBase: (v) => v / 1000,
    ),
    Unit(
      name: 'Centimeter',
      toBase: (v) => v / 100,
      fromBase: (v) => v * 100,
    ),
    Unit(
      name: 'Inci',
      toBase: (v) => v * 0.0254,
      fromBase: (v) => v / 0.0254,
    ),
  ],
);

final weightUnits = UnitCategory(
  name: 'Berat',
  units: [
    Unit(
      name: 'Kilogram',
      toBase: (v) => v,
      fromBase: (v) => v,
    ),
    Unit(
      name: 'Gram',
      toBase: (v) => v / 1000,
      fromBase: (v) => v * 1000,
    ),
    Unit(
      name: 'Pound',
      toBase: (v) => v * 0.453592,
      fromBase: (v) => v / 0.453592,
    ),
  ],
);

final temperatureUnits = UnitCategory(
  name: 'Suhu',
  units: [
    Unit(
      name: 'Celsius',
      toBase: (v) => v,
      fromBase: (v) => v,
    ),
    Unit(
      name: 'Fahrenheit',
      toBase: (v) => (v - 32) * 5 / 9,
      fromBase: (v) => v * 9 / 5 + 32,
    ),
    Unit(
      name: 'Kelvin',
      toBase: (v) => v - 273.15,
      fromBase: (v) => v + 273.15,
    ),
  ],
);

final allCategories = [lengthUnits, weightUnits, temperatureUnits]; 