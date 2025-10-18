import 'package:faker/faker.dart';

/// WooCommerce Product Type Enumeration
///
/// Defines the different types of products supported by WooCommerce.
/// Each type has specific capabilities and behaviors in the store.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a simple product
/// final product = WooProduct(
///   name: 'T-Shirt',
///   type: WooProductType.simple,
///   price: 29.99,
/// );
///
/// // Create a variable product
/// final variableProduct = WooProduct(
///   name: 'T-Shirt with Options',
///   type: WooProductType.variable,
/// );
///
/// // Check product type
/// if (product.type == WooProductType.simple) {
///   print('This is a simple product');
/// }
/// ```
enum WooProductType {
  /// Basic product with fixed pricing and inventory
  ///
  /// Simple products are the most common type, with a single price,
  /// SKU, and inventory level. They don't have variations.
  simple,

  /// Collection of related products sold together
  ///
  /// Grouped products allow customers to purchase multiple related
  /// products as a bundle, but each item is sold separately.
  grouped,

  /// Product sold on external websites
  ///
  /// External products redirect customers to another website
  /// to complete the purchase, bypassing the WooCommerce cart.
  external,

  /// Product with multiple variations (size, color, etc.)
  ///
  /// Variable products have multiple variations with different
  /// attributes like size, color, or material, each with its own price.
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
