import 'variation.dart';

/// WooCommerce Product Variation Batch Response Model
///
/// This class represents the response from a batch product variation operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created variations with server-assigned IDs
/// - **Update Results**: List of successfully updated variations
/// - **Delete Results**: List of successfully deleted variations
/// - **Comprehensive Response**: All operations results in a single response object
/// - **Product Scoped**: All variations belong to the same parent product
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductVariations(
///   productId: 123,
///   batchRequest,
/// );
///
/// // Process created variations
/// for (final variation in response.create ?? []) {
///   print('Created variation: ${variation.sku} with ID: ${variation.id}');
/// }
///
/// // Process updated variations
/// for (final variation in response.update ?? []) {
///   print('Updated variation: ${variation.sku}');
/// }
///
/// // Process deleted variations
/// for (final variation in response.delete ?? []) {
///   print('Deleted variation: ${variation.sku}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductVariations(
///   productId: 123,
///   batchRequest,
/// );
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
/// final batchResponse = WooProductVariationBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooProductVariationBatchResponse {

  /// Creates a new WooProductVariationBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooProductVariation` objects
  /// * [update] - List of updated `WooProductVariation` objects
  /// * [delete] - List of deleted `WooProductVariation` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductVariationBatchResponse(
  ///   create: [createdVariation1, createdVariation2],
  ///   update: [updatedVariation1],
  ///   delete: [deletedVariation1],
  /// );
  /// ```
  WooProductVariationBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductVariationBatchResponse instance from JSON data
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
  /// A `WooProductVariationBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductVariationBatchResponse.fromJson(jsonData);
  /// ```
  factory WooProductVariationBatchResponse.fromJson(
          Map<String, dynamic> json) =>
      WooProductVariationBatchResponse(
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
            ? (json['delete'] as List)
                .map((item) =>
                    WooProductVariation.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created variations
  ///
  /// Contains the variations that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooProductVariation>? create;

  /// List of updated variations
  ///
  /// Contains the variations that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooProductVariation>? update;

  /// List of deleted variations
  ///
  /// Contains the variations that were successfully deleted. These variations
  /// may have limited information depending on the API response.
  final List<WooProductVariation>? delete;

  /// Converts the WooProductVariationBatchResponse instance to JSON format
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
          'create': create!.map((variation) => variation.toJson()).toList(),
        if (update != null)
          'update': update!.map((variation) => variation.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((variation) => variation.toJson()).toList(),
      };

  /// Returns a string representation of the WooProductVariationBatchResponse instance
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
  /// final batchResponse = WooProductVariationBatchResponse(
  ///   create: [variation1, variation2],
  ///   update: [variation3],
  ///   delete: [variation4, variation5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooProductVariationBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductVariationBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

