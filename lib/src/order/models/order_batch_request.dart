import 'order.dart';

/// WooCommerce Order Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple orders in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple orders in a single request
/// - **Bulk Updates**: Update multiple existing orders simultaneously
/// - **Bulk Deletion**: Delete multiple orders at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooOrderBatchRequest(
///   create: [
///     WooOrder(
///       id: 0,
///       status: WooOrderStatus.pending,
///       currency: WooOrderCurrency.usd,
///       total: 99.99,
///       customerId: 123,
///     ),
///     WooOrder(
///       id: 0,
///       status: WooOrderStatus.pending,
///       currency: WooOrderCurrency.usd,
///       total: 149.99,
///       customerId: 456,
///     ),
///   ],
///   update: [
///     existingOrder..status = WooOrderStatus.processing,
///   ],
///   delete: [789, 101112],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooOrderBatchRequest(
///   create: [order1, order2, order3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooOrderBatchRequest(
///   update: [updatedOrder1, updatedOrder2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooOrderBatchRequest(
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
/// final batchRequest = WooOrderBatchRequest.fromJson(jsonData);
/// ```
class WooOrderBatchRequest {

  /// Creates a new WooOrderBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooOrder` objects to create (should have id: 0)
  /// * [update] - List of `WooOrder` objects to update (must include `id`)
  /// * [delete] - List of order IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooOrderBatchRequest(
  ///   create: [
  ///     WooOrder(
  ///       id: 0,
  ///       status: WooOrderStatus.pending,
  ///       currency: WooOrderCurrency.usd,
  ///       total: 99.99,
  ///     ),
  ///   ],
  ///   update: [
  ///     existingOrder..status = WooOrderStatus.processing,
  ///   ],
  ///   delete: [123],
  /// );
  /// ```
  WooOrderBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooOrderBatchRequest instance from JSON data
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
  /// A `WooOrderBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooOrderBatchRequest.fromJson(jsonData);
  /// ```
  factory WooOrderBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooOrderBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) => WooOrder.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) => WooOrder.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );
  /// List of orders to create
  ///
  /// Each order in this list will be created as a new order in the store.
  /// Orders in this list should have id set to 0 (will be assigned by WooCommerce).
  final List<WooOrder>? create;

  /// List of orders to update
  ///
  /// Each order in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooOrder>? update;

  /// List of order IDs to delete
  ///
  /// Each ID in this list represents an order that will be deleted from the store.
  final List<int>? delete;

  /// Converts the WooOrderBatchRequest instance to JSON format
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
          'create': create!.map((order) => order.toJson()).toList(),
        if (update != null)
          'update': update!.map((order) => order.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooOrderBatchRequest instance
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
  /// final batchRequest = WooOrderBatchRequest(
  ///   create: [order1, order2],
  ///   update: [order3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooOrderBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooOrderBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

