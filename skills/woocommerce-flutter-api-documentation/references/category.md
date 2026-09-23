# category

## category_api

### extension WooCategoryApi on WooCommerce

WooCommerce Category API Extension

This extension provides comprehensive product category management capabilities for WooCommerce stores.
It allows you to create, read, update, and delete product categories, as well as retrieve category lists
with extensive filtering and pagination options.

## Key Features

- **Category Management**: Create, read, update, and delete product categories
- **Hierarchical Support**: Handle parent-child category relationships
- **Advanced Filtering**: Filter categories by parent, product, slug, and more
- **Pagination Support**: Efficiently handle large category collections
- **Search Capabilities**: Find categories by name or other criteria
- **Display Control**: Configure how categories display products and subcategories

## Example Usage

```dart
// Get all categories
final categories = await wooCommerce.getCategories();

// Create a new category
final category = WooProductCategory(
  name: 'Electronics',
  description: 'Electronic products and gadgets',
);
final created = await wooCommerce.createCategory(category);
```

### Future<WooPage<WooProductCategory>> getCategories({ WooContext context = WooContext.view, int? page, int? perPage, String? search, List<int>? exclude, List<int>? include, WooSort order = WooSort.desc, WooOrderBy orderBy = WooOrderBy.name, bool? hideEmpty, int? parent, int? product, String? slug, bool? useFaker, }) async

Retrieves a list of product categories from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the categories you need.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-categories

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic category information (default)
  - `WooContext.edit`: Returns full category details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to categories matching a search string
* [exclude] - Ensure result set excludes specific category IDs
* [include] - Limit result set to specific category IDs
* [order] - Order sort attribute ascending or descending (default: desc)
* [orderBy] - Sort collection by object attribute (default: name)
* [hideEmpty] - Whether to hide categories not assigned to any products (default: false)
* [parent] - Limit result set to categories assigned to a specific parent
* [product] - Limit result set to categories assigned to a specific product
* [slug] - Limit result set to categories with a specific slug
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooProductCategory>>` containing the category objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all categories
final categories = await wooCommerce.getCategories();

// Search for categories
final searchResults = await wooCommerce.getCategories(
  search: 'electronics',
  perPage: 20,
);

// Get subcategories of a specific parent
final subcategories = await wooCommerce.getCategories(
  parent: 15,
  hideEmpty: true,
);
```

### Future<WooProductCategory> getCategory(int id, {bool? useFaker}) async

Retrieves a single product category by its ID from the WooCommerce store.

This method fetches detailed information about a specific category,
including all its properties and relationships.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-category

## Parameters

* [id] - The unique identifier of the category to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductCategory>` containing the category object.

## Throws

* `WooCommerceException` if the category is not found or access is denied

## Example Usage

```dart
// Get a specific category
final category = await wooCommerce.getCategory(123);

// Check category details
if (category.count! > 0) {
  print('Category ${category.name} has ${category.count} products');
}
```

### Future<WooProductCategory> createCategory

Creates a new product category in the WooCommerce store.

This method creates a new category with the specified properties and settings.
The category will be immediately available for product assignment.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-product-category

## Parameters

* [category] - The category object containing all the category details
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductCategory>` containing the created category object with server-assigned ID.

## Throws

* `WooCommerceException` if the category creation fails or validation errors occur

## Example Usage

```dart
// Create a top-level category
final category = WooProductCategory(
  name: 'Electronics',
  description: 'Electronic products and gadgets',
  slug: 'electronics',
);
final created = await wooCommerce.createCategory(category);

// Create a subcategory
final subcategory = WooProductCategory(
  name: 'Smartphones',
  parent: created.id,
  description: 'Mobile phones and accessories',
);
final createdSub = await wooCommerce.createCategory(subcategory);
```

### Future<WooProductCategory> updateCategory

Updates an existing product category in the WooCommerce store.

This method updates the properties and settings of an existing category.
The category must have a valid ID to be updated.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-product-category

## Parameters

* [category] - The category object with updated properties (must include valid ID)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductCategory>` containing the updated category object.

## Throws

* `WooCommerceException` if the category update fails, category not found, or validation errors occur

## Example Usage

```dart
// Update an existing category
final existingCategory = await wooCommerce.getCategory(123);
existingCategory.name = 'Updated Electronics';
existingCategory.description = 'Updated description';
final result = await wooCommerce.updateCategory(existingCategory);

// Move category to different parent
existingCategory.parent = 456;
await wooCommerce.updateCategory(existingCategory);
```

### Future<WooDeleteResult> deleteCategory

Deletes a product category from the WooCommerce store.

This method removes a category from the store. By default, the category is moved to trash,
but it can be permanently deleted using the force parameter.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-product-category

## Parameters

* [id] - The unique identifier of the category to delete
* [force] - Whether to permanently delete the category instead of moving to trash (default: false)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<bool>` indicating whether the deletion was successful.

## Throws

* `WooCommerceException` if the category deletion fails or category not found

## Example Usage

```dart
// Move category to trash (can be restored)
final success = await wooCommerce.deleteCategory(123);

// Permanently delete category
final permanentDelete = await wooCommerce.deleteCategory(
  123,
  force: true,
);

if (success) {
  print('Category deleted successfully');
}
```

### Future<WooProductCategoryBatchResponse> batchUpdateCategories

Performs batch operations on product categories (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple product categories
efficiently in a single API call, reducing the number of requests needed
for bulk operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-product-categories

## Parameters

* [request] - The batch request containing categories to create, update, and/or delete
  - `create`: List of `WooProductCategory` objects to create (should not have IDs)
  - `update`: List of `WooProductCategory` objects to update (must include valid IDs)
  - `delete`: List of category IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductCategoryBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created categories with server-assigned IDs
- `update`: List of successfully updated categories
- `delete`: List of successfully deleted categories

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooProductCategoryBatchRequest(
  create: [
    WooProductCategory(
      name: 'Electronics',
      description: 'Electronic products and gadgets',
      slug: 'electronics',
    ),
    WooProductCategory(
      name: 'Clothing',
      description: 'Apparel and accessories',
      slug: 'clothing',
    ),
  ],
  update: [
    existingCategory..name = 'Updated Electronics',
  ],
  delete: [123, 456],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateCategories(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} categories');
print('Updated ${response.update?.length ?? 0} categories');
print('Deleted ${response.delete?.length ?? 0} categories');

// Access individual results
for (final category in response.create ?? []) {
  print('Created category: ${category.name} with ID: ${category.id}');
}
```

## Batch Operations Best Practices

- **Create operations**: Categories should not have IDs assigned
- **Update operations**: Categories must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of categories to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Hierarchical relationships**: When creating parent-child relationships, ensure parent categories are created first or reference existing parent IDs
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## category_query

### class WooCategoryQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooCategoryQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.exclude, this.include, this.hideEmpty, this.parent, this.product, this.slug, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hideEmpty

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? parent

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? product

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## category_display

### enum WooCategoryDisplay implements WooEnum

WooCommerce Category Display Enumeration

Defines how product categories display their content on category pages.
Controls whether to show products, subcategories, or both on the category page.

## Usage Examples

```dart
// Set category to display products only
final category = WooProductCategory(
  name: 'Electronics',
  display: WooCategoryDisplay.products,
);

// Set category to display subcategories only
final parentCategory = WooProductCategory(
  name: 'Technology',
  display: WooCategoryDisplay.subcategories,
);

// Set category to display both products and subcategories
final mixedCategory = WooProductCategory(
  name: 'Home & Garden',
  display: WooCategoryDisplay.both,
);
```

### standard('default'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### products('products'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### subcategories('subcategories'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### both('both'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooCategoryDisplay(this.value)

WooCommerce Category Display Enumeration

Defines how product categories display their content on category pages.
Controls whether to show products, subcategories, or both on the category page.

## Usage Examples

```dart
// Set category to display products only
final category = WooProductCategory(
  name: 'Electronics',
  display: WooCategoryDisplay.products,
);

// Set category to display subcategories only
final parentCategory = WooProductCategory(
  name: 'Technology',
  display: WooCategoryDisplay.subcategories,
);

// Set category to display both products and subcategories
final mixedCategory = WooProductCategory(
  name: 'Home & Garden',
  display: WooCategoryDisplay.both,
);
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooCategoryDisplay fake()

Creates a fake WooCategoryDisplay instance for testing purposes

This method generates a random display type, making it useful for testing and development.

## Returns

A `WooCategoryDisplay` instance with randomly selected display type.

## Example Usage

```dart
final fakeDisplay = WooCategoryDisplay.fake();
```

## category

### class WooProductCategory

WooCommerce Product Category Model

This class represents a product category in WooCommerce with comprehensive
information about the category, its hierarchy, display settings, and metadata.
Categories help organize products and can be arranged in hierarchical structures.

## Key Features

- **Hierarchical Structure**: Support for parent-child category relationships
- **Display Control**: Configure how categories display products and subcategories
- **Rich Metadata**: Support for descriptions, images, and custom ordering
- **Product Association**: Track product counts and relationships
- **SEO Support**: Slug-based URLs and structured data
- **Menu Integration**: Custom ordering for navigation menus

## Usage Examples

### Creating a Category

```dart
final category = WooProductCategory(
  name: 'Electronics',
  description: 'Electronic products and gadgets',
  slug: 'electronics',
  display: WooCategoryDisplay.products,
);
```

### Working with Category Data

```dart
// Check if category has products
if (category.count! > 0) {
  print('Category ${category.name} has ${category.count} products');
}

// Check if category is a subcategory
if (category.parent != null) {
  print('This is a subcategory of parent ID: ${category.parent}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = category.toJson();

// Create from JSON response
final category = WooProductCategory.fromJson(jsonData);
```

### WooProductCategory({ this.id, this.name, this.slug, this.parent, this.description, this.display, this.image, this.menuOrder, this.count, this.links, })

WooCommerce Product Category Model

This class represents a product category in WooCommerce with comprehensive
information about the category, its hierarchy, display settings, and metadata.
Categories help organize products and can be arranged in hierarchical structures.

## Key Features

- **Hierarchical Structure**: Support for parent-child category relationships
- **Display Control**: Configure how categories display products and subcategories
- **Rich Metadata**: Support for descriptions, images, and custom ordering
- **Product Association**: Track product counts and relationships
- **SEO Support**: Slug-based URLs and structured data
- **Menu Integration**: Custom ordering for navigation menus

## Usage Examples

### Creating a Category

```dart
final category = WooProductCategory(
  name: 'Electronics',
  description: 'Electronic products and gadgets',
  slug: 'electronics',
  display: WooCategoryDisplay.products,
);
```

### Working with Category Data

```dart
// Check if category has products
if (category.count! > 0) {
  print('Category ${category.name} has ${category.count} products');
}

// Check if category is a subcategory
if (category.parent != null) {
  print('This is a subcategory of parent ID: ${category.parent}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = category.toJson();

// Create from JSON response
final category = WooProductCategory.fromJson(jsonData);
```

### factory WooProductCategory.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductCategory.fake()

Creates a fake WooProductCategory instance for testing purposes

This factory constructor generates a category with random but realistic
data, making it useful for testing and development.

## Returns

A `WooProductCategory` instance with randomly generated fake data.

## Example Usage

```dart
final fakeCategory = WooProductCategory.fake();
```

### final int? id

Unique identifier for the category

This ID is automatically assigned by WooCommerce when the category is created.

### final String? name

Category name

The display name of the category as it appears to customers.

### final String? slug

Category slug

A URL-friendly version of the category name, used in category URLs.

### final int? parent

Parent category ID

For subcategories, this references the parent category.
For top-level categories, this is null.

### final String? description

Category description

HTML description of the category, displayed on category pages.

### final WooCategoryDisplay? display

Category display type

Controls how products and subcategories are displayed on the category page.

### final WooProductCategoryImage? image

Category image

The featured image for the category, displayed in category listings.

### final int? menuOrder

Menu order

Used to custom sort categories in navigation menus.

### final int? count

Product count

Number of published products in this category.

### final WooProductCategoryLinks? links

Category links

API links for related resources and operations.

### Map<String, dynamic> toJson()

Converts the WooProductCategory instance to JSON format

This method serializes the category data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the category data in JSON format.

## Example Usage

```dart
final jsonData = category.toJson();
```

### WooProductCategory copyWith({ int? id, String? name, String? slug, int? parent, String? description, WooCategoryDisplay? display, WooProductCategoryImage? image, int? menuOrder, int? count, WooProductCategoryLinks? links, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductCategory instance

This method provides a human-readable representation of the category,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the category's main field values in a readable format.

## Example Usage

```dart
final category = WooProductCategory(
  id: 123,
  name: 'Electronics',
  slug: 'electronics',
  count: 25,
);
print(category.toString());
// Output: WooProductCategory(id: 123, name: Electronics, slug: electronics, count: 25)
```

## category_batch_request

### class WooProductCategoryBatchRequest

WooCommerce Product Category Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product categories in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple categories in a single request
- **Bulk Updates**: Update multiple existing categories simultaneously
- **Bulk Deletion**: Delete multiple categories at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Hierarchical Support**: Handle parent-child category relationships

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductCategoryBatchRequest(
  create: [
    WooProductCategory(
      name: 'Electronics',
      description: 'Electronic products and gadgets',
      slug: 'electronics',
    ),
    WooProductCategory(
      name: 'Clothing',
      description: 'Apparel and accessories',
      slug: 'clothing',
    ),
  ],
  update: [
    existingCategory..name = 'Updated Electronics',
  ],
  delete: [123, 456],
);
```

### Working with Hierarchical Categories

```dart
// Create parent and child categories in a batch
final parentCategory = WooProductCategory(
  name: 'Electronics',
  slug: 'electronics',
);

final batchRequest = WooProductCategoryBatchRequest(
  create: [
    parentCategory,
    WooProductCategory(
      name: 'Smartphones',
      parent: parentCategory.id, // Will be set after parent is created
      slug: 'smartphones',
    ),
  ],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductCategoryBatchRequest(
  create: [category1, category2, category3],
);

// Create a batch request with only updates
final updateOnly = WooProductCategoryBatchRequest(
  update: [updatedCategory1, updatedCategory2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductCategoryBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductCategoryBatchRequest.fromJson(jsonData);
```

### WooProductCategoryBatchRequest({this.create, this.update, this.delete})

WooCommerce Product Category Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product categories in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple categories in a single request
- **Bulk Updates**: Update multiple existing categories simultaneously
- **Bulk Deletion**: Delete multiple categories at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Hierarchical Support**: Handle parent-child category relationships

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductCategoryBatchRequest(
  create: [
    WooProductCategory(
      name: 'Electronics',
      description: 'Electronic products and gadgets',
      slug: 'electronics',
    ),
    WooProductCategory(
      name: 'Clothing',
      description: 'Apparel and accessories',
      slug: 'clothing',
    ),
  ],
  update: [
    existingCategory..name = 'Updated Electronics',
  ],
  delete: [123, 456],
);
```

### Working with Hierarchical Categories

```dart
// Create parent and child categories in a batch
final parentCategory = WooProductCategory(
  name: 'Electronics',
  slug: 'electronics',
);

final batchRequest = WooProductCategoryBatchRequest(
  create: [
    parentCategory,
    WooProductCategory(
      name: 'Smartphones',
      parent: parentCategory.id, // Will be set after parent is created
      slug: 'smartphones',
    ),
  ],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductCategoryBatchRequest(
  create: [category1, category2, category3],
);

// Create a batch request with only updates
final updateOnly = WooProductCategoryBatchRequest(
  update: [updatedCategory1, updatedCategory2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductCategoryBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductCategoryBatchRequest.fromJson(jsonData);
```

### factory WooProductCategoryBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooProductCategoryBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooProductCategoryBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooProductCategoryBatchRequest.fromJson(jsonData);
```

### factory WooProductCategoryBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductCategory>? create

List of categories to create

Each category in this list will be created as a new category in the store.
Categories in this list should not have an ID assigned.

### final List<WooProductCategory>? update

List of categories to update

Each category in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of category IDs to delete

Each ID in this list represents a category that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooProductCategoryBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooProductCategoryBatchRequest copyWith({ List<WooProductCategory>? create, List<WooProductCategory>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductCategoryBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooProductCategoryBatchRequest(
  create: [category1, category2],
  update: [category3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooProductCategoryBatchRequest(create: 2, update: 1, delete: 2)
```

## category_batch_response

### class WooProductCategoryBatchResponse

WooCommerce Product Category Batch Response Model

This class represents the response from a batch product category operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created categories with server-assigned IDs
- **Update Results**: List of successfully updated categories
- **Delete Results**: List of successfully deleted categories
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateCategories(batchRequest);

// Process created categories
for (final category in response.create ?? []) {
  print('Created category: ${category.name} with ID: ${category.id}');
}

// Process updated categories
for (final category in response.update ?? []) {
  print('Updated category: ${category.name}');
}

// Process deleted categories
for (final category in response.delete ?? []) {
  print('Deleted category: ${category.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateCategories(batchRequest);

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
final batchResponse = WooProductCategoryBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooProductCategoryBatchResponse({this.create, this.update, this.delete})

WooCommerce Product Category Batch Response Model

This class represents the response from a batch product category operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created categories with server-assigned IDs
- **Update Results**: List of successfully updated categories
- **Delete Results**: List of successfully deleted categories
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateCategories(batchRequest);

// Process created categories
for (final category in response.create ?? []) {
  print('Created category: ${category.name} with ID: ${category.id}');
}

// Process updated categories
for (final category in response.update ?? []) {
  print('Updated category: ${category.name}');
}

// Process deleted categories
for (final category in response.delete ?? []) {
  print('Deleted category: ${category.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateCategories(batchRequest);

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
final batchResponse = WooProductCategoryBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooProductCategoryBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooProductCategoryBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooProductCategoryBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooProductCategoryBatchResponse.fromJson(jsonData);
```

### factory WooProductCategoryBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductCategory>? create

List of created categories

Contains the categories that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooProductCategory>? update

List of updated categories

Contains the categories that were successfully updated, reflecting
the current state after the update operation.

### final List<WooProductCategory>? delete

List of deleted categories

Contains the categories that were successfully deleted. These categories
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooProductCategoryBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooProductCategoryBatchResponse copyWith({ List<WooProductCategory>? create, List<WooProductCategory>? update, List<WooProductCategory>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductCategoryBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooProductCategoryBatchResponse(
  create: [category1, category2],
  update: [category3],
  delete: [category4, category5],
);
print(batchResponse.toString());
// Output: WooProductCategoryBatchResponse(create: 2, update: 1, delete: 2)
```

## category_image

### class WooProductCategoryImage

Represents a WooCommerce product category image.

This class models the featured image for a product category with its metadata,
URLs, and timestamps for creation and modification.

### WooProductCategoryImage({ this.id, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.src, this.name, this.alt, })

Represents a WooCommerce product category image.

This class models the featured image for a product category with its metadata,
URLs, and timestamps for creation and modification.

### factory WooProductCategoryImage.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductCategoryImage.fake()

Creates a fake WooProductCategoryImage instance for testing purposes

This factory constructor generates an image with random but realistic
data, making it useful for testing and development.

## Returns

A `WooProductCategoryImage` instance with randomly generated fake data.

## Example Usage

```dart
final fakeImage = WooProductCategoryImage.fake();
```

### final int? id

Image ID.

### final DateTime? dateCreated

The date the image was created, in the site's timezone.

### final DateTime? dateCreatedGmt

The date the image was created, as GMT

### final DateTime? dateModified

The date the image was last modified, in the site's timezone.

### final DateTime? dateModifiedGmt

The date the image was last modified, as GMT.

### final String? src

Image URL.

### final String? name

Image name.

### final String? alt

Image alternative text.

### Map<String, dynamic> toJson()

Converts the WooProductCategoryImage instance to JSON format

This method serializes the image data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the image data in JSON format.

## Example Usage

```dart
final jsonData = image.toJson();
```

### WooProductCategoryImage copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, String? src, String? name, String? alt, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductCategoryImage instance

This method provides a human-readable representation of the image,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the image's main field values in a readable format.

## Example Usage

```dart
final image = WooProductCategoryImage(
  id: 123,
  name: 'electronics.jpg',
  src: 'https://example.com/image.jpg',
);
print(image.toString());
// Output: WooProductCategoryImage(id: 123, name: electronics.jpg, src: https://example.com/image.jpg)
```

## category_links

### class WooProductCategoryLinks

Represents WooCommerce product category API links.

This class models the API links associated with a product category,
including self-referencing links and collection links.

### WooProductCategoryLinks({this.self, this.collection})

Represents WooCommerce product category API links.

This class models the API links associated with a product category,
including self-referencing links and collection links.

### factory WooProductCategoryLinks.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductCategoryLinks.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductCategorySelf>? self

Self-referencing API links for the category

### final List<WooProductCategoryCollection>? collection

Collection API links for the category

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategoryLinks copyWith({ List<WooProductCategorySelf>? self, List<WooProductCategoryCollection>? collection, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### class WooProductCategorySelf

Represents a self-referencing API link for a WooCommerce product category.

This class models a single self-referencing link that points to the category itself.

### WooProductCategorySelf({this.href})

Represents a self-referencing API link for a WooCommerce product category.

This class models a single self-referencing link that points to the category itself.

### factory WooProductCategorySelf.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategorySelf(href: WooJson.readString(json, 'href'))

Represents a self-referencing API link for a WooCommerce product category.

This class models a single self-referencing link that points to the category itself.

### factory WooProductCategorySelf.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategorySelf(href: FakeHelper.url())

Represents a self-referencing API link for a WooCommerce product category.

This class models a single self-referencing link that points to the category itself.

### final String? href

The URL of the self-referencing link

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategorySelf copyWith({String? href})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategorySelf(href: href ?? this.href)

Represents a self-referencing API link for a WooCommerce product category.

This class models a single self-referencing link that points to the category itself.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### class WooProductCategoryCollection

Represents a collection API link for a WooCommerce product category.

This class models a single collection link that points to related category resources.

### WooProductCategoryCollection({this.href})

Represents a collection API link for a WooCommerce product category.

This class models a single collection link that points to related category resources.

### factory WooProductCategoryCollection.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategoryCollection(href: WooJson.readString(json, 'href'))

Represents a collection API link for a WooCommerce product category.

This class models a single collection link that points to related category resources.

### factory WooProductCategoryCollection.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategoryCollection(href: FakeHelper.url())

Represents a collection API link for a WooCommerce product category.

This class models a single collection link that points to related category resources.

### final String? href

The URL of the self-referencing link

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategoryCollection copyWith({String? href})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductCategoryCollection(href: href ?? this.href)

Represents a collection API link for a WooCommerce product category.

This class models a single collection link that points to related category resources.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

