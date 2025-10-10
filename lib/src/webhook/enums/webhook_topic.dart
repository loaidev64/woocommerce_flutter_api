import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Webhook Topics
///
/// This class provides predefined webhook topic constants for WooCommerce webhooks.
/// Webhook topics determine which events will trigger webhook delivery.
/// https://woocommerce.github.io/woocommerce-rest-api-docs/#topics
/// 
/// ## How Webhook Topics Work
///
/// Webhook topics are strings that combine a resource (e.g., 'order', 'product')
/// with an event (e.g., 'created', 'updated', 'deleted'). When these events occur
/// in your WooCommerce store, webhooks subscribed to the corresponding topic will
/// be triggered and their payloads delivered to the configured URL.
///
/// ## Core WooCommerce Topics
///
/// The following topics are supported by default in WooCommerce:
///
/// ### Coupon Events
/// - `coupon.created` - Triggered when a new coupon is created
/// - `coupon.updated` - Triggered when an existing coupon is modified
/// - `coupon.deleted` - Triggered when a coupon is deleted
///
/// ### Customer Events
/// - `customer.created` - Triggered when a new customer registers
/// - `customer.updated` - Triggered when customer information is updated
/// - `customer.deleted` - Triggered when a customer account is deleted
///
/// ### Order Events
/// - `order.created` - Triggered when a new order is placed
/// - `order.updated` - Triggered when order status or details change
/// - `order.deleted` - Triggered when an order is deleted
///
/// ### Product Events
/// - `product.created` - Triggered when a new product is added
/// - `product.updated` - Triggered when product information is modified
/// - `product.deleted` - Triggered when a product is removed
///
/// ## Custom Topics
///
/// You can also create custom topics that map to specific WordPress hooks.
/// Custom topics should follow the format: `action.hook_name`
///
/// Example: `action.woocommerce_add_to_cart`
///
/// ## Usage Examples
///
/// ```dart
/// // Create a webhook for order updates
/// final webhook = WooWebhook(
///   name: 'Order Updates',
///   topic: WooWebhookTopic.orderUpdated,
///   deliveryUrl: 'https://your-app.com/webhooks/orders',
/// );
///
/// // Create a webhook for new products
/// final productWebhook = WooWebhook(
///   name: 'New Products',
///   topic: WooWebhookTopic.productCreated,
///   deliveryUrl: 'https://your-app.com/webhooks/products',
/// );
///
/// // Get a random topic for testing
/// final randomTopic = WooWebhookTopic.randomTopic();
/// ```
///
/// ## Webhook Delivery Headers
///
/// When a webhook is delivered, WooCommerce includes several headers to help
/// you process the webhook:
///
/// - `X-WC-Webhook-Source`: The store URL
/// - `X-WC-Webhook-Topic`: The topic that triggered the webhook
/// - `X-WC-Webhook-Resource`: The resource type (e.g., 'order', 'product')
/// - `X-WC-Webhook-Event`: The event type (e.g., 'created', 'updated')
/// - `X-WC-Webhook-Signature`: HMAC-SHA256 signature for verification
/// - `X-WC-Webhook-ID`: The webhook's ID
/// - `X-WC-Webhook-Delivery-ID`: The delivery log ID
abstract class WooWebhookTopic {
  /// Coupon created event topic
  ///
  /// Triggered when a new coupon is created in the WooCommerce store.
  /// The webhook payload will contain the complete coupon data.
  static const couponCreated = 'coupon.created';

  /// Coupon updated event topic
  ///
  /// Triggered when an existing coupon is modified in the WooCommerce store.
  /// The webhook payload will contain the updated coupon data.
  static const couponUpdated = 'coupon.updated';

  /// Coupon deleted event topic
  ///
  /// Triggered when a coupon is deleted from the WooCommerce store.
  /// The webhook payload will contain the deleted coupon data.
  static const couponDeleted = 'coupon.deleted';

  /// Customer created event topic
  ///
  /// Triggered when a new customer account is created in the WooCommerce store.
  /// This includes both manual customer creation and customer registration.
  /// The webhook payload will contain the complete customer data.
  static const customerCreated = 'customer.created';

  /// Customer updated event topic
  ///
  /// Triggered when customer information is updated in the WooCommerce store.
  /// This includes profile updates, address changes, and other customer data modifications.
  /// The webhook payload will contain the updated customer data.
  static const customerUpdated = 'customer.updated';

  /// Customer deleted event topic
  ///
  /// Triggered when a customer account is deleted from the WooCommerce store.
  /// The webhook payload will contain the deleted customer data.
  static const customerDeleted = 'customer.deleted';

  /// Order created event topic
  ///
  /// Triggered when a new order is placed in the WooCommerce store.
  /// This is one of the most commonly used webhook topics for order processing.
  /// The webhook payload will contain the complete order data including line items.
  static const orderCreated = 'order.created';

  /// Order updated event topic
  ///
  /// Triggered when an existing order is modified in the WooCommerce store.
  /// This includes status changes, payment updates, and other order modifications.
  /// The webhook payload will contain the updated order data.
  static const orderUpdated = 'order.updated';

  /// Order deleted event topic
  ///
  /// Triggered when an order is deleted from the WooCommerce store.
  /// The webhook payload will contain the deleted order data.
  static const orderDeleted = 'order.deleted';

  /// Product created event topic
  ///
  /// Triggered when a new product is added to the WooCommerce store.
  /// The webhook payload will contain the complete product data including
  /// variations, images, and other product attributes.
  static const productCreated = 'product.created';

  /// Product updated event topic
  ///
  /// Triggered when product information is modified in the WooCommerce store.
  /// This includes price changes, stock updates, and other product modifications.
  /// The webhook payload will contain the updated product data.
  static const productUpdated = 'product.updated';

  /// Product deleted event topic
  ///
  /// Triggered when a product is removed from the WooCommerce store.
  /// The webhook payload will contain the deleted product data.
  static const productDeleted = 'product.deleted';

  /// Generates a random webhook topic for testing purposes.
  ///
  /// This method returns a randomly selected topic from all available
  /// webhook topics. It's primarily used for generating fake data
  /// during testing and development.
  ///
  /// ## Returns
  ///
  /// A `String` containing a randomly selected webhook topic.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a random topic for testing
  /// final randomTopic = WooWebhookTopic.randomTopic();
  /// print('Random topic: $randomTopic');
  ///
  /// // Use in fake webhook generation
  /// final fakeWebhook = WooWebhook(
  ///   name: 'Test Webhook',
  ///   topic: WooWebhookTopic.randomTopic(),
  ///   deliveryUrl: 'https://test.com/webhook',
  /// );
  /// ```
  static String randomTopic() => FakeHelper.randomItem([
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
      ]);
}
