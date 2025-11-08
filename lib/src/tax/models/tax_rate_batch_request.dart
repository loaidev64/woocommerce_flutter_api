import 'tax_rate.dart';

/// WooCommerce Tax Rate Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple tax rates in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple tax rates in a single request
/// - **Bulk Updates**: Update multiple existing tax rates simultaneously
/// - **Bulk Deletion**: Delete multiple tax rates at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
/// - **Geographical Targeting**: Manage tax rates with country, state, city, and postcode rules
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooTaxRateBatchRequest(
///   create: [
///     WooTaxRate(
///       country: 'US',
///       state: 'CA',
///       rate: '8.25',
///       name: 'California Sales Tax',
///       priority: 1,
///     ),
///     WooTaxRate(
///       country: 'US',
///       state: 'NY',
///       rate: '8.00',
///       name: 'New York Sales Tax',
///       priority: 1,
///     ),
///   ],
///   update: [
///     WooTaxRate(
///       id: 123,
///       rate: '9.25', // Updated rate
///       name: 'Updated California Sales Tax',
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
/// final createOnly = WooTaxRateBatchRequest(
///   create: [taxRate1, taxRate2, taxRate3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooTaxRateBatchRequest(
///   update: [updatedTaxRate1, updatedTaxRate2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooTaxRateBatchRequest(
///   delete: [101, 102, 103],
/// );
/// ```
///
/// ### Geographical Targeting
///
/// ```dart
/// // Create tax rates with specific geographical targeting
/// final batchRequest = WooTaxRateBatchRequest(
///   create: [
///     WooTaxRate(
///       country: 'US',
///       state: 'CA',
///       cities: ['Los Angeles', 'San Francisco'],
///       postcodes: ['90001', '90002'],
///       rate: '9.50',
///       name: 'California City Tax',
///     ),
///   ],
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
/// final batchRequest = WooTaxRateBatchRequest.fromJson(jsonData);
/// ```
class WooTaxRateBatchRequest {
  /// List of tax rates to create
  ///
  /// Each tax rate in this list will be created as a new tax rate in the store.
  /// Tax rates in this list should not have an ID assigned.
  final List<WooTaxRate>? create;

  /// List of tax rates to update
  ///
  /// Each tax rate in this list must have a valid ID and will be updated
  /// with the provided values. Common use cases include:
  /// - Updating tax rates for rate changes
  /// - Modifying geographical targeting rules
  /// - Changing priority or compound settings
  final List<WooTaxRate>? update;

  /// List of tax rate IDs to delete
  ///
  /// Each ID in this list represents a tax rate that will be permanently deleted from the store.
  final List<int>? delete;

  /// Creates a new WooTaxRateBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooTaxRate` objects to create
  /// * [update] - List of `WooTaxRate` objects to update (must include `id`)
  /// * [delete] - List of tax rate IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooTaxRateBatchRequest(
  ///   create: [
  ///     WooTaxRate(
  ///       country: 'US',
  ///       state: 'CA',
  ///       rate: '8.25',
  ///       name: 'California Sales Tax',
  ///     ),
  ///   ],
  ///   update: [
  ///     WooTaxRate(
  ///       id: 123,
  ///       rate: '9.25',
  ///     ),
  ///   ],
  ///   delete: [456],
  /// );
  /// ```
  WooTaxRateBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooTaxRateBatchRequest instance from JSON data
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
  /// A `WooTaxRateBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooTaxRateBatchRequest.fromJson(jsonData);
  /// ```
  factory WooTaxRateBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooTaxRateBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooTaxRate.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooTaxRate.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );

  /// Converts the WooTaxRateBatchRequest instance to JSON format
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
          'create': create!.map((taxRate) => taxRate.toJson()).toList(),
        if (update != null)
          'update': update!.map((taxRate) => taxRate.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooTaxRateBatchRequest instance
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
  /// final batchRequest = WooTaxRateBatchRequest(
  ///   create: [taxRate1, taxRate2],
  ///   update: [taxRate3],
  ///   delete: [101, 102],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooTaxRateBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooTaxRateBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

