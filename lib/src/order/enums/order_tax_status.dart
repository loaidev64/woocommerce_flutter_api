// ignore_for_file: constant_identifier_names

import 'package:faker/faker.dart';

/// WooCommerce Order Tax Status Enumeration
///
/// Defines the possible tax statuses for order items in WooCommerce.
/// Used to determine whether items are subject to tax calculations.
///
/// ## Usage Examples
///
/// ```dart
/// // Create order item with tax status
/// final lineItem = WooLineItem(
///   name: 'Product',
///   taxStatus: WooOrderTaxStatus.taxable,
/// );
///
/// // Check if item is taxable
/// if (item.taxStatus == WooOrderTaxStatus.taxable) {
///   print('Item is subject to tax');
/// }
/// ```
enum WooOrderTaxStatus {
  /// Item is subject to tax calculations.
  taxable,
  
  /// Item is not subject to tax calculations.
  none;

  /// Creates a fake WooOrderTaxStatus for testing purposes.
  ///
  /// This method generates a random tax status from the available values,
  /// making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooOrderTaxStatus` with randomly selected value.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeStatus = WooOrderTaxStatus.fake();
  /// print('Random tax status: $fakeStatus');
  /// ```
  static WooOrderTaxStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  /// Creates a WooOrderTaxStatus from a string value.
  ///
  /// This method converts string representations of tax status to the
  /// corresponding enum value, with fallback to 'none' for invalid inputs.
  ///
  /// ## Parameters
  ///
  /// * [type] - String representation of the tax status
  ///
  /// ## Returns
  ///
  /// A `WooOrderTaxStatus` corresponding to the input string, or 'none' if invalid.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final status = WooOrderTaxStatus.fromString('taxable');
  /// print('Tax status: $status'); // Output: WooOrderTaxStatus.taxable
  /// ```
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
