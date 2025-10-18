/// WooCommerce Order Sort By Enumeration
///
/// Defines the available sorting options for WooCommerce orders.
/// Used to specify how orders should be ordered when retrieved from the API.
///
/// ## Usage Examples
///
/// ```dart
/// // Get orders sorted by date
/// final orders = await wooCommerce.getOrders(
///   orderBy: WooOrderOrderBy.date,
///   order: WooSortOrder.desc,
/// );
///
/// // Get orders sorted by ID
/// final ordersById = await wooCommerce.getOrders(
///   orderBy: WooOrderOrderBy.id,
///   order: WooSortOrder.asc,
/// );
/// ```
enum WooOrderOrderBy {
  /// Sort orders by creation date
  ///
  /// Orders are sorted by their creation timestamp.
  date,

  /// Sort orders by modification date
  ///
  /// Orders are sorted by when they were last modified.
  modified,

  /// Sort orders by ID
  ///
  /// Orders are sorted by their unique identifier.
  id,

  /// Sort orders by inclusion order
  ///
  /// Orders are sorted in the order specified by the include parameter.
  include,

  /// Sort orders by title/number
  ///
  /// Orders are sorted by their order number or title.
  title,
}
