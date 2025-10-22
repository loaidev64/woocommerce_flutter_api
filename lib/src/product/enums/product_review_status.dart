import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Product Review Status Enumeration
///
/// Defines the moderation status of product reviews in WooCommerce.
/// Controls the visibility and approval state of customer reviews.
///
/// ## Usage Examples
///
/// ```dart
/// // Create a review with approved status
/// final review = WooProductReview(
///   review: 'Great product!',
///   status: WooProductReviewStatus.approved,
/// );
///
/// // Check review status
/// if (review.status == WooProductReviewStatus.approved) {
///   print('Review is visible to customers');
/// }
///
/// // Handle pending reviews
/// if (review.status == WooProductReviewStatus.hold) {
///   print('Review is pending moderation');
/// }
/// ```
enum WooProductReviewStatus {
  /// Review is approved and visible to customers
  ///
  /// Approved reviews are published and visible to all customers
  /// viewing the product page.
  approved,

  /// Review is pending moderation
  ///
  /// Hold reviews are awaiting approval from an administrator
  /// before being published.
  hold,

  /// Review is marked as spam
  ///
  /// Spam reviews are identified as unwanted content and are
  /// hidden from public view.
  spam,

  /// Review is unmarked from spam
  ///
  /// Unspam reviews restore previously marked spam reviews
  /// to their previous status.
  unspam,

  /// Review is moved to trash
  ///
  /// Trashed reviews are deleted but can be restored if needed.
  trash,

  /// Review is restored from trash
  ///
  /// Untrash reviews restore previously trashed reviews
  /// to their previous status.
  untrash;

  static WooProductReviewStatus fromApi(String? status) => switch (status) {
        'approved' => WooProductReviewStatus.approved,
        'hold' => WooProductReviewStatus.hold,
        'spam' => WooProductReviewStatus.spam,
        'unspam' => WooProductReviewStatus.unspam,
        'trash' => WooProductReviewStatus.trash,
        'untrash' => WooProductReviewStatus.untrash,
        _ => WooProductReviewStatus.approved,
      };

  static WooProductReviewStatus fake() =>
      FakeHelper.randomItem(WooProductReviewStatus.values);
}
