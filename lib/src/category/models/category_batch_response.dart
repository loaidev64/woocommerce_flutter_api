import 'category.dart';

/// WooCommerce Product Category Batch Response Model
///
/// This class represents the response from a batch product category operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created categories with server-assigned IDs
/// - **Update Results**: List of successfully updated categories
/// - **Delete Results**: List of successfully deleted categories
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateCategories(batchRequest);
///
/// // Process created categories
/// for (final category in response.create ?? []) {
///   print('Created category: ${category.name} with ID: ${category.id}');
/// }
///
/// // Process updated categories
/// for (final category in response.update ?? []) {
///   print('Updated category: ${category.name}');
/// }
///
/// // Process deleted categories
/// for (final category in response.delete ?? []) {
///   print('Deleted category: ${category.name}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateCategories(batchRequest);
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
/// final batchResponse = WooProductCategoryBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooProductCategoryBatchResponse {
  /// List of created categories
  ///
  /// Contains the categories that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooProductCategory>? create;

  /// List of updated categories
  ///
  /// Contains the categories that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooProductCategory>? update;

  /// List of deleted categories
  ///
  /// Contains the categories that were successfully deleted. These categories
  /// may have limited information depending on the API response.
  final List<WooProductCategory>? delete;

  /// Creates a new WooProductCategoryBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooProductCategory` objects
  /// * [update] - List of updated `WooProductCategory` objects
  /// * [delete] - List of deleted `WooProductCategory` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductCategoryBatchResponse(
  ///   create: [createdCategory1, createdCategory2],
  ///   update: [updatedCategory1],
  ///   delete: [deletedCategory1],
  /// );
  /// ```
  WooProductCategoryBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductCategoryBatchResponse instance from JSON data
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
  /// A `WooProductCategoryBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductCategoryBatchResponse.fromJson(jsonData);
  /// ```
  factory WooProductCategoryBatchResponse.fromJson(
          Map<String, dynamic> json) =>
      WooProductCategoryBatchResponse(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) => WooProductCategory.fromJson(
                    item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) => WooProductCategory.fromJson(
                    item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List)
                .map((item) => WooProductCategory.fromJson(
                    item as Map<String, dynamic>))
                .toList()
            : null,
      );

  /// Converts the WooProductCategoryBatchResponse instance to JSON format
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
          'create': create!.map((category) => category.toJson()).toList(),
        if (update != null)
          'update': update!.map((category) => category.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((category) => category.toJson()).toList(),
      };

  /// Returns a string representation of the WooProductCategoryBatchResponse instance
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
  /// final batchResponse = WooProductCategoryBatchResponse(
  ///   create: [category1, category2],
  ///   update: [category3],
  ///   delete: [category4, category5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooProductCategoryBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductCategoryBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

