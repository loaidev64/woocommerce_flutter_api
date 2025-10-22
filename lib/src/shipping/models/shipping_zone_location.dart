import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Shipping Zone Location Model
///
/// Represents a geographical location within a shipping zone that determines
/// which customers are eligible for the shipping methods and rates defined
/// within that zone based on their location.
///
/// ## Shipping Zone Location Structure
///
/// A shipping zone location consists of key components:
///
/// - **Location Code**: The specific geographical identifier
/// - **Location Type**: The type of geographical area (country, state, postcode, continent)
/// - **Coverage Definition**: Determines which customers are covered by the zone
///
/// ## Location Types
///
/// - **Country**: Entire countries (e.g., 'US', 'CA', 'GB')
/// - **State**: Specific states/provinces within countries
/// - **Postcode**: Specific postal codes or postal code ranges
/// - **Continent**: Entire continents (e.g., 'NA', 'EU', 'AS')
///
/// ## Example Usage
///
/// ```dart
/// // Create a country location
/// final location = WooShippingZoneLocation(
///   code: 'US',
///   type: 'country',
/// );
///
/// // Create from API response
/// final location = WooShippingZoneLocation.fromJson({
///   'code': 'US',
///   'type': 'country'
/// });
///
/// // Access properties
/// print('${location.type}: ${location.code}');
///
/// // Convert to JSON
/// final json = location.toJson();
/// ```
class WooShippingZoneLocation {
  /// Geographical location code
  ///
  /// The specific identifier for the geographical area. The format depends on
  /// the location type:
  /// - Country: ISO 3166-1 alpha-2 country codes (e.g., 'US', 'CA')
  /// - State: State/province codes (e.g., 'CA', 'NY')
  /// - Postcode: Postal codes or ranges (e.g., '90210', '10000-20000')
  /// - Continent: Continent codes (e.g., 'NA', 'EU')
  final String? code;

  /// Type of geographical location
  ///
  /// Specifies the type of geographical area this location represents.
  /// Common values include 'country', 'state', 'postcode', and 'continent'.
  final String? type;

  /// Creates a new WooShippingZoneLocation instance
  ///
  /// ## Parameters
  ///
  /// * [code] - Geographical location code (optional)
  /// * [type] - Type of geographical location (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a country location
  /// final location = WooShippingZoneLocation(
  ///   code: 'US',
  ///   type: 'country',
  /// );
  ///
  /// // Create a state location
  /// final stateLocation = WooShippingZoneLocation(
  ///   code: 'CA',
  ///   type: 'state',
  /// );
  /// ```
  WooShippingZoneLocation({
    this.code,
    this.type,
  });

  /// Creates a WooShippingZoneLocation from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooShippingZoneLocation object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing location data from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooShippingZoneLocation` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'code': 'US',
  ///   'type': 'country'
  /// };
  /// final location = WooShippingZoneLocation.fromJson(jsonData);
  /// ```
  factory WooShippingZoneLocation.fromJson(Map<String, dynamic> json) =>
      WooShippingZoneLocation(
        code: json['code'],
        type: json['type'],
      );

  /// Converts the location to JSON format
  ///
  /// This method serializes the WooShippingZoneLocation object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the location data in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON
  /// final jsonData = location.toJson();
  /// print(jsonData); // {'code': 'US', 'type': 'country'}
  /// ```
  Map<String, dynamic> toJson() => {
        'code': code,
        'type': type,
      };

  /// Creates a fake shipping zone location for testing and development
  ///
  /// This factory constructor generates a WooShippingZoneLocation instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes.
  ///
  /// ## Returns
  ///
  /// A `WooShippingZoneLocation` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake location for testing
  /// final fakeLocation = WooShippingZoneLocation.fake();
  /// print('Fake location: ${fakeLocation.type} - ${fakeLocation.code}');
  /// ```
  factory WooShippingZoneLocation.fake() => WooShippingZoneLocation(
        code: FakeHelper.word(),
        type: FakeHelper.randomItem(
            const ['postcode', 'state', 'country', 'continent']),
      );
}
