part of 'order_refund_api.dart';

abstract class _OrderRefundEndpoints {
  static String refunds(int orderId) => '/orders/$orderId/refunds';

  static String singleRefund(int orderId, int refundId) =>
      '/orders/$orderId/notes/$refundId';
}
