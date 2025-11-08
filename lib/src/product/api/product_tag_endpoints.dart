part of 'product_tag_api.dart';

abstract class _ProductTagEndpoints {
  static String get tags => '/products/tags';

  static String singleTag(int id) => '/products/tags/$id';

  static String batchProductTags() => '/products/tags/batch';
}
