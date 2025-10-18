/// WooCommerce Product Filter With Option Enumeration
///
/// Defines the available filter options for products with specific relationships.
/// Controls how products are filtered based on their associations and relationships.
///
/// ## Usage Examples
///
/// ```dart
/// // Filter products by related IDs
/// final relatedProducts = await wooCommerce.getProducts(
///   filter: WooProductFilterWithType.relatedIds,
///   filterValue: [123, 456, 789],
/// );
///
/// // Filter products by parent ID
/// final childProducts = await wooCommerce.getProducts(
///   filter: WooProductFilterWithType.parentId,
///   filterValue: [123],
/// );
/// ```
enum WooProductFilterWithType {
  /// Filter products by related product IDs
  ///
  /// Returns products that are marked as related to the specified IDs.
  /// Useful for finding products that are associated with each other.
  relatedIds,

  /// Filter products by upsell product IDs
  ///
  /// Returns products that are marked as upsells to the specified IDs.
  /// Upsells are products suggested as upgrades or better alternatives.
  upsellIds,

  /// Filter products by cross-sell product IDs
  ///
  /// Returns products that are marked as cross-sells to the specified IDs.
  /// Cross-sells are products suggested as complementary purchases.
  crossSellIds,

  /// Filter products by parent product ID
  ///
  /// Returns child products that belong to the specified parent product.
  /// Useful for finding variations or grouped product children.
  parentId,

  /// Filter products by variation IDs
  ///
  /// Returns product variations that match the specified variation IDs.
  /// Useful for finding specific product variations.
  variations,

  /// Filter products by grouped product IDs
  ///
  /// Returns products that are part of the specified grouped products.
  /// Useful for finding products that are sold together as bundles.
  groupedProducts;
}
