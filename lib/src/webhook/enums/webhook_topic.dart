import '../../helpers/fake_helper.dart';

abstract final class WooWebhookTopic {
  static const couponCreated = 'coupon.created';
  static const couponUpdated = 'coupon.updated';
  static const couponDeleted = 'coupon.deleted';
  static const customerCreated = 'customer.created';
  static const customerUpdated = 'customer.updated';
  static const customerDeleted = 'customer.deleted';
  static const orderCreated = 'order.created';
  static const orderUpdated = 'order.updated';
  static const orderDeleted = 'order.deleted';
  static const productCreated = 'product.created';
  static const productUpdated = 'product.updated';
  static const productDeleted = 'product.deleted';
  static const List<String> values = [
    couponCreated,
    couponUpdated,
    couponDeleted,
    customerCreated,
    customerUpdated,
    customerDeleted,
    orderCreated,
    orderUpdated,
    orderDeleted,
    productCreated,
    productUpdated,
    productDeleted,
  ];
  static String randomTopic() => FakeHelper.randomItem(values);
}
