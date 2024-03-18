part of 'product_api.dart';

abstract class _ProductEndpoints {
  static String get products => '/products';

  static String singleProduct(int id) => '/products/$id';
}
