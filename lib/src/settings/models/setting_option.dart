import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Setting Option Model
///
/// Represents an individual setting option within a WooCommerce settings group.
/// Each option represents a configurable aspect of your store, such as store name,
/// currency, shipping methods, or payment gateway settings.
///
/// ## Key Features
///
/// - **Flexible value types**: Support for text, numbers, booleans, and complex objects
/// - **Default values**: Fallback values when no custom value is set
/// - **Input validation**: Built-in validation based on setting type
/// - **User guidance**: Help text, placeholders, and descriptions
/// - **Option constraints**: Limited choices for select-type settings
///
/// ## Setting Types
///
/// - **text**: Single-line text input
/// - **textarea**: Multi-line text input
/// - **select**: Dropdown with predefined options
/// - **checkbox**: Boolean true/false values
/// - **number**: Numeric input with validation
/// - **email**: Email address input with validation
/// - **url**: URL input with validation
///
/// ## Usage Examples
///
/// ```dart
/// // Create a setting option
/// final option = WooSettingOption(
///   id: 'store_name',
///   label: 'Store Name',
///   description: 'The name of your store',
///   value: 'My WooCommerce Store',
///   type: 'text',
/// );
///
/// // Access option properties
/// print('Setting: ${option.label}');
/// print('Current value: ${option.value}');
/// print('Default value: ${option.defaultValue}');
/// print('Type: ${option.type}');
/// ```
class WooSettingOption {

  /// Creates a new WooSettingOption instance
  ///
  /// This constructor creates a setting option with the specified properties.
  /// All parameters are optional, allowing for flexible option creation.
  ///
  /// ## Parameters
  ///
  /// * [id] - Unique identifier for the setting option
  /// * [label] - Human-readable label for display in interfaces
  /// * [description] - Detailed description of the option's purpose
  /// * [value] - Current value of the setting
  /// * [defaultValue] - Default value when no custom value is set
  /// * [tip] - Additional help text for users
  /// * [placeholder] - Placeholder text for input fields
  /// * [type] - Type of setting (text, select, checkbox, etc.)
  /// * [options] - Available choices for select-type settings
  /// * [groupId] - ID of the settings group this option belongs to
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic text setting
  /// final option = WooSettingOption(
  ///   id: 'store_name',
  ///   label: 'Store Name',
  ///   description: 'The name of your store',
  ///   value: 'My WooCommerce Store',
  ///   type: 'text',
  /// );
  ///
  /// // Create a select setting with options
  /// final currencyOption = WooSettingOption(
  ///   id: 'currency',
  ///   label: 'Store Currency',
  ///   description: 'The currency used for prices',
  ///   value: 'USD',
  ///   type: 'select',
  ///   options: {'USD': 'US Dollar', 'EUR': 'Euro', 'GBP': 'British Pound'},
  /// );
  /// ```
  WooSettingOption({
    this.id,
    this.label,
    this.description,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
    this.type,
    this.options,
    this.groupId,
  });

  /// Creates a WooSettingOption instance from JSON data
  ///
  /// This factory constructor is used to deserialize setting option data received
  /// from the WooCommerce REST API. It handles the conversion of JSON fields
  /// to the appropriate Dart types and provides fallback values where needed.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the setting option data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooSettingOption` instance populated with data from the JSON.
  ///
  /// ## JSON Structure
  ///
  /// The expected JSON structure includes:
  /// ```json
  /// {
  ///   "id": "store_name",
  ///   "label": "Store Name",
  ///   "description": "The name of your store",
  ///   "value": "My WooCommerce Store",
  ///   "default": "WooCommerce Store",
  ///   "tip": "Enter your store name",
  ///   "placeholder": "Store Name",
  ///   "type": "text",
  ///   "options": {},
  ///   "group_id": "general"
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse setting option from API response
  /// final jsonData = {
  ///   'id': 'store_name',
  ///   'label': 'Store Name',
  ///   'value': 'My Store',
  ///   'type': 'text',
  ///   'group_id': 'general'
  /// };
  ///
  /// final option = WooSettingOption.fromJson(jsonData);
  /// print('Setting: ${option.label}');
  /// print('Value: ${option.value}');
  /// print('Type: ${option.type}');
  /// ```
  WooSettingOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        description = json['description'],
        value = json['value'],
        defaultValue = json['default'],
        tip = json['tip'],
        placeholder = json['placeholder'],
        type = json['type'],
        options = json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null,
        groupId = json['group_id'];

  /// Creates a fake WooSettingOption instance for testing purposes
  ///
  /// This factory constructor generates a setting option with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated setting option will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake setting option includes:
  /// - Random ID from word generator
  /// - Random label from sentence generator
  /// - Random description from sentence generator
  /// - Random value from word generator
  /// - Random default value from word generator
  /// - Random tip from sentence generator
  /// - Random placeholder from word generator
  /// - Random type from available setting types
  /// - Random options map with multiple choices
  /// - Random group ID from word generator
  ///
  /// ## Returns
  ///
  /// A `WooSettingOption` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake setting option for testing
  /// final fakeOption = WooSettingOption.fake();
  /// print('Fake option: ${fakeOption.label}');
  /// print('Type: ${fakeOption.type}');
  /// print('Value: ${fakeOption.value}');
  ///
  /// // Use in tests
  /// test('setting option creation', () {
  ///   final option = WooSettingOption.fake();
  ///   expect(option.id, isNotNull);
  ///   expect(option.label, isNotNull);
  ///   expect(option.type, isNotNull);
  ///   expect(option.value, isNotNull);
  /// });
  /// ```
  factory WooSettingOption.fake() => WooSettingOption(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
        type: FakeHelper.randomItem(['text', 'select', 'checkbox']),
        options: {
          FakeHelper.word(): FakeHelper.sentence(),
          FakeHelper.word(): FakeHelper.sentence(),
          FakeHelper.word(): FakeHelper.sentence(),
        },
        groupId: FakeHelper.word(),
      );
  /// A unique identifier for the setting.
  ///
  /// This identifier is used to reference the setting in API calls and
  /// to distinguish it from other settings within the same group.
  final String? id;

  /// A human readable label for the setting used in interfaces.
  ///
  /// This is the display name shown to users in the WooCommerce admin
  /// interface. It should be descriptive and user-friendly.
  final String? label;

  /// A human readable description for the setting used in interfaces.
  ///
  /// Provides additional context about what the setting controls
  /// and how it affects store functionality.
  final String? description;

  /// Setting value.
  ///
  /// The current value of the setting. The type depends on the setting type:
  /// - String for text, textarea, email, url types
  /// - bool for checkbox type
  /// - int/double for number type
  /// - String for select type (selected option value)
  final dynamic value;

  /// Default value for the setting.
  ///
  /// The fallback value used when no custom value is set.
  /// This is typically the value that comes with WooCommerce by default.
  final dynamic defaultValue;

  /// Additional help text shown to the user about the setting.
  ///
  /// Provides additional guidance or tips for users configuring
  /// the setting in the admin interface.
  final String? tip;

  /// Placeholder text to be displayed in text inputs.
  ///
  /// Shown as placeholder text in input fields to guide users
  /// on what kind of input is expected.
  final String? placeholder;

  /// Type of setting.
  ///
  /// Determines the input method and validation rules:
  /// - 'text': Single-line text input
  /// - 'textarea': Multi-line text input
  /// - 'select': Dropdown with predefined options
  /// - 'checkbox': Boolean true/false values
  /// - 'number': Numeric input with validation
  /// - 'email': Email address input with validation
  /// - 'url': URL input with validation
  final String? type;

  /// Array of options for inputs.
  ///
  /// For select-type settings, this contains the available choices
  /// as key-value pairs where the key is the option value and the
  /// value is the display label.
  final Map<String, dynamic>? options;

  /// An identifier for the group this setting belongs to.
  ///
  /// References the settings group that contains this option.
  /// Used to organize settings and determine API endpoints.
  final String? groupId;

  /// Converts the WooSettingOption instance to JSON format
  ///
  /// This method serializes the setting option data into a Map that can be sent
  /// to the WooCommerce REST API. It handles the conversion of Dart types
  /// to JSON-compatible formats and includes all necessary fields.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the setting option data in JSON format.
  ///
  /// ## JSON Structure
  ///
  /// The returned JSON structure includes:
  /// ```json
  /// {
  ///   "id": "store_name",
  ///   "label": "Store Name",
  ///   "description": "The name of your store",
  ///   "value": "My WooCommerce Store",
  ///   "default": "WooCommerce Store",
  ///   "tip": "Enter your store name",
  ///   "placeholder": "Store Name",
  ///   "type": "text",
  ///   "options": {},
  ///   "group_id": "general"
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert setting option to JSON for API calls
  /// final option = WooSettingOption(
  ///   id: 'store_name',
  ///   label: 'Store Name',
  ///   value: 'My Store',
  ///   type: 'text',
  /// );
  ///
  /// final jsonData = option.toJson();
  /// print('JSON: $jsonData');
  ///
  /// // Send to API
  /// await dio.put('/settings/general/store_name', data: option.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'description': description,
        'value': value,
        'default': defaultValue,
        'tip': tip,
        'placeholder': placeholder,
        'type': type,
        'options': options,
        'group_id': groupId,
      };
}
