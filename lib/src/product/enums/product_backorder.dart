import 'package:faker/faker.dart';

/// WooCommerce Product Backorder Enumeration
///
/// Defines the backorder behavior for products when they are out of stock.
/// Controls whether customers can purchase products that are currently unavailable.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a product that allows backorders
/// final product = WooProduct(
///   name: 'T-Shirt',
///   backorders: WooProductBackorder.yes,
///   stockStatus: WooProductStockStatus.outofstock,
/// );
///
/// // Check backorder settings
/// if (product.backorders == WooProductBackorder.yes) {
///   print('Customers can purchase even when out of stock');
/// }
/// ```
enum WooProductBackorder {
  /// Backorders are not allowed
  ///
  /// Products cannot be purchased when out of stock.
  /// Customers will see an "out of stock" message.
  no,

  /// Backorders are allowed with notification
  ///
  /// Products can be purchased when out of stock, but customers
  /// are notified that the item is on backorder.
  notify,

  /// Backorders are allowed without notification
  ///
  /// Products can be purchased when out of stock without
  /// any special notification to the customer.
  yes;

  static WooProductBackorder fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooProductBackorder fromString(String type) {
    if (type == 'no') {
      return WooProductBackorder.no;
    }
    if (type == 'notify') {
      return WooProductBackorder.notify;
    }
    if (type == 'yes') {
      return WooProductBackorder.yes;
    }
    return WooProductBackorder.no;
  }
}
