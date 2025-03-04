part of 'order_api.dart';

abstract class _OrderEndpoints {
  static String get orders => '/orders';

  static String singleOrder(int id) => '/orders/$id';
}
