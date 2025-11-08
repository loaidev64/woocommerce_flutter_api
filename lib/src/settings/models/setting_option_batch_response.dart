import 'setting_option.dart';

/// WooCommerce Setting Option Batch Response Model
///
/// This class represents the response from a batch setting option operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created setting options with server-assigned IDs
/// - **Update Results**: List of successfully updated setting options
/// - **Delete Results**: List of successfully deleted setting options
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateSettingOptions(
///   'general',
///   batchRequest,
/// );
///
/// // Process created setting options
/// for (final option in response.create ?? []) {
///   print('Created setting: ${option.label} with ID: ${option.id}');
///   print('Value: ${option.value}');
///   print('Type: ${option.type}');
/// }
///
/// // Process updated setting options
/// for (final option in response.update ?? []) {
///   print('Updated setting: ${option.label}');
///   print('New value: ${option.value}');
/// }
///
/// // Process deleted setting options
/// for (final option in response.delete ?? []) {
///   print('Deleted setting: ${option.id}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateSettingOptions(
///   'general',
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
/// ### Analyzing Settings by Type
///
/// ```dart
/// final response = await wooCommerce.batchUpdateSettingOptions(
///   'general',
///   batchRequest,
/// );
///
/// // Group created settings by type
/// final byType = <String, List<WooSettingOption>>{};
/// for (final option in response.create ?? []) {
///   final type = option.type ?? 'Unknown';
///   byType.putIfAbsent(type, () => []).add(option);
/// }
///
/// print('Settings by type:');
/// byType.forEach((type, options) {
///   print('  $type: ${options.length} settings');
/// });
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Create from JSON response
/// final batchResponse = WooSettingOptionBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooSettingOptionBatchResponse {

  /// Creates a new WooSettingOptionBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooSettingOption` objects
  /// * [update] - List of updated `WooSettingOption` objects
  /// * [delete] - List of deleted `WooSettingOption` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooSettingOptionBatchResponse(
  ///   create: [createdOption1, createdOption2],
  ///   update: [updatedOption1],
  ///   delete: [deletedOption1],
  /// );
  /// ```
  WooSettingOptionBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooSettingOptionBatchResponse instance from JSON data
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
  /// A `WooSettingOptionBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooSettingOptionBatchResponse.fromJson(jsonData);
  /// ```
  factory WooSettingOptionBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooSettingOptionBatchResponse(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooSettingOption.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooSettingOption.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List)
                .map((item) =>
                    WooSettingOption.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created setting options
  ///
  /// Contains the setting options that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooSettingOption>? create;

  /// List of updated setting options
  ///
  /// Contains the setting options that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooSettingOption>? update;

  /// List of deleted setting options
  ///
  /// Contains the setting options that were successfully deleted. These options
  /// may have limited information depending on the API response.
  final List<WooSettingOption>? delete;

  /// Converts the WooSettingOptionBatchResponse instance to JSON format
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
          'create': create!.map((option) => option.toJson()).toList(),
        if (update != null)
          'update': update!.map((option) => option.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((option) => option.toJson()).toList(),
      };

  /// Returns a string representation of the WooSettingOptionBatchResponse instance
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
  /// final batchResponse = WooSettingOptionBatchResponse(
  ///   create: [option1, option2],
  ///   update: [option3],
  ///   delete: [option4, option5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooSettingOptionBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooSettingOptionBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

