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
      queryParameters: _resolveQueryParametersForSalesReport(
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

  /// Resolves query parameters for the sales report API request.
  Map<String, dynamic> _resolveQueryParametersForSalesReport({
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
}
