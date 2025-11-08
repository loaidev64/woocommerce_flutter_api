part of 'product_shipping_class_api.dart';

abstract class _ProductShippingClassEndpoints {
  static String get shippingClasses => '/products/shipping_classes';

  static String singleShippingClass(int id) => '/products/shipping_classes/$id';

  static String batchProductShippingClasses() => '/products/shipping_classes/batch';
}
