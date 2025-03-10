part of 'tax_rate_api.dart';

abstract class _TaxRateEndpoints {
  static String get taxes => '/taxes';

  static String singleTax(int id) => '/taxes/$id';
}
