import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Shipping Zone Model
///
/// Represents a shipping zone in WooCommerce that defines geographical areas
/// where specific shipping methods and rates apply. Shipping zones enable
/// flexible shipping configurations for different regions and customer locations.
///
/// ## Shipping Zone Structure
///
/// A shipping zone consists of key components:
///
/// - **Identification**: Unique ID and human-readable name
/// - **Priority Order**: Order in which zones are evaluated
/// - **Geographical Coverage**: Countries, states, or postcodes
/// - **Shipping Methods**: Available shipping options for the zone
///
/// ## Zone Evaluation Order
///
/// Shipping zones are evaluated in order of their `order` field (ascending).
/// The first zone that matches a customer's location will be used for shipping
/// calculations. This allows for priority-based shipping configuration.
///
/// ## Example Usage
///
/// ```dart
/// // Create a new shipping zone
/// final zone = WooShippingZone(
///   name: 'North America',
///   order: 1,
/// );
///
/// // Create from API response
/// final zone = WooShippingZone.fromJson({
///   'id': 1,
///   'name': 'North America',
///   'order': 1
/// });
///
/// // Access properties
/// print('Zone: ${zone.name} (Order: ${zone.order})');
///
/// // Convert to JSON
/// final json = zone.toJson();
/// ```
class WooShippingZone {
  /// Unique identifier for the shipping zone
  ///
  /// This ID is automatically assigned by WooCommerce when the zone is created.
  /// It's used to identify the zone in API calls and is required for updates and deletions.
  final int? id;

  /// Human-readable name for the shipping zone
  ///
  /// This name helps you identify the shipping zone in the WooCommerce admin panel
  /// and in your application. It should be descriptive of the geographical area
  /// or customer segment the zone serves.
  final String? name;

  /// Priority order for zone evaluation
  ///
  /// Controls the order in which shipping zones are evaluated. Lower numbers
  /// are evaluated first. This allows you to create priority-based shipping
  /// configurations where more specific zones are checked before general ones.
  final int? order;

  /// Creates a new WooShippingZone instance
  ///
  /// ## Required Parameters
  ///
  /// * [name] - Human-readable name for the shipping zone
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier (assigned by WooCommerce)
  /// * [order] - Priority order for zone evaluation (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a basic shipping zone
  /// final zone = WooShippingZone(
  ///   name: 'North America',
  /// );
  ///
  /// // Create a shipping zone with order
  /// final priorityZone = WooShippingZone(
  ///   name: 'Local Area',
  ///   order: 1,
  /// );
  /// ```
  WooShippingZone({
    this.id,
    required this.name,
    this.order,
  });

  /// Creates a WooShippingZone from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooShippingZone object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing shipping zone data from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooShippingZone` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'id': 1,
  ///   'name': 'North America',
  ///   'order': 1
  /// };
  /// final zone = WooShippingZone.fromJson(jsonData);
  /// ```
  factory WooShippingZone.fromJson(Map<String, dynamic> json) =>
      WooShippingZone(
        id: json['id'],
        name: json['name'],
        order: json['order'],
      );

  /// Converts the shipping zone to JSON format
  ///
  /// This method serializes the WooShippingZone object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the shipping zone data in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON
  /// final jsonData = zone.toJson();
  /// print(jsonData); // {'id': 1, 'name': 'North America', 'order': 1}
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'order': order,
      };

  /// Creates a fake shipping zone for testing and development
  ///
  /// This factory constructor generates a WooShippingZone instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes.
  ///
  /// ## Returns
  ///
  /// A `WooShippingZone` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake shipping zone for testing
  /// final fakeZone = WooShippingZone.fake();
  /// print('Fake zone: ${fakeZone.name}');
  /// ```
  factory WooShippingZone.fake() => WooShippingZone(
        id: FakeHelper.integer(),
        name: FakeHelper.sentence(),
        order: FakeHelper.integer(),
      );
}
