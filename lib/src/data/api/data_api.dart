import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'data_endpoints.dart';

/// WooCommerce Data API Extension
///
/// This extension provides comprehensive data management capabilities for WooCommerce stores.
/// It enables access to geographical data, currency information, and system endpoints
/// that are essential for international e-commerce operations.
///
/// ## Data Overview
///
/// The Data API provides access to essential reference data for WooCommerce stores,
/// including geographical information, currency details, and system endpoints.
/// This data is crucial for international operations, tax calculations, and
/// shipping configurations.
///
/// ## Key Features
///
/// - **Geographical Data**: Access to continents, countries, and states/provinces
/// - **Currency Information**: Currency codes, names, symbols, and current store currency
/// - **System Endpoints**: Available API endpoints and their descriptions
/// - **International Support**: Multi-currency and multi-location support
/// - **Fake Data Support**: Built-in fake data generation for testing and development
///
/// ## Data Types
///
/// - **Continents**: Geographic continent information with country lists
/// - **Countries**: Country details with states/provinces and currency information
/// - **Currencies**: Currency codes, names, and symbols for international commerce
/// - **Data Endpoints**: Available API endpoints and their descriptions
///
/// ## Example Usage
///
/// ```dart
/// // Get all continents
/// final continents = await wooCommerce.getContinents();
///
/// // Get specific continent
/// final continent = await wooCommerce.getContinent('NA');
///
/// // Get all countries
/// final countries = await wooCommerce.getCountries();
///
/// // Get specific country
/// final country = await wooCommerce.getCountry('US');
///
/// // Get all currencies
/// final currencies = await wooCommerce.getCurrencies();
///
/// // Get current store currency
/// final currentCurrency = await wooCommerce.getCurrentCurrency();
/// ```
extension WooDataApi on WooCommerce {
  /// Retrieves a list of available data endpoints
  ///
  /// This method fetches all available data endpoints from the WooCommerce store.
  /// It's useful for discovering what data is available and understanding the
  /// structure of the data API.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooDataEndpoint>>` containing the available data endpoints
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all available data endpoints
  /// final endpoints = await wooCommerce.listData();
  /// for (final endpoint in endpoints) {
  ///   print('${endpoint.slug}: ${endpoint.description}');
  /// }
  /// ```
  Future<List<WooDataEndpoint>> listData({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooDataEndpoint.fake);
    }

    final response = await dio.get(_DataEndpoints.data);
    return (response.data as List)
        .map((e) => WooDataEndpoint.fromJson(e))
        .toList();
  }

  /// Retrieves all available continents
  ///
  /// This method fetches a complete list of continents with their associated
  /// countries and geographical information. It's particularly useful for
  /// building location selectors and understanding geographical data structure.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooContinent>>` containing all available continents
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all continents
  /// final continents = await wooCommerce.getContinents();
  /// for (final continent in continents) {
  ///   print('${continent.name}: ${continent.countries?.length} countries');
  /// }
  /// ```
  Future<List<WooContinent>> getContinents({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooContinent.fake);
    }

    final response = await dio.get(_DataEndpoints.continents);
    return (response.data as List)
        .map((e) => WooContinent.fromJson(e))
        .toList();
  }

  /// Retrieves a specific continent by location code
  ///
  /// This method fetches detailed information about a single continent
  /// identified by its location code. It includes all countries within
  /// the continent and their associated data.
  ///
  /// ## Parameters
  ///
  /// * [location] - The continent code (e.g., 'NA' for North America, 'EU' for Europe)
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooContinent>` containing the continent details
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get North America continent
  /// final continent = await wooCommerce.getContinent('NA');
  /// print('Continent: ${continent.name}');
  /// print('Countries: ${continent.countries?.length}');
  /// ```
  Future<WooContinent> getContinent(String location, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooContinent.fake();
    }

    final response = await dio.get(_DataEndpoints.continent(location));
    return WooContinent.fromJson(response.data);
  }

  /// Retrieves all available countries
  ///
  /// This method fetches a complete list of countries with their associated
  /// states/provinces and currency information. It's particularly useful for
  /// building country selectors and understanding geographical data structure.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooCountry>>` containing all available countries
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all countries
  /// final countries = await wooCommerce.getCountries();
  /// for (final country in countries) {
  ///   print('${country.name}: ${country.states?.length} states');
  /// }
  /// ```
  Future<List<WooCountry>> getCountries({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooCountry.fake);
    }

    final response = await dio.get(_DataEndpoints.countries);
    return (response.data as List).map((e) => WooCountry.fromJson(e)).toList();
  }

  /// Retrieves a specific country by location code
  ///
  /// This method fetches detailed information about a single country
  /// identified by its location code. It includes all states/provinces
  /// within the country and their associated data.
  ///
  /// ## Parameters
  ///
  /// * [location] - The country code (e.g., 'US' for United States, 'CA' for Canada)
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooCountry>` containing the country details
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get United States country
  /// final country = await wooCommerce.getCountry('US');
  /// print('Country: ${country.name}');
  /// print('States: ${country.states?.length}');
  /// ```
  Future<WooCountry> getCountry(String location, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCountry.fake();
    }

    final response = await dio.get(_DataEndpoints.country(location));
    return WooCountry.fromJson(response.data);
  }

  /// Retrieves all available currencies
  ///
  /// This method fetches a complete list of currencies with their codes,
  /// names, and symbols. It's particularly useful for building currency
  /// selectors and understanding available currency options.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooCurrency>>` containing all available currencies
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all currencies
  /// final currencies = await wooCommerce.getCurrencies();
  /// for (final currency in currencies) {
  ///   print('${currency.name} (${currency.code}): ${currency.symbol}');
  /// }
  /// ```
  Future<List<WooCurrency>> getCurrencies({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooCurrency.fake);
    }

    final response = await dio.get(_DataEndpoints.currencies);
    return (response.data as List).map((e) => WooCurrency.fromJson(e)).toList();
  }

  /// Retrieves a specific currency by code
  ///
  /// This method fetches detailed information about a single currency
  /// identified by its currency code. It includes the currency name,
  /// symbol, and other relevant information.
  ///
  /// ## Parameters
  ///
  /// * [code] - The currency code (e.g., 'USD' for US Dollar, 'EUR' for Euro)
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooCurrency>` containing the currency details
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get US Dollar currency
  /// final currency = await wooCommerce.getCurrency('USD');
  /// print('Currency: ${currency.name} (${currency.code})');
  /// print('Symbol: ${currency.symbol}');
  /// ```
  Future<WooCurrency> getCurrency(String code, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCurrency.fake();
    }

    final response = await dio.get(_DataEndpoints.currency(code));
    return WooCurrency.fromJson(response.data);
  }

  /// Retrieves the current store currency
  ///
  /// This method fetches the currency currently configured for the WooCommerce store.
  /// It's useful for displaying prices in the store's base currency and
  /// understanding the store's currency configuration.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooCurrency>` containing the current store currency
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get current store currency
  /// final currentCurrency = await wooCommerce.getCurrentCurrency();
  /// print('Store Currency: ${currentCurrency.name} (${currentCurrency.code})');
  /// print('Symbol: ${currentCurrency.symbol}');
  /// ```
  Future<WooCurrency> getCurrentCurrency({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCurrency.fake();
    }

    final response = await dio.get(_DataEndpoints.currentCurrency);
    return WooCurrency.fromJson(response.data);
  }
}
