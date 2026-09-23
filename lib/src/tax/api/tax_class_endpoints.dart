part of 'tax_class_api.dart';

abstract class _TaxClassEndpoints {
  static String get classes => '/taxes/classes';

  static String singleClass(String slug) => '/taxes/classes/$slug';
}
