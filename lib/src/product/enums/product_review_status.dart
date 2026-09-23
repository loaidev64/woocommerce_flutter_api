import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductReviewStatus implements WooEnum {
  approved('approved'),
  hold('hold'),
  spam('spam'),
  unspam('unspam'),
  trash('trash'),
  untrash('untrash'),
  all('all'),
  unknown('unknown');

  const WooProductReviewStatus(this.value);
  @override
  final String value;
  static WooProductReviewStatus fake() => FakeHelper.randomItem(values);
}
