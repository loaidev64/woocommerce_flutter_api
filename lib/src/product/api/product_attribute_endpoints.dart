part of 'product_attribute_api.dart';

abstract class _ProductAttributeEndpoints {
  static String get attributes => '/products/attributes';

  static String singleAttribute(int id) => '/products/attributes/$id';

  static String batchAttributes() => '/products/attributes/batch';

  static String attributeTerms(int attributeId) =>
      '/products/attributes/$attributeId/terms';

  static String singleAttributeTerm(int attributeId, int termId) =>
      '/products/attributes/$attributeId/terms/$termId';

  static String batchAttributeTerms(int attributeId) =>
      '/products/attributes/$attributeId/terms/batch';
}
