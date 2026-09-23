# settings

## settings_api

### extension WooSettingsApi on WooCommerce

WooCommerce Settings API Extension

This extension provides comprehensive settings management capabilities for WooCommerce stores.
Settings allow you to configure various aspects of your store, including general settings,
payment methods, shipping options, and other store configurations.

## Settings Overview

WooCommerce settings are organized into groups, with each group containing multiple
setting options. Settings control store behavior, appearance, and functionality.
They provide a way to customize your store without modifying code.

## Key Features

- **Grouped organization**: Settings are organized into logical groups
- **Flexible configuration**: Support for various setting types (text, select, checkbox, etc.)
- **Real-time updates**: Changes take effect immediately
- **Validation**: Built-in validation for setting values
- **Default values**: Fallback values for all settings

## Settings Structure

1. **Settings Groups**: Top-level categories (e.g., 'general', 'products', 'shipping')
2. **Setting Options**: Individual configuration items within each group
3. **Setting Values**: Current values for each option
4. **Default Values**: Fallback values when no custom value is set

## Common Setting Groups

- **General**: Store name, currency, location settings
- **Products**: Product catalog settings, inventory management
- **Shipping**: Shipping zones, methods, and rates
- **Payments**: Payment gateway configurations
- **Tax**: Tax calculation and display settings

## Example Usage

```dart
// Get all settings groups
final groups = await wooCommerce.getSettingsGroups();

// Get options for a specific group
final options = await wooCommerce.getSettingOptions(groupId: 'general');

// Update a specific setting
option.value = 'new-value';
await wooCommerce.updateSettingOption(option);
```

### Future<List<WooSettings>> getSettingsGroups({bool? useFaker}) async

Retrieves all settings groups from the WooCommerce store.

This method fetches all available settings groups, which are top-level
categories that organize related settings together. Each group contains
multiple setting options that can be configured independently.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-settings-groups

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooSettings>>` containing all available settings groups.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all settings groups
final groups = await wooCommerce.getSettingsGroups();

// Print group information
for (final group in groups) {
  print('Group: ${group.label} (${group.id})');
  print('Description: ${group.description}');
}
```

### Future<List<WooSettingOption>> getSettingOptions({ required String groupId, bool? useFaker, }) async

Retrieves all setting options for a specific settings group.

This method fetches all individual setting options within a specified
settings group. Each option represents a configurable aspect of your
store, such as store name, currency, or shipping settings.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-setting-options

## Parameters

* [groupId] - The unique identifier of the settings group
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooSettingOption>>` containing all setting options for the group.

## Throws

* `WooCommerceException` if the group is not found or access is denied

## Example Usage

```dart
// Get all options for the general settings group
final options = await wooCommerce.getSettingOptions(groupId: 'general');

// Find a specific setting
final storeNameOption = options.firstWhere(
  (option) => option.id == 'woocommerce_store_address',
);
print('Store name: ${storeNameOption.value}');
```

### Future<WooSettingOption> getSettingOption({ required String groupId, required String optionId, bool? useFaker, }) async

Retrieves a specific setting option by its ID.

This method fetches detailed information about a single setting option,
including its current value, default value, type, and configuration options.
Useful when you need to work with a specific setting without loading all options.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-setting-option

## Parameters

* [groupId] - The unique identifier of the settings group
* [optionId] - The unique identifier of the setting option
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooSettingOption>` containing the setting option details.

## Throws

* `WooCommerceException` if the option is not found or access is denied

## Example Usage

```dart
// Get a specific setting option
final option = await wooCommerce.getSettingOption(
  groupId: 'general',
  optionId: 'woocommerce_store_address',
);

print('Setting: ${option.label}');
print('Current value: ${option.value}');
print('Default value: ${option.defaultValue}');
```

### Future<WooSettingOption> updateSettingOption

Updates a specific setting option in the WooCommerce store.

This method allows you to modify the value of a setting option. Changes
take effect immediately and can affect store behavior, appearance, or functionality.
The option must have valid groupId and id properties.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-setting-option

## Parameters

* [option] - The setting option object with updated values
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooSettingOption>` containing the updated setting option.

## Throws

* `WooCommerceException` if the update fails or option is not found

## Example Usage

```dart
// Get the current setting
final option = await wooCommerce.getSettingOption(
  groupId: 'general',
  optionId: 'woocommerce_store_address',
);

// Update the value
option.value = 'New Store Address';
final updatedOption = await wooCommerce.updateSettingOption(option);

print('Updated setting: ${updatedOption.value}');
```

### Future<WooSettingOptionBatchResponse> batchUpdateSettingOptions

Performs batch operations on setting options.

This method allows you to create, update, and delete multiple setting options
in a single API request, making bulk operations more efficient. This is particularly
useful for configuring multiple settings at once or managing settings across
different groups.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-setting-options

## Parameters

* [groupId] - The unique identifier of the settings group (e.g., 'general', 'products', 'shipping')
* [request] - The `WooSettingOptionBatchRequest` object containing
  the create, update, and delete operations to perform
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooSettingOptionBatchResponse>` containing the results of
all batch operations, including created, updated, and deleted setting options.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Important Notes

- **Setting Option IDs**: Unlike other resources, setting option IDs are strings, not integers
- **Settings Groups**: Settings are organized by groups (e.g., 'general', 'products', 'shipping')
- **Group Scoping**: All operations in a batch request must belong to the same settings group

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooSettingOptionBatchRequest(
  create: [
    WooSettingOption(
      id: 'custom_setting_1',
      label: 'Custom Setting 1',
      description: 'First custom setting',
      value: 'value1',
      type: 'text',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'custom_setting_2',
      label: 'Custom Setting 2',
      description: 'Second custom setting',
      value: 'value2',
      type: 'text',
      groupId: 'general',
    ),
  ],
  update: [
    WooSettingOption(
      id: 'woocommerce_store_address',
      value: '123 Main St',
      groupId: 'general',
    ),
  ],
  delete: ['old_setting_1', 'old_setting_2'],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

// Process results
print('Created ${response.create?.length ?? 0} settings');
print('Updated ${response.update?.length ?? 0} settings');
print('Deleted ${response.delete?.length ?? 0} settings');

// Access individual results
for (final option in response.create ?? []) {
  print('Created setting: ${option.label} with ID: ${option.id}');
  print('Value: ${option.value}');
}
```

## Settings Groups Example

```dart
// Update multiple settings in the general group
final batchRequest = WooSettingOptionBatchRequest(
  update: [
    WooSettingOption(
      id: 'woocommerce_store_address',
      value: '123 Main St',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'woocommerce_store_city',
      value: 'New York',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'woocommerce_store_postcode',
      value: '10001',
      groupId: 'general',
    ),
  ],
);

final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);
print('Updated ${response.update?.length ?? 0} general settings');
```

## Batch Operations Best Practices

- **Create operations**: Setting options should have unique string IDs
- **Update operations**: Setting options must have valid string IDs and will be updated with provided values
- **Delete operations**: Provide only the string IDs of setting options to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Settings groups**: All operations must belong to the same settings group specified in the endpoint
- **Setting types**: Support various types (text, select, checkbox, number, email, url)
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## Settings Groups

Settings are organized into groups for better organization:

- **general**: Store name, currency, location, and basic settings
- **products**: Product catalog, inventory, and display settings
- **shipping**: Shipping zones, methods, and rate calculations
- **payments**: Payment gateway configurations and options
- **tax**: Tax calculation and display settings

## Setting Option IDs

Unlike other WooCommerce resources, setting option IDs are strings, not integers.
This allows for more descriptive and meaningful identifiers like:

- `woocommerce_store_address`
- `woocommerce_currency`
- `woocommerce_weight_unit`

When creating or updating settings, always use string IDs.

## setting_option

### class WooSettingOption

WooCommerce Setting Option Model

Represents an individual setting option within a WooCommerce settings group.
Each option represents a configurable aspect of your store, such as store name,
currency, shipping methods, or payment gateway settings.

## Key Features

- **Flexible value types**: Support for text, numbers, booleans, and complex objects
- **Default values**: Fallback values when no custom value is set
- **Input validation**: Built-in validation based on setting type
- **User guidance**: Help text, placeholders, and descriptions
- **Option constraints**: Limited choices for select-type settings

## Setting Types

- **text**: Single-line text input
- **textarea**: Multi-line text input
- **select**: Dropdown with predefined options
- **checkbox**: Boolean true/false values
- **number**: Numeric input with validation
- **email**: Email address input with validation
- **url**: URL input with validation

## Usage Examples

```dart
// Create a setting option
final option = WooSettingOption(
  id: 'store_name',
  label: 'Store Name',
  description: 'The name of your store',
  value: 'My WooCommerce Store',
  type: 'text',
);

// Access option properties
print('Setting: ${option.label}');
print('Current value: ${option.value}');
print('Default value: ${option.defaultValue}');
print('Type: ${option.type}');
```

### WooSettingOption({ this.id, this.label, this.description, this.value, this.defaultValue, this.tip, this.placeholder, this.type, this.options, this.groupId, })

WooCommerce Setting Option Model

Represents an individual setting option within a WooCommerce settings group.
Each option represents a configurable aspect of your store, such as store name,
currency, shipping methods, or payment gateway settings.

## Key Features

- **Flexible value types**: Support for text, numbers, booleans, and complex objects
- **Default values**: Fallback values when no custom value is set
- **Input validation**: Built-in validation based on setting type
- **User guidance**: Help text, placeholders, and descriptions
- **Option constraints**: Limited choices for select-type settings

## Setting Types

- **text**: Single-line text input
- **textarea**: Multi-line text input
- **select**: Dropdown with predefined options
- **checkbox**: Boolean true/false values
- **number**: Numeric input with validation
- **email**: Email address input with validation
- **url**: URL input with validation

## Usage Examples

```dart
// Create a setting option
final option = WooSettingOption(
  id: 'store_name',
  label: 'Store Name',
  description: 'The name of your store',
  value: 'My WooCommerce Store',
  type: 'text',
);

// Access option properties
print('Setting: ${option.label}');
print('Current value: ${option.value}');
print('Default value: ${option.defaultValue}');
print('Type: ${option.type}');
```

### factory WooSettingOption.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSettingOption.fake()

Creates a fake WooSettingOption instance for testing purposes

This factory constructor generates a setting option with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated setting option will have valid data for all fields.

## Generated Data

The fake setting option includes:
- Random ID from word generator
- Random label from sentence generator
- Random description from sentence generator
- Random value from word generator
- Random default value from word generator
- Random tip from sentence generator
- Random placeholder from word generator
- Random type from available setting types
- Random options map with multiple choices
- Random group ID from word generator

## Returns

A `WooSettingOption` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake setting option for testing
final fakeOption = WooSettingOption.fake();
print('Fake option: ${fakeOption.label}');
print('Type: ${fakeOption.type}');
print('Value: ${fakeOption.value}');

// Use in tests
test('setting option creation', () {
  final option = WooSettingOption.fake();
  expect(option.id, isNotNull);
  expect(option.label, isNotNull);
  expect(option.type, isNotNull);
  expect(option.value, isNotNull);
});
```

### final String? id

A unique identifier for the setting.

This identifier is used to reference the setting in API calls and
to distinguish it from other settings within the same group.

### final String? label

A human readable label for the setting used in interfaces.

This is the display name shown to users in the WooCommerce admin
interface. It should be descriptive and user-friendly.

### final String? description

A human readable description for the setting used in interfaces.

Provides additional context about what the setting controls
and how it affects store functionality.

### final dynamic value

Setting value.

The current value of the setting. The type depends on the setting type:
- String for text, textarea, email, url types
- bool for checkbox type
- int/double for number type
- String for select type (selected option value)

### final dynamic defaultValue

Default value for the setting.

The fallback value used when no custom value is set.
This is typically the value that comes with WooCommerce by default.

### final String? tip

Additional help text shown to the user about the setting.

Provides additional guidance or tips for users configuring
the setting in the admin interface.

### final String? placeholder

Placeholder text to be displayed in text inputs.

Shown as placeholder text in input fields to guide users
on what kind of input is expected.

### final String? type

Type of setting.

Determines the input method and validation rules:
- 'text': Single-line text input
- 'textarea': Multi-line text input
- 'select': Dropdown with predefined options
- 'checkbox': Boolean true/false values
- 'number': Numeric input with validation
- 'email': Email address input with validation
- 'url': URL input with validation

### final String? groupId

An identifier for the group this setting belongs to.

References the settings group that contains this option.
Used to organize settings and determine API endpoints.

### Map<String, dynamic> toJson()

Converts the WooSettingOption instance to JSON format

This method serializes the setting option data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the setting option data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "id": "store_name",
  "label": "Store Name",
  "description": "The name of your store",
  "value": "My WooCommerce Store",
  "default": "WooCommerce Store",
  "tip": "Enter your store name",
  "placeholder": "Store Name",
  "type": "text",
  "options": {},
  "group_id": "general"
}
```

## Example Usage

```dart
// Convert setting option to JSON for API calls
final option = WooSettingOption(
  id: 'store_name',
  label: 'Store Name',
  value: 'My Store',
  type: 'text',
);

final jsonData = option.toJson();
print('JSON: $jsonData');

// Send to API
await dio.put('/settings/general/store_name', data: option.toJson());
```

### WooSettingOption copyWith({ String? id, String? label, String? description, dynamic value, dynamic defaultValue, String? tip, String? placeholder, String? type, Map<String, dynamic>? options, String? groupId, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## setting_option_batch_request

### class WooSettingOptionBatchRequest

WooCommerce Setting Option Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple setting options in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple setting options in a single request
- **Bulk Updates**: Update multiple existing setting options simultaneously
- **Bulk Deletion**: Delete multiple setting options at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Settings Groups**: All operations are scoped to a specific settings group

## Important Notes

- **Setting Option IDs**: Unlike other resources, setting option IDs are strings, not integers
- **Settings Groups**: Settings are organized by groups (e.g., 'general', 'products', 'shipping')
- **Group Scoping**: All operations in a batch request must belong to the same settings group

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooSettingOptionBatchRequest(
  create: [
    WooSettingOption(
      id: 'custom_setting_1',
      label: 'Custom Setting 1',
      description: 'First custom setting',
      value: 'value1',
      type: 'text',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'custom_setting_2',
      label: 'Custom Setting 2',
      description: 'Second custom setting',
      value: 'value2',
      type: 'text',
      groupId: 'general',
    ),
  ],
  update: [
    WooSettingOption(
      id: 'store_name',
      value: 'Updated Store Name',
      groupId: 'general',
    ),
  ],
  delete: ['old_setting_1', 'old_setting_2'],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooSettingOptionBatchRequest(
  create: [option1, option2, option3],
);

// Create a batch request with only updates
final updateOnly = WooSettingOptionBatchRequest(
  update: [updatedOption1, updatedOption2],
);

// Create a batch request with only deletes
final deleteOnly = WooSettingOptionBatchRequest(
  delete: ['setting_id_1', 'setting_id_2', 'setting_id_3'],
);
```

### Managing Settings by Group

```dart
// Update multiple settings in the general group
final batchRequest = WooSettingOptionBatchRequest(
  update: [
    WooSettingOption(
      id: 'woocommerce_store_address',
      value: '123 Main St',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'woocommerce_store_city',
      value: 'New York',
      groupId: 'general',
    ),
  ],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooSettingOptionBatchRequest.fromJson(jsonData);
```

### WooSettingOptionBatchRequest({this.create, this.update, this.delete})

WooCommerce Setting Option Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple setting options in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple setting options in a single request
- **Bulk Updates**: Update multiple existing setting options simultaneously
- **Bulk Deletion**: Delete multiple setting options at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Settings Groups**: All operations are scoped to a specific settings group

## Important Notes

- **Setting Option IDs**: Unlike other resources, setting option IDs are strings, not integers
- **Settings Groups**: Settings are organized by groups (e.g., 'general', 'products', 'shipping')
- **Group Scoping**: All operations in a batch request must belong to the same settings group

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooSettingOptionBatchRequest(
  create: [
    WooSettingOption(
      id: 'custom_setting_1',
      label: 'Custom Setting 1',
      description: 'First custom setting',
      value: 'value1',
      type: 'text',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'custom_setting_2',
      label: 'Custom Setting 2',
      description: 'Second custom setting',
      value: 'value2',
      type: 'text',
      groupId: 'general',
    ),
  ],
  update: [
    WooSettingOption(
      id: 'store_name',
      value: 'Updated Store Name',
      groupId: 'general',
    ),
  ],
  delete: ['old_setting_1', 'old_setting_2'],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooSettingOptionBatchRequest(
  create: [option1, option2, option3],
);

// Create a batch request with only updates
final updateOnly = WooSettingOptionBatchRequest(
  update: [updatedOption1, updatedOption2],
);

// Create a batch request with only deletes
final deleteOnly = WooSettingOptionBatchRequest(
  delete: ['setting_id_1', 'setting_id_2', 'setting_id_3'],
);
```

### Managing Settings by Group

```dart
// Update multiple settings in the general group
final batchRequest = WooSettingOptionBatchRequest(
  update: [
    WooSettingOption(
      id: 'woocommerce_store_address',
      value: '123 Main St',
      groupId: 'general',
    ),
    WooSettingOption(
      id: 'woocommerce_store_city',
      value: 'New York',
      groupId: 'general',
    ),
  ],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooSettingOptionBatchRequest.fromJson(jsonData);
```

### factory WooSettingOptionBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooSettingOptionBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooSettingOptionBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooSettingOptionBatchRequest.fromJson(jsonData);
```

### factory WooSettingOptionBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooSettingOption>? create

List of setting options to create

Each setting option in this list will be created as a new option in the store.
Setting options in this list should not have an ID assigned, or should have
a unique string ID that doesn't conflict with existing options.

### final List<WooSettingOption>? update

List of setting options to update

Each setting option in this list must have a valid string ID and will be updated
with the provided values. Common use cases include:
- Updating setting values
- Modifying setting labels or descriptions
- Changing setting types or options

### final List<String>? delete

List of setting option IDs to delete

Each ID in this list is a string representing a setting option that will be
permanently deleted from the store. Note: Setting option IDs are strings, not integers.

### Map<String, dynamic> toJson()

Converts the WooSettingOptionBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooSettingOptionBatchRequest copyWith({ List<WooSettingOption>? create, List<WooSettingOption>? update, List<String>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooSettingOptionBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooSettingOptionBatchRequest(
  create: [option1, option2],
  update: [option3],
  delete: ['id1', 'id2'],
);
print(batchRequest.toString());
// Output: WooSettingOptionBatchRequest(create: 2, update: 1, delete: 2)
```

## setting_option_batch_response

### class WooSettingOptionBatchResponse

WooCommerce Setting Option Batch Response Model

This class represents the response from a batch setting option operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created setting options with server-assigned IDs
- **Update Results**: List of successfully updated setting options
- **Delete Results**: List of successfully deleted setting options
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

// Process created setting options
for (final option in response.create ?? []) {
  print('Created setting: ${option.label} with ID: ${option.id}');
  print('Value: ${option.value}');
  print('Type: ${option.type}');
}

// Process updated setting options
for (final option in response.update ?? []) {
  print('Updated setting: ${option.label}');
  print('New value: ${option.value}');
}

// Process deleted setting options
for (final option in response.delete ?? []) {
  print('Deleted setting: ${option.id}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Analyzing Settings by Type

```dart
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

// Group created settings by type
final byType = <String, List<WooSettingOption>>{};
for (final option in response.create ?? []) {
  final type = option.type ?? 'Unknown';
  byType.putIfAbsent(type, () => []).add(option);
}

print('Settings by type:');
byType.forEach((type, options) {
  print('  $type: ${options.length} settings');
});
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooSettingOptionBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooSettingOptionBatchResponse({this.create, this.update, this.delete})

WooCommerce Setting Option Batch Response Model

This class represents the response from a batch setting option operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created setting options with server-assigned IDs
- **Update Results**: List of successfully updated setting options
- **Delete Results**: List of successfully deleted setting options
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

// Process created setting options
for (final option in response.create ?? []) {
  print('Created setting: ${option.label} with ID: ${option.id}');
  print('Value: ${option.value}');
  print('Type: ${option.type}');
}

// Process updated setting options
for (final option in response.update ?? []) {
  print('Updated setting: ${option.label}');
  print('New value: ${option.value}');
}

// Process deleted setting options
for (final option in response.delete ?? []) {
  print('Deleted setting: ${option.id}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Analyzing Settings by Type

```dart
final response = await wooCommerce.batchUpdateSettingOptions(
  'general',
  batchRequest,
);

// Group created settings by type
final byType = <String, List<WooSettingOption>>{};
for (final option in response.create ?? []) {
  final type = option.type ?? 'Unknown';
  byType.putIfAbsent(type, () => []).add(option);
}

print('Settings by type:');
byType.forEach((type, options) {
  print('  $type: ${options.length} settings');
});
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooSettingOptionBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooSettingOptionBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooSettingOptionBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooSettingOptionBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooSettingOptionBatchResponse.fromJson(jsonData);
```

### factory WooSettingOptionBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooSettingOption>? create

List of created setting options

Contains the setting options that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooSettingOption>? update

List of updated setting options

Contains the setting options that were successfully updated, reflecting
the current state after the update operation.

### final List<WooSettingOption>? delete

List of deleted setting options

Contains the setting options that were successfully deleted. These options
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooSettingOptionBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooSettingOptionBatchResponse copyWith({ List<WooSettingOption>? create, List<WooSettingOption>? update, List<WooSettingOption>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooSettingOptionBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooSettingOptionBatchResponse(
  create: [option1, option2],
  update: [option3],
  delete: [option4, option5],
);
print(batchResponse.toString());
// Output: WooSettingOptionBatchResponse(create: 2, update: 1, delete: 2)
```

## settings

### class WooSettings

WooCommerce Settings Group Model

Represents a settings group in WooCommerce. Settings groups are top-level
categories that organize related settings together, such as 'general',
'products', 'shipping', or 'payments'. Each group contains multiple
setting options that can be configured independently.

## Key Features

- **Hierarchical organization**: Support for parent-child relationships
- **Sub-groups**: Nested organization for complex settings structures
- **Human-readable labels**: User-friendly names for display
- **Descriptive information**: Help text for understanding group purpose

## Common Settings Groups

- **general**: Store name, currency, location, and basic settings
- **products**: Product catalog, inventory, and display settings
- **shipping**: Shipping zones, methods, and rate calculations
- **payments**: Payment gateway configurations and options
- **tax**: Tax calculation and display settings

## Usage Examples

```dart
// Create a settings group
final group = WooSettings(
  id: 'custom_settings',
  label: 'Custom Settings',
  description: 'Custom store configuration options',
);

// Access group properties
print('Group: ${group.label}');
print('Description: ${group.description}');
print('Has sub-groups: ${group.subGroups?.isNotEmpty ?? false}');
```

### WooSettings({ this.id, this.label, this.description, this.parentId, this.subGroups, })

WooCommerce Settings Group Model

Represents a settings group in WooCommerce. Settings groups are top-level
categories that organize related settings together, such as 'general',
'products', 'shipping', or 'payments'. Each group contains multiple
setting options that can be configured independently.

## Key Features

- **Hierarchical organization**: Support for parent-child relationships
- **Sub-groups**: Nested organization for complex settings structures
- **Human-readable labels**: User-friendly names for display
- **Descriptive information**: Help text for understanding group purpose

## Common Settings Groups

- **general**: Store name, currency, location, and basic settings
- **products**: Product catalog, inventory, and display settings
- **shipping**: Shipping zones, methods, and rate calculations
- **payments**: Payment gateway configurations and options
- **tax**: Tax calculation and display settings

## Usage Examples

```dart
// Create a settings group
final group = WooSettings(
  id: 'custom_settings',
  label: 'Custom Settings',
  description: 'Custom store configuration options',
);

// Access group properties
print('Group: ${group.label}');
print('Description: ${group.description}');
print('Has sub-groups: ${group.subGroups?.isNotEmpty ?? false}');
```

### factory WooSettings.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSettings.fake()

Creates a fake WooSettings instance for testing purposes

This factory constructor generates a settings group with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated settings group will have valid data for all fields.

## Generated Data

The fake settings group includes:
- Random ID from word generator
- Random label from sentence generator
- Random description from sentence generator
- Random parent ID from word generator
- Random list of sub-group IDs

## Returns

A `WooSettings` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake settings group for testing
final fakeGroup = WooSettings.fake();
print('Fake group: ${fakeGroup.label}');
print('ID: ${fakeGroup.id}');

// Use in tests
test('settings group creation', () {
  final group = WooSettings.fake();
  expect(group.id, isNotNull);
  expect(group.label, isNotNull);
  expect(group.description, isNotNull);
});
```

### final String? id

A unique identifier that can be used to link settings together.

This identifier is used to reference the settings group in API calls
and to organize related settings. Common values include 'general',
'products', 'shipping', and 'payments'.

### final String? label

A human readable label for the setting used in interfaces.

This is the display name shown to users in the WooCommerce admin
interface. It should be descriptive and user-friendly.

### final String? description

A human readable description for the setting used in interfaces.

Provides additional context about what the settings group contains
and how it affects store functionality.

### final String? parentId

ID of parent grouping.

Used to create hierarchical relationships between settings groups.
When set, this group becomes a sub-group of the parent.

### final List<String>? subGroups

IDs for settings sub groups.

Contains a list of sub-group identifiers that belong to this
settings group, enabling nested organization of settings.

### Map<String, dynamic> toJson()

Converts the WooSettings instance to JSON format

This method serializes the settings group data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the settings group data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "id": "general",
  "label": "General Settings",
  "description": "Basic store configuration",
  "parent_id": null,
  "sub_groups": ["store_info", "currency"]
}
```

## Example Usage

```dart
// Convert settings group to JSON for API calls
final group = WooSettings(
  id: 'custom_settings',
  label: 'Custom Settings',
  description: 'Custom store configuration',
);

final jsonData = group.toJson();
print('JSON: $jsonData');

// Send to API
await dio.post('/settings', data: group.toJson());
```

### WooSettings copyWith({ String? id, String? label, String? description, String? parentId, List<String>? subGroups, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

