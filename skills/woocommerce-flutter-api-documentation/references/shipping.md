# shipping

## shipping_zone_api

### extension WooShippingZoneApi on WooCommerce

WooCommerce Shipping Zone API Extension

This extension provides comprehensive shipping zone management capabilities for WooCommerce stores.
Shipping zones define geographical areas where specific shipping methods and rates apply,
enabling flexible shipping configurations for different regions and customer locations.

## Shipping Zone Overview

Shipping zones are geographical areas that determine which shipping methods and rates
are available to customers based on their location. They provide a flexible way to
configure different shipping options for different regions, countries, or specific areas.

## Key Features

- **Zone Management**: Create, update, and delete shipping zones
- **Geographical Control**: Define specific areas where zones apply
- **Method Assignment**: Associate shipping methods with zones
- **Priority Ordering**: Control the order in which zones are evaluated
- **Flexible Configuration**: Support for countries, states, postcodes, and continents

## Shipping Zone Structure

A shipping zone consists of:

- **Zone Definition**: Name and priority order
- **Geographical Coverage**: Countries, states, or postcodes
- **Shipping Methods**: Available shipping options for the zone
- **Method Settings**: Configuration for each shipping method

## Example Usage

```dart
// Get all shipping zones
final zones = await wooCommerce.getShippingZones();

// Create a new shipping zone
final zone = WooShippingZone(
  name: 'North America',
  order: 1,
);
final createdZone = await wooCommerce.createShippingZone(zone);

// Update a shipping zone
zone.name = 'North America - Updated';
final updatedZone = await wooCommerce.updateShippingZone(zone);

// Delete a shipping zone
await wooCommerce.deleteShippingZone(zoneId);
```

### Future<List<WooShippingZone>> getShippingZones({bool? useFaker}) async

Retrieves all shipping zones from the WooCommerce store

This method fetches a complete list of shipping zones configured in the store.
It's particularly useful for displaying available shipping zones or managing
zone configurations in administrative interfaces.

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooShippingZone>>` containing all available shipping zones

## Example Usage

```dart
// Get all shipping zones
final zones = await wooCommerce.getShippingZones();
for (final zone in zones) {
  print('Zone: ${zone.name} (Order: ${zone.order})');
}
```

### Future<WooShippingZone> getShippingZone(int id, {bool? useFaker}) async

Retrieves a specific shipping zone by its ID

This method fetches detailed information about a single shipping zone
identified by its unique ID. It's useful for getting specific zone details
or validating zone existence.

## Parameters

* [id] - The unique identifier of the shipping zone to retrieve
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingZone>` containing the shipping zone details

## Example Usage

```dart
// Get a specific shipping zone
final zone = await wooCommerce.getShippingZone(id: 1);
print('Zone: ${zone.name}');
print('Order: ${zone.order}');
```

### Future<WooShippingZone> createShippingZone

Creates a new shipping zone in the WooCommerce store

This method allows you to create a new shipping zone with the specified
configuration. The zone will be created with the provided name and order.

## Parameters

* [zone] - The shipping zone object containing all configuration details
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingZone>` containing the created shipping zone with assigned ID

## Example Usage

```dart
// Create a new shipping zone
final zone = WooShippingZone(
  name: 'North America',
  order: 1,
);
final createdZone = await wooCommerce.createShippingZone(zone);
print('Created zone with ID: ${createdZone.id}');
```

### Future<WooShippingZone> updateShippingZone

Updates an existing shipping zone in the WooCommerce store

This method allows you to modify shipping zone configuration, including
name and order. The zone must have a valid ID.

## Parameters

* [zone] - The shipping zone object with updated configuration
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingZone>` containing the updated shipping zone

## Example Usage

```dart
// Update shipping zone name
zone.name = 'North America - Updated';
final updatedZone = await wooCommerce.updateShippingZone(zone);
print('Updated zone: ${updatedZone.name}');
```

### Future<WooDeleteResult> deleteShippingZone(int id, {bool? useFaker}) async

Deletes a shipping zone from the WooCommerce store

This method permanently removes a shipping zone and all its associated
data. Use with caution as this action cannot be undone.

## Parameters

* [zoneId] - The unique identifier of the shipping zone to delete
* [useFaker] - Override the global faker setting for this request (optional)

## Example Usage

```dart
// Delete a shipping zone
await wooCommerce.deleteShippingZone(zoneId);
print('Shipping zone deleted successfully');
```

## shipping_zone_location_api

### extension WooShippingZoneLocationApi on WooCommerce

WooCommerce Shipping Zone Location API Extension

This extension provides comprehensive shipping zone location management capabilities for WooCommerce stores.
Shipping zone locations define the geographical areas where a shipping zone applies,
enabling precise control over which customers can access specific shipping methods.

## Shipping Zone Location Overview

Shipping zone locations specify the geographical coverage of a shipping zone.
They determine which customers are eligible for the shipping methods and rates
defined within that zone based on their location.

## Key Features

- **Location Management**: Add, update, and remove locations from shipping zones
- **Geographical Control**: Support for countries, states, postcodes, and continents
- **Flexible Coverage**: Multiple location types can be combined in a single zone
- **Precise Targeting**: Target specific areas with postcode or state-level precision

## Location Types

- **Country**: Entire countries (e.g., 'US', 'CA', 'GB')
- **State**: Specific states/provinces within countries
- **Postcode**: Specific postal codes or postal code ranges
- **Continent**: Entire continents (e.g., 'NA', 'EU', 'AS')

## Example Usage

```dart
// Get all locations for a shipping zone
final locations = await wooCommerce.getShippingZoneLocations(zoneId: 1);

// Update zone locations
final newLocations = [
  WooShippingZoneLocation(code: 'US', type: 'country'),
  WooShippingZoneLocation(code: 'CA', type: 'country'),
];
final updatedLocations = await wooCommerce.updateShippingZoneLocations(
  zoneId: 1,
  locations: newLocations,
);
```

### Future<List<WooShippingZoneLocation>> getShippingZoneLocations({ required int zoneId, bool? useFaker, }) async

Retrieves all locations for a specific shipping zone

This method fetches all geographical locations associated with a shipping zone.
It's useful for understanding which areas are covered by a zone or for
displaying zone coverage in administrative interfaces.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooShippingZoneLocation>>` containing all zone locations

## Example Usage

```dart
// Get all locations for a shipping zone
final locations = await wooCommerce.getShippingZoneLocations(zoneId: 1);
for (final location in locations) {
  print('${location.type}: ${location.code}');
}
```

### Future<List<WooShippingZoneLocation>> updateShippingZoneLocations({ required int zoneId, required List<WooShippingZoneLocation> locations, bool? useFaker, }) async

Updates the locations for a shipping zone

This method allows you to modify the geographical coverage of a shipping zone
by updating its associated locations. This replaces all existing locations
with the new set of locations provided.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [locations] - List of new locations to assign to the zone
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooShippingZoneLocation>>` containing the updated zone locations

## Example Usage

```dart
// Update zone locations
final newLocations = [
  WooShippingZoneLocation(code: 'US', type: 'country'),
  WooShippingZoneLocation(code: 'CA', type: 'country'),
];
final updatedLocations = await wooCommerce.updateShippingZoneLocations(
  zoneId: 1,
  locations: newLocations,
);
print('Updated ${updatedLocations.length} locations');
```

## shipping_zone_method_api

### extension WooShippingZoneMethodApi on WooCommerce

WooCommerce Shipping Zone Method API Extension

This extension provides comprehensive shipping zone method management capabilities for WooCommerce stores.
Shipping zone methods define the specific shipping options available within a shipping zone,
including rates, settings, and delivery options for customers in that geographical area.

## Shipping Zone Method Overview

Shipping zone methods are the actual shipping options available to customers within a shipping zone.
They include methods like flat rate shipping, free shipping, local pickup, and custom shipping solutions.
Each method can be configured with specific rates, settings, and delivery conditions.

## Key Features

- **Method Management**: Create, update, and delete shipping methods within zones
- **Flexible Configuration**: Support for various shipping method types
- **Rate Control**: Configure shipping rates and conditions
- **Method Settings**: Customize method behavior and display options
- **Order Management**: Control the order in which methods are presented

## Common Shipping Methods

- **Flat Rate**: Fixed cost shipping regardless of weight or distance
- **Free Shipping**: No cost shipping (usually with minimum order requirements)
- **Local Pickup**: Customer picks up items from physical location
- **Custom Methods**: Third-party shipping integrations and custom solutions

## Example Usage

```dart
// Get all shipping methods for a zone
final methods = await wooCommerce.getShippingZoneMethods(zoneId: 1);

// Create a new shipping method
final method = WooShippingZoneMethod(
  methodId: 'flat_rate',
  title: 'Standard Shipping',
  enabled: true,
);
final createdMethod = await wooCommerce.createShippingZoneMethod(
  zoneId: 1,
  method: method,
);

// Update a shipping method
method.title = 'Express Shipping';
final updatedMethod = await wooCommerce.updateShippingZoneMethod(
  zoneId: 1,
  method: method,
);

// Delete a shipping method
await wooCommerce.deleteShippingZoneMethod(
  zoneId: 1,
  methodId: methodId,
);
```

### Future<List<WooShippingZoneMethod>> getShippingZoneMethods({ required int zoneId, bool? useFaker, }) async

Retrieves all shipping methods for a specific shipping zone

This method fetches all shipping methods configured within a shipping zone.
It's useful for displaying available shipping options or managing method
configurations for a specific geographical area.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooShippingZoneMethod>>` containing all zone shipping methods

## Example Usage

```dart
// Get all shipping methods for a zone
final methods = await wooCommerce.getShippingZoneMethods(zoneId: 1);
for (final method in methods) {
  print('${method.title}: ${method.methodId}');
}
```

### Future<WooShippingZoneMethod> getShippingZoneMethod({ required int zoneId, required int instanceId, bool? useFaker, }) async

Retrieves a specific shipping method within a shipping zone

This method fetches detailed information about a single shipping method
within a shipping zone. It's useful for getting specific method details
or validating method existence.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [methodId] - The unique identifier of the shipping method
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingZoneMethod>` containing the shipping method details

## Example Usage

```dart
// Get a specific shipping method
final method = await wooCommerce.getShippingZoneMethod(
  zoneId: 1,
  methodId: 2,
);
print('Method: ${method.title}');
print('Enabled: ${method.enabled}');
```

### Future<WooShippingZoneMethod> createShippingZoneMethod({ required int zoneId, required WooShippingZoneMethod method, bool? useFaker, }) async

Creates a new shipping method within a shipping zone

This method allows you to add a new shipping method to a shipping zone
with the specified configuration. The method will be created with the
provided settings and will be available to customers in that zone.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [method] - The shipping method object containing all configuration details
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingZoneMethod>` containing the created shipping method with assigned instance ID

## Example Usage

```dart
// Create a new shipping method
final method = WooShippingZoneMethod(
  methodId: 'flat_rate',
  title: 'Standard Shipping',
  enabled: true,
);
final createdMethod = await wooCommerce.createShippingZoneMethod(
  zoneId: 1,
  method: method,
);
print('Created method with ID: ${createdMethod.instanceId}');
```

### Future<WooShippingZoneMethod> updateShippingZoneMethod({ required int zoneId, required WooShippingZoneMethod method, bool? useFaker, }) async

Updates an existing shipping method within a shipping zone

This method allows you to modify shipping method configuration, including
title, settings, and enabled status. The method must have a valid instance ID.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [method] - The shipping method object with updated configuration
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingZoneMethod>` containing the updated shipping method

## Example Usage

```dart
// Update shipping method title
method.title = 'Express Shipping';
final updatedMethod = await wooCommerce.updateShippingZoneMethod(
  zoneId: 1,
  method: method,
);
print('Updated method: ${updatedMethod.title}');
```

### Future<WooDeleteResult> deleteShippingZoneMethod({ required int zoneId, required int instanceId, bool? useFaker, }) async

Deletes a shipping method from a shipping zone

This method permanently removes a shipping method from a shipping zone.
Use with caution as this action cannot be undone.

## Parameters

* [zoneId] - The unique identifier of the shipping zone
* [methodId] - The unique identifier of the shipping method to delete
* [useFaker] - Override the global faker setting for this request (optional)

## Example Usage

```dart
// Delete a shipping method
await wooCommerce.deleteShippingZoneMethod(
  zoneId: 1,
  methodId: 2,
);
print('Shipping method deleted successfully');
```

## shipping_zone

### class WooShippingZone

WooCommerce Shipping Zone Model

Represents a shipping zone in WooCommerce that defines geographical areas
where specific shipping methods and rates apply. Shipping zones enable
flexible shipping configurations for different regions and customer locations.

## Shipping Zone Structure

A shipping zone consists of key components:

- **Identification**: Unique ID and human-readable name
- **Priority Order**: Order in which zones are evaluated
- **Geographical Coverage**: Countries, states, or postcodes
- **Shipping Methods**: Available shipping options for the zone

## Zone Evaluation Order

Shipping zones are evaluated in order of their `order` field (ascending).
The first zone that matches a customer's location will be used for shipping
calculations. This allows for priority-based shipping configuration.

## Example Usage

```dart
// Create a new shipping zone
final zone = WooShippingZone(
  name: 'North America',
  order: 1,
);

// Create from API response
final zone = WooShippingZone.fromJson({
  'id': 1,
  'name': 'North America',
  'order': 1
});

// Access properties
print('Zone: ${zone.name} (Order: ${zone.order})');

// Convert to JSON
final json = zone.toJson();
```

### WooShippingZone({this.id, this.name, this.order})

WooCommerce Shipping Zone Model

Represents a shipping zone in WooCommerce that defines geographical areas
where specific shipping methods and rates apply. Shipping zones enable
flexible shipping configurations for different regions and customer locations.

## Shipping Zone Structure

A shipping zone consists of key components:

- **Identification**: Unique ID and human-readable name
- **Priority Order**: Order in which zones are evaluated
- **Geographical Coverage**: Countries, states, or postcodes
- **Shipping Methods**: Available shipping options for the zone

## Zone Evaluation Order

Shipping zones are evaluated in order of their `order` field (ascending).
The first zone that matches a customer's location will be used for shipping
calculations. This allows for priority-based shipping configuration.

## Example Usage

```dart
// Create a new shipping zone
final zone = WooShippingZone(
  name: 'North America',
  order: 1,
);

// Create from API response
final zone = WooShippingZone.fromJson({
  'id': 1,
  'name': 'North America',
  'order': 1
});

// Access properties
print('Zone: ${zone.name} (Order: ${zone.order})');

// Convert to JSON
final json = zone.toJson();
```

### factory WooShippingZone.fromJson(Map<String, dynamic> json)

Creates a WooShippingZone from JSON data

This factory constructor parses JSON data received from the WooCommerce
REST API and creates a corresponding WooShippingZone object.

## Parameters

* [json] - Map containing shipping zone data from WooCommerce API

## Returns

A `WooShippingZone` instance with data from the JSON input

## Example Usage

```dart
// Parse API response
final jsonData = {
  'id': 1,
  'name': 'North America',
  'order': 1
};
final zone = WooShippingZone.fromJson(jsonData);
```

### factory WooShippingZone.fake()

Creates a fake shipping zone for testing and development

This factory constructor generates a WooShippingZone instance with
fake data using the FakeHelper utility. It's particularly useful for
testing, development, and demonstration purposes.

## Returns

A `WooShippingZone` instance with generated fake data

## Example Usage

```dart
// Generate fake shipping zone for testing
final fakeZone = WooShippingZone.fake();
print('Fake zone: ${fakeZone.name}');
```

### final int? id

Unique identifier for the shipping zone

This ID is automatically assigned by WooCommerce when the zone is created.
It's used to identify the zone in API calls and is required for updates and deletions.

### final String? name

Human-readable name for the shipping zone

This name helps you identify the shipping zone in the WooCommerce admin panel
and in your application. It should be descriptive of the geographical area
or customer segment the zone serves.

### final int? order

Priority order for zone evaluation

Controls the order in which shipping zones are evaluated. Lower numbers
are evaluated first. This allows you to create priority-based shipping
configurations where more specific zones are checked before general ones.

### Map<String, dynamic> toJson()

Converts the shipping zone to JSON format

This method serializes the WooShippingZone object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the shipping zone data in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = zone.toJson();
print(jsonData); // {'id': 1, 'name': 'North America', 'order': 1}
```

### WooShippingZone copyWith({int? id, String? name, int? order})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## shipping_zone_location

### class WooShippingZoneLocation

WooCommerce Shipping Zone Location Model

Represents a geographical location within a shipping zone that determines
which customers are eligible for the shipping methods and rates defined
within that zone based on their location.

## Shipping Zone Location Structure

A shipping zone location consists of key components:

- **Location Code**: The specific geographical identifier
- **Location Type**: The type of geographical area (country, state, postcode, continent)
- **Coverage Definition**: Determines which customers are covered by the zone

## Location Types

- **Country**: Entire countries (e.g., 'US', 'CA', 'GB')
- **State**: Specific states/provinces within countries
- **Postcode**: Specific postal codes or postal code ranges
- **Continent**: Entire continents (e.g., 'NA', 'EU', 'AS')

## Example Usage

```dart
// Create a country location
final location = WooShippingZoneLocation(
  code: 'US',
  type: 'country',
);

// Create from API response
final location = WooShippingZoneLocation.fromJson({
  'code': 'US',
  'type': 'country'
});

// Access properties
print('${location.type}: ${location.code}');

// Convert to JSON
final json = location.toJson();
```

### WooShippingZoneLocation({this.code, this.type})

WooCommerce Shipping Zone Location Model

Represents a geographical location within a shipping zone that determines
which customers are eligible for the shipping methods and rates defined
within that zone based on their location.

## Shipping Zone Location Structure

A shipping zone location consists of key components:

- **Location Code**: The specific geographical identifier
- **Location Type**: The type of geographical area (country, state, postcode, continent)
- **Coverage Definition**: Determines which customers are covered by the zone

## Location Types

- **Country**: Entire countries (e.g., 'US', 'CA', 'GB')
- **State**: Specific states/provinces within countries
- **Postcode**: Specific postal codes or postal code ranges
- **Continent**: Entire continents (e.g., 'NA', 'EU', 'AS')

## Example Usage

```dart
// Create a country location
final location = WooShippingZoneLocation(
  code: 'US',
  type: 'country',
);

// Create from API response
final location = WooShippingZoneLocation.fromJson({
  'code': 'US',
  'type': 'country'
});

// Access properties
print('${location.type}: ${location.code}');

// Convert to JSON
final json = location.toJson();
```

### factory WooShippingZoneLocation.fromJson(Map<String, dynamic> json)

Creates a WooShippingZoneLocation from JSON data

This factory constructor parses JSON data received from the WooCommerce
REST API and creates a corresponding WooShippingZoneLocation object.

## Parameters

* [json] - Map containing location data from WooCommerce API

## Returns

A `WooShippingZoneLocation` instance with data from the JSON input

## Example Usage

```dart
// Parse API response
final jsonData = {
  'code': 'US',
  'type': 'country'
};
final location = WooShippingZoneLocation.fromJson(jsonData);
```

### factory WooShippingZoneLocation.fake()

Creates a fake shipping zone location for testing and development

This factory constructor generates a WooShippingZoneLocation instance with
fake data using the FakeHelper utility. It's particularly useful for
testing, development, and demonstration purposes.

## Returns

A `WooShippingZoneLocation` instance with generated fake data

## Example Usage

```dart
// Generate fake location for testing
final fakeLocation = WooShippingZoneLocation.fake();
print('Fake location: ${fakeLocation.type} - ${fakeLocation.code}');
```

### final String? code

Geographical location code

The specific identifier for the geographical area. The format depends on
the location type:
- Country: ISO 3166-1 alpha-2 country codes (e.g., 'US', 'CA')
- State: State/province codes (e.g., 'CA', 'NY')
- Postcode: Postal codes or ranges (e.g., '90210', '10000-20000')
- Continent: Continent codes (e.g., 'NA', 'EU')

### final String? type

Type of geographical location

Specifies the type of geographical area this location represents.
Common values include 'country', 'state', 'postcode', and 'continent'.

### Map<String, dynamic> toJson()

Converts the location to JSON format

This method serializes the WooShippingZoneLocation object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.

## Returns

A `Map<String, dynamic>` containing the location data in JSON format

## Example Usage

```dart
// Convert to JSON
final jsonData = location.toJson();
print(jsonData); // {'code': 'US', 'type': 'country'}
```

### WooShippingZoneLocation copyWith({String? code, String? type})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## shipping_zone_method

### class WooShippingZoneMethod

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooShippingZoneMethod({ required this.methodId, this.instanceId, this.title, this.order, this.enabled, this.methodTitle, this.methodDescription, this.settings, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooShippingZoneMethod.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooShippingZoneMethod.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? methodId

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? instanceId

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? title

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? order

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? enabled

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? methodTitle

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? methodDescription

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooShippingZoneMethod copyWith({ String? methodId, int? instanceId, String? title, int? order, bool? enabled, String? methodTitle, String? methodDescription, Map<String, WooShippingZoneMethodSetting>? settings, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## shipping_zone_method_setting

### class WooShippingZoneMethodSetting

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooShippingZoneMethodSetting({ this.id, this.label, this.description, this.type, this.value, this.defaultValue, this.tip, this.placeholder, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooShippingZoneMethodSetting.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooShippingZoneMethodSetting.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? id

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? label

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? description

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? type

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? defaultValue

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? tip

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? placeholder

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooShippingZoneMethodSetting copyWith({ String? id, String? label, String? description, String? type, String? value, String? defaultValue, String? tip, String? placeholder, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

