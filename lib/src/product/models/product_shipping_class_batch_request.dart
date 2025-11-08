import 'product_shipping_class.dart';

/// WooCommerce Product Shipping Class Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple product shipping classes in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple shipping classes in a single request
/// - **Bulk Updates**: Update multiple existing shipping classes simultaneously
/// - **Bulk Deletion**: Delete multiple shipping classes at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooProductShippingClassBatchRequest(
///   create: [
///     WooProductShippingClass(
///       name: 'Express Shipping',
///       slug: 'express-shipping',
///       description: 'Fast delivery option',
///     ),
///     WooProductShippingClass(
///       name: 'Standard Shipping',
///       slug: 'standard-shipping',
///       description: 'Regular delivery option',
///     ),
///   ],
///   update: [
///     WooProductShippingClass(
///       id: 123,
///       name: 'Updated Express Shipping',
///       slug: 'updated-express-shipping',
///       description: 'Updated fast delivery option',
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
/// final createOnly = WooProductShippingClassBatchRequest(
///   create: [shippingClass1, shippingClass2, shippingClass3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooProductShippingClassBatchRequest(
///   update: [updatedShippingClass1, updatedShippingClass2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooProductShippingClassBatchRequest(
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
/// final batchRequest = WooProductShippingClassBatchRequest.fromJson(jsonData);
/// ```
class WooProductShippingClassBatchRequest {

  /// Creates a new WooProductShippingClassBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooProductShippingClass` objects to create
  /// * [update] - List of `WooProductShippingClass` objects to update (must include `id`)
  /// * [delete] - List of shipping class IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductShippingClassBatchRequest(
  ///   create: [
  ///     WooProductShippingClass(
  ///       name: 'Express Shipping',
  ///       slug: 'express-shipping',
  ///       description: 'Fast delivery option',
  ///     ),
  ///   ],
  ///   update: [
  ///     WooProductShippingClass(
  ///       id: 123,
  ///       name: 'Updated Express Shipping',
  ///       slug: 'updated-express-shipping',
  ///       description: 'Updated fast delivery option',
  ///     ),
  ///   ],
  ///   delete: [456],
  /// );
  /// ```
  WooProductShippingClassBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductShippingClassBatchRequest instance from JSON data
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
  /// A `WooProductShippingClassBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductShippingClassBatchRequest.fromJson(jsonData);
  /// ```
  factory WooProductShippingClassBatchRequest.fromJson(
      Map<String, dynamic> json) =>
      WooProductShippingClassBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooProductShippingClass.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooProductShippingClass.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );
  /// List of shipping classes to create
  ///
  /// Each shipping class in this list will be created as a new shipping class in the store.
  /// Shipping classes in this list should not have an ID assigned.
  final List<WooProductShippingClass>? create;

  /// List of shipping classes to update
  ///
  /// Each shipping class in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooProductShippingClass>? update;

  /// List of shipping class IDs to delete
  ///
  /// Each ID in this list represents a shipping class that will be deleted from the store.
  final List<int>? delete;

  /// Converts the WooProductShippingClassBatchRequest instance to JSON format
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
          'create': create!.map((shippingClass) => shippingClass.toJson()).toList(),
        if (update != null)
          'update': update!.map((shippingClass) => shippingClass.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooProductShippingClassBatchRequest instance
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
  /// final batchRequest = WooProductShippingClassBatchRequest(
  ///   create: [shippingClass1, shippingClass2],
  ///   update: [shippingClass3],
  ///   delete: [101, 102],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooProductShippingClassBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductShippingClassBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

