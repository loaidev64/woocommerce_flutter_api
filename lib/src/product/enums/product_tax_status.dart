import 'package:faker/faker.dart';

/// WooCommerce Product Tax Status Enumeration
///
/// Defines the tax treatment for products in WooCommerce.
/// Controls whether and how taxes are applied to products and shipping.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a taxable product
/// final product = WooProduct(
///   name: 'T-Shirt',
///   taxStatus: WooProductTaxStatus.taxable,
///   price: 29.99,
/// );
///
/// // Create a tax-exempt product
/// final exemptProduct = WooProduct(
///   name: 'Book',
///   taxStatus: WooProductTaxStatus.none,
///   price: 19.99,
/// );
///
/// // Check tax status
/// if (product.taxStatus == WooProductTaxStatus.taxable) {
///   print('Product is subject to taxes');
/// }
/// ```
enum WooProductTaxStatus {
  /// Product is subject to standard taxes
  ///
  /// Products with this status are taxed according to the store's
  /// tax settings and the customer's location.
  taxable,

  /// Product is subject to shipping taxes only
  ///
  /// Products with this status are not taxed themselves, but
  /// shipping costs for these products are subject to tax.
  shipping,

  /// Product is not subject to any taxes
  ///
  /// Products with this status are completely tax-exempt,
  /// regardless of the store's tax settings.
  none;

  static WooProductTaxStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooProductTaxStatus fromString(String type) {
    if (type == 'taxable') {
      return WooProductTaxStatus.taxable;
    }
    if (type == 'shipping') {
      return WooProductTaxStatus.shipping;
    }
    if (type == 'none') {
      return WooProductTaxStatus.none;
    }
    return WooProductTaxStatus.taxable;
  }
}
