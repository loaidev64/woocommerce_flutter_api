/// WooCommerce Order Refund Sort Enumeration
///
/// Defines the possible sorting options for order refunds in WooCommerce.
/// Used to specify how refunds should be ordered when retrieved from the API.
///
/// ## Usage Examples
///
/// ```dart
/// // Sort refunds by date
/// final refunds = await wooCommerce.getOrderRefunds(
///   orderId: 123,
///   orderBy: WooSortRefund.date,
/// );
///
/// // Sort refunds by ID
/// final sortedRefunds = await wooCommerce.getOrderRefunds(
///   orderId: 123,
///   orderBy: WooSortRefund.id,
/// );
/// ```
enum WooSortRefund {
  /// Sort by refund creation date.
  date,
  
  /// Sort by refund modification date.
  modified,
  
  /// Sort by refund ID.
  id,
  
  /// Sort by inclusion order.
  include,
  
  /// Sort by refund title.
  title,
  
  /// Sort by refund slug.
  slug,
}
