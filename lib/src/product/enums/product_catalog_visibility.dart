import 'package:faker/faker.dart';

/// WooCommerce Product Catalog Visibility Enumeration
///
/// Defines where and how products appear in the store catalog.
/// Controls the visibility of products in different areas of the website.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a fully visible product
/// final product = WooProduct(
///   name: 'T-Shirt',
///   catalogVisibility: WooProductCatalogVisibility.visible,
/// );
///
/// // Create a hidden product
/// final hiddenProduct = WooProduct(
///   name: 'Secret Item',
///   catalogVisibility: WooProductCatalogVisibility.hidden,
/// );
///
/// // Check visibility settings
/// if (product.catalogVisibility == WooProductCatalogVisibility.visible) {
///   print('Product appears everywhere');
/// }
/// ```
enum WooProductCatalogVisibility {
  /// Product is visible in catalog and search results
  ///
  /// Products with this setting appear in all areas of the store
  /// including category pages, search results, and product listings.
  visible,

  /// Product is visible only in catalog (not in search)
  ///
  /// Products with this setting appear in category pages and product
  /// listings but are excluded from search results.
  catalog,

  /// Product is visible only in search results (not in catalog)
  ///
  /// Products with this setting appear in search results but are
  /// hidden from category pages and product listings.
  search,

  /// Product is hidden from catalog and search
  ///
  /// Products with this setting are completely hidden from public
  /// areas but can still be accessed via direct URL.
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
