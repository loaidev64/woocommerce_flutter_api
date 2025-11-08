import 'setting_option.dart';

/// WooCommerce Setting Option Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple setting options in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple setting options in a single request
/// - **Bulk Updates**: Update multiple existing setting options simultaneously
/// - **Bulk Deletion**: Delete multiple setting options at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
/// - **Settings Groups**: All operations are scoped to a specific settings group
///
/// ## Important Notes
///
/// - **Setting Option IDs**: Unlike other resources, setting option IDs are strings, not integers
/// - **Settings Groups**: Settings are organized by groups (e.g., 'general', 'products', 'shipping')
/// - **Group Scoping**: All operations in a batch request must belong to the same settings group
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooSettingOptionBatchRequest(
///   create: [
///     WooSettingOption(
///       id: 'custom_setting_1',
///       label: 'Custom Setting 1',
///       description: 'First custom setting',
///       value: 'value1',
///       type: 'text',
///       groupId: 'general',
///     ),
///     WooSettingOption(
///       id: 'custom_setting_2',
///       label: 'Custom Setting 2',
///       description: 'Second custom setting',
///       value: 'value2',
///       type: 'text',
///       groupId: 'general',
///     ),
///   ],
///   update: [
///     WooSettingOption(
///       id: 'store_name',
///       value: 'Updated Store Name',
///       groupId: 'general',
///     ),
///   ],
///   delete: ['old_setting_1', 'old_setting_2'],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooSettingOptionBatchRequest(
///   create: [option1, option2, option3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooSettingOptionBatchRequest(
///   update: [updatedOption1, updatedOption2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooSettingOptionBatchRequest(
///   delete: ['setting_id_1', 'setting_id_2', 'setting_id_3'],
/// );
/// ```
///
/// ### Managing Settings by Group
///
/// ```dart
/// // Update multiple settings in the general group
/// final batchRequest = WooSettingOptionBatchRequest(
///   update: [
///     WooSettingOption(
///       id: 'woocommerce_store_address',
///       value: '123 Main St',
///       groupId: 'general',
///     ),
///     WooSettingOption(
///       id: 'woocommerce_store_city',
///       value: 'New York',
///       groupId: 'general',
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
/// final batchRequest = WooSettingOptionBatchRequest.fromJson(jsonData);
/// ```
class WooSettingOptionBatchRequest {
  /// List of setting options to create
  ///
  /// Each setting option in this list will be created as a new option in the store.
  /// Setting options in this list should not have an ID assigned, or should have
  /// a unique string ID that doesn't conflict with existing options.
  final List<WooSettingOption>? create;

  /// List of setting options to update
  ///
  /// Each setting option in this list must have a valid string ID and will be updated
  /// with the provided values. Common use cases include:
  /// - Updating setting values
  /// - Modifying setting labels or descriptions
  /// - Changing setting types or options
  final List<WooSettingOption>? update;

  /// List of setting option IDs to delete
  ///
  /// Each ID in this list is a string representing a setting option that will be
  /// permanently deleted from the store. Note: Setting option IDs are strings, not integers.
  final List<String>? delete;

  /// Creates a new WooSettingOptionBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooSettingOption` objects to create
  /// * [update] - List of `WooSettingOption` objects to update (must include `id` as string)
  /// * [delete] - List of setting option IDs (strings) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooSettingOptionBatchRequest(
  ///   create: [
  ///     WooSettingOption(
  ///       id: 'custom_setting',
  ///       label: 'Custom Setting',
  ///       value: 'value',
  ///       type: 'text',
  ///       groupId: 'general',
  ///     ),
  ///   ],
  ///   update: [
  ///     WooSettingOption(
  ///       id: 'store_name',
  ///       value: 'New Store Name',
  ///       groupId: 'general',
  ///     ),
  ///   ],
  ///   delete: ['old_setting'],
  /// );
  /// ```
  WooSettingOptionBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooSettingOptionBatchRequest instance from JSON data
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
  /// A `WooSettingOptionBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooSettingOptionBatchRequest.fromJson(jsonData);
  /// ```
  factory WooSettingOptionBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooSettingOptionBatchRequest(
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
            ? (json['delete'] as List).cast<String>()
            : null,
      );

  /// Converts the WooSettingOptionBatchRequest instance to JSON format
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
          'create': create!.map((option) => option.toJson()).toList(),
        if (update != null)
          'update': update!.map((option) => option.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooSettingOptionBatchRequest instance
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
  /// final batchRequest = WooSettingOptionBatchRequest(
  ///   create: [option1, option2],
  ///   update: [option3],
  ///   delete: ['id1', 'id2'],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooSettingOptionBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooSettingOptionBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

