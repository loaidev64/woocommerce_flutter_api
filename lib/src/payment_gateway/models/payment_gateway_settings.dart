import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Payment Gateway Setting Model
///
/// Represents a configuration setting for a payment gateway in WooCommerce.
/// Each setting controls a specific aspect of the gateway's behavior, such as
/// API credentials, processing options, or display preferences.
///
/// ## Setting Structure
///
/// A payment gateway setting consists of several key components:
///
/// - **Identification**: Unique ID and display information
/// - **Configuration**: Setting value and default value
/// - **User Interface**: Label, description, and help text
/// - **Input Type**: Text, select, checkbox, etc.
/// - **Validation**: Placeholder text and input constraints
///
/// ## Common Setting Types
///
/// - **text**: Single-line text input (API keys, usernames)
/// - **textarea**: Multi-line text input (descriptions, instructions)
/// - **select**: Dropdown with predefined options (currency, region)
/// - **checkbox**: Boolean true/false values (enable/disable features)
/// - **number**: Numeric input with validation (timeouts, limits)
/// - **email**: Email address input with validation
/// - **url**: URL input with validation (webhook URLs, redirect URLs)
///
/// ## Example Usage
///
/// ```dart
/// // Create a payment gateway setting
/// final setting = WooPaymentGatewaySetting(
///   id: 'api_key',
///   label: 'API Key',
///   description: 'Your payment processor API key',
///   value: 'sk_test_123456789',
///   type: 'text',
/// );
///
/// // Access setting properties
/// print('Setting: ${setting.label}');
/// print('Value: ${setting.value}');
/// print('Type: ${setting.type}');
/// ```
class WooPaymentGatewaySetting {

  /// Creates a new WooPaymentGatewaySetting instance
  ///
  /// This constructor creates a payment gateway setting with the specified properties.
  /// All parameters are optional, allowing for flexible setting creation.
  ///
  /// ## Parameters
  ///
  /// * [id] - Unique identifier for the setting
  /// * [label] - Human-readable label for display in interfaces
  /// * [description] - Detailed description of the setting's purpose
  /// * [type] - Type of setting input (text, select, checkbox, etc.)
  /// * [value] - Current value of the setting
  /// * [defaultValue] - Default value when no custom value is set
  /// * [tip] - Additional help text for users
  /// * [placeholder] - Placeholder text for input fields
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic API key setting
  /// final setting = WooPaymentGatewaySetting(
  ///   id: 'api_key',
  ///   label: 'API Key',
  ///   description: 'Your payment processor API key',
  ///   value: 'sk_test_123456789',
  ///   type: 'text',
  /// );
  ///
  /// // Create a select setting with options
  /// final currencySetting = WooPaymentGatewaySetting(
  ///   id: 'currency',
  ///   label: 'Currency',
  ///   description: 'The currency for payments',
  ///   value: 'USD',
  ///   type: 'select',
  /// );
  /// ```
  WooPaymentGatewaySetting({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
  });

  /// Creates a WooPaymentGatewaySetting instance from JSON data
  ///
  /// This factory constructor is used to deserialize payment gateway setting data received
  /// from the WooCommerce REST API. It handles the conversion of JSON fields
  /// to the appropriate Dart types and provides fallback values where needed.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the payment gateway setting data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooPaymentGatewaySetting` instance populated with data from the JSON.
  ///
  /// ## JSON Structure
  ///
  /// The expected JSON structure includes:
  /// ```json
  /// {
  ///   "id": "api_key",
  ///   "label": "API Key",
  ///   "description": "Your payment processor API key",
  ///   "type": "text",
  ///   "value": "sk_test_123456789",
  ///   "default": "sk_live_123456789",
  ///   "tip": "Enter your API key from the payment processor",
  ///   "placeholder": "sk_test_..."
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse payment gateway setting from API response
  /// final jsonData = {
  ///   'id': 'api_key',
  ///   'label': 'API Key',
  ///   'value': 'sk_test_123456789',
  ///   'type': 'text'
  /// };
  ///
  /// final setting = WooPaymentGatewaySetting.fromJson(jsonData);
  /// print('Setting: ${setting.label}');
  /// print('Value: ${setting.value}');
  /// print('Type: ${setting.type}');
  /// ```
  factory WooPaymentGatewaySetting.fromJson(Map<String, dynamic> json) =>
      WooPaymentGatewaySetting(
        id: json['id'],
        label: json['label'],
        description: json['description'],
        type: json['type'],
        value: json['value'],
        defaultValue: json['default'],
        tip: json['tip'],
        placeholder: json['placeholder'],
      );

  /// Creates a fake WooPaymentGatewaySetting instance for testing purposes
  ///
  /// This factory constructor generates a payment gateway setting with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated setting will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake payment gateway setting includes:
  /// - Random ID from word generator
  /// - Random label from word generator
  /// - Random description from sentence generator
  /// - Random type from available setting types
  /// - Random value from word generator
  /// - Random default value from word generator
  /// - Random tip from sentence generator
  /// - Random placeholder from word generator
  ///
  /// ## Returns
  ///
  /// A `WooPaymentGatewaySetting` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake payment gateway setting for testing
  /// final fakeSetting = WooPaymentGatewaySetting.fake();
  /// print('Fake setting: ${fakeSetting.label}');
  /// print('Type: ${fakeSetting.type}');
  /// print('Value: ${fakeSetting.value}');
  ///
  /// // Use in tests
  /// test('payment gateway setting creation', () {
  ///   final setting = WooPaymentGatewaySetting.fake();
  ///   expect(setting.id, isNotNull);
  ///   expect(setting.label, isNotNull);
  ///   expect(setting.type, isNotNull);
  ///   expect(setting.value, isNotNull);
  /// });
  /// ```
  factory WooPaymentGatewaySetting.fake() => WooPaymentGatewaySetting(
        id: FakeHelper.word(),
        label: FakeHelper.word(),
        description: FakeHelper.sentence(),
        type: FakeHelper.randomItem(['text', 'select', 'checkbox']),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
      );
  /// Unique identifier for the setting
  ///
  /// This ID is used to reference the setting in API calls and configuration.
  /// Common examples include 'api_key', 'api_secret', 'webhook_url', etc.
  final String? id;

  /// Human-readable label for the setting
  ///
  /// This is the display name shown to users in the payment gateway configuration
  /// interface. It should be descriptive and user-friendly.
  final String? label;

  /// Detailed description of the setting
  ///
  /// Provides additional context about what the setting controls and how
  /// it affects the payment gateway's behavior.
  final String? description;

  /// Type of setting input
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

  /// Current value of the setting
  ///
  /// The active configuration value for this setting. This is what the
  /// payment gateway will use for its operation.
  final String? value;

  /// Default value for the setting
  ///
  /// The fallback value used when no custom value is set. This is typically
  /// the value that comes with the payment gateway by default.
  final String? defaultValue;

  /// Additional help text for users
  ///
  /// Provides additional guidance or tips for users configuring
  /// the setting in the admin interface.
  final String? tip;

  /// Placeholder text for input fields
  ///
  /// Shown as placeholder text in input fields to guide users
  /// on what kind of input is expected.
  final String? placeholder;

  /// Converts the WooPaymentGatewaySetting instance to JSON format
  ///
  /// This method serializes the payment gateway setting data into a Map that can be sent
  /// to the WooCommerce REST API. It handles the conversion of Dart types
  /// to JSON-compatible formats and includes all necessary fields.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the payment gateway setting data in JSON format.
  ///
  /// ## JSON Structure
  ///
  /// The returned JSON structure includes:
  /// ```json
  /// {
  ///   "id": "api_key",
  ///   "label": "API Key",
  ///   "description": "Your payment processor API key",
  ///   "type": "text",
  ///   "value": "sk_test_123456789",
  ///   "default": "sk_live_123456789",
  ///   "tip": "Enter your API key from the payment processor",
  ///   "placeholder": "sk_test_..."
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert payment gateway setting to JSON for API calls
  /// final setting = WooPaymentGatewaySetting(
  ///   id: 'api_key',
  ///   label: 'API Key',
  ///   value: 'sk_test_123456789',
  ///   type: 'text',
  /// );
  ///
  /// final jsonData = setting.toJson();
  /// print('JSON: $jsonData');
  ///
  /// // Send to API
  /// await dio.put('/payment_gateways/stripe', data: setting.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'description': description,
        'type': type,
        'value': value,
        'default': defaultValue,
        'tip': tip,
        'placeholder': placeholder,
      };
}
