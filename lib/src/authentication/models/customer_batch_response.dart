import 'customer.dart';

/// WooCommerce Customer Batch Response Model
///
/// This class represents the response from a batch customer operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created customers with server-assigned IDs
/// - **Update Results**: List of successfully updated customers
/// - **Delete Results**: List of successfully deleted customers
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateCustomers(batchRequest);
///
/// // Process created customers
/// for (final customer in response.create ?? []) {
///   print('Created customer: ${customer.email} with ID: ${customer.id}');
/// }
///
/// // Process updated customers
/// for (final customer in response.update ?? []) {
///   print('Updated customer: ${customer.email}');
/// }
///
/// // Process deleted customers
/// for (final customer in response.delete ?? []) {
///   print('Deleted customer: ${customer.email}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateCustomers(batchRequest);
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
/// final batchResponse = WooCustomerBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooCustomerBatchResponse {
  /// List of created customers
  ///
  /// Contains the customers that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooCustomer>? create;

  /// List of updated customers
  ///
  /// Contains the customers that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooCustomer>? update;

  /// List of deleted customers
  ///
  /// Contains the customers that were successfully deleted. These customers
  /// may have limited information depending on the API response.
  final List<WooCustomer>? delete;

  /// Creates a new WooCustomerBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooCustomer` objects
  /// * [update] - List of updated `WooCustomer` objects
  /// * [delete] - List of deleted `WooCustomer` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooCustomerBatchResponse(
  ///   create: [createdCustomer1, createdCustomer2],
  ///   update: [updatedCustomer1],
  ///   delete: [deletedCustomer1],
  /// );
  /// ```
  WooCustomerBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooCustomerBatchResponse instance from JSON data
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
  /// A `WooCustomerBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooCustomerBatchResponse.fromJson(jsonData);
  /// ```
  factory WooCustomerBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooCustomerBatchResponse(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooCustomer.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooCustomer.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List)
                .map((item) =>
                    WooCustomer.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );

  /// Converts the WooCustomerBatchResponse instance to JSON format
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
          'create': create!.map((customer) => customer.toJson()).toList(),
        if (update != null)
          'update': update!.map((customer) => customer.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((customer) => customer.toJson()).toList(),
      };

  /// Returns a string representation of the WooCustomerBatchResponse instance
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
  /// final batchResponse = WooCustomerBatchResponse(
  ///   create: [customer1, customer2],
  ///   update: [customer3],
  ///   delete: [customer4, customer5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooCustomerBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooCustomerBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

