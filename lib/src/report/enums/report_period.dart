// ignore_for_file: constant_identifier_names

/// WooCommerce Report Period Enumeration
///
/// Defines the possible time periods for generating reports in WooCommerce.
/// This enum is used to specify the time range for sales reports, top sellers reports,
/// and other analytics data.
///
/// ## Usage Examples
///
/// ```dart
/// // Get sales report for the current month
/// final salesReport = await wooCommerce.getSalesReport(
///   period: WooReportPeriod.month,
/// );
///
/// // Get top sellers for the last month
/// final topSellers = await wooCommerce.getTopSellersReport(
///   period: WooReportPeriod.last_month,
/// );
///
/// // Check report period
/// if (period == WooReportPeriod.year) {
///   print('Generating yearly report');
/// }
/// ```
enum WooReportPeriod {
  /// Weekly report period.
  ///
  /// Generates reports for the current week (Monday to Sunday).
  week,

  /// Monthly report period.
  ///
  /// Generates reports for the current month (1st to last day of the month).
  month,

  /// Last month report period.
  ///
  /// Generates reports for the previous month.
  last_month,

  /// Yearly report period.
  ///
  /// Generates reports for the current year (January 1st to December 31st).
  year,
}
