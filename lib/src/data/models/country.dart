import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Country Model
///
/// Represents a country in WooCommerce with its code, name, and associated states/provinces.
/// Used for geographical data management and international e-commerce operations.
///
/// ## Country Structure
///
/// A country consists of key components:
///
/// - **Code**: ISO 3166-1 alpha-2 country code (e.g., 'US', 'CA', 'GB')
/// - **Name**: Human-readable country name (e.g., 'United States', 'Canada')
/// - **States**: List of states/provinces within the country
///
/// ## Common Countries
///
/// - **US**: United States (50 states)
/// - **CA**: Canada (13 provinces/territories)
/// - **GB**: United Kingdom (4 countries)
/// - **AU**: Australia (8 states/territories)
/// - **DE**: Germany (16 states)
///
/// ## Example Usage
///
/// ```dart
/// // Create from API response
/// final country = WooCountry.fromJson({
///   'code': 'US',
///   'name': 'United States',
///   'states': [...]
/// });
///
/// // Access properties
/// print('${country.name} (${country.code}): ${country.states?.length} states');
///
/// // Convert to JSON
/// final json = country.toJson();
/// ```
class WooCountry {

  /// Creates a new WooCountry instance
  ///
  /// ## Parameters
  ///
  /// * [code] - ISO 3166-1 alpha-2 country code (optional)
  /// * [name] - Human-readable country name (optional)
  /// * [states] - List of states/provinces within the country (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a country
  /// final country = WooCountry(
  ///   code: 'US',
  ///   name: 'United States',
  ///   states: [StateInCountry(code: 'CA', name: 'California')],
  /// );
  /// ```
  WooCountry({this.code, this.name, this.states});

  /// Creates a WooCountry from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooCountry object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing country information from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooCountry` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'code': 'US',
  ///   'name': 'United States',
  ///   'states': [{'code': 'CA', 'name': 'California'}]
  /// };
  /// final country = WooCountry.fromJson(jsonData);
  /// ```
  factory WooCountry.fromJson(Map<String, dynamic> json) => WooCountry(
        code: json['code'],
        name: json['name'],
        states: json['states'] != null
            ? (json['states'] as List)
                .map((e) => StateInCountry.fromJson(e))
                .toList()
            : null,
      );

  /// Creates a fake country for testing and development
  ///
  /// This factory constructor generates a WooCountry instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes.
  ///
  /// ## Returns
  ///
  /// A `WooCountry` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake country for testing
  /// final fakeCountry = WooCountry.fake();
  /// print('Fake country: ${fakeCountry.name} (${fakeCountry.code})');
  /// ```
  factory WooCountry.fake() => WooCountry(
        code: FakeHelper.countryCode(),
        name: FakeHelper.country(),
        states: FakeHelper.list(() => StateInCountry.fake()),
      );
  /// ISO 3166-1 alpha-2 country code
  ///
  /// The two-letter country code as defined by ISO 3166-1 standard.
  /// Examples include 'US' for United States, 'CA' for Canada, 'GB' for United Kingdom.
  final String? code;

  /// Human-readable country name
  ///
  /// The full name of the country, such as 'United States', 'Canada', or 'United Kingdom'.
  /// This is typically used in user interfaces and documentation.
  final String? name;

  /// List of states/provinces within the country
  ///
  /// Contains all states, provinces, or administrative divisions within the country.
  /// Each state includes its code and name for geographical reference.
  final List<StateInCountry>? states;

  /// Converts the country to JSON format
  ///
  /// This method serializes the WooCountry object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the country information in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON
  /// final jsonData = country.toJson();
  /// print(jsonData); // {'code': 'US', 'name': 'United States', 'states': [...]}
  /// ```
  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'states': states?.map((e) => e.toJson()).toList(),
      };
}
