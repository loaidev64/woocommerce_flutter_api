# shipping_method

## shipping_method_api

### extension WooShippingMethodApi on WooCommerce

WooCommerce Shipping Method API Extension

This extension provides comprehensive shipping method management capabilities for WooCommerce stores.
Shipping methods define how products are delivered to customers, including delivery options, costs,
and availability rules for e-commerce applications.

## Shipping Method Overview

Shipping methods are delivery options configured in WooCommerce that determine how products
are shipped to customers. They provide a way to offer different delivery options with varying
costs and timeframes to enhance the customer shopping experience.

## Key Features

- **Method Retrieval**: Fetch all available shipping methods from the store
- **Individual Access**: Get specific shipping method details by ID
- **Display Information**: Access human-readable titles and descriptions
- **Fake Data Support**: Built-in fake data generation for testing and development

## Shipping Method Types

- **Flat Rate**: Fixed cost shipping regardless of weight or distance
- **Free Shipping**: No cost shipping (usually with minimum order requirements)
- **Local Pickup**: Customer picks up items from physical location
- **Custom Methods**: Third-party shipping integrations and custom solutions

## Example Usage

```dart
// Get all shipping methods
final methods = await wooCommerce.getShippingMethods();

// Get specific shipping method
final method = await wooCommerce.getShippingMethod(id: 'flat_rate');

// Display shipping options to customers
for (final method in methods) {
  print('${method.title}: ${method.description}');
}
```

### Future<List<WooShippingMethod>> getShippingMethods({bool? useFaker}) async

Retrieves a paginated list of shipping methods from the WooCommerce store.

This method allows you to fetch all available shipping methods configured in your store.
It's particularly useful for displaying shipping options to customers during checkout
or for administrative management of shipping configurations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-shipping-methods

## Parameters

* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<List<WooShippingMethod>>` containing the shipping method objects.

## Example Usage

```dart
// Get all shipping methods
final methods = await wooCommerce.getShippingMethods();

// Display shipping options in UI
for (final method in methods) {
  print('${method.title}: ${method.description}');
}

// Use fake data for testing
final fakeMethods = await wooCommerce.getShippingMethods(useFaker: true);
```

### Future<WooShippingMethod> getShippingMethod(String id, {bool? useFaker}) async

Retrieves a specific shipping method by its unique identifier.

This method fetches detailed information about a single shipping method
identified by its unique ID. It's useful for getting specific shipping
method details, validating shipping method existence, or displaying
detailed information about a particular shipping option.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-shipping-method

## Parameters

* [id] - The unique identifier of the shipping method to retrieve
* [useFaker] - Override the global faker setting for this request (optional)

## Returns

A `Future<WooShippingMethod>` containing the shipping method details.

## Throws

* `WooCommerceException` if the shipping method is not found or access is denied

## Example Usage

```dart
// Get a specific shipping method
final method = await wooCommerce.getShippingMethod(id: 'flat_rate');
print('Shipping Method: ${method.title}');
print('Description: ${method.description}');

// Check if method exists
try {
  final method = await wooCommerce.getShippingMethod(id: 'express');
  print('Express shipping is available');
} catch (e) {
  print('Express shipping not found');
}
```

## shipping_method

### class WooShippingMethod

WooCommerce Shipping Method Model

Represents a shipping method configuration in WooCommerce. Shipping methods define
how products are delivered to customers, including delivery options, costs, and
availability rules for e-commerce applications.

## Shipping Method Structure

A shipping method consists of several key components:

- **Identification**: Unique ID and human-readable title
- **Display Information**: Title and description for customer display
- **Configuration**: Method-specific settings and rules
- **Availability**: Rules determining when the method is available

## Shipping Method Types

1. **Flat Rate**: Fixed cost shipping regardless of weight or distance
2. **Free Shipping**: No cost shipping (usually with minimum order requirements)
3. **Local Pickup**: Customer picks up items from physical location
4. **Custom Methods**: Third-party shipping integrations and custom solutions

## Example Usage

```dart
// Create a new shipping method
final method = WooShippingMethod(
  id: 'flat_rate',
  title: 'Flat Rate Shipping',
  description: 'Fixed rate shipping for all orders',
);

// Create from API response
final method = WooShippingMethod.fromJson({
  'id': 'flat_rate',
  'title': 'Flat Rate Shipping',
  'description': 'Fixed rate shipping'
});

// Access properties
print('${method.title}: ${method.description}');

// Convert to JSON
final json = method.toJson();
```

### WooShippingMethod({this.id, this.title, this.description})

WooCommerce Shipping Method Model

Represents a shipping method configuration in WooCommerce. Shipping methods define
how products are delivered to customers, including delivery options, costs, and
availability rules for e-commerce applications.

## Shipping Method Structure

A shipping method consists of several key components:

- **Identification**: Unique ID and human-readable title
- **Display Information**: Title and description for customer display
- **Configuration**: Method-specific settings and rules
- **Availability**: Rules determining when the method is available

## Shipping Method Types

1. **Flat Rate**: Fixed cost shipping regardless of weight or distance
2. **Free Shipping**: No cost shipping (usually with minimum order requirements)
3. **Local Pickup**: Customer picks up items from physical location
4. **Custom Methods**: Third-party shipping integrations and custom solutions

## Example Usage

```dart
// Create a new shipping method
final method = WooShippingMethod(
  id: 'flat_rate',
  title: 'Flat Rate Shipping',
  description: 'Fixed rate shipping for all orders',
);

// Create from API response
final method = WooShippingMethod.fromJson({
  'id': 'flat_rate',
  'title': 'Flat Rate Shipping',
  'description': 'Fixed rate shipping'
});

// Access properties
print('${method.title}: ${method.description}');

// Convert to JSON
final json = method.toJson();
```

### factory WooShippingMethod.fromJson(Map<String, dynamic> json)

Creates a WooShippingMethod instance from JSON data

This factory constructor parses JSON data received from the WooCommerce
REST API and creates a corresponding WooShippingMethod object. It handles
the conversion of API response data into a structured Dart object.

## Parameters

* [json] - Map containing shipping method data from WooCommerce API

## Returns

A `WooShippingMethod` instance with data from the JSON input

## Example Usage

```dart
// Parse API response
final jsonData = {
  'id': 'flat_rate',
  'title': 'Flat Rate Shipping',
  'description': 'Fixed rate shipping for all orders'
};
final method = WooShippingMethod.fromJson(jsonData);
```

### factory WooShippingMethod.fake()

Creates a fake shipping method for testing and development

This factory constructor generates a WooShippingMethod instance with
fake data using the FakeHelper utility. It's particularly useful for
testing, development, and demonstration purposes when real API data
is not available or needed.

## Returns

A `WooShippingMethod` instance with generated fake data

## Example Usage

```dart
// Generate fake shipping method for testing
final fakeMethod = WooShippingMethod.fake();
print(fakeMethod.title); // Random generated title

// Use in development
final testMethods = List.generate(3, (_) => WooShippingMethod.fake());
```

### final String? id

Unique identifier for the shipping method

This identifier is used by WooCommerce to distinguish between different
shipping methods. Common values include 'flat_rate', 'free_shipping',
'local_pickup', and custom method identifiers.

### final String? title

Display title for the shipping method

The human-readable name that customers see during checkout.
This title is typically configured in the WooCommerce admin panel
and can be customized for different languages or regions.

### final String? description

Description of the shipping method

Provides additional information about the shipping method, such as
delivery timeframes, special conditions, or service details. This
description helps customers understand what to expect from their
shipping selection.

### Map<String, dynamic> toJson()

Converts the shipping method to JSON format

This method serializes the WooShippingMethod object into a JSON-compatible
map that can be sent to the WooCommerce API or stored in a database.
It includes all non-null properties in the resulting JSON structure.

## Returns

A `Map<String, dynamic>` containing the shipping method data in JSON format

## Example Usage

```dart
// Convert to JSON for API requests
final jsonData = method.toJson();
print(jsonData); // {'id': 'flat_rate', 'title': 'Flat Rate', 'description': 'Fixed rate'}

// Send to API
await dio.post('/shipping_methods', data: method.toJson());
```

### WooShippingMethod copyWith

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

