part of 'order_api.dart';

abstract class _OrderEndpoints {
  static String get orders => '/orders';

  static String singleOrder(int id) => '/orders/$id';

  static String sendOrderDetails(int orderId) =>
      '/orders/$orderId/actions/send_order_details';

  static String batchOrders() => '/orders/batch';
}
