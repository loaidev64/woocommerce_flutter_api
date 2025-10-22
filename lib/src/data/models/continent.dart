import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Continent Model
///
/// Represents a continent in WooCommerce with its code, name, and associated countries.
/// Used for geographical data management and international e-commerce operations.
///
/// ## Continent Structure
///
/// A continent consists of key components:
///
/// - **Code**: Continent code (e.g., 'NA', 'EU', 'AS')
/// - **Name**: Human-readable continent name (e.g., 'North America', 'Europe')
/// - **Countries**: List of countries within the continent
///
/// ## Common Continents
///
/// - **NA**: North America
/// - **SA**: South America
/// - **EU**: Europe
/// - **AS**: Asia
/// - **AF**: Africa
/// - **OC**: Oceania
/// - **AN**: Antarctica
///
/// ## Example Usage
///
/// ```dart
/// // Create from API response
/// final continent = WooContinent.fromJson({
///   'code': 'NA',
///   'name': 'North America',
///   'countries': [...]
/// });
///
/// // Access properties
/// print('${continent.name} (${continent.code}): ${continent.countries?.length} countries');
///
/// // Convert to JSON
/// final json = continent.toJson();
/// ```
class WooContinent {

  /// Creates a new WooContinent instance
  ///
  /// ## Parameters
  ///
  /// * [code] - Continent code (optional)
  /// * [name] - Human-readable continent name (optional)
  /// * [countries] - List of countries within the continent (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a continent
  /// final continent = WooContinent(
  ///   code: 'NA',
  ///   name: 'North America',
  ///   countries: [CountryInContinent(code: 'US', name: 'United States')],
  /// );
  /// ```
  WooContinent({this.code, this.name, this.countries});

  /// Creates a WooContinent from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooContinent object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing continent information from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooContinent` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'code': 'NA',
  ///   'name': 'North America',
  ///   'countries': [{'code': 'US', 'name': 'United States'}]
  /// };
  /// final continent = WooContinent.fromJson(jsonData);
  /// ```
  factory WooContinent.fromJson(Map<String, dynamic> json) => WooContinent(
        code: json['code'],
        name: json['name'],
        countries: json['countries'] != null
            ? (json['countries'] as List)
                .map((e) => CountryInContinent.fromJson(e))
                .toList()
            : null,
      );

  /// Creates a fake continent for testing and development
  ///
  /// This factory constructor generates a WooContinent instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes.
  ///
  /// ## Returns
  ///
  /// A `WooContinent` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake continent for testing
  /// final fakeContinent = WooContinent.fake();
  /// print('Fake continent: ${fakeContinent.name} (${fakeContinent.code})');
  /// ```
  factory WooContinent.fake() => WooContinent(
        code: FakeHelper.countryCode(),
        name: FakeHelper.country(),
        countries: FakeHelper.list(() => CountryInContinent.fake()),
      );
  /// Continent code
  ///
  /// The two-letter continent code used for geographical reference.
  /// Examples include 'NA' for North America, 'EU' for Europe, 'AS' for Asia.
  final String? code;

  /// Human-readable continent name
  ///
  /// The full name of the continent, such as 'North America', 'Europe', or 'Asia'.
  /// This is typically used in user interfaces and documentation.
  final String? name;

  /// List of countries within the continent
  ///
  /// Contains all countries within the continent with their associated
  /// geographical and currency information.
  final List<CountryInContinent>? countries;

  /// Converts the continent to JSON format
  ///
  /// This method serializes the WooContinent object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the continent information in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON
  /// final jsonData = continent.toJson();
  /// print(jsonData); // {'code': 'NA', 'name': 'North America', 'countries': [...]}
  /// ```
  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'countries': countries?.map((e) => e.toJson()).toList(),
      };
}

class CountryInContinent {

  CountryInContinent({
    this.code,
    this.currencyCode,
    this.currencyPos,
    this.decimalSep,
    this.dimensionUnit,
    this.name,
    this.numDecimals,
    this.states,
    this.thousandSep,
    this.weightUnit,
  });

  factory CountryInContinent.fromJson(Map<String, dynamic> json) =>
      CountryInContinent(
        code: json['code'],
        currencyCode: json['currency_code'],
        currencyPos: json['currency_pos'],
        decimalSep: json['decimal_sep'],
        dimensionUnit: json['dimension_unit'],
        name: json['name'],
        numDecimals: json['num_decimals'],
        states: json['states'] != null
            ? (json['states'] as List)
                .map((e) => StateInCountry.fromJson(e))
                .toList()
            : null,
        thousandSep: json['thousand_sep'],
        weightUnit: json['weight_unit'],
      );

  factory CountryInContinent.fake() => CountryInContinent(
        code: FakeHelper.countryCode(),
        currencyCode: FakeHelper.currencyCode(),
        currencyPos: FakeHelper.word(),
        decimalSep: FakeHelper.word(),
        dimensionUnit: FakeHelper.word(),
        name: FakeHelper.country(),
        numDecimals: FakeHelper.integer(max: 3),
        states: FakeHelper.list(() => StateInCountry.fake()),
        thousandSep: FakeHelper.word(),
        weightUnit: FakeHelper.word(),
      );
  final String? code;
  final String? currencyCode;
  final String? currencyPos;
  final String? decimalSep;
  final String? dimensionUnit;
  final String? name;
  final int? numDecimals;
  final List<StateInCountry>? states;
  final String? thousandSep;
  final String? weightUnit;

  /// Converts the country to JSON format
  Map<String, dynamic> toJson() => {
        'code': code,
        'currency_code': currencyCode,
        'currency_pos': currencyPos,
        'decimal_sep': decimalSep,
        'dimension_unit': dimensionUnit,
        'name': name,
        'num_decimals': numDecimals,
        'states': states?.map((e) => e.toJson()).toList(),
        'thousand_sep': thousandSep,
        'weight_unit': weightUnit,
      };
}

class StateInCountry {

  StateInCountry({this.code, this.name});

  factory StateInCountry.fromJson(Map<String, dynamic> json) => StateInCountry(
        code: json['code'],
        name: json['name'],
      );

  factory StateInCountry.fake() => StateInCountry(
        code: FakeHelper.word(),
        name: FakeHelper.state(),
      );
  final String? code;
  final String? name;

  /// Converts the state to JSON format
  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}
