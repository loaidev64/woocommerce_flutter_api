import 'package:faker/faker.dart';

enum WooProductType {
  simple,
  grouped,
  external,
  variable;

  static WooProductType fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooProductType fromString(String type) {
    if (type == 'simple') {
      return WooProductType.simple;
    }
    if (type == 'grouped') {
      return WooProductType.grouped;
    }
    if (type == 'external') {
      return WooProductType.external;
    }
    if (type == 'variable') {
      return WooProductType.variable;
    }
    return WooProductType.simple;
  }
}
