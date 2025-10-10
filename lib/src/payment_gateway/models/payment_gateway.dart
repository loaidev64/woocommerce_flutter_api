import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Payment Gateway Model
///
/// Represents a payment gateway in WooCommerce. Payment gateways handle the
/// processing of payments from customers, including credit cards, digital wallets,
/// bank transfers, and other payment methods.
///
/// ## Payment Gateway Structure
///
/// A payment gateway consists of several key components:
///
/// - **Identification**: Unique ID and display information
/// - **Configuration**: Settings and behavior customization
/// - **Status Management**: Enable/disable and display order
/// - **Feature Support**: Capabilities like refunds, subscriptions, etc.
/// - **Customer Experience**: Titles, descriptions, and checkout display
///
/// ## Common Payment Gateways
///
/// - **PayPal**: PayPal Standard, PayPal Express, PayPal Pro
/// - **Stripe**: Credit cards, digital wallets, bank transfers
/// - **Square**: Point of sale integration and online payments
/// - **Authorize.Net**: Credit card processing
/// - **Bank Transfer**: Direct bank transfers
/// - **Cash on Delivery**: Payment upon delivery
///
/// ## Supported Features
///
/// - **products**: Product-based payments
/// - **refunds**: Refund processing capability
/// - **subscriptions**: Subscription payment support
/// - **pre-orders**: Pre-order payment handling
/// - **tokenization**: Token-based payments
///
/// ## Example Usage
///
/// ```dart
/// // Create a payment gateway
/// final gateway = WooPaymentGateway(
///   id: 'custom_gateway',
///   title: 'Custom Payment',
///   description: 'Pay securely with our custom gateway',
///   enabled: true,
/// );
///
/// // Access gateway properties
/// print('Gateway: ${gateway.title}');
/// print('Enabled: ${gateway.enabled}');
/// print('Supports: ${gateway.methodSupports}');
/// ```
class WooPaymentGateway {
  /// Payment gateway ID
  ///
  /// Unique identifier for the payment gateway (e.g., 'paypal', 'stripe', 'bacs').
  /// This ID is used to reference the gateway in API calls and configuration.
  final String? id;

  /// Payment gateway title on checkout
  ///
  /// The display name shown to customers during checkout. This should be
  /// user-friendly and clearly indicate the payment method.
  final String? title;

  /// Payment gateway description on checkout
  ///
  /// Additional information shown to customers about the payment method,
  /// such as security features or processing time.
  final String? description;

  /// Payment gateway sort order
  ///
  /// Determines the display order of payment methods on the checkout page.
  /// Lower numbers appear first in the list.
  final int? order;

  /// Payment gateway enabled status
  ///
  /// Controls whether the payment gateway is available to customers.
  /// When false, the gateway is hidden from checkout options.
  final bool? enabled;

  /// Payment gateway method title
  ///
  /// The title used in the payment method selection during checkout.
  /// This may differ from the main gateway title for branding purposes.
  final String? methodTitle;

  /// Payment gateway method description
  ///
  /// Detailed description of the payment method shown to customers
  /// during the checkout process.
  final String? methodDescription;

  /// Supported features
  ///
  /// List of features supported by this payment gateway:
  /// - 'products': Product-based payments
  /// - 'refunds': Refund processing capability
  /// - 'subscriptions': Subscription payment support
  /// - 'pre-orders': Pre-order payment handling
  /// - 'tokenization': Token-based payments
  final List<String>? methodSupports;

  /// Payment gateway settings
  ///
  /// Configuration settings for the payment gateway, including API keys,
  /// processing options, and other customizable parameters.
  final Map<String, WooPaymentGatewaySetting>? settings;

  /// Creates a new WooPaymentGateway instance
  ///
  /// This constructor creates a payment gateway with the specified properties.
  /// All parameters are optional, allowing for flexible gateway creation.
  ///
  /// ## Parameters
  ///
  /// * [id] - Unique identifier for the payment gateway
  /// * [title] - Display name shown to customers during checkout
  /// * [description] - Additional information about the payment method
  /// * [order] - Sort order for display on checkout page
  /// * [enabled] - Whether the gateway is available to customers
  /// * [methodTitle] - Title used in payment method selection
  /// * [methodDescription] - Detailed description for customers
  /// * [methodSupports] - List of supported features
  /// * [settings] - Configuration settings for the gateway
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic payment gateway
  /// final gateway = WooPaymentGateway(
  ///   id: 'custom_gateway',
  ///   title: 'Custom Payment',
  ///   description: 'Pay securely with our custom gateway',
  ///   enabled: true,
  /// );
  ///
  /// // Create a gateway with full configuration
  /// final paypal = WooPaymentGateway(
  ///   id: 'paypal',
  ///   title: 'PayPal',
  ///   description: 'Pay securely with PayPal',
  ///   enabled: true,
  ///   methodTitle: 'PayPal - Safe and Secure',
  ///   methodSupports: ['products', 'refunds'],
  ///   order: 1,
  /// );
  /// ```
  WooPaymentGateway({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
  });

  /// Creates a WooPaymentGateway instance from JSON data
  ///
  /// This factory constructor is used to deserialize payment gateway data received
  /// from the WooCommerce REST API. It handles the conversion of JSON fields
  /// to the appropriate Dart types and provides fallback values where needed.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the payment gateway data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooPaymentGateway` instance populated with data from the JSON.
  ///
  /// ## JSON Structure
  ///
  /// The expected JSON structure includes:
  /// ```json
  /// {
  ///   "id": "paypal",
  ///   "title": "PayPal",
  ///   "description": "Pay securely with PayPal",
  ///   "order": 1,
  ///   "enabled": true,
  ///   "method_title": "PayPal - Safe and Secure",
  ///   "method_description": "Pay with your PayPal account",
  ///   "method_supports": ["products", "refunds"],
  ///   "settings": {
  ///     "api_username": {"id": "api_username", "value": "your_api_username"},
  ///     "api_password": {"id": "api_password", "value": "your_api_password"}
  ///   }
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse payment gateway from API response
  /// final jsonData = {
  ///   'id': 'paypal',
  ///   'title': 'PayPal',
  ///   'enabled': true,
  ///   'method_supports': ['products', 'refunds']
  /// };
  ///
  /// final gateway = WooPaymentGateway.fromJson(jsonData);
  /// print('Gateway: ${gateway.title}');
  /// print('Enabled: ${gateway.enabled}');
  /// print('Supports: ${gateway.methodSupports}');
  /// ```
  factory WooPaymentGateway.fromJson(Map<String, dynamic> json) {
    final settings = json['settings'] as Map<String, dynamic>?;

    return WooPaymentGateway(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      order: json['order'],
      enabled: json['enabled'],
      methodTitle: json['method_title'],
      methodDescription: json['method_description'],
      methodSupports: json['method_supports'] != null
          ? List<String>.from(json['method_supports'])
          : null,
      settings: settings?.map((key, value) =>
          MapEntry(key, WooPaymentGatewaySetting.fromJson(value))),
    );
  }

  /// Converts the WooPaymentGateway instance to JSON format
  ///
  /// This method serializes the payment gateway data into a Map that can be sent
  /// to the WooCommerce REST API. It handles the conversion of Dart types
  /// to JSON-compatible formats and includes all necessary fields.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the payment gateway data in JSON format.
  ///
  /// ## JSON Structure
  ///
  /// The returned JSON structure includes:
  /// ```json
  /// {
  ///   "id": "paypal",
  ///   "title": "PayPal",
  ///   "description": "Pay securely with PayPal",
  ///   "order": 1,
  ///   "enabled": true,
  ///   "method_title": "PayPal - Safe and Secure",
  ///   "method_description": "Pay with your PayPal account",
  ///   "method_supports": ["products", "refunds"],
  ///   "settings": {
  ///     "api_username": {"id": "api_username", "value": "your_api_username"},
  ///     "api_password": {"id": "api_password", "value": "your_api_password"}
  ///   }
  /// }
  /// ```
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert payment gateway to JSON for API calls
  /// final gateway = WooPaymentGateway(
  ///   id: 'paypal',
  ///   title: 'PayPal',
  ///   enabled: true,
  /// );
  ///
  /// final jsonData = gateway.toJson();
  /// print('JSON: $jsonData');
  ///
  /// // Send to API
  /// await dio.put('/payment_gateways/paypal', data: gateway.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'order': order,
        'enabled': enabled,
        'method_title': methodTitle,
        'method_description': methodDescription,
        'method_supports': methodSupports,
        'settings':
            settings?.map((key, value) => MapEntry(key, value.toJson())),
      };

  /// Creates a fake WooPaymentGateway instance for testing purposes
  ///
  /// This factory constructor generates a payment gateway with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated payment gateway will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake payment gateway includes:
  /// - Random ID from word generator
  /// - Random title from word generator
  /// - Random description from sentence generator
  /// - Random order from integer generator
  /// - Random enabled status from boolean generator
  /// - Random method title from sentence generator
  /// - Random method description from sentence generator
  /// - Random list of supported features
  /// - Random settings map with multiple configuration options
  ///
  /// ## Returns
  ///
  /// A `WooPaymentGateway` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake payment gateway for testing
  /// final fakeGateway = WooPaymentGateway.fake();
  /// print('Fake gateway: ${fakeGateway.title}');
  /// print('ID: ${fakeGateway.id}');
  /// print('Enabled: ${fakeGateway.enabled}');
  ///
  /// // Use in tests
  /// test('payment gateway creation', () {
  ///   final gateway = WooPaymentGateway.fake();
  ///   expect(gateway.id, isNotNull);
  ///   expect(gateway.title, isNotNull);
  ///   expect(gateway.enabled, isA<bool>());
  /// });
  /// ```
  factory WooPaymentGateway.fake() => WooPaymentGateway(
        id: FakeHelper.word(),
        title: FakeHelper.word(),
        description: FakeHelper.sentence(),
        order: FakeHelper.integer(),
        enabled: FakeHelper.boolean(),
        methodTitle: FakeHelper.sentence(),
        methodDescription: FakeHelper.sentence(),
        methodSupports: FakeHelper.list(() => FakeHelper.word()),
        settings: {
          for (var i = 0; i < FakeHelper.integer(max: 2); i++)
            FakeHelper.word(): WooPaymentGatewaySetting.fake(),
        },
      );
}
