// ignore_for_file: constant_identifier_names

import 'package:faker/faker.dart';

enum WooOrderTaxStatus {
  taxable,
  none;

  static WooOrderTaxStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooOrderTaxStatus fromString(String type) {
    if (type == 'taxable') {
      return WooOrderTaxStatus.taxable;
    }
    if (type == 'none') {
      return WooOrderTaxStatus.none;
    }

    return WooOrderTaxStatus.none;
  }
}
