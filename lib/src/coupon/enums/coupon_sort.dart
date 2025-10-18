/// WooCommerce Coupon Sort Enumeration
///
/// Defines the possible sorting options for coupons in WooCommerce.
/// Used to specify how coupon collections should be ordered when retrieved.
///
/// ## Usage Examples
///
/// ```dart
/// // Sort coupons by creation date
/// final coupons = await wooCommerce.getCoupons(
///   orderby: WooSortCoupon.date,
/// );
///
/// // Sort coupons by modification date
/// final recentCoupons = await wooCommerce.getCoupons(
///   orderby: WooSortCoupon.modified,
///   order: WooSortOrder.desc,
/// );
///
/// // Sort coupons by ID
/// final sortedById = await wooCommerce.getCoupons(
///   orderby: WooSortCoupon.id,
/// );
/// ```
enum WooSortCoupon {
  /// Sort by coupon creation date
  date,

  /// Sort by coupon last modified date
  modified,

  /// Sort by coupon ID
  id,

  /// Sort by included coupon IDs
  include,

  /// Sort by coupon title/name
  title,

  /// Sort by coupon slug
  slug;
}
