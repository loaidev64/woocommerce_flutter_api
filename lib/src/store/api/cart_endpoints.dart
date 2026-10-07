part of 'cart_api.dart';

abstract class _StoreCartEndpoints {
  static String get cart => '/cart';
  static String get addItem => '/cart/add-item';
  static String get updateItem => '/cart/update-item';
  static String get removeItem => '/cart/remove-item';
  static String get applyCoupon => '/cart/apply-coupon';
  static String get removeCoupon => '/cart/remove-coupon';
  static String get updateCustomer => '/cart/update-customer';
  static String get selectShippingRate => '/cart/select-shipping-rate';
  static String get batch => '/batch';
}
