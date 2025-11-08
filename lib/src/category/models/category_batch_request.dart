import 'category.dart';

/// WooCommerce Product Category Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple product categories in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple categories in a single request
/// - **Bulk Updates**: Update multiple existing categories simultaneously
/// - **Bulk Deletion**: Delete multiple categories at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
/// - **Hierarchical Support**: Handle parent-child category relationships
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooProductCategoryBatchRequest(
///   create: [
///     WooProductCategory(
///       name: 'Electronics',
///       description: 'Electronic products and gadgets',
///       slug: 'electronics',
///     ),
///     WooProductCategory(
///       name: 'Clothing',
///       description: 'Apparel and accessories',
///       slug: 'clothing',
///     ),
///   ],
///   update: [
///     existingCategory..name = 'Updated Electronics',
///   ],
///   delete: [123, 456],
/// );
/// ```
///
/// ### Working with Hierarchical Categories
///
/// ```dart
/// // Create parent and child categories in a batch
/// final parentCategory = WooProductCategory(
///   name: 'Electronics',
///   slug: 'electronics',
/// );
///
/// final batchRequest = WooProductCategoryBatchRequest(
///   create: [
///     parentCategory,
///     WooProductCategory(
///       name: 'Smartphones',
///       parent: parentCategory.id, // Will be set after parent is created
///       slug: 'smartphones',
///     ),
///   ],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooProductCategoryBatchRequest(
///   create: [category1, category2, category3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooProductCategoryBatchRequest(
///   update: [updatedCategory1, updatedCategory2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooProductCategoryBatchRequest(
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
/// final batchRequest = WooProductCategoryBatchRequest.fromJson(jsonData);
/// ```
class WooProductCategoryBatchRequest {
  /// List of categories to create
  ///
  /// Each category in this list will be created as a new category in the store.
  /// Categories in this list should not have an ID assigned.
  final List<WooProductCategory>? create;

  /// List of categories to update
  ///
  /// Each category in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooProductCategory>? update;

  /// List of category IDs to delete
  ///
  /// Each ID in this list represents a category that will be deleted from the store.
  final List<int>? delete;

  /// Creates a new WooProductCategoryBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooProductCategory` objects to create
  /// * [update] - List of `WooProductCategory` objects to update (must include `id`)
  /// * [delete] - List of category IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductCategoryBatchRequest(
  ///   create: [
  ///     WooProductCategory(
  ///       name: 'Electronics',
  ///       description: 'Electronic products',
  ///     ),
  ///   ],
  ///   update: [
  ///     existingCategory..name = 'Updated Name',
  ///   ],
  ///   delete: [123],
  /// );
  /// ```
  WooProductCategoryBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductCategoryBatchRequest instance from JSON data
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
  /// A `WooProductCategoryBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductCategoryBatchRequest.fromJson(jsonData);
  /// ```
  factory WooProductCategoryBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductCategoryBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) => WooProductCategory.fromJson(
                    item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) => WooProductCategory.fromJson(
                    item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );

  /// Converts the WooProductCategoryBatchRequest instance to JSON format
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
          'create': create!.map((category) => category.toJson()).toList(),
        if (update != null)
          'update': update!.map((category) => category.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooProductCategoryBatchRequest instance
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
  /// final batchRequest = WooProductCategoryBatchRequest(
  ///   create: [category1, category2],
  ///   update: [category3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooProductCategoryBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductCategoryBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

