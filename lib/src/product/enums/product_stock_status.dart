import 'package:faker/faker.dart';

/// WooCommerce Product Stock Status Enumeration
///
/// Defines the current stock availability status of products.
/// Controls whether products can be purchased and how they appear to customers.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a product with stock
/// final product = WooProduct(
///   name: 'T-Shirt',
///   stockStatus: WooProductStockStatus.instock,
///   stockQuantity: 100,
/// );
///
/// // Check stock status
/// if (product.stockStatus == WooProductStockStatus.instock) {
///   print('Product is available for purchase');
/// }
///
/// // Handle out of stock products
/// if (product.stockStatus == WooProductStockStatus.outofstock) {
///   print('Product is currently unavailable');
/// }
/// ```
enum WooProductStockStatus {
  /// Product is in stock and available for purchase
  ///
  /// Products with this status can be added to cart and purchased
  /// by customers, assuming other conditions are met.
  instock,

  /// Product is out of stock and unavailable for purchase
  ///
  /// Products with this status cannot be purchased and will show
  /// as unavailable to customers.
  outofstock,

  /// Product is out of stock but can still be purchased
  ///
  /// Products with this status allow purchases even when out of stock,
  /// typically for items that can be restocked or made to order.
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
