import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Report API Extension
///
/// This extension provides comprehensive reporting capabilities for WooCommerce stores.
/// It enables retrieval of sales analytics, top sellers data, and various total reports
/// to help store owners understand their business performance.
///
/// ## Key Features
///
/// - **Sales Analytics**: Get detailed sales reports with financial metrics
/// - **Top Sellers**: Identify best-performing products and their sales data
/// - **Total Reports**: Access aggregated data for coupons, customers, orders, products, and reviews
/// - **Flexible Time Periods**: Generate reports for different time ranges (week, month, year)
/// - **Date Range Filtering**: Specify custom date ranges for reports
///
/// ## Example Usage
///
/// ```dart
/// // Get sales report for current month
/// final salesReport = await wooCommerce.getSalesReport(
///   period: WooReportPeriod.month,
/// );
///
/// // Get top sellers for last month
/// final topSellers = await wooCommerce.getTopSellersReport(
///   period: WooReportPeriod.last_month,
/// );
///
/// // Get coupon totals
/// final couponTotals = await wooCommerce.getCouponsTotalReport();
/// ```
extension WooReportApi on WooCommerce {
  /// Retrieves a comprehensive sales report from the WooCommerce store.
  ///
  /// This method provides detailed sales analytics including gross sales, net sales,
  /// order statistics, and time-based breakdowns. It supports flexible time periods
  /// and custom date ranges for precise reporting.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#sales-report
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic sales information (default)
  ///   - `WooContext.edit`: Returns full sales details including sensitive data
  ///
  /// * [period] - Report period for the sales data. Options: week, month, last_month, year
  /// * [dateMin] - Return sales for a specific start date, in the format `YYYY-MM-DD`
  /// * [dateMax] - Return sales for a specific end date, in the format `YYYY-MM-DD`
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooSalesReport>>` containing the sales report objects with detailed analytics.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get sales report for current month
  /// final salesReport = await wooCommerce.getSalesReport(
  ///   period: WooReportPeriod.month,
  /// );
  ///
  /// // Get sales report for custom date range
  /// final customReport = await wooCommerce.getSalesReport(
  ///   dateMin: '2024-01-01',
  ///   dateMax: '2024-01-31',
  /// );
  ///
  /// // Get detailed sales report
  /// final detailedReport = await wooCommerce.getSalesReport(
  ///   context: WooContext.edit,
  ///   period: WooReportPeriod.year,
  /// );
  /// ```
  Future<List<WooSalesReport>> getSalesReport({
    WooContext context = WooContext.view,
    WooReportPeriod? period,
    String? dateMin,
    String? dateMax,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooSalesReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.sales,
      queryParameters: _resolveQueryParametersForSalesAndTopSellersReport(
        context: context,
        period: period,
        dateMin: dateMin,
        dateMax: dateMax,
      ),
    );

    return (response.data as List)
        .map((e) => WooSalesReport.fromJson(e))
        .toList();
  }

  /// Retrieves the top sellers report from the WooCommerce store.
  ///
  /// This method provides information about the best-performing products based on
  /// sales quantity. It helps identify which products are selling the most during
  /// the specified time period.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#top-sellers-report
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic product information (default)
  ///   - `WooContext.edit`: Returns full product details including sensitive data
  ///
  /// * [period] - Report period for the top sellers data. Options: week, month, last_month, year
  /// * [dateMin] - Return top sellers for a specific start date, in the format `YYYY-MM-DD`
  /// * [dateMax] - Return top sellers for a specific end date, in the format `YYYY-MM-DD`
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooTopSellersReport>>` containing the top sellers report objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get top sellers for current month
  /// final topSellers = await wooCommerce.getTopSellersReport(
  ///   period: WooReportPeriod.month,
  /// );
  ///
  /// // Get top sellers for last month
  /// final lastMonthSellers = await wooCommerce.getTopSellersReport(
  ///   period: WooReportPeriod.last_month,
  /// );
  ///
  /// // Get top sellers for custom date range
  /// final customSellers = await wooCommerce.getTopSellersReport(
  ///   dateMin: '2024-01-01',
  ///   dateMax: '2024-01-31',
  /// );
  /// ```
  Future<List<WooTopSellersReport>> getTopSellersReport({
    WooContext context = WooContext.view,
    WooReportPeriod? period,
    String? dateMin,
    String? dateMax,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooTopSellersReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.topSellers,
      queryParameters: _resolveQueryParametersForSalesAndTopSellersReport(
        context: context,
        period: period,
        dateMin: dateMin,
        dateMax: dateMax,
      ),
    );

    return (response.data as List)
        .map((e) => WooTopSellersReport.fromJson(e))
        .toList();
  }

  /// Resolves query parameters for the sales report API request.
  Map<String, dynamic> _resolveQueryParametersForSalesAndTopSellersReport({
    required WooContext context,
    required WooReportPeriod? period,
    required String? dateMin,
    required String? dateMax,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
    };

    if (period != null) {
      map['period'] = period.name;
    }

    if (dateMin != null) {
      map['date_min'] = dateMin;
    }

    if (dateMax != null) {
      map['date_max'] = dateMax;
    }

    return map;
  }

  /// Retrieves the coupon totals report from the WooCommerce store.
  ///
  /// This method provides aggregated data about coupon usage, showing the total
  /// number of coupons by type. It helps track promotional campaign effectiveness
  /// and coupon performance.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooCouponTotalReport>>` containing the coupon totals report objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get coupon totals
  /// final couponTotals = await wooCommerce.getCouponsTotalReport();
  ///
  /// // Get coupon totals with fake data for testing
  /// final fakeTotals = await wooCommerce.getCouponsTotalReport(useFaker: true);
  /// ```
  Future<List<WooCouponTotalReport>> getCouponsTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooCouponTotalReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.couponsTotal,
    );

    return (response.data as List)
        .map((e) => WooCouponTotalReport.fromJson(e))
        .toList();
  }

  /// Retrieves the customer totals report from the WooCommerce store.
  ///
  /// This method provides aggregated data about customer counts by type,
  /// helping track customer acquisition and segmentation performance.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooCustomerTotalReport>>` containing the customer totals report objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get customer totals
  /// final customerTotals = await wooCommerce.getCustomersTotalReport();
  ///
  /// // Get customer totals with fake data for testing
  /// final fakeTotals = await wooCommerce.getCustomersTotalReport(useFaker: true);
  /// ```
  Future<List<WooCustomerTotalReport>> getCustomersTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooCustomerTotalReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.customersTotal,
    );

    return (response.data as List)
        .map((e) => WooCustomerTotalReport.fromJson(e))
        .toList();
  }

  /// Retrieves the order totals report from the WooCommerce store.
  ///
  /// This method provides aggregated data about order counts by status,
  /// helping track order processing performance and fulfillment metrics.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooOrderTotalReport>>` containing the order totals report objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get order totals
  /// final orderTotals = await wooCommerce.getOrdersTotalReport();
  ///
  /// // Get order totals with fake data for testing
  /// final fakeTotals = await wooCommerce.getOrdersTotalReport(useFaker: true);
  /// ```
  Future<List<WooOrderTotalReport>> getOrdersTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooOrderTotalReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.ordersTotal,
    );

    return (response.data as List)
        .map((e) => WooOrderTotalReport.fromJson(e))
        .toList();
  }

  /// Retrieves the product totals report from the WooCommerce store.
  ///
  /// This method provides aggregated data about product counts by type,
  /// helping track product catalog performance and inventory management.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductTotalReport>>` containing the product totals report objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get product totals
  /// final productTotals = await wooCommerce.getProductsTotalReport();
  ///
  /// // Get product totals with fake data for testing
  /// final fakeTotals = await wooCommerce.getProductsTotalReport(useFaker: true);
  /// ```
  Future<List<WooProductTotalReport>> getProductsTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooProductTotalReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.productsTotal,
    );

    return (response.data as List)
        .map((e) => WooProductTotalReport.fromJson(e))
        .toList();
  }

  /// Retrieves the product review totals report from the WooCommerce store.
  ///
  /// This method provides aggregated data about product review counts by status,
  /// helping track customer feedback and review management performance.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductReviewTotalReport>>` containing the product review totals report objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get product review totals
  /// final reviewTotals = await wooCommerce.getProductReviewsTotalReport();
  ///
  /// // Get product review totals with fake data for testing
  /// final fakeTotals = await wooCommerce.getProductReviewsTotalReport(useFaker: true);
  /// ```
  Future<List<WooProductReviewTotalReport>> getProductReviewsTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooProductReviewTotalReport.fake);
    }

    final response = await dio.get(
      _ReportEndpoints.reviewsTotal,
    );

    return (response.data as List)
        .map((e) => WooProductReviewTotalReport.fromJson(e))
        .toList();
  }
}
