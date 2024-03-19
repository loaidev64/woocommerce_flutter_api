part of 'variation_api.dart';

abstract class _VariationEndpoints {
  static String variations(int productId) => '/products/$productId/variations';

  static String singleVariation(int productId, int id) =>
      '/products/$productId/variations/$id';
}
