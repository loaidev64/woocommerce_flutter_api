import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooCouponDiscountType implements WooEnum {
  percent('percent'),
  fixedCart('fixed_cart'),
  fixedProduct('fixed_product'),
  unknown('unknown');

  const WooCouponDiscountType(this.value);
  @override
  final String value;
  static WooCouponDiscountType fake() => FakeHelper.randomItem(values);
}
