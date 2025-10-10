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
}
