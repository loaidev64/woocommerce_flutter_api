part of 'checkout_api.dart';

abstract class _StoreCheckoutEndpoints {
  static String get checkout => '/checkout';
  static String singleOrder(int orderId) => '/checkout/$orderId';
}
