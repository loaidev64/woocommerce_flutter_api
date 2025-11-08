import 'product.dart';

/// WooCommerce Product Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple products in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple products in a single request
/// - **Bulk Updates**: Update multiple existing products simultaneously
/// - **Bulk Deletion**: Delete multiple products at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooProductBatchRequest(
///   create: [
///     WooProduct(
///       name: 'New Product 1',
///       type: WooProductType.simple,
///       price: 29.99,
///       status: WooProductStatus.publish,
///     ),
///     WooProduct(
///       name: 'New Product 2',
///       type: WooProductType.simple,
///       price: 49.99,
///       status: WooProductStatus.publish,
///     ),
///   ],
///   update: [
///     existingProduct.copyWith(
///       name: 'Updated Product Name',
///       price: 39.99,
///     ),
///   ],
///   delete: [123, 456],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooProductBatchRequest(
///   create: [product1, product2, product3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooProductBatchRequest(
///   update: [updatedProduct1, updatedProduct2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooProductBatchRequest(
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
/// final batchRequest = WooProductBatchRequest.fromJson(jsonData);
/// ```
class WooProductBatchRequest {

  /// Creates a new WooProductBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooProduct` objects to create
  /// * [update] - List of `WooProduct` objects to update (must include `id`)
  /// * [delete] - List of product IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductBatchRequest(
  ///   create: [
  ///     WooProduct(
  ///       name: 'New Product',
  ///       type: WooProductType.simple,
  ///       price: 29.99,
  ///     ),
  ///   ],
  ///   update: [
  ///     existingProduct.copyWith(name: 'Updated Name'),
  ///   ],
  ///   delete: [123],
  /// );
  /// ```
  WooProductBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductBatchRequest instance from JSON data
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
  /// A `WooProductBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductBatchRequest.fromJson(jsonData);
  /// ```
  factory WooProductBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooProduct.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooProduct.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );
  /// List of products to create
  ///
  /// Each product in this list will be created as a new product in the store.
  /// Products in this list should not have an ID assigned.
  final List<WooProduct>? create;

  /// List of products to update
  ///
  /// Each product in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooProduct>? update;

  /// List of product IDs to delete
  ///
  /// Each ID in this list represents a product that will be deleted from the store.
  final List<int>? delete;

  /// Converts the WooProductBatchRequest instance to JSON format
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
          'create': create!.map((product) => product.toJson()).toList(),
        if (update != null)
          'update': update!.map((product) => product.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooProductBatchRequest instance
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
  /// final batchRequest = WooProductBatchRequest(
  ///   create: [product1, product2],
  ///   update: [product3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooProductBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

