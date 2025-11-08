import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Settings API Extension
///
/// This extension provides comprehensive settings management capabilities for WooCommerce stores.
/// Settings allow you to configure various aspects of your store, including general settings,
/// payment methods, shipping options, and other store configurations.
///
/// ## Settings Overview
///
/// WooCommerce settings are organized into groups, with each group containing multiple
/// setting options. Settings control store behavior, appearance, and functionality.
/// They provide a way to customize your store without modifying code.
///
/// ## Key Features
///
/// - **Grouped organization**: Settings are organized into logical groups
/// - **Flexible configuration**: Support for various setting types (text, select, checkbox, etc.)
/// - **Real-time updates**: Changes take effect immediately
/// - **Validation**: Built-in validation for setting values
/// - **Default values**: Fallback values for all settings
///
/// ## Settings Structure
///
/// 1. **Settings Groups**: Top-level categories (e.g., 'general', 'products', 'shipping')
/// 2. **Setting Options**: Individual configuration items within each group
/// 3. **Setting Values**: Current values for each option
/// 4. **Default Values**: Fallback values when no custom value is set
///
/// ## Common Setting Groups
///
/// - **General**: Store name, currency, location settings
/// - **Products**: Product catalog settings, inventory management
/// - **Shipping**: Shipping zones, methods, and rates
/// - **Payments**: Payment gateway configurations
/// - **Tax**: Tax calculation and display settings
///
/// ## Example Usage
///
/// ```dart
/// // Get all settings groups
/// final groups = await wooCommerce.getSettingsGroups();
///
/// // Get options for a specific group
/// final options = await wooCommerce.getSettingOptions(groupId: 'general');
///
/// // Update a specific setting
/// option.value = 'new-value';
/// await wooCommerce.updateSettingOption(option);
/// ```
extension WooSettingsApi on WooCommerce {
  /// Retrieves all settings groups from the WooCommerce store.
  ///
  /// This method fetches all available settings groups, which are top-level
  /// categories that organize related settings together. Each group contains
  /// multiple setting options that can be configured independently.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-settings-groups
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooSettings>>` containing all available settings groups.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all settings groups
  /// final groups = await wooCommerce.getSettingsGroups();
  ///
  /// // Print group information
  /// for (final group in groups) {
  ///   print('Group: ${group.label} (${group.id})');
  ///   print('Description: ${group.description}');
  /// }
  /// ```
  Future<List<WooSettings>> getSettingsGroups({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooSettings.fake);
    }

    final response = await dio.get(
      _SettingsEndpoints.settings,
    );

    return (response.data as List).map((e) => WooSettings.fromJson(e)).toList();
  }

  /// Retrieves all setting options for a specific settings group.
  ///
  /// This method fetches all individual setting options within a specified
  /// settings group. Each option represents a configurable aspect of your
  /// store, such as store name, currency, or shipping settings.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-setting-options
  ///
  /// ## Parameters
  ///
  /// * [groupId] - The unique identifier of the settings group
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooSettingOption>>` containing all setting options for the group.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the group is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all options for the general settings group
  /// final options = await wooCommerce.getSettingOptions(groupId: 'general');
  ///
  /// // Find a specific setting
  /// final storeNameOption = options.firstWhere(
  ///   (option) => option.id == 'woocommerce_store_address',
  /// );
  /// print('Store name: ${storeNameOption.value}');
  /// ```
  Future<List<WooSettingOption>> getSettingOptions({
    required String groupId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooSettingOption.fake);
    }

    final response = await dio.get(
      _SettingsEndpoints.settingOptions(groupId),
    );

    return (response.data as List)
        .map((e) => WooSettingOption.fromJson(e))
        .toList();
  }

  /// Retrieves a specific setting option by its ID.
  ///
  /// This method fetches detailed information about a single setting option,
  /// including its current value, default value, type, and configuration options.
  /// Useful when you need to work with a specific setting without loading all options.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-setting-option
  ///
  /// ## Parameters
  ///
  /// * [groupId] - The unique identifier of the settings group
  /// * [optionId] - The unique identifier of the setting option
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooSettingOption>` containing the setting option details.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the option is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific setting option
  /// final option = await wooCommerce.getSettingOption(
  ///   groupId: 'general',
  ///   optionId: 'woocommerce_store_address',
  /// );
  ///
  /// print('Setting: ${option.label}');
  /// print('Current value: ${option.value}');
  /// print('Default value: ${option.defaultValue}');
  /// ```
  Future<WooSettingOption> getSettingOption({
    required String groupId,
    required String optionId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooSettingOption.fake();
    }

    final response = await dio.get(
      _SettingsEndpoints.singleSettingOption(groupId, optionId),
    );

    return WooSettingOption.fromJson(response.data);
  }

  /// Updates a specific setting option in the WooCommerce store.
  ///
  /// This method allows you to modify the value of a setting option. Changes
  /// take effect immediately and can affect store behavior, appearance, or functionality.
  /// The option must have valid groupId and id properties.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-setting-option
  ///
  /// ## Parameters
  ///
  /// * [option] - The setting option object with updated values
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooSettingOption>` containing the updated setting option.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the update fails or option is not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get the current setting
  /// final option = await wooCommerce.getSettingOption(
  ///   groupId: 'general',
  ///   optionId: 'woocommerce_store_address',
  /// );
  ///
  /// // Update the value
  /// option.value = 'New Store Address';
  /// final updatedOption = await wooCommerce.updateSettingOption(option);
  ///
  /// print('Updated setting: ${updatedOption.value}');
  /// ```
  Future<WooSettingOption> updateSettingOption(
    WooSettingOption option, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return option;
    }

    final response = await dio.put(
      _SettingsEndpoints.singleSettingOption(option.groupId!, option.id!),
      data: option.toJson(),
    );

    return WooSettingOption.fromJson(response.data);
  }

  /// Performs batch operations on setting options.
  ///
  /// This method allows you to create, update, and delete multiple setting options
  /// in a single API request, making bulk operations more efficient. This is particularly
  /// useful for configuring multiple settings at once or managing settings across
  /// different groups.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-setting-options
  ///
  /// ## Parameters
  ///
  /// * [groupId] - The unique identifier of the settings group (e.g., 'general', 'products', 'shipping')
  /// * [request] - The `WooSettingOptionBatchRequest` object containing
  ///   the create, update, and delete operations to perform
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooSettingOptionBatchResponse>` containing the results of
  /// all batch operations, including created, updated, and deleted setting options.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Important Notes
  ///
  /// - **Setting Option IDs**: Unlike other resources, setting option IDs are strings, not integers
  /// - **Settings Groups**: Settings are organized by groups (e.g., 'general', 'products', 'shipping')
  /// - **Group Scoping**: All operations in a batch request must belong to the same settings group
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a batch request with multiple operations
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
  ///       id: 'woocommerce_store_address',
  ///       value: '123 Main St',
  ///       groupId: 'general',
  ///     ),
  ///   ],
  ///   delete: ['old_setting_1', 'old_setting_2'],
  /// );
  ///
  /// // Execute the batch operation
  /// final response = await wooCommerce.batchUpdateSettingOptions(
  ///   'general',
  ///   batchRequest,
  /// );
  ///
  /// // Process results
  /// print('Created ${response.create?.length ?? 0} settings');
  /// print('Updated ${response.update?.length ?? 0} settings');
  /// print('Deleted ${response.delete?.length ?? 0} settings');
  ///
  /// // Access individual results
  /// for (final option in response.create ?? []) {
  ///   print('Created setting: ${option.label} with ID: ${option.id}');
  ///   print('Value: ${option.value}');
  /// }
  /// ```
  ///
  /// ## Settings Groups Example
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
  ///     WooSettingOption(
  ///       id: 'woocommerce_store_postcode',
  ///       value: '10001',
  ///       groupId: 'general',
  ///     ),
  ///   ],
  /// );
  ///
  /// final response = await wooCommerce.batchUpdateSettingOptions(
  ///   'general',
  ///   batchRequest,
  /// );
  /// print('Updated ${response.update?.length ?? 0} general settings');
  /// ```
  ///
  /// ## Batch Operations Best Practices
  ///
  /// - **Create operations**: Setting options should have unique string IDs
  /// - **Update operations**: Setting options must have valid string IDs and will be updated with provided values
  /// - **Delete operations**: Provide only the string IDs of setting options to delete
  /// - **Mixed operations**: You can combine create, update, and delete in a single request
  /// - **Settings groups**: All operations must belong to the same settings group specified in the endpoint
  /// - **Setting types**: Support various types (text, select, checkbox, number, email, url)
  /// - **Error handling**: If any operation fails, the entire batch may fail depending on API behavior
  ///
  /// ## Settings Groups
  ///
  /// Settings are organized into groups for better organization:
  ///
  /// - **general**: Store name, currency, location, and basic settings
  /// - **products**: Product catalog, inventory, and display settings
  /// - **shipping**: Shipping zones, methods, and rate calculations
  /// - **payments**: Payment gateway configurations and options
  /// - **tax**: Tax calculation and display settings
  ///
  /// ## Setting Option IDs
  ///
  /// Unlike other WooCommerce resources, setting option IDs are strings, not integers.
  /// This allows for more descriptive and meaningful identifiers like:
  ///
  /// - `woocommerce_store_address`
  /// - `woocommerce_currency`
  /// - `woocommerce_weight_unit`
  ///
  /// When creating or updating settings, always use string IDs.
  Future<WooSettingOptionBatchResponse> batchUpdateSettingOptions(
    String groupId,
    WooSettingOptionBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooSettingOptionBatchResponse(
        create: request.create?.map((option) => WooSettingOption.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) {
          final fakeOption = WooSettingOption.fake();
          return WooSettingOption(
            id: id,
            label: fakeOption.label,
            description: fakeOption.description,
            value: fakeOption.value,
            defaultValue: fakeOption.defaultValue,
            tip: fakeOption.tip,
            placeholder: fakeOption.placeholder,
            type: fakeOption.type,
            options: fakeOption.options,
            groupId: groupId,
          );
        }).toList(),
      );
    }

    final response = await dio.post(
      _SettingsEndpoints.batchSettingOptions(groupId),
      data: request.toJson(),
    );

    return WooSettingOptionBatchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
