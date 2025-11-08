import 'product.dart';

/// WooCommerce Product Batch Response Model
///
/// This class represents the response from a batch product operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created products with server-assigned IDs
/// - **Update Results**: List of successfully updated products
/// - **Delete Results**: List of successfully deleted products
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProducts(batchRequest);
///
/// // Process created products
/// for (final product in response.create ?? []) {
///   print('Created product: ${product.name} with ID: ${product.id}');
/// }
///
/// // Process updated products
/// for (final product in response.update ?? []) {
///   print('Updated product: ${product.name}');
/// }
///
/// // Process deleted products
/// for (final product in response.delete ?? []) {
///   print('Deleted product: ${product.name}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProducts(batchRequest);
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
/// final batchResponse = WooProductBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooProductBatchResponse {

  /// Creates a new WooProductBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooProduct` objects
  /// * [update] - List of updated `WooProduct` objects
  /// * [delete] - List of deleted `WooProduct` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductBatchResponse(
  ///   create: [createdProduct1, createdProduct2],
  ///   update: [updatedProduct1],
  ///   delete: [deletedProduct1],
  /// );
  /// ```
  WooProductBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductBatchResponse instance from JSON data
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
  /// A `WooProductBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductBatchResponse.fromJson(jsonData);
  /// ```
  factory WooProductBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductBatchResponse(
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
            ? (json['delete'] as List)
                .map((item) =>
                    WooProduct.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created products
  ///
  /// Contains the products that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooProduct>? create;

  /// List of updated products
  ///
  /// Contains the products that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooProduct>? update;

  /// List of deleted products
  ///
  /// Contains the products that were successfully deleted. These products
  /// may have limited information depending on the API response.
  final List<WooProduct>? delete;

  /// Converts the WooProductBatchResponse instance to JSON format
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
          'create': create!.map((product) => product.toJson()).toList(),
        if (update != null)
          'update': update!.map((product) => product.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((product) => product.toJson()).toList(),
      };

  /// Returns a string representation of the WooProductBatchResponse instance
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
  /// final batchResponse = WooProductBatchResponse(
  ///   create: [product1, product2],
  ///   update: [product3],
  ///   delete: [product4, product5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooProductBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

