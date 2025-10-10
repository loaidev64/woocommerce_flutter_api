import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import '../enums/webhook_status.dart';
import '../enums/webhook_topic.dart';

/// WooCommerce Webhook Model
///
/// Represents a webhook configuration in WooCommerce. Webhooks are HTTP callbacks
/// that are triggered by specific events in your store, allowing you to receive
/// real-time notifications about store activities.
///
/// ## Webhook Structure
///
/// A webhook consists of several key components:
///
/// - **Identification**: Unique ID and human-readable name
/// - **Event Subscription**: Topic that determines which events trigger the webhook
/// - **Delivery Configuration**: URL where payloads are sent and optional secret for verification
/// - **Status Management**: Control whether the webhook is active, paused, or disabled
/// - **Timestamps**: Creation and modification tracking
///
/// ## Webhook Lifecycle
///
/// 1. **Creation**: Webhook is created with topic and delivery URL
/// 2. **Activation**: Status is set to 'active' to start receiving events
/// 3. **Delivery**: WooCommerce sends HTTP POST requests to the delivery URL
/// 4. **Verification**: Optional HMAC-SHA256 signature verification using the secret
/// 5. **Management**: Update, pause, or delete as needed
///
/// ## Security Features
///
/// - **Secret Key**: Optional HMAC-SHA256 signature for payload verification
/// - **HTTPS Support**: Delivery URLs must use HTTP or HTTPS
/// - **Status Control**: Pause or disable webhooks without deletion
///
/// ## Example Usage
///
/// ```dart
/// // Create a new webhook
/// final webhook = WooWebhook(
///   name: 'Order Updates',
///   topic: 'order.updated',
///   deliveryUrl: 'https://your-app.com/webhooks/orders',
///   secret: 'your-secret-key',
///   status: WooWebhookStatus.active,
/// );
///
/// // Create webhook via API
/// final createdWebhook = await wooCommerce.createWebhook(webhook);
///
/// // Update webhook status
/// webhook.status = WooWebhookStatus.paused;
/// await wooCommerce.updateWebhook(webhook);
///
/// // Generate fake webhook for testing
/// final fakeWebhook = WooWebhook.fake();
/// ```
///
/// ## Webhook Delivery Headers
///
/// When a webhook is delivered, WooCommerce includes these headers:
///
/// - `X-WC-Webhook-Source`: Store URL
/// - `X-WC-Webhook-Topic`: The topic that triggered the webhook
/// - `X-WC-Webhook-Resource`: Resource type (e.g., 'order', 'product')
/// - `X-WC-Webhook-Event`: Event type (e.g., 'created', 'updated')
/// - `X-WC-Webhook-Signature`: HMAC-SHA256 signature (if secret is set)
/// - `X-WC-Webhook-ID`: Webhook's ID
/// - `X-WC-Webhook-Delivery-ID`: Delivery log ID
class WooWebhook {
  /// Unique identifier for the webhook
  ///
  /// This ID is automatically assigned by WooCommerce when the webhook is created.
  /// It's used to identify the webhook in API calls and is included in delivery headers.
  final int? id;

  /// Human-readable name for the webhook
  ///
  /// This name helps you identify the webhook in the WooCommerce admin panel
  /// and in your application. It should be descriptive of the webhook's purpose.
  final String? name;

  /// Current status of the webhook
  ///
  /// Controls whether the webhook is active and delivering payloads:
  /// - `WooWebhookStatus.active`: Webhook is active and delivering payloads
  /// - `WooWebhookStatus.paused`: Webhook is paused by admin (no delivery)
  /// - `WooWebhookStatus.disabled`: Webhook is disabled due to delivery failures
  final WooWebhookStatus? status;

  /// The event topic that triggers this webhook
  ///
  /// Determines which events will trigger webhook delivery. Common topics include:
  /// - `order.created`, `order.updated`, `order.deleted`
  /// - `product.created`, `product.updated`, `product.deleted`
  /// - `customer.created`, `customer.updated`, `customer.deleted`
  /// - `coupon.created`, `coupon.updated`, `coupon.deleted`
  ///
  /// You can use [WooWebhookTopic] to get the available topics.
  final String? topic;

  /// The resource type for this webhook
  ///
  /// Automatically derived from the topic (e.g., 'order', 'product', 'customer').
  /// This is included in the delivery headers to help identify the resource type.
  final String? resource;

  /// The event type for this webhook
  ///
  /// Automatically derived from the topic (e.g., 'created', 'updated', 'deleted').
  /// This is included in the delivery headers to help identify the event type.
  final String? event;

  /// Array of WordPress hook names bound to this webhook
  ///
  /// These are the actual WordPress hooks that trigger the webhook delivery.
  /// They are automatically determined based on the topic when the webhook is created.
  final List<String>? hooks;

  /// URL where webhook payloads are delivered
  ///
  /// This must be a valid HTTP or HTTPS URL that can receive POST requests.
  /// The endpoint should be able to handle JSON payloads and verify signatures.
  final String? deliveryUrl;

  /// Optional secret key for HMAC-SHA256 signature verification
  ///
  /// If provided, WooCommerce will generate a signature using this secret
  /// and include it in the `X-WC-Webhook-Signature` header. This allows
  /// you to verify that the webhook payload is authentic and hasn't been tampered with.
  final String? secret;

  /// Date and time when the webhook was created (local time)
  ///
  /// This timestamp reflects when the webhook was first created in the store's local timezone.
  final DateTime? dateCreated;

  /// Date and time when the webhook was created (GMT)
  ///
  /// This timestamp reflects when the webhook was first created in GMT/UTC timezone.
  final DateTime? dateCreatedGmt;

  /// Date and time when the webhook was last modified (local time)
  ///
  /// This timestamp reflects when the webhook was last updated in the store's local timezone.
  final DateTime? dateModified;

  /// Date and time when the webhook was last modified (GMT)
  ///
  /// This timestamp reflects when the webhook was last updated in GMT/UTC timezone.
  final DateTime? dateModifiedGmt;

  /// Creates a new WooWebhook instance
  ///
  /// ## Required Parameters
  ///
  /// * [name] - Human-readable name for the webhook
  /// * [topic] - The event topic that triggers this webhook (e.g., 'order.created')
  /// * [deliveryUrl] - URL where webhook payloads will be delivered
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier (assigned by WooCommerce)
  /// * [status] - Webhook status (default: active)
  /// * [resource] - Resource type (auto-derived from topic)
  /// * [event] - Event type (auto-derived from topic)
  /// * [hooks] - WordPress hook names (auto-assigned)
  /// * [secret] - Secret key for signature verification
  /// * [dateCreated] - Creation timestamp (local time)
  /// * [dateCreatedGmt] - Creation timestamp (GMT)
  /// * [dateModified] - Last modification timestamp (local time)
  /// * [dateModifiedGmt] - Last modification timestamp (GMT)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic webhook
  /// final webhook = WooWebhook(
  ///   name: 'Order Updates',
  ///   topic: 'order.updated',
  ///   deliveryUrl: 'https://your-app.com/webhooks/orders',
  /// );
  ///
  /// // Create a webhook with secret for verification
  /// final secureWebhook = WooWebhook(
  ///   name: 'Secure Order Updates',
  ///   topic: 'order.created',
  ///   deliveryUrl: 'https://your-app.com/webhooks/orders',
  ///   secret: 'your-secret-key',
  ///   status: WooWebhookStatus.active,
  /// );
  /// ```
  WooWebhook({
    this.id,
    required this.name,
    this.status = WooWebhookStatus.active,
    required this.topic,
    this.resource,
    this.event,
    this.hooks,
    required this.deliveryUrl,
    this.secret,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
  });

  /// Creates a WooWebhook instance from JSON data
  ///
  /// This factory constructor is used to deserialize webhook data received
  /// from the WooCommerce REST API. It handles the conversion of JSON fields
  /// to the appropriate Dart types and provides fallback values where needed.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the webhook data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooWebhook` instance populated with data from the JSON.
  ///
  /// ## JSON Structure
  ///
  /// The expected JSON structure includes:
  /// ```json
  /// {
  ///   "id": 123,
  ///   "name": "Order Updates",
  ///   "status": "active",
  ///   "topic": "order.updated",
  ///   "resource": "order",
  ///   "event": "updated",
  ///   "hooks": ["woocommerce_order_status_changed"],
  ///   "delivery_url": "https://example.com/webhook",
  ///   "secret": "secret-key",
  ///   "date_created": "2023-01-01T00:00:00",
  ///   "date_created_gmt": "2023-01-01T00:00:00",
  ///   "date_modified": "2023-01-01T00:00:00",
  ///   "date_modified_gmt": "2023-01-01T00:00:00"
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse webhook from API response
  /// final jsonData = {
  ///   'id': 123,
  ///   'name': 'Order Updates',
  ///   'status': 'active',
  ///   'topic': 'order.updated',
  ///   'delivery_url': 'https://example.com/webhook',
  /// };
  ///
  /// final webhook = WooWebhook.fromJson(jsonData);
  /// print('Webhook: ${webhook.name}');
  /// ```
  factory WooWebhook.fromJson(Map<String, dynamic> json) => WooWebhook(
        id: json['id'],
        name: json['name'],
        status: WooWebhookStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => WooWebhookStatus.active,
        ),
        topic: json['topic'],
        resource: json['resource'],
        event: json['event'],
        hooks: json['hooks'] != null ? List<String>.from(json['hooks']) : null,
        deliveryUrl: json['delivery_url'],
        secret: json['secret'],
        dateCreated: DateTime.parse(json['date_created']),
        dateCreatedGmt: DateTime.parse(json['date_created_gmt']),
        dateModified: DateTime.parse(json['date_modified']),
        dateModifiedGmt: DateTime.parse(json['date_modified_gmt']),
      );

  /// Converts the WooWebhook instance to JSON format
  ///
  /// This method serializes the webhook data into a Map that can be sent
  /// to the WooCommerce REST API. It handles the conversion of Dart types
  /// to JSON-compatible formats and includes all necessary fields.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the webhook data in JSON format.
  ///
  /// ## JSON Structure
  ///
  /// The returned JSON structure includes:
  /// ```json
  /// {
  ///   "id": 123,
  ///   "name": "Order Updates",
  ///   "status": "active",
  ///   "topic": "order.updated",
  ///   "resource": "order",
  ///   "event": "updated",
  ///   "hooks": ["woocommerce_order_status_changed"],
  ///   "delivery_url": "https://example.com/webhook",
  ///   "secret": "secret-key",
  ///   "date_created": "2023-01-01T00:00:00",
  ///   "date_created_gmt": "2023-01-01T00:00:00",
  ///   "date_modified": "2023-01-01T00:00:00",
  ///   "date_modified_gmt": "2023-01-01T00:00:00"
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert webhook to JSON for API calls
  /// final webhook = WooWebhook(
  ///   name: 'Order Updates',
  ///   topic: 'order.updated',
  ///   deliveryUrl: 'https://example.com/webhook',
  /// );
  ///
  /// final jsonData = webhook.toJson();
  /// print('JSON: $jsonData');
  ///
  /// // Send to API
  /// await dio.post('/webhooks', data: webhook.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status?.name,
        'topic': topic,
        'resource': resource,
        'event': event,
        'hooks': hooks,
        'delivery_url': deliveryUrl,
        'secret': secret,
        'date_created': dateCreated?.toIso8601String(),
        'date_created_gmt': dateCreatedGmt?.toIso8601String(),
        'date_modified': dateModified?.toIso8601String(),
        'date_modified_gmt': dateModifiedGmt?.toIso8601String(),
      };

  /// Creates a fake WooWebhook instance for testing purposes
  ///
  /// This factory constructor generates a webhook with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated webhook will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake webhook includes:
  /// - Random name from sentence generator
  /// - Random status from available statuses
  /// - Random topic from available topics
  /// - Random delivery URL
  /// - Random secret key
  ///
  /// ## Returns
  ///
  /// A `WooWebhook` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake webhook for testing
  /// final fakeWebhook = WooWebhook.fake();
  /// print('Fake webhook: ${fakeWebhook.name}');
  /// print('Topic: ${fakeWebhook.topic}');
  ///
  /// // Use in tests
  /// test('webhook creation', () {
  ///   final webhook = WooWebhook.fake();
  ///   expect(webhook.name, isNotNull);
  ///   expect(webhook.topic, isNotNull);
  ///   expect(webhook.deliveryUrl, isNotNull);
  /// });
  /// ```
  factory WooWebhook.fake() => WooWebhook(
        name: FakeHelper.sentence(),
        status: FakeHelper.randomItem(WooWebhookStatus.values),
        topic: WooWebhookTopic.randomTopic(),
        deliveryUrl: FakeHelper.url(),
        secret: FakeHelper.code(),
      );
}
