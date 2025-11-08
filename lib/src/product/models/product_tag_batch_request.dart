import 'product_tag.dart';

/// WooCommerce Product Tag Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple product tags in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple tags in a single request
/// - **Bulk Updates**: Update multiple existing tags simultaneously
/// - **Bulk Deletion**: Delete multiple tags at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooProductTagBatchRequest(
///   create: [
///     WooProductTag(
///       null,
///       'Electronics',
///       'electronics',
///       'Electronic products and gadgets',
///     ),
///     WooProductTag(
///       null,
///       'Clothing',
///       'clothing',
///       'Apparel and accessories',
///     ),
///   ],
///   update: [
///     WooProductTag(
///       123,
///       'Updated Electronics',
///       'updated-electronics',
///       'Updated description',
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
/// final createOnly = WooProductTagBatchRequest(
///   create: [tag1, tag2, tag3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooProductTagBatchRequest(
///   update: [updatedTag1, updatedTag2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooProductTagBatchRequest(
///   delete: [101, 102, 103],
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
/// final batchRequest = WooProductTagBatchRequest.fromJson(jsonData);
/// ```
class WooProductTagBatchRequest {
  /// List of tags to create
  ///
  /// Each tag in this list will be created as a new tag in the store.
  /// Tags in this list should not have an ID assigned (use null for id).
  final List<WooProductTag>? create;

  /// List of tags to update
  ///
  /// Each tag in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooProductTag>? update;

  /// List of tag IDs to delete
  ///
  /// Each ID in this list represents a tag that will be deleted from the store.
  final List<int>? delete;

  /// Creates a new WooProductTagBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooProductTag` objects to create (should have id: null)
  /// * [update] - List of `WooProductTag` objects to update (must include `id`)
  /// * [delete] - List of tag IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductTagBatchRequest(
  ///   create: [
  ///     WooProductTag(null, 'Electronics', 'electronics', 'Electronic products'),
  ///   ],
  ///   update: [
  ///     WooProductTag(123, 'Updated Electronics', 'updated-electronics', 'Updated description'),
  ///   ],
  ///   delete: [456],
  /// );
  /// ```
  WooProductTagBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductTagBatchRequest instance from JSON data
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
  /// A `WooProductTagBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductTagBatchRequest.fromJson(jsonData);
  /// ```
  factory WooProductTagBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductTagBatchRequest(
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
            ? (json['delete'] as List).cast<int>()
            : null,
      );

  /// Converts the WooProductTagBatchRequest instance to JSON format
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
          'create': create!.map((tag) => tag.toJson()).toList(),
        if (update != null)
          'update': update!.map((tag) => tag.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooProductTagBatchRequest instance
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
  /// final batchRequest = WooProductTagBatchRequest(
  ///   create: [tag1, tag2],
  ///   update: [tag3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooProductTagBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductTagBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

