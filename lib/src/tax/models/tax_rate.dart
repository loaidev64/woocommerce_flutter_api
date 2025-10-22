import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Tax Rate Model
///
/// Represents a tax rate configuration in WooCommerce with comprehensive
/// geographical and tax calculation settings. This model provides detailed
/// tax rate information including location-based rules, compound tax settings,
/// and priority management for complex tax scenarios.
///
/// ## Key Features
///
/// - **Geographical Targeting**: Country, state, city, and postal code targeting
/// - **Flexible Location Rules**: Support for both legacy and modern location formats
/// - **Compound Tax Support**: Handle complex tax calculations with compound rates
/// - **Priority Management**: Control tax rate application order
/// - **Shipping Integration**: Apply taxes to shipping costs
/// - **Tax Class Association**: Link rates to specific tax classes
///
/// ## Usage Examples
///
/// ### Creating a Tax Rate
///
/// ```dart
/// final taxRate = WooTaxRate(
///   country: 'US',
///   state: 'CA',
///   rate: '8.25',
///   name: 'California Sales Tax',
///   priority: 1,
/// );
/// ```
///
/// ### Working with Tax Rate Data
///
/// ```dart
/// // Check tax rate configuration
/// if (taxRate.compound == true) {
///   print('This is a compound tax rate');
/// }
///
/// // Access geographical targeting
/// if (taxRate.country == 'US' && taxRate.state == 'CA') {
///   print('California tax rate: ${taxRate.rate}%');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = taxRate.toJson();
///
/// // Create from JSON response
/// final taxRate = WooTaxRate.fromJson(jsonData);
/// ```
class WooTaxRate {

  /// Creates a new WooTaxRate instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the tax rate (read-only)
  /// * [country] - Country ISO 3166 code for geographical targeting
  /// * [state] - State code for geographical targeting
  /// * [postcode] - Single postal code (deprecated, use postcodes instead)
  /// * [city] - Single city name (deprecated, use cities instead)
  /// * [postcodes] - List of postal codes for geographical targeting
  /// * [cities] - List of city names for geographical targeting
  /// * [rate] - Tax rate as a decimal string (e.g., '8.25')
  /// * [name] - Descriptive name for the tax rate
  /// * [priority] - Priority for tax rate application (default: 1)
  /// * [compound] - Whether this is a compound tax rate (default: false)
  /// * [shipping] - Whether to apply to shipping costs (default: true)
  /// * [order] - Display order in admin interfaces
  /// * [taxClass] - Tax class this rate applies to (default: 'standard')
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final taxRate = WooTaxRate(
  ///   country: 'US',
  ///   state: 'CA',
  ///   rate: '8.25',
  ///   name: 'California Sales Tax',
  ///   priority: 1,
  /// );
  /// ```
  WooTaxRate({
    this.id,
    this.country,
    this.state,
    this.postcode,
    this.city,
    this.postcodes,
    this.cities,
    this.rate,
    this.name,
    this.priority = 1,
    this.compound = false,
    this.shipping = true,
    this.order,
    this.taxClass = 'standard',
  });

  /// Creates a WooTaxRate instance from JSON data
  ///
  /// This factory constructor is used to deserialize tax rate data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the tax rate data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooTaxRate` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final taxRate = WooTaxRate.fromJson(jsonData);
  /// ```
  WooTaxRate.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        country = json['country'],
        state = json['state'],
        postcode = json['postcode'],
        city = json['city'],
        postcodes = json['postcodes'] != null
            ? List<String>.from(json['postcodes'])
            : null,
        cities =
            json['cities'] != null ? List<String>.from(json['cities']) : null,
        rate = json['rate'],
        name = json['name'],
        priority = json['priority'],
        compound = json['compound'],
        shipping = json['shipping'],
        order = json['order'],
        taxClass = json['class'];

  /// Creates a fake WooTaxRate instance for testing purposes
  ///
  /// This factory constructor generates a tax rate with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Parameters
  ///
  /// * [id] - Optional specific ID to use for the fake tax rate
  ///
  /// ## Returns
  ///
  /// A `WooTaxRate` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeTaxRate = WooTaxRate.fake();
  /// final fakeTaxRateWithId = WooTaxRate.fake(123);
  /// ```
  factory WooTaxRate.fake([int? id]) => WooTaxRate(
        id: id ?? FakeHelper.integer(),
        country: FakeHelper.countryCode(),
        state: FakeHelper.state(),
        postcode: FakeHelper.zipCode(),
        city: FakeHelper.city(),
        postcodes: FakeHelper.list(FakeHelper.zipCode),
        cities: FakeHelper.list(FakeHelper.city),
        rate: FakeHelper.decimal().toString(),
        name: FakeHelper.word(),
        priority: FakeHelper.integer(min: 1, max: 10),
        compound: FakeHelper.boolean(),
        shipping: FakeHelper.boolean(),
        order: FakeHelper.integer(),
        taxClass: FakeHelper.word(),
      );
  /// Unique identifier for the resource. Read-only.
  ///
  /// The system-generated ID for this tax rate. This field is read-only
  /// and assigned by WooCommerce when the tax rate is created.
  int? id;

  /// Country ISO 3166 code.
  ///
  /// The two-letter country code (ISO 3166-1 alpha-2) that this tax rate
  /// applies to. Use 'XX' for all countries.
  String? country;

  /// State code.
  ///
  /// The state or province code that this tax rate applies to.
  /// Leave empty to apply to all states in the country.
  String? state;

  /// Postcode/ZIP. Deprecated as of WooCommerce 5.3.
  ///
  /// Single postal code that this tax rate applies to.
  /// This field is deprecated in favor of the [postcodes] list.
  String? postcode;

  /// City name. Deprecated as of WooCommerce 5.3.
  ///
  /// Single city name that this tax rate applies to.
  /// This field is deprecated in favor of the [cities] list.
  String? city;

  /// Postcodes/ZIPs. Introduced in WooCommerce 5.3.
  ///
  /// List of postal codes that this tax rate applies to.
  /// This replaces the deprecated [postcode] field for better flexibility.
  List<String>? postcodes;

  /// City names. Introduced in WooCommerce 5.3.
  ///
  /// List of city names that this tax rate applies to.
  /// This replaces the deprecated [city] field for better flexibility.
  List<String>? cities;

  /// Tax rate.
  ///
  /// The tax rate as a decimal number (e.g., '8.25' for 8.25%).
  /// This is the percentage rate that will be applied to applicable items.
  String? rate;

  /// Tax rate name.
  ///
  /// A descriptive name for this tax rate (e.g., 'California Sales Tax').
  /// This helps identify the tax rate in the admin interface.
  String? name;

  /// Tax priority. Default is 1.
  ///
  /// The priority of this tax rate when multiple rates could apply.
  /// Lower numbers have higher priority. Default is 1.
  int? priority;

  /// Whether or not this is a compound tax rate. Default is false.
  ///
  /// When true, this tax rate is calculated on top of other tax rates.
  /// Compound taxes are applied after non-compound taxes.
  bool? compound;

  /// Whether or not this tax rate also gets applied to shipping. Default is true.
  ///
  /// When true, this tax rate will be applied to shipping costs.
  /// When false, shipping will be exempt from this tax rate.
  bool? shipping;

  /// Indicates the order that will appear in queries.
  ///
  /// The display order for this tax rate in admin interfaces.
  /// Lower numbers appear first.
  int? order;

  /// Tax class. Default is standard.
  ///
  /// The tax class this rate applies to. Common values include
  /// 'standard', 'reduced-rate', 'zero-rate', and custom tax classes.
  String? taxClass;

  /// Converts the WooTaxRate instance to JSON format
  ///
  /// This method serializes the tax rate data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the tax rate data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = taxRate.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'state': state,
        'postcode': postcode,
        'city': city,
        'postcodes': postcodes,
        'cities': cities,
        'rate': rate,
        'name': name,
        'priority': priority,
        'compound': compound,
        'shipping': shipping,
        'order': order,
        'class': taxClass,
      };

  /// Returns a string representation of the WooTaxRate instance
  ///
  /// This method provides a human-readable representation of the tax rate,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the tax rate's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final taxRate = WooTaxRate(id: 1, country: 'US', rate: '8.25');
  /// print(taxRate.toString());
  /// // Output: {id: 1, country: US, rate: 8.25, ...}
  /// ```
  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooTaxRate &&
        other.id == id &&
        other.country == country &&
        other.state == state &&
        other.postcode == postcode &&
        other.city == city &&
        other.postcodes == postcodes &&
        other.cities == cities &&
        other.rate == rate &&
        other.name == name &&
        other.priority == priority &&
        other.compound == compound &&
        other.shipping == shipping &&
        other.order == order &&
        other.taxClass == taxClass;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      country.hashCode ^
      state.hashCode ^
      postcode.hashCode ^
      city.hashCode ^
      postcodes.hashCode ^
      cities.hashCode ^
      rate.hashCode ^
      name.hashCode ^
      priority.hashCode ^
      compound.hashCode ^
      shipping.hashCode ^
      order.hashCode ^
      taxClass.hashCode;
}
