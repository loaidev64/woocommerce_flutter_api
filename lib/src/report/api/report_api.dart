import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../../base/enums/context.dart';
import '../enums/report_period.dart';
import '../models/models.dart';
part 'endpoints.dart';

extension WooReportApi on WooCommerce {
  Future<List<WooReportItem>> getReports({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooReportItem.fake);
    }
    final response = await requestGet<List<dynamic>>(_ReportEndpoints.reports);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooReportItem.fromJson)
            .toList() ??
        [];
  }

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
    final response = await requestGet<List<dynamic>>(
      _ReportEndpoints.sales,
      queryParameters: _salesReportQueryParameters(
        context: context,
        period: period,
        dateMin: dateMin,
        dateMax: dateMax,
      ),
    );
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooSalesReport.fromJson)
            .toList() ??
        [];
  }

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
    final response = await requestGet<List<dynamic>>(
      _ReportEndpoints.topSellers,
      queryParameters: _salesReportQueryParameters(
        context: context,
        period: period,
        dateMin: dateMin,
        dateMax: dateMax,
      ),
    );
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooTopSellersReport.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooCouponTotalReport>> getCouponsTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooCouponTotalReport.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ReportEndpoints.couponsTotal);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooCouponTotalReport.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooCustomerTotalReport>> getCustomersTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooCustomerTotalReport.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ReportEndpoints.customersTotal);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooCustomerTotalReport.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooOrderTotalReport>> getOrdersTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooOrderTotalReport.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ReportEndpoints.ordersTotal);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooOrderTotalReport.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooProductTotalReport>> getProductsTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooProductTotalReport.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ReportEndpoints.productsTotal);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductTotalReport.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooProductReviewTotalReport>> getProductReviewsTotalReport(
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooProductReviewTotalReport.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ReportEndpoints.reviewsTotal);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductReviewTotalReport.fromJson)
            .toList() ??
        [];
  }

  Map<String, dynamic> _salesReportQueryParameters({
    required WooContext context,
    required WooReportPeriod? period,
    required String? dateMin,
    required String? dateMax,
  }) =>
      <String, dynamic>{}
        ..putEnum('context', context)
        ..putEnum('period', period)
        ..putIfPresent('date_min', dateMin)
        ..putIfPresent('date_max', dateMax);
}
