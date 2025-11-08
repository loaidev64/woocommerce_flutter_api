import 'order.dart';

/// WooCommerce Order Batch Response Model
///
/// This class represents the response from a batch order operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created orders with server-assigned IDs
/// - **Update Results**: List of successfully updated orders
/// - **Delete Results**: List of successfully deleted orders
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateOrders(batchRequest);
///
/// // Process created orders
/// for (final order in response.create ?? []) {
///   print('Created order: ${order.number} with ID: ${order.id}');
/// }
///
/// // Process updated orders
/// for (final order in response.update ?? []) {
///   print('Updated order: ${order.number}');
/// }
///
/// // Process deleted orders
/// for (final order in response.delete ?? []) {
///   print('Deleted order: ${order.number}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateOrders(batchRequest);
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
/// final batchResponse = WooOrderBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooOrderBatchResponse {

  /// Creates a new WooOrderBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooOrder` objects
  /// * [update] - List of updated `WooOrder` objects
  /// * [delete] - List of deleted `WooOrder` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooOrderBatchResponse(
  ///   create: [createdOrder1, createdOrder2],
  ///   update: [updatedOrder1],
  ///   delete: [deletedOrder1],
  /// );
  /// ```
  WooOrderBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooOrderBatchResponse instance from JSON data
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
  /// A `WooOrderBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooOrderBatchResponse.fromJson(jsonData);
  /// ```
  factory WooOrderBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooOrderBatchResponse(
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
            ? (json['delete'] as List)
                .map((item) => WooOrder.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created orders
  ///
  /// Contains the orders that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooOrder>? create;

  /// List of updated orders
  ///
  /// Contains the orders that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooOrder>? update;

  /// List of deleted orders
  ///
  /// Contains the orders that were successfully deleted. These orders
  /// may have limited information depending on the API response.
  final List<WooOrder>? delete;

  /// Converts the WooOrderBatchResponse instance to JSON format
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
          'create': create!.map((order) => order.toJson()).toList(),
        if (update != null)
          'update': update!.map((order) => order.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((order) => order.toJson()).toList(),
      };

  /// Returns a string representation of the WooOrderBatchResponse instance
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
  /// final batchResponse = WooOrderBatchResponse(
  ///   create: [order1, order2],
  ///   update: [order3],
  ///   delete: [order4, order5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooOrderBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooOrderBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

