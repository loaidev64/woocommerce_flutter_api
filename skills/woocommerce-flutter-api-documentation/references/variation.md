# variation

## variation_api

### extension WooVariationApi on WooCommerce

WooCommerce Product Variation API Extension

This extension provides comprehensive product variation management capabilities for WooCommerce stores.
Product variations are different versions of a variable product, each with their own attributes,
pricing, inventory, and other properties.

## Key Features

- **Variation Retrieval**: Get all variations for a product or a specific variation
- **Advanced Filtering**: Filter variations by price, stock status, SKU, and more
- **Pagination Support**: Handle large product catalogs with efficient pagination
- **Search Capabilities**: Find variations using search terms and filters
- **Fake Data Support**: Generate fake variation data for testing and development

## Example Usage

```dart
// Get all variations for a product
final variations = await wooCommerce.getProductVaritaions(productId: 123);

// Get a specific variation
final variation = await wooCommerce.getProductVariation(productId: 123, id: 456);

// Search variations with filters
final filteredVariations = await wooCommerce.getProductVaritaions(
  productId: 123,
  search: 'red',
  stockStatus: WooProductStockStatus.instock,
  minPrice: 10.0,
  maxPrice: 100.0,
);
```

### Future<WooPage<WooProductVariation>> getProductVariations

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductVariation> getProductVariation

Retrieves a specific product variation by ID.

This method fetches detailed information about a single product variation,
including all its attributes, pricing, inventory, and metadata.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-variation

## Parameters

* [productId] - The ID of the parent product
* [id] - The ID of the specific variation to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductVariation>` containing the variation object.

## Throws

* `WooCommerceException` if the request fails or access is denied
* `WooCommerceException` if the variation or parent product is not found

## Example Usage

```dart
// Get a specific variation
final variation = await wooCommerce.getProductVariation(
  productId: 123,
  id: 456,
);

// Check variation properties
if (variation.onSale == true) {
  print('Variation is on sale: ${variation.salePrice}');
}
```

### Future<WooProductVariation> createProductVariation

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductVariation> updateProductVariation

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteProductVariation

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductVariationBatchResponse> batchUpdateProductVariations

Performs batch operations on product variations (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple product variations
efficiently in a single API call, reducing the number of requests needed
for bulk operations. All variations must belong to the same parent product.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-product-variations

## Parameters

* [productId] - The ID of the parent product that owns these variations
* [request] - The batch request containing variations to create, update, and/or delete
  - `create`: List of `WooProductVariation` objects to create (should not have IDs)
  - `update`: List of `WooProductVariation` objects to update (must include valid IDs)
  - `delete`: List of variation IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductVariationBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created variations with server-assigned IDs
- `update`: List of successfully updated variations
- `delete`: List of successfully deleted variations

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooProductVariationBatchRequest(
  create: [
    WooProductVariation(
      sku: 'T-SHIRT-RED-L',
      price: 25.99,
      regularPrice: 29.99,
      stockQuantity: 50,
      stockStatus: WooProductStockStatus.instock,
    ),
    WooProductVariation(
      sku: 'T-SHIRT-BLUE-L',
      price: 25.99,
      regularPrice: 29.99,
      stockQuantity: 30,
      stockStatus: WooProductStockStatus.instock,
    ),
  ],
  update: [
    existingVariation..price = 24.99,
  ],
  delete: [789, 101112],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateProductVariations(
  123,
  batchRequest,
);

// Process results
print('Created ${response.create?.length ?? 0} variations');
print('Updated ${response.update?.length ?? 0} variations');
print('Deleted ${response.delete?.length ?? 0} variations');

// Access individual results
for (final variation in response.create ?? []) {
  print('Created variation: ${variation.sku} with ID: ${variation.id}');
}
```

## Batch Operations Best Practices

- **Product Scoping**: All variations in the batch must belong to the same parent product
- **Create operations**: Variations should not have IDs assigned
- **Update operations**: Variations must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of variations to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## variation_query

### class WooVariationQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooVariationQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.after, this.before, this.datesAreGmt, this.modifiedAfter, this.modifiedBefore, this.exclude, this.include, this.parent, this.parentExclude, this.slug, this.status, this.sku, this.taxClass, this.onSale, this.minPrice, this.maxPrice, this.stockStatus, this.menuOrder, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? after

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? before

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? datesAreGmt

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? modifiedAfter

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? modifiedBefore

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? parent

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? parentExclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductStatus? status

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? sku

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? taxClass

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? onSale

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final double? minPrice

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final double? maxPrice

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductStockStatus? stockStatus

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? menuOrder

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## variation

### class WooProductVariation

WooCommerce Product Variation Model

Represents a product variation in WooCommerce, which is a specific version of a variable product
with its own attributes, pricing, inventory, and other properties. Variations allow customers
to choose different options like size, color, material, etc., for the same base product.

## Key Features

- **Attribute Management**: Store and manage variation-specific attributes
- **Pricing Control**: Set individual prices, sale prices, and sale periods
- **Inventory Management**: Track stock levels, backorders, and stock status
- **Download Support**: Handle downloadable products with download limits and expiry
- **Shipping Configuration**: Set weight, dimensions, and shipping class
- **Tax Configuration**: Configure tax status and tax class per variation

## Usage Examples

### Creating a Product Variation

```dart
final variation = WooProductVariation(
  sku: 'T-SHIRT-RED-L',
  price: 25.99,
  regularPrice: 29.99,
  salePrice: 25.99,
  stockQuantity: 50,
  stockStatus: WooProductStockStatus.instock,
);
```

### Working with Variation Data

```dart
// Check if variation is on sale
if (variation.onSale == true) {
  print('Sale price: ${variation.salePrice}');
}

// Check stock availability
if (variation.stockStatus == WooProductStockStatus.instock) {
  print('Available quantity: ${variation.stockQuantity}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = variation.toJson();

// Create from JSON response
final variation = WooProductVariation.fromJson(jsonData);
```

### WooProductVariation({ this.id, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.description, this.permalink, this.sku, this.price, this.attributes, this.regularPrice, this.salePrice, this.dateOnSaleFrom, this.dateOnSaleFromGmt, this.dateOnSaleTo, this.dateOnSaleToGmt, this.onSale, this.status, this.purchasable, this.virtual, this.downloadable, this.downloads, this.downloadLimit, this.downloadExpiry, this.taxStatus, this.taxClass, this.manageStock, this.stockQuantity, this.stockStatus, this.backorders, this.backordersAllowed, this.backordered, this.weight, this.shippingClass, this.shippingClassId, this.menuOrder, this.dimensions, this.metaData, this.image, })

WooCommerce Product Variation Model

Represents a product variation in WooCommerce, which is a specific version of a variable product
with its own attributes, pricing, inventory, and other properties. Variations allow customers
to choose different options like size, color, material, etc., for the same base product.

## Key Features

- **Attribute Management**: Store and manage variation-specific attributes
- **Pricing Control**: Set individual prices, sale prices, and sale periods
- **Inventory Management**: Track stock levels, backorders, and stock status
- **Download Support**: Handle downloadable products with download limits and expiry
- **Shipping Configuration**: Set weight, dimensions, and shipping class
- **Tax Configuration**: Configure tax status and tax class per variation

## Usage Examples

### Creating a Product Variation

```dart
final variation = WooProductVariation(
  sku: 'T-SHIRT-RED-L',
  price: 25.99,
  regularPrice: 29.99,
  salePrice: 25.99,
  stockQuantity: 50,
  stockStatus: WooProductStockStatus.instock,
);
```

### Working with Variation Data

```dart
// Check if variation is on sale
if (variation.onSale == true) {
  print('Sale price: ${variation.salePrice}');
}

// Check stock availability
if (variation.stockStatus == WooProductStockStatus.instock) {
  print('Available quantity: ${variation.stockQuantity}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = variation.toJson();

// Create from JSON response
final variation = WooProductVariation.fromJson(jsonData);
```

### factory WooProductVariation.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductVariation.fake()

Creates a fake WooProductVariation instance for testing purposes

This factory constructor generates a variation with random but realistic
data, making it useful for testing and development.

## Returns

A `WooProductVariation` instance with randomly generated fake data.

## Example Usage

```dart
final fakeVariation = WooProductVariation.fake();
```

### final int? id

Unique identifier for the resource.

### final DateTime? dateCreated

The date the variation was created, in the site's timezone.

### final DateTime? dateCreatedGmt

The date the variation was created, as GMT.

### final DateTime? dateModified

The date the variation was last modified, in the site's timezone.

### final DateTime? dateModifiedGmt

The date the variation was last modified, as GMT.

### final String? description

Variation description.

### final String? permalink

Variation URL.

### final String? sku

Unique identifier.

### final double? price

Current variation price.

### final List<WooProductItemAttribute>? attributes

List of attributes.

### final double? regularPrice

Variation regular price.

### final double? salePrice

Variation sale price.

### final DateTime? dateOnSaleFrom

Start date of sale price, in the site's timezone.

### final DateTime? dateOnSaleFromGmt

Start date of sale price, as GMT.

### final DateTime? dateOnSaleTo

End date of sale price, in the site's timezone.

### final DateTime? dateOnSaleToGmt

End date of sale price, as GMT.

### final bool? onSale

Shows if the variation is on sale.

### final WooProductStatus? status

Variation status. Options: draft, pending, private and publish. Default is publish.

### final bool? purchasable

Shows if the variation can be bought.

### final bool? virtual

If the variation is virtual. Default is false.

### final bool? downloadable

If the variation is downloadable. Default is false.

### final List<WooProductDownload>? downloads

If the variation is downloadable. Default is false.

### final int? downloadLimit

Number of times downloadable files can be downloaded after purchase. Default is -1.

### final int? downloadExpiry

Number of days until access to downloadable files expires. Default is -1.

### final WooProductTaxStatus? taxStatus

Tax status. Options: taxable, shipping and none. Default is taxable.

### final String? taxClass

Tax class.

### final bool? manageStock

Stock management at variation level. Default is false.

### final int? stockQuantity

Stock quantity.

### final WooProductStockStatus? stockStatus

Controls the stock status of the product. Options: instock, outofstock, onbackorder. Default is instock.

### final WooProductBackorder? backorders

If managing stock, this controls if backorders are allowed. Options: no, notify and yes. Default is no.

### final bool? backordersAllowed

Shows if backorders are allowed.

### final bool? backordered

Shows if the variation is on backordered.

### final String? weight

Variation weight.

### final String? shippingClass

Shipping class slug.

### final int? shippingClassId

Shipping class ID.

### final int? menuOrder

Menu order, used to custom sort products.

### final WooProductDimension? dimensions

Variation dimensions.

### final List<WooMetaData>? metaData

Meta data.

### final WooProductImage? image

Variation image data.

### Map<String, dynamic> toJson()

Converts the WooProductVariation instance to JSON format

This method serializes the variation data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the variation data in JSON format.

## Example Usage

```dart
final jsonData = variation.toJson();
```

### WooProductVariation copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, String? description, String? permalink, String? sku, double? price, List<WooProductItemAttribute>? attributes, double? regularPrice, double? salePrice, DateTime? dateOnSaleFrom, DateTime? dateOnSaleFromGmt, DateTime? dateOnSaleTo, DateTime? dateOnSaleToGmt, bool? onSale, WooProductStatus? status, bool? purchasable, bool? virtual, bool? downloadable, List<WooProductDownload>? downloads, int? downloadLimit, int? downloadExpiry, WooProductTaxStatus? taxStatus, String? taxClass, bool? manageStock, int? stockQuantity, WooProductStockStatus? stockStatus, WooProductBackorder? backorders, bool? backordersAllowed, bool? backordered, String? weight, String? shippingClass, int? shippingClassId, int? menuOrder, WooProductDimension? dimensions, List<WooMetaData>? metaData, WooProductImage? image, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductVariation instance

This method provides a human-readable representation of the variation,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the variation's main field values in a readable format.

## Example Usage

```dart
final variation = WooProductVariation(sku: 'T-SHIRT-RED-L', price: 25.99);
print(variation.toString());
// Output: WooProductVariation(id: 1, sku: T-SHIRT-RED-L, price: 25.99, status: publish, stockStatus: instock)
```

## variation_batch_request

### class WooProductVariationBatchRequest

WooCommerce Product Variation Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product variations in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple variations in a single request
- **Bulk Updates**: Update multiple existing variations simultaneously
- **Bulk Deletion**: Delete multiple variations at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Product Scoped**: All variations must belong to the same parent product

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductVariationBatchRequest(
  create: [
    WooProductVariation(
      sku: 'T-SHIRT-RED-L',
      price: 25.99,
      regularPrice: 29.99,
      stockQuantity: 50,
      stockStatus: WooProductStockStatus.instock,
    ),
    WooProductVariation(
      sku: 'T-SHIRT-BLUE-L',
      price: 25.99,
      regularPrice: 29.99,
      stockQuantity: 30,
      stockStatus: WooProductStockStatus.instock,
    ),
  ],
  update: [
    existingVariation..price = 24.99,
  ],
  delete: [789, 101112],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductVariationBatchRequest(
  create: [variation1, variation2, variation3],
);

// Create a batch request with only updates
final updateOnly = WooProductVariationBatchRequest(
  update: [updatedVariation1, updatedVariation2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductVariationBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductVariationBatchRequest.fromJson(jsonData);
```

### WooProductVariationBatchRequest({this.create, this.update, this.delete})

WooCommerce Product Variation Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product variations in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple variations in a single request
- **Bulk Updates**: Update multiple existing variations simultaneously
- **Bulk Deletion**: Delete multiple variations at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Product Scoped**: All variations must belong to the same parent product

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductVariationBatchRequest(
  create: [
    WooProductVariation(
      sku: 'T-SHIRT-RED-L',
      price: 25.99,
      regularPrice: 29.99,
      stockQuantity: 50,
      stockStatus: WooProductStockStatus.instock,
    ),
    WooProductVariation(
      sku: 'T-SHIRT-BLUE-L',
      price: 25.99,
      regularPrice: 29.99,
      stockQuantity: 30,
      stockStatus: WooProductStockStatus.instock,
    ),
  ],
  update: [
    existingVariation..price = 24.99,
  ],
  delete: [789, 101112],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductVariationBatchRequest(
  create: [variation1, variation2, variation3],
);

// Create a batch request with only updates
final updateOnly = WooProductVariationBatchRequest(
  update: [updatedVariation1, updatedVariation2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductVariationBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductVariationBatchRequest.fromJson(jsonData);
```

### factory WooProductVariationBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooProductVariationBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooProductVariationBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooProductVariationBatchRequest.fromJson(jsonData);
```

### factory WooProductVariationBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductVariation>? create

List of variations to create

Each variation in this list will be created as a new variation for the parent product.
Variations in this list should not have an ID assigned.

### final List<WooProductVariation>? update

List of variations to update

Each variation in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of variation IDs to delete

Each ID in this list represents a variation that will be deleted from the product.

### Map<String, dynamic> toJson()

Converts the WooProductVariationBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooProductVariationBatchRequest copyWith({ List<WooProductVariation>? create, List<WooProductVariation>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductVariationBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooProductVariationBatchRequest(
  create: [variation1, variation2],
  update: [variation3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooProductVariationBatchRequest(create: 2, update: 1, delete: 2)
```

## variation_batch_response

### class WooProductVariationBatchResponse

WooCommerce Product Variation Batch Response Model

This class represents the response from a batch product variation operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created variations with server-assigned IDs
- **Update Results**: List of successfully updated variations
- **Delete Results**: List of successfully deleted variations
- **Comprehensive Response**: All operations results in a single response object
- **Product Scoped**: All variations belong to the same parent product

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductVariations(
  productId: 123,
  batchRequest,
);

// Process created variations
for (final variation in response.create ?? []) {
  print('Created variation: ${variation.sku} with ID: ${variation.id}');
}

// Process updated variations
for (final variation in response.update ?? []) {
  print('Updated variation: ${variation.sku}');
}

// Process deleted variations
for (final variation in response.delete ?? []) {
  print('Deleted variation: ${variation.sku}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductVariations(
  productId: 123,
  batchRequest,
);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooProductVariationBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooProductVariationBatchResponse({this.create, this.update, this.delete})

WooCommerce Product Variation Batch Response Model

This class represents the response from a batch product variation operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created variations with server-assigned IDs
- **Update Results**: List of successfully updated variations
- **Delete Results**: List of successfully deleted variations
- **Comprehensive Response**: All operations results in a single response object
- **Product Scoped**: All variations belong to the same parent product

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductVariations(
  productId: 123,
  batchRequest,
);

// Process created variations
for (final variation in response.create ?? []) {
  print('Created variation: ${variation.sku} with ID: ${variation.id}');
}

// Process updated variations
for (final variation in response.update ?? []) {
  print('Updated variation: ${variation.sku}');
}

// Process deleted variations
for (final variation in response.delete ?? []) {
  print('Deleted variation: ${variation.sku}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductVariations(
  productId: 123,
  batchRequest,
);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooProductVariationBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooProductVariationBatchResponse.fromJson

Creates a WooProductVariationBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooProductVariationBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooProductVariationBatchResponse.fromJson(jsonData);
```

### factory WooProductVariationBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductVariation>? create

List of created variations

Contains the variations that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooProductVariation>? update

List of updated variations

Contains the variations that were successfully updated, reflecting
the current state after the update operation.

### final List<WooProductVariation>? delete

List of deleted variations

Contains the variations that were successfully deleted. These variations
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooProductVariationBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooProductVariationBatchResponse copyWith({ List<WooProductVariation>? create, List<WooProductVariation>? update, List<WooProductVariation>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductVariationBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooProductVariationBatchResponse(
  create: [variation1, variation2],
  update: [variation3],
  delete: [variation4, variation5],
);
print(batchResponse.toString());
// Output: WooProductVariationBatchResponse(create: 2, update: 1, delete: 2)
```

