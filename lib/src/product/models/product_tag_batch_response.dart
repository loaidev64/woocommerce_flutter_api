import 'product_tag.dart';

/// WooCommerce Product Tag Batch Response Model
///
/// This class represents the response from a batch product tag operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created tags with server-assigned IDs
/// - **Update Results**: List of successfully updated tags
/// - **Delete Results**: List of successfully deleted tags
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductTags(batchRequest);
///
/// // Process created tags
/// for (final tag in response.create ?? []) {
///   print('Created tag: ${tag.name} with ID: ${tag.id}');
/// }
///
/// // Process updated tags
/// for (final tag in response.update ?? []) {
///   print('Updated tag: ${tag.name}');
/// }
///
/// // Process deleted tags
/// for (final tag in response.delete ?? []) {
///   print('Deleted tag: ${tag.name}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductTags(batchRequest);
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
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Create from JSON response
/// final batchResponse = WooProductTagBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooProductTagBatchResponse {

  /// Creates a new WooProductTagBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooProductTag` objects
  /// * [update] - List of updated `WooProductTag` objects
  /// * [delete] - List of deleted `WooProductTag` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductTagBatchResponse(
  ///   create: [createdTag1, createdTag2],
  ///   update: [updatedTag1],
  ///   delete: [deletedTag1],
  /// );
  /// ```
  WooProductTagBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductTagBatchResponse instance from JSON data
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
  /// A `WooProductTagBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductTagBatchResponse.fromJson(jsonData);
  /// ```
  factory WooProductTagBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductTagBatchResponse(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooProductTag.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooProductTag.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List)
                .map((item) =>
                    WooProductTag.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created tags
  ///
  /// Contains the tags that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooProductTag>? create;

  /// List of updated tags
  ///
  /// Contains the tags that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooProductTag>? update;

  /// List of deleted tags
  ///
  /// Contains the tags that were successfully deleted. These tags
  /// may have limited information depending on the API response.
  final List<WooProductTag>? delete;

  /// Converts the WooProductTagBatchResponse instance to JSON format
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
          'create': create!.map((tag) => tag.toJson()).toList(),
        if (update != null)
          'update': update!.map((tag) => tag.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((tag) => tag.toJson()).toList(),
      };

  /// Returns a string representation of the WooProductTagBatchResponse instance
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
  /// final batchResponse = WooProductTagBatchResponse(
  ///   create: [tag1, tag2],
  ///   update: [tag3],
  ///   delete: [tag4, tag5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooProductTagBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductTagBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

