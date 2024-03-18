import 'package:faker/faker.dart';

enum WooProductCatalogVisibility {
  visible,
  catalog,
  search,
  hidden;

  static WooProductCatalogVisibility fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooProductCatalogVisibility fromString(String type) {
    if (type == 'visible') {
      return WooProductCatalogVisibility.visible;
    }
    if (type == 'catalog') {
      return WooProductCatalogVisibility.catalog;
    }
    if (type == 'search') {
      return WooProductCatalogVisibility.search;
    }
    if (type == 'hidden') {
      return WooProductCatalogVisibility.hidden;
    }
    return WooProductCatalogVisibility.visible;
  }
}
