part of 'category_api.dart';

abstract class _CategoryEndpoints {
  static String get categories => '/products/categories';

  static String singleCategory(int id) => '/products/categories/$id';
}
