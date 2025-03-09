import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

enum WooProductReviewStatus {
  approved,
  hold,
  spam,
  unspam,
  trash,
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
