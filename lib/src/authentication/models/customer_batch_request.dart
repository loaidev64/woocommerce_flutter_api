import 'customer.dart';

/// WooCommerce Customer Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple customers in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple customers in a single request
/// - **Bulk Updates**: Update multiple existing customers simultaneously
/// - **Bulk Deletion**: Delete multiple customers at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooCustomerBatchRequest(
///   create: [
///     WooCustomer(
///       email: 'customer1@example.com',
///       firstName: 'John',
///       lastName: 'Doe',
///       username: 'johndoe',
///     ),
///     WooCustomer(
///       email: 'customer2@example.com',
///       firstName: 'Jane',
///       lastName: 'Smith',
///       username: 'janesmith',
///     ),
///   ],
///   update: [
///     existingCustomer..firstName = 'Updated Name',
///   ],
///   delete: [123, 456],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooCustomerBatchRequest(
///   create: [customer1, customer2, customer3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooCustomerBatchRequest(
///   update: [updatedCustomer1, updatedCustomer2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooCustomerBatchRequest(
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
/// final batchRequest = WooCustomerBatchRequest.fromJson(jsonData);
/// ```
class WooCustomerBatchRequest {
  /// List of customers to create
  ///
  /// Each customer in this list will be created as a new customer in the store.
  /// Customers in this list should not have an ID assigned.
  final List<WooCustomer>? create;

  /// List of customers to update
  ///
  /// Each customer in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooCustomer>? update;

  /// List of customer IDs to delete
  ///
  /// Each ID in this list represents a customer that will be deleted from the store.
  final List<int>? delete;

  /// Creates a new WooCustomerBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooCustomer` objects to create
  /// * [update] - List of `WooCustomer` objects to update (must include `id`)
  /// * [delete] - List of customer IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooCustomerBatchRequest(
  ///   create: [
  ///     WooCustomer(
  ///       email: 'customer@example.com',
  ///       firstName: 'John',
  ///       lastName: 'Doe',
  ///     ),
  ///   ],
  ///   update: [
  ///     existingCustomer..firstName = 'Updated Name',
  ///   ],
  ///   delete: [123],
  /// );
  /// ```
  WooCustomerBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooCustomerBatchRequest instance from JSON data
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
  /// A `WooCustomerBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooCustomerBatchRequest.fromJson(jsonData);
  /// ```
  factory WooCustomerBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooCustomerBatchRequest(
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
            ? (json['delete'] as List).cast<int>()
            : null,
      );

  /// Converts the WooCustomerBatchRequest instance to JSON format
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
          'create': create!.map((customer) => customer.toJson()).toList(),
        if (update != null)
          'update': update!.map((customer) => customer.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooCustomerBatchRequest instance
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
  /// final batchRequest = WooCustomerBatchRequest(
  ///   create: [customer1, customer2],
  ///   update: [customer3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooCustomerBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooCustomerBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

