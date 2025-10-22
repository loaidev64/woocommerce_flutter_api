import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// WooCommerce Currency Model
///
/// Represents a currency in WooCommerce with its code, name, and symbol.
/// Used for international e-commerce operations and multi-currency support.
///
/// ## Currency Structure
///
/// A currency consists of key components:
///
/// - **Code**: ISO 4217 currency code (e.g., 'USD', 'EUR', 'GBP')
/// - **Name**: Human-readable currency name (e.g., 'US Dollar', 'Euro')
/// - **Symbol**: Currency symbol for display (e.g., '$', '€', '£')
///
/// ## Common Currencies
///
/// - **USD**: US Dollar ($)
/// - **EUR**: Euro (€)
/// - **GBP**: British Pound (£)
/// - **JPY**: Japanese Yen (¥)
/// - **CAD**: Canadian Dollar (C$)
///
/// ## Example Usage
///
/// ```dart
/// // Create from API response
/// final currency = WooCurrency.fromJson({
///   'code': 'USD',
///   'name': 'US Dollar',
///   'symbol': '\$'
/// });
///
/// // Access properties
/// print('${currency.name} (${currency.code}): ${currency.symbol}');
///
/// // Convert to JSON
/// final json = currency.toJson();
/// ```
class WooCurrency {

  /// Creates a new WooCurrency instance
  ///
  /// ## Parameters
  ///
  /// * [code] - ISO 4217 currency code (optional)
  /// * [name] - Human-readable currency name (optional)
  /// * [symbol] - Currency symbol for display (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a currency
  /// final currency = WooCurrency(
  ///   code: 'USD',
  ///   name: 'US Dollar',
  ///   symbol: '\$',
  /// );
  /// ```
  WooCurrency({this.code, this.name, this.symbol});

  /// Creates a WooCurrency from JSON data
  ///
  /// This factory constructor parses JSON data received from the WooCommerce
  /// REST API and creates a corresponding WooCurrency object.
  ///
  /// ## Parameters
  ///
  /// * [json] - Map containing currency information from WooCommerce API
  ///
  /// ## Returns
  ///
  /// A `WooCurrency` instance with data from the JSON input
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Parse API response
  /// final jsonData = {
  ///   'code': 'USD',
  ///   'name': 'US Dollar',
  ///   'symbol': '\$'
  /// };
  /// final currency = WooCurrency.fromJson(jsonData);
  /// ```
  factory WooCurrency.fromJson(Map<String, dynamic> json) => WooCurrency(
        code: json['code'],
        name: json['name'],
        symbol: json['symbol'],
      );

  /// Creates a fake currency for testing and development
  ///
  /// This factory constructor generates a WooCurrency instance with
  /// fake data using the FakeHelper utility. It's particularly useful for
  /// testing, development, and demonstration purposes.
  ///
  /// ## Returns
  ///
  /// A `WooCurrency` instance with generated fake data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate fake currency for testing
  /// final fakeCurrency = WooCurrency.fake();
  /// print('Fake currency: ${fakeCurrency.name} (${fakeCurrency.code})');
  /// ```
  factory WooCurrency.fake() => WooCurrency(
        code: FakeHelper.currencyCode(),
        name: FakeHelper.word(),
        symbol: '\$',
      );
  /// ISO 4217 currency code
  ///
  /// The three-letter currency code as defined by ISO 4217 standard.
  /// Examples include 'USD' for US Dollar, 'EUR' for Euro, 'GBP' for British Pound.
  final String? code;

  /// Human-readable currency name
  ///
  /// The full name of the currency, such as 'US Dollar', 'Euro', or 'British Pound'.
  /// This is typically used in user interfaces and documentation.
  final String? name;

  /// Currency symbol for display
  ///
  /// The symbol used to represent the currency in prices and monetary displays.
  /// Examples include '$' for US Dollar, '€' for Euro, '£' for British Pound.
  final String? symbol;

  /// Converts the currency to JSON format
  ///
  /// This method serializes the WooCurrency object into a JSON-compatible
  /// map that can be sent to the WooCommerce API or stored in a database.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the currency information in JSON format
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Convert to JSON
  /// final jsonData = currency.toJson();
  /// print(jsonData); // {'code': 'USD', 'name': 'US Dollar', 'symbol': '\$'}
  /// ```
  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'symbol': symbol,
      };
}
