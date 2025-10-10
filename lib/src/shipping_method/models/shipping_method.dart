import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Shipping Method Model
///
/// Represents a shipping method configuration in WooCommerce. Shipping methods define
/// how products are delivered to customers, including delivery options, costs, and
/// availability rules for e-commerce applications.
///
/// ## Shipping Method Structure
///
/// A shipping method consists of several key components:
///
/// - **Identification**: Unique ID and human-readable title
/// - **Display Information**: Title and description for customer display
/// - **Configuration**: Method-specific settings and rules
/// - **Availability**: Rules determining when the method is available
///
/// ## Shipping Method Types
///
/// 1. **Flat Rate**: Fixed cost shipping regardless of weight or distance
/// 2. **Free Shipping**: No cost shipping (usually with minimum order requirements)
/// 3. **Local Pickup**: Customer picks up items from physical location
/// 4. **Custom Methods**: Third-party shipping integrations and custom solutions
///
/// ## Example Usage
///
/// ```dart
/// // Create a new shipping method
/// final method = WooShippingMethod(
///   id: 'flat_rate',
///   title: 'Flat Rate Shipping',
///   description: 'Fixed rate shipping for all orders',
/// );
///
/// // Create from API response
/// final method = WooShippingMethod.fromJson({
///   'id': 'flat_rate',
///   'title': 'Flat Rate Shipping',
///   'description': 'Fixed rate shipping'
/// });
///
/// // Access properties
/// print('${method.title}: ${method.description}');
///
/// // Convert to JSON
/// final json = method.toJson();
/// ```
class WooShippingMethod {
  /// Unique identifier for the shipping method
  ///
  /// This identifier is used by WooCommerce to distinguish between different
  /// shipping methods. Common values include 'flat_rate', 'free_shipping',
  /// 'local_pickup', and custom method identifiers.
  final String? id;

  /// Display title for the shipping method
  ///
  /// The human-readable name that customers see during checkout.
  /// This title is typically configured in the WooCommerce admin panel
  /// and can be customized for different languages or regions.
  final String? title;

  /// Description of the shipping method
  ///
  /// Provides additional information about the shipping method, such as
  /// delivery timeframes, special conditions, or service details. This
  /// description helps customers understand what to expect from their
  /// shipping selection.
  final String? description;

  /// Creates a new WooShippingMethod instance
  ///
  /// All parameters are optional and can be null. This constructor is typically
  /// used when creating shipping method objects from API responses or when
  /// building shipping method configurations programmatically.
  ///
  /// ## Parameters
  ///
  /// * [id] - Unique identifier for the shipping method (optional)
  /// * [title] - Display title for the shipping method (optional)
  /// * [description] - Detailed description of the shipping method (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a shipping method with all properties
  /// final method = WooShippingMethod(
  ///   id: 'express_shipping',
  ///   title: 'Express Delivery',
  ///   description: 'Next-day delivery service',
  /// );
  ///
  /// // Create a minimal shipping method
  /// final basicMethod = WooShippingMethod(
  ///   id: 'standard',
  ///   title: 'Standard Shipping',
  /// );
  /// ```
  WooShippingMethod({
    this.id,
    this.title,
    this.description,
  });

  /// Creates a WooShippingMethod instance from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooShippingMethod object. It handles
  /// the conversion of API response data into a structured Dart object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing shipping method data from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooShippingMethod` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'id': 'flat_rate',
  ///   'title': 'Flat Rate Shipping',
  ///   'description': 'Fixed rate shipping for all orders'
  /// };
  /// final method = WooShippingMethod.fromJson(jsonData);
  /// ```
  factory WooShippingMethod.fromJson(Map<String, dynamic> json) =>
      WooShippingMethod(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );

  /// Converts the shipping method to JSON format
  ///
  /// This method serializes the WooShippingMethod object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  /// It includes all non-null properties in the resulting JSON structure.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the shipping method data in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON for API requests
  /// final jsonData = method.toJson();
  /// print(jsonData); // {'id': 'flat_rate', 'title': 'Flat Rate', 'description': 'Fixed rate'}
  ///
  /// // Send to API
  /// await dio.post('/shipping_methods', data: method.toJson());
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };

  /// Creates a fake shipping method for testing and development
  ///
  /// This factory constructor generates a WooShippingMethod instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes when real API data
  /// is not available or needed.
  ///
  /// ## Returns
  ///
  /// A `WooShippingMethod` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake shipping method for testing
  /// final fakeMethod = WooShippingMethod.fake();
  /// print(fakeMethod.title); // Random generated title
  ///
  /// // Use in development
  /// final testMethods = List.generate(3, (_) => WooShippingMethod.fake());
  /// ```
  factory WooShippingMethod.fake() => WooShippingMethod(
        id: FakeHelper.word(),
        title: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
      );
}
