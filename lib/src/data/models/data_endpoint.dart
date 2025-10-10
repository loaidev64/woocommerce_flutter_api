import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Data Endpoint Model
///
/// Represents a data endpoint in WooCommerce that provides access to specific
/// reference data such as geographical information, currencies, and other
/// system data essential for e-commerce operations.
///
/// ## Data Endpoint Structure
///
/// A data endpoint consists of key components:
///
/// - **Identification**: Unique slug identifier for the endpoint
/// - **Description**: Human-readable description of the endpoint's purpose
/// - **Data Access**: Provides access to specific reference data
///
/// ## Common Data Endpoints
///
/// - **continents**: Geographic continent information
/// - **countries**: Country details with states/provinces
/// - **currencies**: Currency codes, names, and symbols
/// - **system_status**: Store system information and status
///
/// ## Example Usage
///
/// ```dart
/// // Create from API response
/// final endpoint = WooDataEndpoint.fromJson({
///   'slug': 'continents',
///   'description': 'List of continents and their countries'
/// });
///
/// // Access properties
/// print('Endpoint: ${endpoint.slug}');
/// print('Description: ${endpoint.description}');
///
/// // Convert to JSON
/// final json = endpoint.toJson();
/// ```
class WooDataEndpoint {
  /// Unique slug identifier for the data endpoint
  ///
  /// This identifier is used to access specific data endpoints in the WooCommerce API.
  /// Common values include 'continents', 'countries', 'currencies', and 'system_status'.
  final String? slug;

  /// Human-readable description of the data endpoint
  ///
  /// Provides a description of what data is available through this endpoint
  /// and how it can be used in e-commerce applications.
  final String? description;

  /// Creates a new WooDataEndpoint instance
  ///
  /// ## Parameters
  ///
  /// * [slug] - Unique slug identifier for the data endpoint (optional)
  /// * [description] - Human-readable description of the endpoint (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a data endpoint
  /// final endpoint = WooDataEndpoint(
  ///   slug: 'continents',
  ///   description: 'List of continents and their countries',
  /// );
  /// ```
  WooDataEndpoint({this.slug, this.description});

  /// Creates a WooDataEndpoint from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooDataEndpoint object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing data endpoint information from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooDataEndpoint` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'slug': 'continents',
  ///   'description': 'List of continents and their countries'
  /// };
  /// final endpoint = WooDataEndpoint.fromJson(jsonData);
  /// ```
  factory WooDataEndpoint.fromJson(Map<String, dynamic> json) =>
      WooDataEndpoint(
        slug: json['slug'],
        description: json['description'],
      );

  /// Converts the data endpoint to JSON format
  ///
  /// This method serializes the WooDataEndpoint object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the data endpoint information in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON
  /// final jsonData = endpoint.toJson();
  /// print(jsonData); // {'slug': 'continents', 'description': 'List of continents'}
  /// ```
  Map<String, dynamic> toJson() => {
        'slug': slug,
        'description': description,
      };

  /// Creates a fake data endpoint for testing and development
  ///
  /// This factory constructor generates a WooDataEndpoint instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes.
  ///
  /// ## Returns
  ///
  /// A `WooDataEndpoint` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake data endpoint for testing
  /// final fakeEndpoint = WooDataEndpoint.fake();
  /// print('Fake endpoint: ${fakeEndpoint.slug}');
  /// ```
  factory WooDataEndpoint.fake() => WooDataEndpoint(
        slug: FakeHelper.word(),
        description: FakeHelper.sentence(),
      );
}
