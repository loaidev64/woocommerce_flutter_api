/// WooCommerce Tax Rate Order By Enumeration
///
/// Defines the possible sorting attributes for tax rate queries in WooCommerce.
/// This enum is used to specify how tax rates should be ordered when retrieved
/// from the API, providing flexible sorting options for different use cases.
///
/// ## Usage Examples
///
/// ```dart
/// // Get tax rates sorted by date
/// final taxRates = await wooCommerce.getTaxRates(
///   orderBy: WooTaxRateOrderBy.date,
/// );
///
/// // Get tax rates sorted by ID
/// final taxRatesById = await wooCommerce.getTaxRates(
///   orderBy: WooTaxRateOrderBy.id,
/// );
///
/// // Check sorting attribute
/// if (orderBy == WooTaxRateOrderBy.date) {
///   print('Sorting by creation date');
/// }
/// ```
enum WooTaxRateOrderBy {
  /// Sort by creation date.
  ///
  /// Orders tax rates by their creation date, with newer rates appearing first
  /// when using descending order.
  date,

  /// Sort by tax rate ID.
  ///
  /// Orders tax rates by their unique identifier, providing a consistent
  /// ordering based on the system-assigned ID.
  id,

  /// Sort by included tax rates.
  ///
  /// Orders tax rates based on inclusion criteria, useful for filtering
  /// specific tax rates in queries.
  include,

  /// Sort by tax rate title/name.
  ///
  /// Orders tax rates alphabetically by their name or title, making it
  /// easier to find specific tax rates by name.
  title,

  /// Sort by tax rate slug.
  ///
  /// Orders tax rates by their URL-friendly slug identifier, useful for
  /// consistent ordering based on the slug field.
  slug,

  /// Sort by tax rate value.
  ///
  /// Orders tax rates by their tax rate percentage value, allowing you to
  /// sort from lowest to highest or highest to lowest tax rates.
  price,

  /// Sort by popularity.
  ///
  /// Orders tax rates by their usage frequency or popularity, with the most
  /// commonly used tax rates appearing first.
  popularity,

  /// Sort by rating.
  ///
  /// Orders tax rates by their rating or priority value, useful for
  /// displaying tax rates in order of importance or preference.
  rating,
}
