part of 'product_review_api.dart';

abstract class _ProductReviewEndpoints {
  static String get reviews => '/products/reviews';

  static String singleReview(int id) => '/products/reviews/$id';
}
