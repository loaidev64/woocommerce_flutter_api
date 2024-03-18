part of 'product_api.dart';

abstract class _Endpoints {
  static String get products => '/products';

  static String singleProduct(int id) => '/products/$id';
}
