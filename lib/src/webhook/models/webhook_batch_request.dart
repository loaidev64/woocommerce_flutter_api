import 'webhook.dart';

/// WooCommerce Webhook Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple webhooks in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple webhooks in a single request
/// - **Bulk Updates**: Update multiple existing webhooks simultaneously
/// - **Bulk Deletion**: Delete multiple webhooks at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
/// - **Webhook Configuration**: Manage topics, delivery URLs, and secret keys in bulk
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooWebhookBatchRequest(
///   create: [
///     WooWebhook(
///       name: 'Order Created Webhook',
///       topic: 'order.created',
///       deliveryUrl: 'https://your-app.com/webhooks/orders',
///       secret: 'your-secret-key',
///       status: WooWebhookStatus.active,
///     ),
///     WooWebhook(
///       name: 'Product Updated Webhook',
///       topic: 'product.updated',
///       deliveryUrl: 'https://your-app.com/webhooks/products',
///       secret: 'another-secret-key',
///       status: WooWebhookStatus.active,
///     ),
///   ],
///   update: [
///     WooWebhook(
///       id: 123,
///       name: 'Updated Order Webhook',
///       status: WooWebhookStatus.paused,
///     ),
///   ],
///   delete: [456, 789],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooWebhookBatchRequest(
///   create: [webhook1, webhook2, webhook3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooWebhookBatchRequest(
///   update: [updatedWebhook1, updatedWebhook2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooWebhookBatchRequest(
///   delete: [101, 102, 103],
/// );
/// ```
///
/// ### Managing Webhook Topics
///
/// ```dart
/// // Create webhooks for different topics
/// final batchRequest = WooWebhookBatchRequest(
///   create: [
///     WooWebhook(
///       name: 'Order Events',
///       topic: 'order.created',
///       deliveryUrl: 'https://your-app.com/webhooks/orders',
///     ),
///     WooWebhook(
///       name: 'Customer Events',
///       topic: 'customer.created',
///       deliveryUrl: 'https://your-app.com/webhooks/customers',
///     ),
///     WooWebhook(
///       name: 'Product Events',
///       topic: 'product.updated',
///       deliveryUrl: 'https://your-app.com/webhooks/products',
///     ),
///   ],
/// );
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = batchRequest.toJson();
///
/// // Create from JSON response
/// final batchRequest = WooWebhookBatchRequest.fromJson(jsonData);
/// ```
class WooWebhookBatchRequest {
  /// List of webhooks to create
  ///
  /// Each webhook in this list will be created as a new webhook in the store.
  /// Webhooks in this list should not have an ID assigned.
  final List<WooWebhook>? create;

  /// List of webhooks to update
  ///
  /// Each webhook in this list must have a valid ID and will be updated
  /// with the provided values. Common use cases include:
  /// - Updating webhook status (active, paused, disabled)
  /// - Changing delivery URLs
  /// - Updating secret keys
  /// - Modifying webhook names or topics
  final List<WooWebhook>? update;

  /// List of webhook IDs to delete
  ///
  /// Each ID in this list represents a webhook that will be permanently deleted from the store.
  final List<int>? delete;

  /// Creates a new WooWebhookBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooWebhook` objects to create
  /// * [update] - List of `WooWebhook` objects to update (must include `id`)
  /// * [delete] - List of webhook IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooWebhookBatchRequest(
  ///   create: [
  ///     WooWebhook(
  ///       name: 'Order Updates',
  ///       topic: 'order.updated',
  ///       deliveryUrl: 'https://your-app.com/webhooks/orders',
  ///       secret: 'your-secret-key',
  ///     ),
  ///   ],
  ///   update: [
  ///     WooWebhook(
  ///       id: 123,
  ///       status: WooWebhookStatus.paused,
  ///     ),
  ///   ],
  ///   delete: [456],
  /// );
  /// ```
  WooWebhookBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooWebhookBatchRequest instance from JSON data
  ///
  /// This factory constructor is used to deserialize batch request data
  /// received from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the batch request data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooWebhookBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooWebhookBatchRequest.fromJson(jsonData);
  /// ```
  factory WooWebhookBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooWebhookBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooWebhook.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooWebhook.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );

  /// Converts the WooWebhookBatchRequest instance to JSON format
  ///
  /// This method serializes the batch request data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the batch request data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = batchRequest.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        if (create != null)
          'create': create!.map((webhook) => webhook.toJson()).toList(),
        if (update != null)
          'update': update!.map((webhook) => webhook.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooWebhookBatchRequest instance
  ///
  /// This method provides a human-readable representation of the batch request,
  /// displaying the counts of create, update, and delete operations.
  ///
  /// ## Returns
  ///
  /// A `String` containing the batch request's operation counts in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooWebhookBatchRequest(
  ///   create: [webhook1, webhook2],
  ///   update: [webhook3],
  ///   delete: [101, 102],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooWebhookBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooWebhookBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

