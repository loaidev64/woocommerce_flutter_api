# tax

## tax_class_api

### extension WooTaxClassApi on WooCommerce

WooCommerce Tax Class API Extension

This extension provides comprehensive tax class management capabilities for WooCommerce stores.
It enables creation, retrieval, and deletion of tax classes to help store owners
organize and manage different tax categories for their products.

## Key Features

- **Tax Class Retrieval**: Get all available tax classes
- **Tax Class Creation**: Create new custom tax classes
- **Tax Class Deletion**: Remove unwanted tax classes
- **Simple Management**: Easy-to-use methods for tax class operations

## Example Usage

```dart
// Get all tax classes
final taxClasses = await wooCommerce.getTaxClasses();

// Create a new tax class
final newTaxClass = WooTaxClass(
  slug: 'reduced-rate',
  name: 'Reduced Rate',
);
final created = await wooCommerce.createTaxClass(newTaxClass);

// Delete a tax class
await wooCommerce.deleteTaxClass(taxClass);
```

### Future<List<WooTaxClass>> getTaxClasses({bool? useFaker}) async

Retrieves all tax classes from the WooCommerce store.

This method returns a list of all available tax classes, including
standard tax classes and any custom tax classes that have been created.

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooTaxClass>>` containing all tax class objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all tax classes
final taxClasses = await wooCommerce.getTaxClasses();

// Get tax classes with fake data for testing
final fakeTaxClasses = await wooCommerce.getTaxClasses(useFaker: true);
```

### Future<WooTaxClass> createTaxClass(WooTaxClass taxClass, {bool? useFaker}) async

Creates a new tax class in the WooCommerce store.

This method creates a new tax class with the specified slug and name.
Tax classes are used to categorize products for different tax treatments.

## Parameters

* [taxClass] - The tax class object to create
* [useFaker] - When true, returns the input tax class without API call

## Returns

A `Future<WooTaxClass>` containing the created tax class object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
final newTaxClass = WooTaxClass(
  slug: 'reduced-rate',
  name: 'Reduced Rate',
);
final created = await wooCommerce.createTaxClass(newTaxClass);
```

### Future<WooDeleteResult> deleteTaxClass(String slug, {bool? useFaker}) async

Deletes a tax class from the WooCommerce store.

This method permanently removes a tax class from the store.
Use with caution as this action cannot be undone.

## Parameters

* [taxClass] - The tax class object to delete
* [useFaker] - When true, performs no actual deletion

## Returns

A `Future<void>` that completes when the deletion is successful.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
await wooCommerce.deleteTaxClass(taxClass);
```

## tax_rate_api

### extension WooTaxRateApi on WooCommerce

WooCommerce Tax Rate API Extension

This extension provides comprehensive tax rate management capabilities for WooCommerce stores.
It enables creation, retrieval, updating, and deletion of tax rates with extensive
filtering and sorting options to help store owners manage complex tax configurations.

## Key Features

- **Tax Rate Management**: Full CRUD operations for tax rates
- **Advanced Filtering**: Filter by tax class, geographical location, and more
- **Flexible Sorting**: Sort tax rates by various attributes
- **Geographical Targeting**: Support for country, state, city, and postal code rules
- **Pagination Support**: Handle large datasets with page-based navigation

## Example Usage

```dart
// Get all tax rates
final taxRates = await wooCommerce.getTaxRates();

// Get tax rates for a specific tax class
final standardRates = await wooCommerce.getTaxRates(
  taxClass: 'standard',
);

// Create a new tax rate
final newTaxRate = WooTaxRate(
  country: 'US',
  state: 'CA',
  rate: '8.25',
  name: 'California Sales Tax',
);
final created = await wooCommerce.createTaxRate(newTaxRate);
```

### Future<WooPage<WooTaxRate>> getTaxRates({ WooContext context = WooContext.view, int? page, int? perPage, int? offset, WooSort? order, WooOrderBy? orderBy, String? taxClass, bool? useFaker, }) async

Retrieves a list of tax rates from the WooCommerce store.

This method supports extensive filtering and sorting options to help you
find exactly the tax rates you need. You can filter by tax class, sort by
various attributes, and use pagination for large datasets.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-tax-rates

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic tax rate information (default)
  - `WooContext.edit`: Returns full tax rate details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [offset] - Offset the result set by a specific number of items
* [order] - Order sort attribute ascending or descending (default: desc)
* [orderBy] - Sort collection by object attribute (default: date)
* [taxClass] - Retrieve only tax rates of this tax class
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooTaxRate>>` containing the tax rate objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all tax rates
final taxRates = await wooCommerce.getTaxRates();

// Get tax rates for standard tax class
final standardRates = await wooCommerce.getTaxRates(
  taxClass: 'standard',
);

// Get tax rates with pagination
final pagedRates = await wooCommerce.getTaxRates(
  page: 2,
  perPage: 20,
);
```

### Future<WooTaxRate> getTaxRate(int id, {bool? useFaker}) async

Retrieves a specific tax rate by ID from the WooCommerce store.

This method fetches detailed information about a single tax rate
using its unique identifier.

## Parameters

* [id] - The unique identifier of the tax rate to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooTaxRate>` containing the tax rate object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
final taxRate = await wooCommerce.getTaxRate(123);
```

### Future<WooTaxRate> createTaxRate(WooTaxRate taxRate, {bool? useFaker}) async

Creates a new tax rate in the WooCommerce store.

This method creates a new tax rate with the specified configuration.
The tax rate will be applied based on its geographical and tax class settings.

## Parameters

* [taxRate] - The tax rate object to create
* [useFaker] - When true, returns the input tax rate without API call

## Returns

A `Future<WooTaxRate>` containing the created tax rate object with assigned ID.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
final newTaxRate = WooTaxRate(
  country: 'US',
  state: 'CA',
  rate: '8.25',
  name: 'California Sales Tax',
);
final created = await wooCommerce.createTaxRate(newTaxRate);
```

### Future<WooTaxRate> updateTaxRate

Updates an existing tax rate in the WooCommerce store.

This method updates an existing tax rate with new configuration.
The tax rate must have a valid ID to be updated.

## Parameters

* [taxRate] - The tax rate object with updated information
* [useFaker] - When true, returns the input tax rate without API call

## Returns

A `Future<WooTaxRate>` containing the updated tax rate object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
final updatedTaxRate = WooTaxRate(
  id: 123,
  country: 'US',
  state: 'CA',
  rate: '9.25', // Updated rate
  name: 'California Sales Tax',
);
final result = await wooCommerce.updateTaxRate(updatedTaxRate);
```

### Future<WooDeleteResult> deleteTaxRate(int id, {bool? useFaker}) async

Deletes a tax rate from the WooCommerce store.

This method permanently removes a tax rate from the store.
Use with caution as this action cannot be undone.

## Parameters

* [taxRateId] - The unique identifier of the tax rate to delete
* [useFaker] - When true, performs no actual deletion

## Returns

A `Future<void>` that completes when the deletion is successful.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
await wooCommerce.deleteTaxRate(123);
```

### Future<WooTaxRateBatchResponse> batchUpdateTaxRates

Performs batch operations on tax rates.

This method allows you to create, update, and delete multiple tax rates
in a single API request, making bulk operations more efficient. This is particularly
useful for managing tax configurations across multiple regions or updating
tax rates in bulk when rates change.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-tax-rates

## Parameters

* [request] - The `WooTaxRateBatchRequest` object containing
  the create, update, and delete operations to perform
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooTaxRateBatchResponse>` containing the results of
all batch operations, including created, updated, and deleted tax rates.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooTaxRateBatchRequest(
  create: [
    WooTaxRate(
      country: 'US',
      state: 'CA',
      rate: '8.25',
      name: 'California Sales Tax',
      priority: 1,
    ),
    WooTaxRate(
      country: 'US',
      state: 'NY',
      rate: '8.00',
      name: 'New York Sales Tax',
      priority: 1,
    ),
  ],
  update: [
    WooTaxRate(
      id: 123,
      rate: '9.25', // Updated rate
      name: 'Updated California Sales Tax',
    ),
  ],
  delete: [456, 789],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} tax rates');
print('Updated ${response.update?.length ?? 0} tax rates');
print('Deleted ${response.delete?.length ?? 0} tax rates');

// Access individual results
for (final taxRate in response.create ?? []) {
  print('Created tax rate: ${taxRate.name} with ID: ${taxRate.id}');
  print('Rate: ${taxRate.rate}% for ${taxRate.country}/${taxRate.state}');
}
```

## Geographical Targeting Example

```dart
// Create tax rates with specific geographical targeting
final batchRequest = WooTaxRateBatchRequest(
  create: [
    WooTaxRate(
      country: 'US',
      state: 'CA',
      cities: ['Los Angeles', 'San Francisco'],
      postcodes: ['90001', '90002'],
      rate: '9.50',
      name: 'California City Tax',
      priority: 1,
    ),
    WooTaxRate(
      country: 'US',
      state: 'NY',
      cities: ['New York'],
      rate: '8.875',
      name: 'New York City Tax',
      priority: 1,
    ),
  ],
);

final response = await wooCommerce.batchUpdateTaxRates(batchRequest);
print('Created ${response.create?.length ?? 0} city-specific tax rates');
```

## Batch Operations Best Practices

- **Create operations**: Tax rates should not have IDs assigned
- **Update operations**: Tax rates must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of tax rates to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Geographical targeting**: Use country, state, city, and postcode fields for precise targeting
- **Priority management**: Set appropriate priority values when multiple rates could apply
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## Geographical Targeting

Tax rates support flexible geographical targeting:

- **Country**: Two-letter ISO 3166-1 alpha-2 code (e.g., 'US', 'CA', 'GB')
- **State**: State or province code within the country
- **City**: Single city name (deprecated) or list of cities (modern)
- **Postcode**: Single postal code (deprecated) or list of postcodes (modern)

Use the modern `cities` and `postcodes` list fields for better flexibility:

```dart
WooTaxRate(
  country: 'US',
  state: 'CA',
  cities: ['Los Angeles', 'San Francisco', 'San Diego'],
  postcodes: ['90001', '90002', '94102'],
  rate: '9.50',
  name: 'California Major Cities Tax',
)
```

## tax_rate_query

### class WooTaxRateQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooTaxRateQuery({ super.page, super.perPage, super.order, super.orderBy, super.offset, super.search, this.context, this.taxClass, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext? context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? taxClass

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## tax_class

### class WooTaxClass

Represents a tax class with basic information.

Brief description of the model's purpose and usage.

### WooTaxClass({this.slug, this.name})

Represents a tax class with basic information.

Brief description of the model's purpose and usage.

### factory WooTaxClass.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooTaxClass.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

Unique identifier for the resource.

### final String? name

Tax class name.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooTaxClass copyWith({String? slug, String? name})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTaxClass instance.

Displays all main fields for debugging and logging purposes.

## tax_rate

### class WooTaxRate

WooCommerce Tax Rate Model

Represents a tax rate configuration in WooCommerce with comprehensive
geographical and tax calculation settings. This model provides detailed
tax rate information including location-based rules, compound tax settings,
and priority management for complex tax scenarios.

## Key Features

- **Geographical Targeting**: Country, state, city, and postal code targeting
- **Flexible Location Rules**: Support for both legacy and modern location formats
- **Compound Tax Support**: Handle complex tax calculations with compound rates
- **Priority Management**: Control tax rate application order
- **Shipping Integration**: Apply taxes to shipping costs
- **Tax Class Association**: Link rates to specific tax classes

## Usage Examples

### Creating a Tax Rate

```dart
final taxRate = WooTaxRate(
  country: 'US',
  state: 'CA',
  rate: '8.25',
  name: 'California Sales Tax',
  priority: 1,
);
```

### Working with Tax Rate Data

```dart
// Check tax rate configuration
if (taxRate.compound == true) {
  print('This is a compound tax rate');
}

// Access geographical targeting
if (taxRate.country == 'US' && taxRate.state == 'CA') {
  print('California tax rate: ${taxRate.rate}%');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = taxRate.toJson();

// Create from JSON response
final taxRate = WooTaxRate.fromJson(jsonData);
```

### WooTaxRate({ this.id, this.country, this.state, this.postcode, this.city, this.postcodes, this.cities, this.rate, this.name, this.priority = 1, this.compound = false, this.shipping = true, this.order, this.taxClass = 'standard', })

WooCommerce Tax Rate Model

Represents a tax rate configuration in WooCommerce with comprehensive
geographical and tax calculation settings. This model provides detailed
tax rate information including location-based rules, compound tax settings,
and priority management for complex tax scenarios.

## Key Features

- **Geographical Targeting**: Country, state, city, and postal code targeting
- **Flexible Location Rules**: Support for both legacy and modern location formats
- **Compound Tax Support**: Handle complex tax calculations with compound rates
- **Priority Management**: Control tax rate application order
- **Shipping Integration**: Apply taxes to shipping costs
- **Tax Class Association**: Link rates to specific tax classes

## Usage Examples

### Creating a Tax Rate

```dart
final taxRate = WooTaxRate(
  country: 'US',
  state: 'CA',
  rate: '8.25',
  name: 'California Sales Tax',
  priority: 1,
);
```

### Working with Tax Rate Data

```dart
// Check tax rate configuration
if (taxRate.compound == true) {
  print('This is a compound tax rate');
}

// Access geographical targeting
if (taxRate.country == 'US' && taxRate.state == 'CA') {
  print('California tax rate: ${taxRate.rate}%');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = taxRate.toJson();

// Create from JSON response
final taxRate = WooTaxRate.fromJson(jsonData);
```

### factory WooTaxRate.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooTaxRate.fake({int? id})

Creates a fake WooTaxRate instance for testing purposes

This factory constructor generates a tax rate with random but realistic
data, making it useful for testing and development.

## Parameters

* [id] - Optional specific ID to use for the fake tax rate

## Returns

A `WooTaxRate` instance with randomly generated fake data.

## Example Usage

```dart
final fakeTaxRate = WooTaxRate.fake();
final fakeTaxRateWithId = WooTaxRate.fake(123);
```

### final int? id

Unique identifier for the resource. Read-only.

The system-generated ID for this tax rate. This field is read-only
and assigned by WooCommerce when the tax rate is created.

### final String? country

Country ISO 3166 code.

The two-letter country code (ISO 3166-1 alpha-2) that this tax rate
applies to. Use 'XX' for all countries.

### final String? state

State code.

The state or province code that this tax rate applies to.
Leave empty to apply to all states in the country.

### final String? postcode

Postcode/ZIP. Deprecated as of WooCommerce 5.3.

Single postal code that this tax rate applies to.
This field is deprecated in favor of the [postcodes] list.

### final String? city

City name. Deprecated as of WooCommerce 5.3.

Single city name that this tax rate applies to.
This field is deprecated in favor of the [cities] list.

### final List<String>? postcodes

Postcodes/ZIPs. Introduced in WooCommerce 5.3.

List of postal codes that this tax rate applies to.
This replaces the deprecated [postcode] field for better flexibility.

### final List<String>? cities

City names. Introduced in WooCommerce 5.3.

List of city names that this tax rate applies to.
This replaces the deprecated [city] field for better flexibility.

### final String? rate

Tax rate.

The tax rate as a decimal number (e.g., '8.25' for 8.25%).
This is the percentage rate that will be applied to applicable items.

### final String? name

Tax rate name.

A descriptive name for this tax rate (e.g., 'California Sales Tax').
This helps identify the tax rate in the admin interface.

### final int? priority

Tax priority. Default is 1.

The priority of this tax rate when multiple rates could apply.
Lower numbers have higher priority. Default is 1.

### final bool? compound

Whether or not this is a compound tax rate. Default is false.

When true, this tax rate is calculated on top of other tax rates.
Compound taxes are applied after non-compound taxes.

### final bool? shipping

Whether or not this tax rate also gets applied to shipping. Default is true.

When true, this tax rate will be applied to shipping costs.
When false, shipping will be exempt from this tax rate.

### final int? order

Indicates the order that will appear in queries.

The display order for this tax rate in admin interfaces.
Lower numbers appear first.

### final String? taxClass

Tax class. Default is standard.

The tax class this rate applies to. Common values include
'standard', 'reduced-rate', 'zero-rate', and custom tax classes.

### Map<String, dynamic> toJson()

Converts the WooTaxRate instance to JSON format

This method serializes the tax rate data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the tax rate data in JSON format.

## Example Usage

```dart
final jsonData = taxRate.toJson();
```

### WooTaxRate copyWith({ int? id, String? country, String? state, String? postcode, String? city, List<String>? postcodes, List<String>? cities, String? rate, String? name, int? priority, bool? compound, bool? shipping, int? order, String? taxClass, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTaxRate instance

This method provides a human-readable representation of the tax rate,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the tax rate's main field values in a readable format.

## Example Usage

```dart
final taxRate = WooTaxRate(id: 1, country: 'US', rate: '8.25');
print(taxRate.toString());
// Output: {id: 1, country: US, rate: 8.25, ...}
```

## tax_rate_batch_request

### class WooTaxRateBatchRequest

WooCommerce Tax Rate Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple tax rates in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple tax rates in a single request
- **Bulk Updates**: Update multiple existing tax rates simultaneously
- **Bulk Deletion**: Delete multiple tax rates at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Geographical Targeting**: Manage tax rates with country, state, city, and postcode rules

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooTaxRateBatchRequest(
  create: [
    WooTaxRate(
      country: 'US',
      state: 'CA',
      rate: '8.25',
      name: 'California Sales Tax',
      priority: 1,
    ),
    WooTaxRate(
      country: 'US',
      state: 'NY',
      rate: '8.00',
      name: 'New York Sales Tax',
      priority: 1,
    ),
  ],
  update: [
    WooTaxRate(
      id: 123,
      rate: '9.25', // Updated rate
      name: 'Updated California Sales Tax',
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooTaxRateBatchRequest(
  create: [taxRate1, taxRate2, taxRate3],
);

// Create a batch request with only updates
final updateOnly = WooTaxRateBatchRequest(
  update: [updatedTaxRate1, updatedTaxRate2],
);

// Create a batch request with only deletes
final deleteOnly = WooTaxRateBatchRequest(
  delete: [101, 102, 103],
);
```

### Geographical Targeting

```dart
// Create tax rates with specific geographical targeting
final batchRequest = WooTaxRateBatchRequest(
  create: [
    WooTaxRate(
      country: 'US',
      state: 'CA',
      cities: ['Los Angeles', 'San Francisco'],
      postcodes: ['90001', '90002'],
      rate: '9.50',
      name: 'California City Tax',
    ),
  ],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooTaxRateBatchRequest.fromJson(jsonData);
```

### WooTaxRateBatchRequest({this.create, this.update, this.delete})

WooCommerce Tax Rate Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple tax rates in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple tax rates in a single request
- **Bulk Updates**: Update multiple existing tax rates simultaneously
- **Bulk Deletion**: Delete multiple tax rates at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Geographical Targeting**: Manage tax rates with country, state, city, and postcode rules

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooTaxRateBatchRequest(
  create: [
    WooTaxRate(
      country: 'US',
      state: 'CA',
      rate: '8.25',
      name: 'California Sales Tax',
      priority: 1,
    ),
    WooTaxRate(
      country: 'US',
      state: 'NY',
      rate: '8.00',
      name: 'New York Sales Tax',
      priority: 1,
    ),
  ],
  update: [
    WooTaxRate(
      id: 123,
      rate: '9.25', // Updated rate
      name: 'Updated California Sales Tax',
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooTaxRateBatchRequest(
  create: [taxRate1, taxRate2, taxRate3],
);

// Create a batch request with only updates
final updateOnly = WooTaxRateBatchRequest(
  update: [updatedTaxRate1, updatedTaxRate2],
);

// Create a batch request with only deletes
final deleteOnly = WooTaxRateBatchRequest(
  delete: [101, 102, 103],
);
```

### Geographical Targeting

```dart
// Create tax rates with specific geographical targeting
final batchRequest = WooTaxRateBatchRequest(
  create: [
    WooTaxRate(
      country: 'US',
      state: 'CA',
      cities: ['Los Angeles', 'San Francisco'],
      postcodes: ['90001', '90002'],
      rate: '9.50',
      name: 'California City Tax',
    ),
  ],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooTaxRateBatchRequest.fromJson(jsonData);
```

### factory WooTaxRateBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooTaxRateBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooTaxRateBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooTaxRateBatchRequest.fromJson(jsonData);
```

### factory WooTaxRateBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooTaxRate>? create

List of tax rates to create

Each tax rate in this list will be created as a new tax rate in the store.
Tax rates in this list should not have an ID assigned.

### final List<WooTaxRate>? update

List of tax rates to update

Each tax rate in this list must have a valid ID and will be updated
with the provided values. Common use cases include:
- Updating tax rates for rate changes
- Modifying geographical targeting rules
- Changing priority or compound settings

### final List<int>? delete

List of tax rate IDs to delete

Each ID in this list represents a tax rate that will be permanently deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooTaxRateBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooTaxRateBatchRequest copyWith({ List<WooTaxRate>? create, List<WooTaxRate>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTaxRateBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooTaxRateBatchRequest(
  create: [taxRate1, taxRate2],
  update: [taxRate3],
  delete: [101, 102],
);
print(batchRequest.toString());
// Output: WooTaxRateBatchRequest(create: 2, update: 1, delete: 2)
```

## tax_rate_batch_response

### class WooTaxRateBatchResponse

WooCommerce Tax Rate Batch Response Model

This class represents the response from a batch tax rate operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created tax rates with server-assigned IDs
- **Update Results**: List of successfully updated tax rates
- **Delete Results**: List of successfully deleted tax rates
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

// Process created tax rates
for (final taxRate in response.create ?? []) {
  print('Created tax rate: ${taxRate.name} with ID: ${taxRate.id}');
  print('Rate: ${taxRate.rate}% for ${taxRate.country}/${taxRate.state}');
}

// Process updated tax rates
for (final taxRate in response.update ?? []) {
  print('Updated tax rate: ${taxRate.name}');
  print('New rate: ${taxRate.rate}%');
}

// Process deleted tax rates
for (final taxRate in response.delete ?? []) {
  print('Deleted tax rate: ${taxRate.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Analyzing Geographical Distribution

```dart
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

// Group created tax rates by country
final byCountry = <String, List<WooTaxRate>>{};
for (final taxRate in response.create ?? []) {
  final country = taxRate.country ?? 'Unknown';
  byCountry.putIfAbsent(country, () => []).add(taxRate);
}

print('Tax rates by country:');
byCountry.forEach((country, rates) {
  print('  $country: ${rates.length} rates');
});
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooTaxRateBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooTaxRateBatchResponse({this.create, this.update, this.delete})

WooCommerce Tax Rate Batch Response Model

This class represents the response from a batch tax rate operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created tax rates with server-assigned IDs
- **Update Results**: List of successfully updated tax rates
- **Delete Results**: List of successfully deleted tax rates
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

// Process created tax rates
for (final taxRate in response.create ?? []) {
  print('Created tax rate: ${taxRate.name} with ID: ${taxRate.id}');
  print('Rate: ${taxRate.rate}% for ${taxRate.country}/${taxRate.state}');
}

// Process updated tax rates
for (final taxRate in response.update ?? []) {
  print('Updated tax rate: ${taxRate.name}');
  print('New rate: ${taxRate.rate}%');
}

// Process deleted tax rates
for (final taxRate in response.delete ?? []) {
  print('Deleted tax rate: ${taxRate.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Analyzing Geographical Distribution

```dart
final response = await wooCommerce.batchUpdateTaxRates(batchRequest);

// Group created tax rates by country
final byCountry = <String, List<WooTaxRate>>{};
for (final taxRate in response.create ?? []) {
  final country = taxRate.country ?? 'Unknown';
  byCountry.putIfAbsent(country, () => []).add(taxRate);
}

print('Tax rates by country:');
byCountry.forEach((country, rates) {
  print('  $country: ${rates.length} rates');
});
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooTaxRateBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooTaxRateBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooTaxRateBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooTaxRateBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooTaxRateBatchResponse.fromJson(jsonData);
```

### factory WooTaxRateBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooTaxRate>? create

List of created tax rates

Contains the tax rates that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooTaxRate>? update

List of updated tax rates

Contains the tax rates that were successfully updated, reflecting
the current state after the update operation.

### final List<WooTaxRate>? delete

List of deleted tax rates

Contains the tax rates that were successfully deleted. These tax rates
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooTaxRateBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooTaxRateBatchResponse copyWith({ List<WooTaxRate>? create, List<WooTaxRate>? update, List<WooTaxRate>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTaxRateBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooTaxRateBatchResponse(
  create: [taxRate1, taxRate2],
  update: [taxRate3],
  delete: [taxRate4, taxRate5],
);
print(batchResponse.toString());
// Output: WooTaxRateBatchResponse(create: 2, update: 1, delete: 2)
```

