import 'product_shipping_class.dart';

/// WooCommerce Product Shipping Class Batch Response Model
///
/// This class represents the response from a batch product shipping class operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created shipping classes with server-assigned IDs
/// - **Update Results**: List of successfully updated shipping classes
/// - **Delete Results**: List of successfully deleted shipping classes
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);
///
/// // Process created shipping classes
/// for (final shippingClass in response.create ?? []) {
///   print('Created shipping class: ${shippingClass.name} with ID: ${shippingClass.id}');
/// }
///
/// // Process updated shipping classes
/// for (final shippingClass in response.update ?? []) {
///   print('Updated shipping class: ${shippingClass.name}');
/// }
///
/// // Process deleted shipping classes
/// for (final shippingClass in response.delete ?? []) {
///   print('Deleted shipping class: ${shippingClass.name}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);
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
/// final batchResponse = WooProductShippingClassBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooProductShippingClassBatchResponse {
  /// List of created shipping classes
  ///
  /// Contains the shipping classes that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooProductShippingClass>? create;

  /// List of updated shipping classes
  ///
  /// Contains the shipping classes that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooProductShippingClass>? update;

  /// List of deleted shipping classes
  ///
  /// Contains the shipping classes that were successfully deleted. These shipping classes
  /// may have limited information depending on the API response.
  final List<WooProductShippingClass>? delete;

  /// Creates a new WooProductShippingClassBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooProductShippingClass` objects
  /// * [update] - List of updated `WooProductShippingClass` objects
  /// * [delete] - List of deleted `WooProductShippingClass` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductShippingClassBatchResponse(
  ///   create: [createdShippingClass1, createdShippingClass2],
  ///   update: [updatedShippingClass1],
  ///   delete: [deletedShippingClass1],
  /// );
  /// ```
  WooProductShippingClassBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductShippingClassBatchResponse instance from JSON data
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
  /// A `WooProductShippingClassBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductShippingClassBatchResponse.fromJson(jsonData);
  /// ```
  factory WooProductShippingClassBatchResponse.fromJson(
      Map<String, dynamic> json) =>
      WooProductShippingClassBatchResponse(
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
            ? (json['delete'] as List)
                .map((item) =>
                    WooProductShippingClass.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );

  /// Converts the WooProductShippingClassBatchResponse instance to JSON format
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
          'create': create!.map((shippingClass) => shippingClass.toJson()).toList(),
        if (update != null)
          'update': update!.map((shippingClass) => shippingClass.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((shippingClass) => shippingClass.toJson()).toList(),
      };

  /// Returns a string representation of the WooProductShippingClassBatchResponse instance
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
  /// final batchResponse = WooProductShippingClassBatchResponse(
  ///   create: [shippingClass1, shippingClass2],
  ///   update: [shippingClass3],
  ///   delete: [shippingClass4, shippingClass5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooProductShippingClassBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductShippingClassBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

