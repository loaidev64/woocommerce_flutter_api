import 'package:faker/faker.dart';

/// WooCommerce Category Display Enumeration
///
/// Defines how product categories display their content on category pages.
/// Controls whether to show products, subcategories, or both on the category page.
///
/// ## Usage Examples
///
/// ```dart
/// // Set category to display products only
/// final category = WooProductCategory(
///   name: 'Electronics',
///   display: WooCategoryDisplay.products,
/// );
///
/// // Set category to display subcategories only
/// final parentCategory = WooProductCategory(
///   name: 'Technology',
///   display: WooCategoryDisplay.subcategories,
/// );
///
/// // Set category to display both products and subcategories
/// final mixedCategory = WooProductCategory(
///   name: 'Home & Garden',
///   display: WooCategoryDisplay.both,
/// );
/// ```
enum WooCategoryDisplay {
  /// Default display behavior (products)
  default_,

  /// Display products only on category page
  products,

  /// Display subcategories only on category page
  subcategories,

  /// Display both products and subcategories on category page
  both;

  /// Creates a fake WooCategoryDisplay instance for testing purposes
  ///
  /// This method generates a random display type, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooCategoryDisplay` instance with randomly selected display type.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeDisplay = WooCategoryDisplay.fake();
  /// ```
  static WooCategoryDisplay fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  /// Creates a WooCategoryDisplay instance from a string value
  ///
  /// This method converts string values from API responses into the appropriate enum value.
  ///
  /// ## Parameters
  ///
  /// * [type] - String value representing the display type
  ///
  /// ## Returns
  ///
  /// A `WooCategoryDisplay` instance corresponding to the string value.
  /// Returns `default_` if the string doesn't match any known values.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final display = WooCategoryDisplay.fromString('products');
  /// ```
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
