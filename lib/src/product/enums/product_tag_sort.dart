// ignore_for_file: constant_identifier_names

/// WooCommerce Product Tag Sort Enumeration
///
/// Defines the available sorting options for product tags in WooCommerce.
/// Controls how product tags are ordered when retrieved from the API.
///
/// ## Usage Examples
///
/// ```dart
/// // Sort tags by name
/// final tags = await wooCommerce.getProductTags(
///   orderby: WooSortProductTag.name,
/// );
///
/// // Sort tags by count (most used first)
/// final popularTags = await wooCommerce.getProductTags(
///   orderby: WooSortProductTag.count,
/// );
/// ```
enum WooSortProductTag {
  /// Sort tags by ID
  ///
  /// Tags are ordered by their unique identifier,
  /// typically in ascending or descending order.
  id,

  /// Sort tags by include list
  ///
  /// Tags are ordered according to a specific
  /// list of IDs provided in the include parameter.
  include,

  /// Sort tags by name
  ///
  /// Tags are ordered alphabetically by their name,
  /// useful for consistent alphabetical ordering.
  name,

  /// Sort tags by slug
  ///
  /// Tags are ordered alphabetically by their slug,
  /// useful for URL-friendly ordering.
  slug,

  /// Sort tags by term group
  ///
  /// Tags are ordered by their term group classification,
  /// useful for grouping related tags together.
  term_group,

  /// Sort tags by description
  ///
  /// Tags are ordered alphabetically by their description,
  /// useful when descriptions are meaningful for sorting.
  description,

  /// Sort tags by usage count
  ///
  /// Tags are ordered by how many products use them,
  /// useful for finding the most or least popular tags.
  count,
}
