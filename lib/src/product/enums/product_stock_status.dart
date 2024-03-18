import 'package:faker/faker.dart';

enum WooProductStockStatus {
  instock,
  outofstock,
  onbackorder;

  static WooProductStockStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooProductStockStatus fromString(String type) {
    if (type == 'instock') {
      return WooProductStockStatus.instock;
    }
    if (type == 'outofstock') {
      return WooProductStockStatus.outofstock;
    }
    if (type == 'onbackorder') {
      return WooProductStockStatus.onbackorder;
    }
    return WooProductStockStatus.instock;
  }
}
