import 'webhook.dart';

/// WooCommerce Webhook Batch Response Model
///
/// This class represents the response from a batch webhook operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created webhooks with server-assigned IDs
/// - **Update Results**: List of successfully updated webhooks
/// - **Delete Results**: List of successfully deleted webhooks
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateWebhooks(batchRequest);
///
/// // Process created webhooks
/// for (final webhook in response.create ?? []) {
///   print('Created webhook: ${webhook.name} with ID: ${webhook.id}');
///   print('Topic: ${webhook.topic}');
///   print('Delivery URL: ${webhook.deliveryUrl}');
///   print('Status: ${webhook.status}');
/// }
///
/// // Process updated webhooks
/// for (final webhook in response.update ?? []) {
///   print('Updated webhook: ${webhook.name}');
///   print('New status: ${webhook.status}');
/// }
///
/// // Process deleted webhooks
/// for (final webhook in response.delete ?? []) {
///   print('Deleted webhook: ${webhook.name}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateWebhooks(batchRequest);
///
/// final createdCount = response.create?.length ?? 0;
/// final updatedCount = response.update?.length ?? 0;
/// final deletedCount = response.delete?.length ?? 0;
///
/// print('Batch operation completed:');
/// print('  Created: $createdCount');
/// print('  Updated: $updatedCount');
/// print('  Deleted: $deletedCount');
/// ```
///
/// ### Analyzing Webhook Topics
///
/// ```dart
/// final response = await wooCommerce.batchUpdateWebhooks(batchRequest);
///
/// // Group created webhooks by topic
/// final byTopic = <String, List<WooWebhook>>{};
/// for (final webhook in response.create ?? []) {
///   final topic = webhook.topic ?? 'Unknown';
///   byTopic.putIfAbsent(topic, () => []).add(webhook);
/// }
///
/// print('Webhooks by topic:');
/// byTopic.forEach((topic, webhooks) {
///   print('  $topic: ${webhooks.length} webhooks');
/// });
/// ```
///
/// ### Verifying Webhook Status
///
/// ```dart
/// final response = await wooCommerce.batchUpdateWebhooks(batchRequest);
///
/// // Check which webhooks are active
/// final activeWebhooks = response.create
///     ?.where((webhook) => webhook.status == WooWebhookStatus.active)
///     .toList() ?? [];
///
/// print('Active webhooks: ${activeWebhooks.length}');
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Create from JSON response
/// final batchResponse = WooWebhookBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooWebhookBatchResponse {
  /// List of created webhooks
  ///
  /// Contains the webhooks that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooWebhook>? create;

  /// List of updated webhooks
  ///
  /// Contains the webhooks that were successfully updated, reflecting
  /// the current state after the update operation, including any status changes.
  final List<WooWebhook>? update;

  /// List of deleted webhooks
  ///
  /// Contains the webhooks that were successfully deleted. These webhooks
  /// may have limited information depending on the API response.
  final List<WooWebhook>? delete;

  /// Creates a new WooWebhookBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooWebhook` objects
  /// * [update] - List of updated `WooWebhook` objects
  /// * [delete] - List of deleted `WooWebhook` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooWebhookBatchResponse(
  ///   create: [createdWebhook1, createdWebhook2],
  ///   update: [updatedWebhook1],
  ///   delete: [deletedWebhook1],
  /// );
  /// ```
  WooWebhookBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooWebhookBatchResponse instance from JSON data
  ///
  /// This factory constructor is used to deserialize batch response data
  /// received from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the batch response data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooWebhookBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooWebhookBatchResponse.fromJson(jsonData);
  /// ```
  factory WooWebhookBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooWebhookBatchResponse(
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
            ? (json['delete'] as List)
                .map((item) =>
                    WooWebhook.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );

  /// Converts the WooWebhookBatchResponse instance to JSON format
  ///
  /// This method serializes the batch response data into a Map.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the batch response data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = batchResponse.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        if (create != null)
          'create': create!.map((webhook) => webhook.toJson()).toList(),
        if (update != null)
          'update': update!.map((webhook) => webhook.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((webhook) => webhook.toJson()).toList(),
      };

  /// Returns a string representation of the WooWebhookBatchResponse instance
  ///
  /// This method provides a human-readable representation of the batch response,
  /// displaying the counts of create, update, and delete results.
  ///
  /// ## Returns
  ///
  /// A `String` containing the batch response's result counts in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooWebhookBatchResponse(
  ///   create: [webhook1, webhook2],
  ///   update: [webhook3],
  ///   delete: [webhook4, webhook5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooWebhookBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooWebhookBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

