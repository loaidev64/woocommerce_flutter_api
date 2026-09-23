# payment_gateway

## payment_gateway_api

### extension WooPaymentGatewayApi on WooCommerce

WooCommerce Payment Gateway API Extension

This extension provides comprehensive payment gateway management capabilities for WooCommerce stores.
Payment gateways handle the processing of payments from customers, including credit cards,
digital wallets, bank transfers, and other payment methods.

## Payment Gateway Overview

Payment gateways are the systems that process payments for your WooCommerce store.
They handle the secure transmission of payment information between your store and
payment processors, ensuring transactions are completed safely and efficiently.

## Key Features

- **Multiple payment methods**: Support for various payment types and processors
- **Configuration management**: Customize gateway settings and behavior
- **Status control**: Enable or disable payment methods as needed
- **Feature support**: Configure supported features like refunds, subscriptions
- **Order management**: Control display order and checkout experience

## Common Payment Gateways

- **PayPal**: PayPal Standard, PayPal Express, PayPal Pro
- **Stripe**: Credit cards, digital wallets, bank transfers
- **Square**: Point of sale integration and online payments
- **Authorize.Net**: Credit card processing
- **Bank Transfer**: Direct bank transfers
- **Cash on Delivery**: Payment upon delivery

## Example Usage

```dart
// Get all payment gateways
final gateways = await wooCommerce.getPaymentGateways();

// Get a specific gateway
final paypal = await wooCommerce.getPaymentGateway(id: 'paypal');

// Update gateway settings
paypal.enabled = true;
await wooCommerce.updatePaymentGateway(paypal);
```

### Future<List<WooPaymentGateway>> getPaymentGateways({bool? useFaker}) async

Retrieves all payment gateways from the WooCommerce store.

This method fetches all available payment gateways, including their
configuration, status, and supported features. Payment gateways determine
how customers can pay for their orders.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-payment-gateways

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooPaymentGateway>>` containing all available payment gateways.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all payment gateways
final gateways = await wooCommerce.getPaymentGateways();

// Filter enabled gateways
final enabledGateways = gateways.where((gateway) => gateway.enabled == true);

// Print gateway information
for (final gateway in gateways) {
  print('Gateway: ${gateway.title} (${gateway.id})');
  print('Enabled: ${gateway.enabled}');
  print('Supports: ${gateway.methodSupports}');
}
```

### Future<WooPaymentGateway> getPaymentGateway(String id, {bool? useFaker}) async

Retrieves a specific payment gateway by its ID.

This method fetches detailed information about a single payment gateway,
including its configuration, settings, and supported features.
Useful when you need to work with a specific gateway without loading all gateways.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-payment-gateway

## Parameters

* [id] - The unique identifier of the payment gateway (e.g., 'paypal', 'stripe')
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooPaymentGateway>` containing the payment gateway details.

## Throws

* `WooCommerceException` if the gateway is not found or access is denied

## Example Usage

```dart
// Get PayPal gateway
final paypal = await wooCommerce.getPaymentGateway(id: 'paypal');

print('Gateway: ${paypal.title}');
print('Enabled: ${paypal.enabled}');
print('Supports: ${paypal.methodSupports}');

// Check if gateway supports refunds
if (paypal.methodSupports?.contains('refunds') == true) {
  print('PayPal supports refunds');
}
```

### Future<WooPaymentGateway> updatePaymentGateway

Updates a payment gateway in the WooCommerce store.

This method allows you to modify payment gateway configuration, including
enabling/disabling the gateway, updating settings, and changing display options.
The gateway must have a valid ID.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-payment-gateway

## Parameters

* [gateway] - The payment gateway object with updated configuration
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooPaymentGateway>` containing the updated payment gateway.

## Throws

* `WooCommerceException` if the update fails or gateway not found

## Example Usage

```dart
// Get current gateway configuration
final paypal = await wooCommerce.getPaymentGateway(id: 'paypal');

// Enable the gateway
paypal.enabled = true;
paypal.title = 'PayPal - Safe and Secure';

// Update gateway settings
final updatedPaypal = await wooCommerce.updatePaymentGateway(paypal);
print('Gateway updated: ${updatedPaypal.enabled}');
```

## payment_gateway

### class WooPaymentGateway

WooCommerce Payment Gateway Model

Represents a payment gateway in WooCommerce. Payment gateways handle the
processing of payments from customers, including credit cards, digital wallets,
bank transfers, and other payment methods.

## Payment Gateway Structure

A payment gateway consists of several key components:

- **Identification**: Unique ID and display information
- **Configuration**: Settings and behavior customization
- **Status Management**: Enable/disable and display order
- **Feature Support**: Capabilities like refunds, subscriptions, etc.
- **Customer Experience**: Titles, descriptions, and checkout display

## Common Payment Gateways

- **PayPal**: PayPal Standard, PayPal Express, PayPal Pro
- **Stripe**: Credit cards, digital wallets, bank transfers
- **Square**: Point of sale integration and online payments
- **Authorize.Net**: Credit card processing
- **Bank Transfer**: Direct bank transfers
- **Cash on Delivery**: Payment upon delivery

## Supported Features

- **products**: Product-based payments
- **refunds**: Refund processing capability
- **subscriptions**: Subscription payment support
- **pre-orders**: Pre-order payment handling
- **tokenization**: Token-based payments

## Example Usage

```dart
// Create a payment gateway
final gateway = WooPaymentGateway(
  id: 'custom_gateway',
  title: 'Custom Payment',
  description: 'Pay securely with our custom gateway',
  enabled: true,
);

// Access gateway properties
print('Gateway: ${gateway.title}');
print('Enabled: ${gateway.enabled}');
print('Supports: ${gateway.methodSupports}');
```

### WooPaymentGateway({ this.id, this.title, this.description, this.order, this.enabled, this.methodTitle, this.methodDescription, this.methodSupports, this.settings, })

WooCommerce Payment Gateway Model

Represents a payment gateway in WooCommerce. Payment gateways handle the
processing of payments from customers, including credit cards, digital wallets,
bank transfers, and other payment methods.

## Payment Gateway Structure

A payment gateway consists of several key components:

- **Identification**: Unique ID and display information
- **Configuration**: Settings and behavior customization
- **Status Management**: Enable/disable and display order
- **Feature Support**: Capabilities like refunds, subscriptions, etc.
- **Customer Experience**: Titles, descriptions, and checkout display

## Common Payment Gateways

- **PayPal**: PayPal Standard, PayPal Express, PayPal Pro
- **Stripe**: Credit cards, digital wallets, bank transfers
- **Square**: Point of sale integration and online payments
- **Authorize.Net**: Credit card processing
- **Bank Transfer**: Direct bank transfers
- **Cash on Delivery**: Payment upon delivery

## Supported Features

- **products**: Product-based payments
- **refunds**: Refund processing capability
- **subscriptions**: Subscription payment support
- **pre-orders**: Pre-order payment handling
- **tokenization**: Token-based payments

## Example Usage

```dart
// Create a payment gateway
final gateway = WooPaymentGateway(
  id: 'custom_gateway',
  title: 'Custom Payment',
  description: 'Pay securely with our custom gateway',
  enabled: true,
);

// Access gateway properties
print('Gateway: ${gateway.title}');
print('Enabled: ${gateway.enabled}');
print('Supports: ${gateway.methodSupports}');
```

### factory WooPaymentGateway.fromJson(Map<String, dynamic> json)

Creates a WooPaymentGateway instance from JSON data

This factory constructor is used to deserialize payment gateway data received
from the WooCommerce REST API. It handles the conversion of JSON fields
to the appropriate Dart types and provides fallback values where needed.

## Parameters

* [json] - A Map containing the payment gateway data in JSON format

## Returns

A `WooPaymentGateway` instance populated with data from the JSON.

## JSON Structure

The expected JSON structure includes:
```json
{
  "id": "paypal",
  "title": "PayPal",
  "description": "Pay securely with PayPal",
  "order": 1,
  "enabled": true,
  "method_title": "PayPal - Safe and Secure",
  "method_description": "Pay with your PayPal account",
  "method_supports": ["products", "refunds"],
  "settings": {
    "api_username": {"id": "api_username", "value": "your_api_username"},
    "api_password": {"id": "api_password", "value": "your_api_password"}
  }
}
```

## Example Usage

```dart
// Parse payment gateway from API response
final jsonData = {
  'id': 'paypal',
  'title': 'PayPal',
  'enabled': true,
  'method_supports': ['products', 'refunds']
};

final gateway = WooPaymentGateway.fromJson(jsonData);
print('Gateway: ${gateway.title}');
print('Enabled: ${gateway.enabled}');
print('Supports: ${gateway.methodSupports}');
```

### factory WooPaymentGateway.fake()

Creates a fake WooPaymentGateway instance for testing purposes

This factory constructor generates a payment gateway with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated payment gateway will have valid data for all fields.

## Generated Data

The fake payment gateway includes:
- Random ID from word generator
- Random title from word generator
- Random description from sentence generator
- Random order from integer generator
- Random enabled status from boolean generator
- Random method title from sentence generator
- Random method description from sentence generator
- Random list of supported features
- Random settings map with multiple configuration options

## Returns

A `WooPaymentGateway` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake payment gateway for testing
final fakeGateway = WooPaymentGateway.fake();
print('Fake gateway: ${fakeGateway.title}');
print('ID: ${fakeGateway.id}');
print('Enabled: ${fakeGateway.enabled}');

// Use in tests
test('payment gateway creation', () {
  final gateway = WooPaymentGateway.fake();
  expect(gateway.id, isNotNull);
  expect(gateway.title, isNotNull);
  expect(gateway.enabled, isA<bool>());
});
```

### final String? id

Payment gateway ID

Unique identifier for the payment gateway (e.g., 'paypal', 'stripe', 'bacs').
This ID is used to reference the gateway in API calls and configuration.

### final String? title

Payment gateway title on checkout

The display name shown to customers during checkout. This should be
user-friendly and clearly indicate the payment method.

### final String? description

Payment gateway description on checkout

Additional information shown to customers about the payment method,
such as security features or processing time.

### final int? order

Payment gateway sort order

Determines the display order of payment methods on the checkout page.
Lower numbers appear first in the list.

### final bool? enabled

Payment gateway enabled status

Controls whether the payment gateway is available to customers.
When false, the gateway is hidden from checkout options.

### final String? methodTitle

Payment gateway method title

The title used in the payment method selection during checkout.
This may differ from the main gateway title for branding purposes.

### final String? methodDescription

Payment gateway method description

Detailed description of the payment method shown to customers
during the checkout process.

### final List<String>? methodSupports

Supported features

List of features supported by this payment gateway:
- 'products': Product-based payments
- 'refunds': Refund processing capability
- 'subscriptions': Subscription payment support
- 'pre-orders': Pre-order payment handling
- 'tokenization': Token-based payments

### Map<String, dynamic> toJson()

Converts the WooPaymentGateway instance to JSON format

This method serializes the payment gateway data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the payment gateway data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "id": "paypal",
  "title": "PayPal",
  "description": "Pay securely with PayPal",
  "order": 1,
  "enabled": true,
  "method_title": "PayPal - Safe and Secure",
  "method_description": "Pay with your PayPal account",
  "method_supports": ["products", "refunds"],
  "settings": {
    "api_username": {"id": "api_username", "value": "your_api_username"},
    "api_password": {"id": "api_password", "value": "your_api_password"}
  }
}
```

## Example Usage

```dart
// Convert payment gateway to JSON for API calls
final gateway = WooPaymentGateway(
  id: 'paypal',
  title: 'PayPal',
  enabled: true,
);

final jsonData = gateway.toJson();
print('JSON: $jsonData');

// Send to API
await dio.put('/payment_gateways/paypal', data: gateway.toJson());
```

### WooPaymentGateway copyWith({ String? id, String? title, String? description, int? order, bool? enabled, String? methodTitle, String? methodDescription, List<String>? methodSupports, Map<String, WooPaymentGatewaySetting>? settings, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## payment_gateway_settings

### class WooPaymentGatewaySetting

WooCommerce Payment Gateway Setting Model

Represents a configuration setting for a payment gateway in WooCommerce.
Each setting controls a specific aspect of the gateway's behavior, such as
API credentials, processing options, or display preferences.

## Setting Structure

A payment gateway setting consists of several key components:

- **Identification**: Unique ID and display information
- **Configuration**: Setting value and default value
- **User Interface**: Label, description, and help text
- **Input Type**: Text, select, checkbox, etc.
- **Validation**: Placeholder text and input constraints

## Common Setting Types

- **text**: Single-line text input (API keys, usernames)
- **textarea**: Multi-line text input (descriptions, instructions)
- **select**: Dropdown with predefined options (currency, region)
- **checkbox**: Boolean true/false values (enable/disable features)
- **number**: Numeric input with validation (timeouts, limits)
- **email**: Email address input with validation
- **url**: URL input with validation (webhook URLs, redirect URLs)

## Example Usage

```dart
// Create a payment gateway setting
final setting = WooPaymentGatewaySetting(
  id: 'api_key',
  label: 'API Key',
  description: 'Your payment processor API key',
  value: 'sk_test_123456789',
  type: 'text',
);

// Access setting properties
print('Setting: ${setting.label}');
print('Value: ${setting.value}');
print('Type: ${setting.type}');
```

### WooPaymentGatewaySetting({ this.id, this.label, this.description, this.type, this.value, this.defaultValue, this.tip, this.placeholder, })

WooCommerce Payment Gateway Setting Model

Represents a configuration setting for a payment gateway in WooCommerce.
Each setting controls a specific aspect of the gateway's behavior, such as
API credentials, processing options, or display preferences.

## Setting Structure

A payment gateway setting consists of several key components:

- **Identification**: Unique ID and display information
- **Configuration**: Setting value and default value
- **User Interface**: Label, description, and help text
- **Input Type**: Text, select, checkbox, etc.
- **Validation**: Placeholder text and input constraints

## Common Setting Types

- **text**: Single-line text input (API keys, usernames)
- **textarea**: Multi-line text input (descriptions, instructions)
- **select**: Dropdown with predefined options (currency, region)
- **checkbox**: Boolean true/false values (enable/disable features)
- **number**: Numeric input with validation (timeouts, limits)
- **email**: Email address input with validation
- **url**: URL input with validation (webhook URLs, redirect URLs)

## Example Usage

```dart
// Create a payment gateway setting
final setting = WooPaymentGatewaySetting(
  id: 'api_key',
  label: 'API Key',
  description: 'Your payment processor API key',
  value: 'sk_test_123456789',
  type: 'text',
);

// Access setting properties
print('Setting: ${setting.label}');
print('Value: ${setting.value}');
print('Type: ${setting.type}');
```

### factory WooPaymentGatewaySetting.fromJson(Map<String, dynamic> json)

Creates a WooPaymentGatewaySetting instance from JSON data

This factory constructor is used to deserialize payment gateway setting data received
from the WooCommerce REST API. It handles the conversion of JSON fields
to the appropriate Dart types and provides fallback values where needed.

## Parameters

* [json] - A Map containing the payment gateway setting data in JSON format

## Returns

A `WooPaymentGatewaySetting` instance populated with data from the JSON.

## JSON Structure

The expected JSON structure includes:
```json
{
  "id": "api_key",
  "label": "API Key",
  "description": "Your payment processor API key",
  "type": "text",
  "value": "sk_test_123456789",
  "default": "sk_live_123456789",
  "tip": "Enter your API key from the payment processor",
  "placeholder": "sk_test_..."
}
```

## Example Usage

```dart
// Parse payment gateway setting from API response
final jsonData = {
  'id': 'api_key',
  'label': 'API Key',
  'value': 'sk_test_123456789',
  'type': 'text'
};

final setting = WooPaymentGatewaySetting.fromJson(jsonData);
print('Setting: ${setting.label}');
print('Value: ${setting.value}');
print('Type: ${setting.type}');
```

### factory WooPaymentGatewaySetting.fake()

Creates a fake WooPaymentGatewaySetting instance for testing purposes

This factory constructor generates a payment gateway setting with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated setting will have valid data for all fields.

## Generated Data

The fake payment gateway setting includes:
- Random ID from word generator
- Random label from word generator
- Random description from sentence generator
- Random type from available setting types
- Random value from word generator
- Random default value from word generator
- Random tip from sentence generator
- Random placeholder from word generator

## Returns

A `WooPaymentGatewaySetting` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake payment gateway setting for testing
final fakeSetting = WooPaymentGatewaySetting.fake();
print('Fake setting: ${fakeSetting.label}');
print('Type: ${fakeSetting.type}');
print('Value: ${fakeSetting.value}');

// Use in tests
test('payment gateway setting creation', () {
  final setting = WooPaymentGatewaySetting.fake();
  expect(setting.id, isNotNull);
  expect(setting.label, isNotNull);
  expect(setting.type, isNotNull);
  expect(setting.value, isNotNull);
});
```

### final String? id

Unique identifier for the setting

This ID is used to reference the setting in API calls and configuration.
Common examples include 'api_key', 'api_secret', 'webhook_url', etc.

### final String? label

Human-readable label for the setting

This is the display name shown to users in the payment gateway configuration
interface. It should be descriptive and user-friendly.

### final String? description

Detailed description of the setting

Provides additional context about what the setting controls and how
it affects the payment gateway's behavior.

### final String? type

Type of setting input

Determines the input method and validation rules:
- 'text': Single-line text input
- 'textarea': Multi-line text input
- 'select': Dropdown with predefined options
- 'checkbox': Boolean true/false values
- 'number': Numeric input with validation
- 'email': Email address input with validation
- 'url': URL input with validation

### final String? value

Current value of the setting

The active configuration value for this setting. This is what the
payment gateway will use for its operation.

### final String? defaultValue

Default value for the setting

The fallback value used when no custom value is set. This is typically
the value that comes with the payment gateway by default.

### final String? tip

Additional help text for users

Provides additional guidance or tips for users configuring
the setting in the admin interface.

### final String? placeholder

Placeholder text for input fields

Shown as placeholder text in input fields to guide users
on what kind of input is expected.

### Map<String, dynamic> toJson()

Converts the WooPaymentGatewaySetting instance to JSON format

This method serializes the payment gateway setting data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the payment gateway setting data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "id": "api_key",
  "label": "API Key",
  "description": "Your payment processor API key",
  "type": "text",
  "value": "sk_test_123456789",
  "default": "sk_live_123456789",
  "tip": "Enter your API key from the payment processor",
  "placeholder": "sk_test_..."
}
```

## Example Usage

```dart
// Convert payment gateway setting to JSON for API calls
final setting = WooPaymentGatewaySetting(
  id: 'api_key',
  label: 'API Key',
  value: 'sk_test_123456789',
  type: 'text',
);

final jsonData = setting.toJson();
print('JSON: $jsonData');

// Send to API
await dio.put('/payment_gateways/stripe', data: setting.toJson());
```

### WooPaymentGatewaySetting copyWith({ String? id, String? label, String? description, String? type, String? value, String? defaultValue, String? tip, String? placeholder, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

