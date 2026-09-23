# data

## data_api

### extension WooDataApi on WooCommerce

WooCommerce Data API Extension

This extension provides comprehensive data management capabilities for WooCommerce stores.
It enables access to geographical data, currency information, and system endpoints
that are essential for international e-commerce operations.

## Data Overview

The Data API provides access to essential reference data for WooCommerce stores,
including geographical information, currency details, and system endpoints.
This data is crucial for international operations, tax calculations, and
shipping configurations.

## Key Features

- **Geographical Data**: Access to continents, countries, and states/provinces
- **Currency Information**: Currency codes, names, symbols, and current store currency
- **System Endpoints**: Available API endpoints and their descriptions
- **International Support**: Multi-currency and multi-location support
- **Fake Data Support**: Built-in fake data generation for testing and development

## Data Types

- **Continents**: Geographic continent information with country lists
- **Countries**: Country details with states/provinces and currency information
- **Currencies**: Currency codes, names, and symbols for international commerce
- **Data Endpoints**: Available API endpoints and their descriptions

## Example Usage

```dart
// Get all continents
final continents = await wooCommerce.getContinents();

// Get specific continent
final continent = await wooCommerce.getContinent('NA');

// Get all countries
final countries = await wooCommerce.getCountries();

// Get specific country
final country = await wooCommerce.getCountry('US');

// Get all currencies
final currencies = await wooCommerce.getCurrencies();

// Get current store currency
final currentCurrency = await wooCommerce.getCurrentCurrency();
```

### Future<List<WooDataEndpoint>> listData({bool? useFaker}) async

Retrieves a list of available data endpoints

This method fetches all available data endpoints from the WooCommerce store.
It's useful for discovering what data is available and understanding the
structure of the data API.

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooDataEndpoint>>` containing the available data endpoints

## Example Usage

```dart
// Get all available data endpoints
final endpoints = await wooCommerce.listData();
for (final endpoint in endpoints) {
  print('${endpoint.slug}: ${endpoint.description}');
}
```

### Future<List<WooContinent>> getContinents({bool? useFaker}) async

Retrieves all available continents

This method fetches a complete list of continents with their associated
countries and geographical information. It's particularly useful for
building location selectors and understanding geographical data structure.

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooContinent>>` containing all available continents

## Example Usage

```dart
// Get all continents
final continents = await wooCommerce.getContinents();
for (final continent in continents) {
  print('${continent.name}: ${continent.countries?.length} countries');
}
```

### Future<WooContinent> getContinent(String location, {bool? useFaker}) async

Retrieves a specific continent by location code

This method fetches detailed information about a single continent
identified by its location code. It includes all countries within
the continent and their associated data.

## Parameters

* [location] - The continent code (e.g., 'NA' for North America, 'EU' for Europe)
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooContinent>` containing the continent details

## Example Usage

```dart
// Get North America continent
final continent = await wooCommerce.getContinent('NA');
print('Continent: ${continent.name}');
print('Countries: ${continent.countries?.length}');
```

### Future<List<WooCountry>> getCountries({bool? useFaker}) async

Retrieves all available countries

This method fetches a complete list of countries with their associated
states/provinces and currency information. It's particularly useful for
building country selectors and understanding geographical data structure.

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooCountry>>` containing all available countries

## Example Usage

```dart
// Get all countries
final countries = await wooCommerce.getCountries();
for (final country in countries) {
  print('${country.name}: ${country.states?.length} states');
}
```

### Future<WooCountry> getCountry(String location, {bool? useFaker}) async

Retrieves a specific country by location code

This method fetches detailed information about a single country
identified by its location code. It includes all states/provinces
within the country and their associated data.

## Parameters

* [location] - The country code (e.g., 'US' for United States, 'CA' for Canada)
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooCountry>` containing the country details

## Example Usage

```dart
// Get United States country
final country = await wooCommerce.getCountry('US');
print('Country: ${country.name}');
print('States: ${country.states?.length}');
```

### Future<List<WooDataCurrency>> getCurrencies({bool? useFaker}) async

Retrieves all available currencies

This method fetches a complete list of currencies with their codes,
names, and symbols. It's particularly useful for building currency
selectors and understanding available currency options.

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooCurrency>>` containing all available currencies

## Example Usage

```dart
// Get all currencies
final currencies = await wooCommerce.getCurrencies();
for (final currency in currencies) {
  print('${currency.name} (${currency.code}): ${currency.symbol}');
}
```

### Future<WooDataCurrency> getCurrency(String code, {bool? useFaker}) async

Retrieves a specific currency by code

This method fetches detailed information about a single currency
identified by its currency code. It includes the currency name,
symbol, and other relevant information.

## Parameters

* [code] - The currency code (e.g., 'USD' for US Dollar, 'EUR' for Euro)
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooCurrency>` containing the currency details

## Example Usage

```dart
// Get US Dollar currency
final currency = await wooCommerce.getCurrency('USD');
print('Currency: ${currency.name} (${currency.code})');
print('Symbol: ${currency.symbol}');
```

### Future<WooDataCurrency> getCurrentCurrency({bool? useFaker}) async

Retrieves the current store currency

This method fetches the currency currently configured for the WooCommerce store.
It's useful for displaying prices in the store's base currency and
understanding the store's currency configuration.

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooCurrency>` containing the current store currency

## Example Usage

```dart
// Get current store currency
final currentCurrency = await wooCommerce.getCurrentCurrency();
print('Store Currency: ${currentCurrency.name} (${currentCurrency.code})');
print('Symbol: ${currentCurrency.symbol}');
```

## continent

### class WooContinent

WooCommerce Continent Model

Represents a continent in WooCommerce with its code, name, and associated countries.
Used for geographical data management and international e-commerce operations.

## Continent Structure

A continent consists of key components:

- **Code**: Continent code (e.g., 'NA', 'EU', 'AS')
- **Name**: Human-readable continent name (e.g., 'North America', 'Europe')
- **Countries**: List of countries within the continent

## Common Continents

- **NA**: North America
- **SA**: South America
- **EU**: Europe
- **AS**: Asia
- **AF**: Africa
- **OC**: Oceania
- **AN**: Antarctica

## Example Usage

```dart
// Create from API response
final continent = WooContinent.fromJson({
  'code': 'NA',
  'name': 'North America',
  'countries': [...]
});

// Access properties
print('${continent.name} (${continent.code}): ${continent.countries?.length} countries');

// Convert to JSON
final json = continent.toJson();
```

### WooContinent({this.code, this.name, this.countries})

WooCommerce Continent Model

Represents a continent in WooCommerce with its code, name, and associated countries.
Used for geographical data management and international e-commerce operations.

## Continent Structure

A continent consists of key components:

- **Code**: Continent code (e.g., 'NA', 'EU', 'AS')
- **Name**: Human-readable continent name (e.g., 'North America', 'Europe')
- **Countries**: List of countries within the continent

## Common Continents

- **NA**: North America
- **SA**: South America
- **EU**: Europe
- **AS**: Asia
- **AF**: Africa
- **OC**: Oceania
- **AN**: Antarctica

## Example Usage

```dart
// Create from API response
final continent = WooContinent.fromJson({
  'code': 'NA',
  'name': 'North America',
  'countries': [...]
});

// Access properties
print('${continent.name} (${continent.code}): ${continent.countries?.length} countries');

// Convert to JSON
final json = continent.toJson();
```

### factory WooContinent.fromJson(Map<String, dynamic> json)

Creates a WooContinent from JSON data

This factory constructor parses JSON data received from the WooCommerce
REST API and creates a corresponding WooContinent object.

## Parameters

* [json] - Map containing continent information from WooCommerce API

## Returns

A `WooContinent` instance with data from the JSON input

## Example Usage

```dart
// Parse API response
final jsonData = {
  'code': 'NA',
  'name': 'North America',
  'countries': [{'code': 'US', 'name': 'United States'}]
};
final continent = WooContinent.fromJson(jsonData);
```

### factory WooContinent.fake()

Creates a fake continent for testing and development

This factory constructor generates a WooContinent instance with
fake data using the FakeHelper utility. It's particularly useful for
testing, development, and demonstration purposes.

## Returns

A `WooContinent` instance with generated fake data

## Example Usage

```dart
// Generate fake continent for testing
final fakeContinent = WooContinent.fake();
print('Fake continent: ${fakeContinent.name} (${fakeContinent.code})');
```

### final String? code

Continent code

The two-letter continent code used for geographical reference.
Examples include 'NA' for North America, 'EU' for Europe, 'AS' for Asia.

### final String? name

Human-readable continent name

The full name of the continent, such as 'North America', 'Europe', or 'Asia'.
This is typically used in user interfaces and documentation.

### final List<CountryInContinent>? countries

List of countries within the continent

Contains all countries within the continent with their associated
geographical and currency information.

### Map<String, dynamic> toJson()

Converts the continent to JSON format

This method serializes the WooContinent object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the continent information in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = continent.toJson();
print(jsonData); // {'code': 'NA', 'name': 'North America', 'countries': [...]}
```

### WooContinent copyWith({ String? code, String? name, List<CountryInContinent>? countries, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### class CountryInContinent

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### CountryInContinent({ this.code, this.currencyCode, this.currencyPos, this.decimalSep, this.dimensionUnit, this.name, this.numDecimals, this.states, this.thousandSep, this.weightUnit, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory CountryInContinent.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory CountryInContinent.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? code

Continent code

The two-letter continent code used for geographical reference.
Examples include 'NA' for North America, 'EU' for Europe, 'AS' for Asia.

### final String? currencyCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? currencyPos

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? decimalSep

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? dimensionUnit

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

Human-readable continent name

The full name of the continent, such as 'North America', 'Europe', or 'Asia'.
This is typically used in user interfaces and documentation.

### final int? numDecimals

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<StateInCountry>? states

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? thousandSep

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? weightUnit

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

Converts the continent to JSON format

This method serializes the WooContinent object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the continent information in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = continent.toJson();
print(jsonData); // {'code': 'NA', 'name': 'North America', 'countries': [...]}
```

### CountryInContinent copyWith({ String? code, String? currencyCode, String? currencyPos, String? decimalSep, String? dimensionUnit, String? name, int? numDecimals, List<StateInCountry>? states, String? thousandSep, String? weightUnit, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## country

### class WooCountry

WooCommerce Country Model

Represents a country in WooCommerce with its code, name, and associated states/provinces.
Used for geographical data management and international e-commerce operations.

## Country Structure

A country consists of key components:

- **Code**: ISO 3166-1 alpha-2 country code (e.g., 'US', 'CA', 'GB')
- **Name**: Human-readable country name (e.g., 'United States', 'Canada')
- **States**: List of states/provinces within the country

## Common Countries

- **US**: United States (50 states)
- **CA**: Canada (13 provinces/territories)
- **GB**: United Kingdom (4 countries)
- **AU**: Australia (8 states/territories)
- **DE**: Germany (16 states)

## Example Usage

```dart
// Create from API response
final country = WooCountry.fromJson({
  'code': 'US',
  'name': 'United States',
  'states': [...]
});

// Access properties
print('${country.name} (${country.code}): ${country.states?.length} states');

// Convert to JSON
final json = country.toJson();
```

### WooCountry({this.code, this.name, this.states})

WooCommerce Country Model

Represents a country in WooCommerce with its code, name, and associated states/provinces.
Used for geographical data management and international e-commerce operations.

## Country Structure

A country consists of key components:

- **Code**: ISO 3166-1 alpha-2 country code (e.g., 'US', 'CA', 'GB')
- **Name**: Human-readable country name (e.g., 'United States', 'Canada')
- **States**: List of states/provinces within the country

## Common Countries

- **US**: United States (50 states)
- **CA**: Canada (13 provinces/territories)
- **GB**: United Kingdom (4 countries)
- **AU**: Australia (8 states/territories)
- **DE**: Germany (16 states)

## Example Usage

```dart
// Create from API response
final country = WooCountry.fromJson({
  'code': 'US',
  'name': 'United States',
  'states': [...]
});

// Access properties
print('${country.name} (${country.code}): ${country.states?.length} states');

// Convert to JSON
final json = country.toJson();
```

### factory WooCountry.fromJson(Map<String, dynamic> json)

Creates a WooCountry from JSON data

This factory constructor parses JSON data received from the WooCommerce
REST API and creates a corresponding WooCountry object.

## Parameters

* [json] - Map containing country information from WooCommerce API

## Returns

A `WooCountry` instance with data from the JSON input

## Example Usage

```dart
// Parse API response
final jsonData = {
  'code': 'US',
  'name': 'United States',
  'states': [{'code': 'CA', 'name': 'California'}]
};
final country = WooCountry.fromJson(jsonData);
```

### factory WooCountry.fake()

Creates a fake country for testing and development

This factory constructor generates a WooCountry instance with
fake data using the FakeHelper utility. It's particularly useful for
testing, development, and demonstration purposes.

## Returns

A `WooCountry` instance with generated fake data

## Example Usage

```dart
// Generate fake country for testing
final fakeCountry = WooCountry.fake();
print('Fake country: ${fakeCountry.name} (${fakeCountry.code})');
```

### final String? code

ISO 3166-1 alpha-2 country code

The two-letter country code as defined by ISO 3166-1 standard.
Examples include 'US' for United States, 'CA' for Canada, 'GB' for United Kingdom.

### final String? name

Human-readable country name

The full name of the country, such as 'United States', 'Canada', or 'United Kingdom'.
This is typically used in user interfaces and documentation.

### final List<StateInCountry>? states

List of states/provinces within the country

Contains all states, provinces, or administrative divisions within the country.
Each state includes its code and name for geographical reference.

### Map<String, dynamic> toJson()

Converts the country to JSON format

This method serializes the WooCountry object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the country information in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = country.toJson();
print(jsonData); // {'code': 'US', 'name': 'United States', 'states': [...]}
```

### WooCountry copyWith({ String? code, String? name, List<StateInCountry>? states, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### class StateInCountry

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### StateInCountry({this.code, this.name})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory StateInCountry.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory StateInCountry.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? code

ISO 3166-1 alpha-2 country code

The two-letter country code as defined by ISO 3166-1 standard.
Examples include 'US' for United States, 'CA' for Canada, 'GB' for United Kingdom.

### final String? name

Human-readable country name

The full name of the country, such as 'United States', 'Canada', or 'United Kingdom'.
This is typically used in user interfaces and documentation.

### Map<String, dynamic> toJson()

Converts the country to JSON format

This method serializes the WooCountry object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the country information in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = country.toJson();
print(jsonData); // {'code': 'US', 'name': 'United States', 'states': [...]}
```

### StateInCountry copyWith({String? code, String? name})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## data_currency

### class WooDataCurrency

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooDataCurrency({this.code, this.name, this.symbol})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooDataCurrency.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooDataCurrency.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? code

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? symbol

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooDataCurrency copyWith({String? code, String? name, String? symbol})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## data_endpoint

### class WooDataEndpoint

WooCommerce Data Endpoint Model

Represents a data endpoint in WooCommerce that provides access to specific
reference data such as geographical information, currencies, and other
system data essential for e-commerce operations.

## Data Endpoint Structure

A data endpoint consists of key components:

- **Identification**: Unique slug identifier for the endpoint
- **Description**: Human-readable description of the endpoint's purpose
- **Data Access**: Provides access to specific reference data

## Common Data Endpoints

- **continents**: Geographic continent information
- **countries**: Country details with states/provinces
- **currencies**: Currency codes, names, and symbols
- **system_status**: Store system information and status

## Example Usage

```dart
// Create from API response
final endpoint = WooDataEndpoint.fromJson({
  'slug': 'continents',
  'description': 'List of continents and their countries'
});

// Access properties
print('Endpoint: ${endpoint.slug}');
print('Description: ${endpoint.description}');

// Convert to JSON
final json = endpoint.toJson();
```

### WooDataEndpoint({this.slug, this.description})

WooCommerce Data Endpoint Model

Represents a data endpoint in WooCommerce that provides access to specific
reference data such as geographical information, currencies, and other
system data essential for e-commerce operations.

## Data Endpoint Structure

A data endpoint consists of key components:

- **Identification**: Unique slug identifier for the endpoint
- **Description**: Human-readable description of the endpoint's purpose
- **Data Access**: Provides access to specific reference data

## Common Data Endpoints

- **continents**: Geographic continent information
- **countries**: Country details with states/provinces
- **currencies**: Currency codes, names, and symbols
- **system_status**: Store system information and status

## Example Usage

```dart
// Create from API response
final endpoint = WooDataEndpoint.fromJson({
  'slug': 'continents',
  'description': 'List of continents and their countries'
});

// Access properties
print('Endpoint: ${endpoint.slug}');
print('Description: ${endpoint.description}');

// Convert to JSON
final json = endpoint.toJson();
```

### factory WooDataEndpoint.fromJson(Map<String, dynamic> json)

Creates a WooDataEndpoint from JSON data

This factory constructor parses JSON data received from the WooCommerce
REST API and creates a corresponding WooDataEndpoint object.

## Parameters

* [json] - Map containing data endpoint information from WooCommerce API

## Returns

A `WooDataEndpoint` instance with data from the JSON input

## Example Usage

```dart
// Parse API response
final jsonData = {
  'slug': 'continents',
  'description': 'List of continents and their countries'
};
final endpoint = WooDataEndpoint.fromJson(jsonData);
```

### factory WooDataEndpoint.fake()

Creates a fake data endpoint for testing and development

This factory constructor generates a WooDataEndpoint instance with
fake data using the FakeHelper utility. It's particularly useful for
testing, development, and demonstration purposes.

## Returns

A `WooDataEndpoint` instance with generated fake data

## Example Usage

```dart
// Generate fake data endpoint for testing
final fakeEndpoint = WooDataEndpoint.fake();
print('Fake endpoint: ${fakeEndpoint.slug}');
```

### final String? slug

Unique slug identifier for the data endpoint

This identifier is used to access specific data endpoints in the WooCommerce API.
Common values include 'continents', 'countries', 'currencies', and 'system_status'.

### final String? description

Human-readable description of the data endpoint

Provides a description of what data is available through this endpoint
and how it can be used in e-commerce applications.

### Map<String, dynamic> toJson()

Converts the data endpoint to JSON format

This method serializes the WooDataEndpoint object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the data endpoint information in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = endpoint.toJson();
print(jsonData); // {'slug': 'continents', 'description': 'List of continents'}
```

### WooDataEndpoint copyWith({String? slug, String? description})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

