part of 'tax_class_api.dart';

abstract class _TaxRateEndpoints {
  static String get taxeClasses => '/taxes/classes';

  static String singleTaxClass(String slug) => '/taxes/classes/$slug';
}
