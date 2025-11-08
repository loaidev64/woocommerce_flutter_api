part of 'variation_api.dart';

/// Internal endpoints for WooCommerce Product Variation API
///
/// This abstract class defines the REST API endpoints used for product variation
/// operations in WooCommerce. These endpoints are used internally by the
/// WooVariationApi extension.
///
/// ## Endpoints
///
/// - **variations**: Get all variations for a specific product
/// - **singleVariation**: Get a specific variation by ID
///
/// ## Example Usage
///
/// ```dart
/// // Get variations endpoint
/// final endpoint = _VariationEndpoints.variations(123);
/// // Returns: '/products/123/variations'
///
/// // Get single variation endpoint
/// final endpoint = _VariationEndpoints.singleVariation(123, 456);
/// // Returns: '/products/123/variations/456'
/// ```
abstract class _VariationEndpoints {
  /// Returns the endpoint for retrieving all variations of a product
  ///
  /// ## Parameters
  ///
  /// * [productId] - The ID of the parent product
  ///
  /// ## Returns
  ///
  /// A `String` containing the REST API endpoint path.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final endpoint = _VariationEndpoints.variations(123);
  /// // Returns: '/products/123/variations'
  /// ```
  static String variations(int productId) => '/products/$productId/variations';

  /// Returns the endpoint for retrieving a specific product variation
  ///
  /// ## Parameters
  ///
  /// * [productId] - The ID of the parent product
  /// * [id] - The ID of the specific variation
  ///
  /// ## Returns
  ///
  /// A `String` containing the REST API endpoint path.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final endpoint = _VariationEndpoints.singleVariation(123, 456);
  /// // Returns: '/products/123/variations/456'
  /// ```
  static String singleVariation(int productId, int id) =>
      '/products/$productId/variations/$id';

  /// Returns the endpoint for batch operations on product variations
  ///
  /// ## Parameters
  ///
  /// * [productId] - The ID of the parent product
  ///
  /// ## Returns
  ///
  /// A `String` containing the REST API endpoint path for batch operations.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final endpoint = _VariationEndpoints.batchVariations(123);
  /// // Returns: '/products/123/variations/batch'
  /// ```
  static String batchVariations(int productId) =>
      '/products/$productId/variations/batch';
}
