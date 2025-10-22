/// WooCommerce Product Review Sort Enumeration
///
/// Defines the available sorting options for product reviews in WooCommerce.
/// Controls how reviews are ordered when retrieved from the API.
///
/// ## Usage Examples
///
/// ```dart
/// // Sort reviews by date
/// final reviews = await wooCommerce.getProductReviews(
///   productId: 123,
///   orderby: WooSortProductReview.date,
/// );
///
/// // Sort reviews by ID
/// final reviewsById = await wooCommerce.getProductReviews(
///   productId: 123,
///   orderby: WooSortProductReview.id,
/// );
/// ```
enum WooSortProductReview {
  /// Sort reviews by creation date
  ///
  /// Reviews are ordered by their creation timestamp,
  /// typically newest first or oldest first depending on order.
  date,

  /// Sort reviews by GMT creation date
  ///
  /// Reviews are ordered by their GMT creation timestamp,
  /// providing consistent sorting across time zones.
  dateGmt,

  /// Sort reviews by ID
  ///
  /// Reviews are ordered by their unique identifier,
  /// typically in ascending or descending order.
  id,

  /// Sort reviews by slug
  ///
  /// Reviews are ordered alphabetically by their slug,
  /// useful for consistent ordering.
  slug,

  /// Sort reviews by include list
  ///
  /// Reviews are ordered according to a specific
  /// list of IDs provided in the include parameter.
  include,

  /// Sort reviews by product
  ///
  /// Reviews are ordered by their associated product,
  /// useful when retrieving reviews across multiple products.
  product,
}
