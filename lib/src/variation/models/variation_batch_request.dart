import 'variation.dart';

/// WooCommerce Product Variation Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple product variations in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple variations in a single request
/// - **Bulk Updates**: Update multiple existing variations simultaneously
/// - **Bulk Deletion**: Delete multiple variations at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
/// - **Product Scoped**: All variations must belong to the same parent product
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooProductVariationBatchRequest(
///   create: [
///     WooProductVariation(
///       sku: 'T-SHIRT-RED-L',
///       price: 25.99,
///       regularPrice: 29.99,
///       stockQuantity: 50,
///       stockStatus: WooProductStockStatus.instock,
///     ),
///     WooProductVariation(
///       sku: 'T-SHIRT-BLUE-L',
///       price: 25.99,
///       regularPrice: 29.99,
///       stockQuantity: 30,
///       stockStatus: WooProductStockStatus.instock,
///     ),
///   ],
///   update: [
///     existingVariation..price = 24.99,
///   ],
///   delete: [789, 101112],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooProductVariationBatchRequest(
///   create: [variation1, variation2, variation3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooProductVariationBatchRequest(
///   update: [updatedVariation1, updatedVariation2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooProductVariationBatchRequest(
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
/// final batchRequest = WooProductVariationBatchRequest.fromJson(jsonData);
/// ```
class WooProductVariationBatchRequest {

  /// Creates a new WooProductVariationBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooProductVariation` objects to create
  /// * [update] - List of `WooProductVariation` objects to update (must include `id`)
  /// * [delete] - List of variation IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductVariationBatchRequest(
  ///   create: [
  ///     WooProductVariation(
  ///       sku: 'T-SHIRT-RED-L',
  ///       price: 25.99,
  ///       stockQuantity: 50,
  ///     ),
  ///   ],
  ///   update: [
  ///     existingVariation..price = 24.99,
  ///   ],
  ///   delete: [123],
  /// );
  /// ```
  WooProductVariationBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductVariationBatchRequest instance from JSON data
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
  /// A `WooProductVariationBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductVariationBatchRequest.fromJson(jsonData);
  /// ```
  factory WooProductVariationBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductVariationBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooProductVariation.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooProductVariation.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );
  /// List of variations to create
  ///
  /// Each variation in this list will be created as a new variation for the parent product.
  /// Variations in this list should not have an ID assigned.
  final List<WooProductVariation>? create;

  /// List of variations to update
  ///
  /// Each variation in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooProductVariation>? update;

  /// List of variation IDs to delete
  ///
  /// Each ID in this list represents a variation that will be deleted from the product.
  final List<int>? delete;

  /// Converts the WooProductVariationBatchRequest instance to JSON format
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
          'create': create!.map((variation) => variation.toJson()).toList(),
        if (update != null)
          'update': update!.map((variation) => variation.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooProductVariationBatchRequest instance
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
  /// final batchRequest = WooProductVariationBatchRequest(
  ///   create: [variation1, variation2],
  ///   update: [variation3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooProductVariationBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductVariationBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

