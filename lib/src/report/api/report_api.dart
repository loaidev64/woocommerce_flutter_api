import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooReportApi on WooCommerce {
  /// Fetches the sales report from WooCommerce.
  ///
  /// [context] Scope under which the request is made; determines fields present in response. Default is view.
  ///
  /// [period] Report period. Default is today's date. Options: week, month, last_month and year
  ///
  /// [dateMin] Return sales for a specific start date, in the format `YYYY-MM-DD`.
  ///
  /// [dateMax] Return sales for a specific end date, in the format `YYYY-MM-DD`.
  ///
  /// [useFaker] If true, returns fake data for testing purposes.
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

  /// Fetches the top sellers report from WooCommerce.
  ///
  /// [context] Scope under which the request is made; determines fields present in response. Default is view.
  ///
  /// [period] Report period. Default is today's date. Options: week, month, last_month and year
  ///
  /// [dateMin] Return sales for a specific start date, in the format `YYYY-MM-DD`.
  ///
  /// [dateMax] Return sales for a specific end date, in the format `YYYY-MM-DD`.
  ///
  /// [useFaker] If true, returns fake data for testing purposes.
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
}
