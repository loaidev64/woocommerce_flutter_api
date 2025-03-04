part of 'coupon_api.dart';

abstract class _CouponEndpoints {
  static String get coupons => '/coupons';

  static String singleCoupon(int id) => '/coupons/$id';
}
