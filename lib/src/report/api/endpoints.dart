part of 'report_api.dart';

abstract class _ReportEndpoints {
  static String get sales => '/reports/sales';

  static String get topSellers => '/reports/top_sellers';

  static String get couponsTotal => '/reports/coupons/totals';

  static String get customersTotal => '/reports/customers/totals';

  static String get ordersTotal => '/reports/orders/totals';
}
