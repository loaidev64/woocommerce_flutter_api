// ignore_for_file: constant_identifier_names

/// WooCommerce Category Order By Enumeration
///
/// Defines the possible sorting options for product categories in WooCommerce.
/// Used to specify how category collections should be ordered when retrieved.
///
/// ## Usage Examples
///
/// ```dart
/// // Sort categories by name
/// final categories = await wooCommerce.getCategories(
///   orderBy: WooCategoryOrderBy.name,
/// );
///
/// // Sort categories by product count
/// final categoriesByCount = await wooCommerce.getCategories(
///   orderBy: WooCategoryOrderBy.count,
///   order: WooSortOrder.desc,
/// );
///
/// // Sort categories by ID
/// final sortedById = await wooCommerce.getCategories(
///   orderBy: WooCategoryOrderBy.id,
/// );
/// ```
enum WooCategoryOrderBy {
  /// Sort by category ID
  id,

  /// Sort by included category IDs
  include,

  /// Sort by category name
  name,

  /// Sort by category slug
  slug,

  /// Sort by term group
  term_group,

  /// Sort by category description
  description,

  /// Sort by product count
  count,
}
