import 'package:faker/faker.dart';

enum WooCategoryDisplay {
  default_,
  products,
  subcategories,
  both;

  static WooCategoryDisplay fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooCategoryDisplay fromString(String type) {
    if (type == 'default') {
      return WooCategoryDisplay.default_;
    }
    if (type == 'products') {
      return WooCategoryDisplay.products;
    }
    if (type == 'subcategories') {
      return WooCategoryDisplay.subcategories;
    }
    if (type == 'both') {
      return WooCategoryDisplay.both;
    }
    return WooCategoryDisplay.default_;
  }
}
