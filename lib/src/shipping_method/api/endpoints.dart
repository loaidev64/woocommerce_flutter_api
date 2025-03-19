part of 'shipping_method_api.dart';

abstract class _ShippingMethodEndpoints {
  static String get methods => '/shipping_methods';
  static String singleMethod(String id) => '/shipping_methods/$id';
}