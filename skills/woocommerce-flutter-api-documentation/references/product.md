# product

## product_api

### extension WooProductApi on WooCommerce

WooCommerce Product API Extension

This extension provides comprehensive product management capabilities for WooCommerce stores.
Products are the core entities in any e-commerce store, representing items that customers can purchase.

## Key Features

- **Product Retrieval**: Get products with extensive filtering and pagination
- **Product Management**: Create, update, and delete products
- **Product Variations**: Handle variable products with multiple options
- **Product Relationships**: Manage related, upsell, and cross-sell products
- **Advanced Filtering**: Filter by category, tag, price, stock status, and more
- **Bulk Operations**: Duplicate products and manage product hierarchies

## Example Usage

```dart
// Get all products
final products = await wooCommerce.getProducts();

// Create a new product
final product = WooProduct(
  name: 'New Product',
  type: WooProductType.simple,
  price: 29.99,
);
final createdProduct = await wooCommerce.createProduct(product);

// Get products with filtering
final featuredProducts = await wooCommerce.getProducts(
  featured: true,
  status: WooFilterStatus.publish,
);
```

### Future<WooPage<WooProduct>> getProducts({ WooContext context = WooContext.view, int? page, int? perPage, String? search, DateTime? after, DateTime? before, DateTime? modifiedAfter, DateTime? modifiedBefore, bool? datesAreGmt, List<int>? exclude, List<int>? include, int? offset, WooSort order = WooSort.desc, WooOrderBy orderBy = WooOrderBy.date, List<int>? parent, List<int>? parentExclude, String? slug, WooProductStatus? status, WooProductType? type, String? sku, bool? featured, int? category, int? tag, int? shippingClass, String? attribute, String? attributeTerm, String? taxClass, bool? onSale, double? minPrice, double? maxPrice, WooProductStockStatus? stockStatus, String? currency, bool? useFaker, }) async

Retrieves a list of products from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the products you need.

## Parameters

- [context]: Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
- [page]: Current page of the collection. Default is 1.
- [perPage]: Maximum number of items to be returned in result set. Default is 10.
- [search]: Limit results to those matching a string.
- [after]: Limit response to resources published after a given ISO8601 compliant date.
- [before]: Limit response to resources published before a given ISO8601 compliant date.
- [modifiedAfter]: Limit response to resources modified after a given ISO8601 compliant date.
- [modifiedBefore]: Limit response to resources modified after a given ISO8601 compliant date.
- [datesAreGmt]: Whether to consider GMT post dates when limiting response by published or modified date.
- [exclude]: Ensure result set excludes specific IDs.
- [include]: Limit result set to specific ids.
- [offset]: Offset the result set by a specific number of items.
- [order]: Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
- [orderBy]: Sort collection by object attribute. Options: date, id, include, title, slug, price, popularity and rating. Default is date.
- [parent]: Limit result set to those of particular parent IDs.
- [parentExclude]: Limit result set to all items except those of a particular parent ID.
- [slug]: Limit result set to products with a specific slug.
- [status]: Limit result set to products assigned a specific status. Options: any, draft, pending, private and publish. Default is any.
- [type]: Limit result set to products assigned a specific type. Options: simple, grouped, external and variable.
- [sku]: Limit result set to products with a specific SKU.
- [featured]: Limit result set to featured products.
- [category]: Limit result set to products assigned a specific category ID.
- [tag]: Limit result set to products assigned a specific tag ID.
- [shippingClass]: Limit result set to products assigned a specific shipping class ID.
- [attribute]: Limit result set to products with a specific attribute.
- [attributeTerm]: Limit result set to products with a specific attribute term ID (required an assigned attribute).
- [taxClass]: Limit result set to products with a specific tax class. Default options: standard, reduced-rate and zero-rate.
- [onSale]: Limit result set to products on sale.
- [minPrice]: Limit result set to products based on a minimum price.
- [maxPrice]: Limit result set to products based on a maximum price.
- [stockStatus]: Limit result set to products with specified stock status. Options: instock, outofstock and onbackorder.
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with a list of [WooProduct] objects.

## Example

```dart
// Get first 10 published products
final products = await woocommerce.getProducts(
  perPage: 10,
  status: WooFilterStatus.publish,
);

// Search for products
final searchResults = await woocommerce.getProducts(
  search: 'laptop',
  perPage: 20,
);

// Get featured products on sale
final featuredOnSale = await woocommerce.getProducts(
  featured: true,
  onSale: true,
);
```

### Future<WooProduct> getProduct(int id, {bool? useFaker}) async

Retrieves a single product by its ID.

## Parameters

- [id]: The unique identifier of the product to retrieve.
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with a [WooProduct] object.

## Example

```dart
final product = await woocommerce.getProduct(123);
print('Product: ${product.name}');
```

### Future<WooProductWithChildren> getProductWithOptions

Retrieves a product along with its related products in a single optimized request.

This method is particularly useful for product detail pages where you need
to display the main product along with its variations, upsells, cross-sells,
or related products without making multiple API calls.

## Parameters

- [product]: The main product for which to fetch related data.
- [types]: List of related product types to fetch (variations, upsells, etc.).
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with a [WooProductWithChildrens] object containing
the main product and all requested related products.

## Example

```dart
final productWithDetails = await woocommerce.getProductWithOptions(
  selectedProduct,
  [
    WooProductFilterWithType.variations,
    WooProductFilterWithType.upsellIds,
    WooProductFilterWithType.relatedIds,
  ],
);

// Access main product
print('Main: ${productWithDetails.mainProduct.name}');

// Access variations
for (final variation in productWithDetails.variations ?? []) {
  print('Variation: ${variation.name}');
}
```

### Future<WooProduct> createProduct

Creates a new product in the WooCommerce store.

## Parameters

- [product]: The product object to create.
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with the created [WooProduct] object (including the assigned ID).

## Example

```dart
final newProduct = WooProduct(
  name: 'New Product',
  type: WooProductType.simple,
  status: WooProductStatus.publish,
  price: 29.99,
);

final createdProduct = await woocommerce.createProduct(newProduct);
print('Created product with ID: ${createdProduct.id}');
```

### Future<WooProduct> duplicateProduct(int productId, {bool? useFaker}) async

Duplicates an existing product, creating a copy with a new ID.

This is useful for creating product variants or templates based on existing products.

## Parameters

- [productId]: The ID of the product to duplicate.
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with the duplicated [WooProduct] object.

## Example

```dart
final duplicatedProduct = await woocommerce.duplicateProduct(123);
print('Duplicated product: ${duplicatedProduct.name}');
```

### Future<WooProduct> updateProduct

Updates an existing product in the WooCommerce store.

## Parameters

- [id]: The ID of the product to update.
- [product]: The updated product data.
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with the updated [WooProduct] object.

## Example

```dart
final updatedProduct = product.copyWith(
  name: 'Updated Product Name',
  price: 39.99,
);

final result = await woocommerce.updateProduct(123, updatedProduct);
print('Updated: ${result.name}');
```

### Future<WooDeleteResult> deleteProduct

Deletes a product from the WooCommerce store.

## Parameters

- [id]: The ID of the product to delete.
- [force]: Whether to permanently delete the product (defaults to false - move to trash).
- [useFaker]: Override the global useFaker setting for this request.

## Returns

A [Future] that completes with the deleted [WooProduct] object.

## Example

```dart
// Move to trash (default)
final deletedProduct = await woocommerce.deleteProduct(123);

// Permanently delete
final permanentlyDeleted = await woocommerce.deleteProduct(123, force: true);
```

### Future<WooProductBatchResponse> batchUpdateProducts

Performs batch operations on products (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple products
efficiently in a single API call, reducing the number of requests needed
for bulk operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-products

## Parameters

* [request] - The batch request containing products to create, update, and/or delete
  - `create`: List of `WooProduct` objects to create (should not have IDs)
  - `update`: List of `WooProduct` objects to update (must include valid IDs)
  - `delete`: List of product IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created products with server-assigned IDs
- `update`: List of successfully updated products
- `delete`: List of successfully deleted products

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooProductBatchRequest(
  create: [
    WooProduct(
      name: 'New Product 1',
      type: WooProductType.simple,
      price: 29.99,
      status: WooProductStatus.publish,
    ),
    WooProduct(
      name: 'New Product 2',
      type: WooProductType.simple,
      price: 49.99,
      status: WooProductStatus.publish,
    ),
  ],
  update: [
    existingProduct.copyWith(
      name: 'Updated Product Name',
      price: 39.99,
    ),
  ],
  delete: [123, 456],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateProducts(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} products');
print('Updated ${response.update?.length ?? 0} products');
print('Deleted ${response.delete?.length ?? 0} products');

// Access individual results
for (final product in response.create ?? []) {
  print('Created product: ${product.name} with ID: ${product.id}');
}
```

## Batch Operations Best Practices

- **Create operations**: Products should not have IDs assigned
- **Update operations**: Products must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of products to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## product_attribute_api

### extension WooProductAttributeApi on WooCommerce

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooPage<WooProductAttribute>> getProductAttributes({ WooContext context = WooContext.view, int? page, int? perPage, String? search, bool? useFaker, }) async

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttribute> getProductAttribute

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttribute> createProductAttribute

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttribute> updateProductAttribute

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteProductAttribute

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttributeBatchResponse> batchUpdateProductAttributes

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooPage<WooProductAttributeTerm>> getProductAttributeTerms

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttributeTerm> getProductAttributeTerm

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttributeTerm> createProductAttributeTerm

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttributeTerm> updateProductAttributeTerm

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteProductAttributeTerm

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductAttributeTermBatchResponse> batchUpdateProductAttributeTerms

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_query

### class WooProductAttributeQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductAttributeQuery({ super.page, super.perPage, super.search, super.offset, this.context = WooContext.view, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_term_query

### class WooProductAttributeTermQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductAttributeTermQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.exclude, this.include, this.hideEmpty, this.product, this.slug, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hideEmpty

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? product

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_query

### class WooProductQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.after, this.before, this.modifiedAfter, this.modifiedBefore, this.datesAreGmt, this.exclude, this.include, this.parent, this.parentExclude, this.slug, this.status, this.type, this.sku, this.featured, this.category, this.tag, this.shippingClass, this.attribute, this.attributeTerm, this.taxClass, this.onSale, this.minPrice, this.maxPrice, this.stockStatus, this.currency, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? after

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? before

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? modifiedAfter

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? modifiedBefore

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? datesAreGmt

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? parent

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? parentExclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductStatus? status

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductType? type

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? sku

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? featured

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? category

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? tag

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? shippingClass

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? attribute

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? attributeTerm

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

### final String? currency

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_review_api

### extension WooProductReviewApi on WooCommerce

WooCommerce Product Review API Extension

This extension provides comprehensive product review management capabilities for WooCommerce stores.
Product reviews allow customers to share their experiences with products, helping other customers
make informed purchasing decisions and providing valuable feedback to store owners.

## Product Review Overview

Product reviews are customer-generated content that includes ratings, comments, and feedback
about products. They help build trust, improve SEO, and provide social proof for your products.

## Key Features

- **Review Retrieval**: Get product reviews with extensive filtering and pagination
- **Review Management**: Create, update, and delete product reviews
- **Status Control**: Manage review approval and moderation
- **Advanced Filtering**: Filter by product, reviewer, status, and date
- **Rating System**: Support for star ratings and review scoring

## Review Lifecycle

1. **Submission**: Customer submits review with rating and comment
2. **Moderation**: Review is held for approval (if moderation is enabled)
3. **Approval**: Review is approved and becomes visible to customers
4. **Display**: Review appears on product pages and in listings

## Example Usage

```dart
// Get all approved reviews
final reviews = await wooCommerce.getProductReviews();

// Get reviews for a specific product
final productReviews = await wooCommerce.getProductReviews(
  product: [123],
  status: WooProductReviewStatus.approved,
);

// Get pending reviews for moderation
final pendingReviews = await wooCommerce.getProductReviews(
  status: WooProductReviewStatus.hold,
);
```

### Future<WooPage<WooProductReview>> getProductReviews({ WooContext context = WooContext.view, int? page, int? perPage, String? search, DateTime? after, DateTime? before, List<int>? exclude, List<int>? include, int? offset, WooSort order = WooSort.desc, WooOrderBy orderBy = WooOrderBy.dateGmt, List<int>? reviewer, List<int>? reviewerExclude, List<String>? reviewerEmail, List<int>? product, WooProductReviewStatus status = WooProductReviewStatus.approved, bool? useFaker, }) async

Retrieves a list of product reviews from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the reviews you need for moderation, display, or analysis.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-reviews

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic review information (default)
  - `WooContext.edit`: Returns full review details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to reviews matching a search string
* [after] - Limit response to reviews published after this date
* [before] - Limit response to reviews published before this date
* [exclude] - Exclude reviews with specific IDs from results
* [include] - Only include reviews with specific IDs
* [offset] - Offset the result set by a specific number of items
* [reviewer] - Filter by reviewer user IDs
* [reviewerExclude] - Exclude reviews from specific reviewer IDs
* [reviewerEmail] - Filter by reviewer email addresses
* [product] - Filter by product IDs
* [status] - Filter by review status (default: approved)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooProductReview>>` containing the review objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all approved reviews
final reviews = await wooCommerce.getProductReviews();

// Get reviews for a specific product
final productReviews = await wooCommerce.getProductReviews(
  product: [123],
  status: WooProductReviewStatus.approved,
);

// Get pending reviews for moderation
final pendingReviews = await wooCommerce.getProductReviews(
  status: WooProductReviewStatus.hold,
);

// Search reviews by content
final searchResults = await wooCommerce.getProductReviews(
  search: 'excellent',
  perPage: 20,
);
```

### Future<WooProductReview> getProductReview(int id, {bool? useFaker}) async

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductReview> createProductReview

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductReview> updateProductReview

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteProductReview(int id, {bool? useFaker}) async

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooProductReviewBatchResponse> batchUpdateProductReviews

Performs batch operations on product reviews.

This method allows you to create, update, and delete multiple product reviews
in a single API request, making bulk operations more efficient. This is particularly
useful for review moderation workflows, such as approving multiple pending reviews
or managing review status in bulk.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-product-reviews

## Parameters

* [request] - The `WooProductReviewBatchRequest` object containing
  the create, update, and delete operations to perform
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductReviewBatchResponse>` containing the results of
all batch operations, including created, updated, and deleted reviews.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooProductReviewBatchRequest(
  create: [
    WooProductReview(
      productId: 123,
      reviewer: 'John Doe',
      reviewerEmail: 'john@example.com',
      review: 'Great product! Highly recommended.',
      rating: 5,
      status: WooProductReviewStatus.approved,
    ),
    WooProductReview(
      productId: 456,
      reviewer: 'Jane Smith',
      reviewerEmail: 'jane@example.com',
      review: 'Good quality, fast shipping.',
      rating: 4,
      status: WooProductReviewStatus.hold,
    ),
  ],
  update: [
    WooProductReview(
      id: 789,
      status: WooProductReviewStatus.approved,
      review: 'Updated review text',
    ),
  ],
  delete: [101, 102],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} reviews');
print('Updated ${response.update?.length ?? 0} reviews');
print('Deleted ${response.delete?.length ?? 0} reviews');

// Access individual results
for (final review in response.create ?? []) {
  print('Created review: ${review.reviewer} with ID: ${review.id}');
}
```

## Review Moderation Workflow

```dart
// Approve multiple pending reviews
final pendingReviews = await wooCommerce.getProductReviews(
  status: WooProductReviewStatus.hold,
);

final batchRequest = WooProductReviewBatchRequest(
  update: pendingReviews.map((review) => WooProductReview(
    id: review.id,
    status: WooProductReviewStatus.approved,
  )).toList(),
);

final response = await wooCommerce.batchUpdateProductReviews(batchRequest);
print('Approved ${response.update?.length ?? 0} reviews');
```

## Batch Operations Best Practices

- **Create operations**: Reviews should not have IDs assigned
- **Update operations**: Reviews must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of reviews to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Status management**: Use update operations to change review status (approved, hold, spam, trash)
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## Review Status Management

When creating or updating reviews, you can control their status:

- `WooProductReviewStatus.approved` - Review is visible to customers
- `WooProductReviewStatus.hold` - Review is pending moderation
- `WooProductReviewStatus.spam` - Mark review as spam
- `WooProductReviewStatus.trash` - Move review to trash
- `WooProductReviewStatus.unspam` - Unmark review from spam
- `WooProductReviewStatus.untrash` - Restore review from trash

## product_review_query

### class WooProductReviewQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductReviewQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.after, this.before, this.exclude, this.include, this.reviewer, this.reviewerExclude, this.reviewerEmail, this.product, this.status = WooProductReviewStatus.approved, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? after

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? before

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? reviewer

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? reviewerExclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<String>? reviewerEmail

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? product

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductReviewStatus status

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_shipping_class_api

### extension WooProductShippingClassApi on WooCommerce

WooCommerce Product Shipping Class API Extension

This extension provides comprehensive product shipping class management capabilities for WooCommerce stores.
It allows you to retrieve, create, update, and delete shipping classes, which are used to group
products with similar shipping requirements.

## Key Features

- **Retrieve Shipping Classes**: Get all shipping classes with extensive filtering options
- **Get Single Shipping Class**: Retrieve a specific shipping class by ID
- **Create Shipping Classes**: Add new shipping classes for product grouping
- **Update Shipping Classes**: Modify existing shipping class properties
- **Delete Shipping Classes**: Remove shipping classes (with force deletion)

## Example Usage

```dart
// Get all shipping classes
final shippingClasses = await wooCommerce.getProductShippingClasses();

// Create a new shipping class
final shippingClass = WooProductShippingClass(
  name: 'Express Shipping',
  slug: 'express-shipping',
  description: 'Fast delivery option',
);
final created = await wooCommerce.createProductShippingClass(shippingClass);
```

### Future<WooPage<WooProductShippingClass>> getProductShippingClasses({ WooContext context = WooContext.view, int? page, int? perPage, String? search, List<int>? exclude, List<int>? include, int? offset, WooSort order = WooSort.asc, WooOrderBy orderBy = WooOrderBy.name, bool? hideEmpty, int? product, String? slug, bool? useFaker, }) async

Retrieves a list of product shipping classes from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the shipping classes you need.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-shipping-classes

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic shipping class information (default)
  - `WooContext.edit`: Returns full shipping class details including sensitive data
* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to shipping classes matching a search string
* [exclude] - Ensure result set excludes specific shipping class IDs
* [include] - Limit result set to specific shipping class IDs
* [offset] - Offset the result set by a specific number of items
* [order] - Order sort attribute ascending or descending (default: asc)
* [orderBy] - Sort collection by resource attribute (default: name)
* [hideEmpty] - Whether to hide shipping classes not assigned to any products (default: false)
* [product] - Limit result set to shipping classes assigned to a specific product
* [slug] - Limit result set to shipping classes with a specific slug
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooProductShippingClass>>` containing the shipping class objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all shipping classes
final shippingClasses = await wooCommerce.getProductShippingClasses();

// Search for shipping classes with pagination
final searchResults = await wooCommerce.getProductShippingClasses(
  search: 'express',
  perPage: 20,
  page: 1,
);

// Get shipping classes for a specific product
final productShippingClasses = await wooCommerce.getProductShippingClasses(
  product: 123,
);
```

### Future<WooProductShippingClass> getProductShippingClass

Retrieves a specific product shipping class by its ID.

This method fetches a single shipping class associated with the given ID.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-shipping-class

## Parameters

* [id] - The ID of the shipping class to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductShippingClass>` containing the shipping class object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get a specific shipping class
final shippingClass = await wooCommerce.getProductShippingClass(123);
```

### Future<WooProductShippingClass> createProductShippingClass

Creates a new product shipping class.

This method adds a new shipping class to the WooCommerce store.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-product-shipping-class

## Parameters

* [shippingClass] - The WooProductShippingClass object containing the shipping class data
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductShippingClass>` containing the created shipping class object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a new shipping class
final shippingClass = WooProductShippingClass(
  name: 'Express Shipping',
  slug: 'express-shipping',
  description: 'Fast delivery option',
);
final created = await wooCommerce.createProductShippingClass(shippingClass);
```

### Future<WooProductShippingClass> updateProductShippingClass

Updates an existing product shipping class.

This method modifies an existing shipping class in the WooCommerce store.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-product-shipping-class

## Parameters

* [shippingClass] - The WooProductShippingClass object containing the updated shipping class data
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductShippingClass>` containing the updated shipping class object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Update an existing shipping class
final updatedShippingClass = WooProductShippingClass(
  id: 123,
  name: 'Premium Express Shipping',
  slug: 'premium-express-shipping',
  description: 'Premium fast delivery option',
);
final updated = await wooCommerce.updateProductShippingClass(updatedShippingClass);
```

### Future<WooDeleteResult> deleteProductShippingClass

Deletes a specific product shipping class.

This method permanently removes a shipping class from the WooCommerce store.
Note: The force parameter is required to be true as shipping classes do not support trashing.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-product-shipping-class

## Parameters

* [shippingClassId] - The ID of the shipping class to delete
* [useFaker] - When true, simulates successful deletion for testing purposes

## Returns

A `Future<WooProductShippingClass>` containing the deleted shipping class object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Delete a shipping class
final deleted = await wooCommerce.deleteProductShippingClass(123);
if (deleted != null) {
  print('Shipping class deleted successfully');
}
```

## product_shipping_class_query

### class WooProductShippingClassQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductShippingClassQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.exclude, this.include, this.hideEmpty, this.product, this.slug, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hideEmpty

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? product

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_tag_api

### extension WooProductTagApi on WooCommerce

WooCommerce Product Tag API Extension

This extension provides comprehensive product tag management capabilities for WooCommerce stores.
It allows you to retrieve, create, update, and delete product tags, which are used to categorize
and organize products for better discoverability and filtering.

## Key Features

- **Retrieve Product Tags**: Get all product tags with extensive filtering options
- **Get Single Product Tag**: Retrieve a specific product tag by ID
- **Create Product Tags**: Add new product tags for product categorization
- **Update Product Tags**: Modify existing product tag properties
- **Delete Product Tags**: Remove product tags (with force deletion)

## Example Usage

```dart
// Get all product tags
final tags = await wooCommerce.getProductTags();

// Create a new product tag
final tag = WooProductTag(
  name: 'Electronics',
  slug: 'electronics',
  description: 'Electronic products and devices',
);
final created = await wooCommerce.createProductTag(tag);
```

### Future<WooPage<WooProductTag>> getProductTags({ WooContext context = WooContext.view, int? page, int? perPage, String? search, List<int>? exclude, List<int>? include, int? offset, WooSort order = WooSort.asc, WooOrderBy orderBy = WooOrderBy.name, bool? hideEmpty, int? product, String? slug, bool? useFaker, }) async

Retrieves a list of product tags from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the product tags you need.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-tags

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic tag information (default)
  - `WooContext.edit`: Returns full tag details including sensitive data
* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to tags matching a search string
* [exclude] - Ensure result set excludes specific tag IDs
* [include] - Limit result set to specific tag IDs
* [offset] - Offset the result set by a specific number of items
* [order] - Order sort attribute ascending or descending (default: asc)
* [orderBy] - Sort collection by resource attribute (default: name)
* [hideEmpty] - Whether to hide tags not assigned to any products (default: false)
* [product] - Limit result set to tags assigned to a specific product
* [slug] - Limit result set to tags with a specific slug
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooProductTag>>` containing the product tag objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all product tags
final tags = await wooCommerce.getProductTags();

// Search for tags with pagination
final searchResults = await wooCommerce.getProductTags(
  search: 'electronics',
  perPage: 20,
  page: 1,
);

// Get tags for a specific product
final productTags = await wooCommerce.getProductTags(
  product: 123,
);
```

### Future<WooProductTag> getProductTag(int id, {bool? useFaker}) async

Retrieves a specific product tag by its ID.

This method fetches a single product tag associated with the given ID.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-tag

## Parameters

* [id] - The ID of the product tag to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductTag>` containing the product tag object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get a specific product tag
final tag = await wooCommerce.getProductTag(123);
```

### Future<WooProductTag> createProductTag

Creates a new product tag.

This method adds a new product tag to the WooCommerce store.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-product-tag

## Parameters

* [tag] - The WooProductTag object containing the tag data
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductTag>` containing the created product tag object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a new product tag
final tag = WooProductTag(
  name: 'Electronics',
  slug: 'electronics',
  description: 'Electronic products and devices',
);
final created = await wooCommerce.createProductTag(tag);
```

### Future<WooProductTag> updateProductTag

Updates an existing product tag.

This method modifies an existing product tag in the WooCommerce store.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-product-tag

## Parameters

* [tag] - The WooProductTag object containing the updated tag data
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductTag>` containing the updated product tag object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Update an existing product tag
final updatedTag = WooProductTag(
  id: 123,
  name: 'Premium Electronics',
  slug: 'premium-electronics',
  description: 'High-end electronic products and devices',
);
final updated = await wooCommerce.updateProductTag(updatedTag);
```

### Future<WooDeleteResult> deleteProductTag(int id, {bool? useFaker}) async

Deletes a specific product tag.

This method permanently removes a product tag from the WooCommerce store.
Note: The force parameter is required to be true as product tags do not support trashing.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-product-tag

## Parameters

* [tagId] - The ID of the product tag to delete
* [useFaker] - When true, simulates successful deletion for testing purposes

## Returns

A `Future<WooProductTag>` containing the deleted product tag object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Delete a product tag
final deleted = await wooCommerce.deleteProductTag(123);
if (deleted != null) {
  print('Product tag deleted successfully');
}
```

### Future<WooProductTagBatchResponse> batchUpdateProductTags

Performs batch operations on product tags (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple product tags
efficiently in a single API call, reducing the number of requests needed
for bulk operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-product-tags

## Parameters

* [request] - The batch request containing tags to create, update, and/or delete
  - `create`: List of `WooProductTag` objects to create (should have id: null)
  - `update`: List of `WooProductTag` objects to update (must include valid IDs)
  - `delete`: List of tag IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooProductTagBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created tags with server-assigned IDs
- `update`: List of successfully updated tags
- `delete`: List of successfully deleted tags

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooProductTagBatchRequest(
  create: [
    WooProductTag(
      null,
      'Electronics',
      'electronics',
      'Electronic products and gadgets',
    ),
    WooProductTag(
      null,
      'Clothing',
      'clothing',
      'Apparel and accessories',
    ),
  ],
  update: [
    WooProductTag(
      123,
      'Updated Electronics',
      'updated-electronics',
      'Updated description',
    ),
  ],
  delete: [456, 789],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateProductTags(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} tags');
print('Updated ${response.update?.length ?? 0} tags');
print('Deleted ${response.delete?.length ?? 0} tags');

// Access individual results
for (final tag in response.create ?? []) {
  print('Created tag: ${tag.name} with ID: ${tag.id}');
}
```

## Batch Operations Best Practices

- **Create operations**: Tags should not have IDs assigned (use null for id)
- **Update operations**: Tags must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of tags to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## product_tag_query

### class WooProductTagQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductTagQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.exclude, this.include, this.hideEmpty, this.product, this.slug, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hideEmpty

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? product

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_order_by

### enum WooProductAttributeOrderBy implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### menuOrder('menu_order'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### name('name'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### nameNum('name_num'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### id('id'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductAttributeOrderBy(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductAttributeOrderBy fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_type

### enum WooProductAttributeType implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### select('select'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### button('button'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductAttributeType(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductAttributeType fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_backorder

### enum WooProductBackorder implements WooEnum

WooCommerce Product Backorder Enumeration

Defines the backorder behavior for products when they are out of stock.
Controls whether customers can purchase products that are currently unavailable.

## Usage Examples

```dart
// Create a product that allows backorders
final product = WooProduct(
  name: 'T-Shirt',
  backorders: WooProductBackorder.yes,
  stockStatus: WooProductStockStatus.outofstock,
);

// Check backorder settings
if (product.backorders == WooProductBackorder.yes) {
  print('Customers can purchase even when out of stock');
}
```

### no('no'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### notify('notify'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### yes('yes'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductBackorder(this.value)

WooCommerce Product Backorder Enumeration

Defines the backorder behavior for products when they are out of stock.
Controls whether customers can purchase products that are currently unavailable.

## Usage Examples

```dart
// Create a product that allows backorders
final product = WooProduct(
  name: 'T-Shirt',
  backorders: WooProductBackorder.yes,
  stockStatus: WooProductStockStatus.outofstock,
);

// Check backorder settings
if (product.backorders == WooProductBackorder.yes) {
  print('Customers can purchase even when out of stock');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductBackorder fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_catalog_visibility

### enum WooProductCatalogVisibility implements WooEnum

WooCommerce Product Catalog Visibility Enumeration

Defines where and how products appear in the store catalog.
Controls the visibility of products in different areas of the website.

## Usage Examples

```dart
// Create a fully visible product
final product = WooProduct(
  name: 'T-Shirt',
  catalogVisibility: WooProductCatalogVisibility.visible,
);

// Create a hidden product
final hiddenProduct = WooProduct(
  name: 'Secret Item',
  catalogVisibility: WooProductCatalogVisibility.hidden,
);

// Check visibility settings
if (product.catalogVisibility == WooProductCatalogVisibility.visible) {
  print('Product appears everywhere');
}
```

### visible('visible'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### catalog('catalog'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### search('search'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### hidden('hidden'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductCatalogVisibility(this.value)

WooCommerce Product Catalog Visibility Enumeration

Defines where and how products appear in the store catalog.
Controls the visibility of products in different areas of the website.

## Usage Examples

```dart
// Create a fully visible product
final product = WooProduct(
  name: 'T-Shirt',
  catalogVisibility: WooProductCatalogVisibility.visible,
);

// Create a hidden product
final hiddenProduct = WooProduct(
  name: 'Secret Item',
  catalogVisibility: WooProductCatalogVisibility.hidden,
);

// Check visibility settings
if (product.catalogVisibility == WooProductCatalogVisibility.visible) {
  print('Product appears everywhere');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductCatalogVisibility fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_filter_with_option

### enum WooProductFilterWithType implements WooEnum

WooCommerce Product Filter With Option Enumeration

Defines the available filter options for products with specific relationships.
Controls how products are filtered based on their associations and relationships.

## Usage Examples

```dart
// Filter products by related IDs
final relatedProducts = await wooCommerce.getProducts(
  filter: WooProductFilterWithType.relatedIds,
  filterValue: [123, 456, 789],
);

// Filter products by parent ID
final childProducts = await wooCommerce.getProducts(
  filter: WooProductFilterWithType.parentId,
  filterValue: [123],
);
```

### relatedIds('related_ids'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### upsellIds('upsell_ids'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### crossSellIds('cross_sell_ids'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### parentId('parent_id'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### variations('variations'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### groupedProducts('grouped_products'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductFilterWithType(this.value)

WooCommerce Product Filter With Option Enumeration

Defines the available filter options for products with specific relationships.
Controls how products are filtered based on their associations and relationships.

## Usage Examples

```dart
// Filter products by related IDs
final relatedProducts = await wooCommerce.getProducts(
  filter: WooProductFilterWithType.relatedIds,
  filterValue: [123, 456, 789],
);

// Filter products by parent ID
final childProducts = await wooCommerce.getProducts(
  filter: WooProductFilterWithType.parentId,
  filterValue: [123],
);
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductFilterWithType fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_review_status

### enum WooProductReviewStatus implements WooEnum

WooCommerce Product Review Status Enumeration

Defines the moderation status of product reviews in WooCommerce.
Controls the visibility and approval state of customer reviews.

## Usage Examples

```dart
// Create a review with approved status
final review = WooProductReview(
  review: 'Great product!',
  status: WooProductReviewStatus.approved,
);

// Check review status
if (review.status == WooProductReviewStatus.approved) {
  print('Review is visible to customers');
}

// Handle pending reviews
if (review.status == WooProductReviewStatus.hold) {
  print('Review is pending moderation');
}
```

### approved('approved'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### hold('hold'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### spam('spam'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unspam('unspam'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### trash('trash'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### untrash('untrash'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### all('all'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductReviewStatus(this.value)

WooCommerce Product Review Status Enumeration

Defines the moderation status of product reviews in WooCommerce.
Controls the visibility and approval state of customer reviews.

## Usage Examples

```dart
// Create a review with approved status
final review = WooProductReview(
  review: 'Great product!',
  status: WooProductReviewStatus.approved,
);

// Check review status
if (review.status == WooProductReviewStatus.approved) {
  print('Review is visible to customers');
}

// Handle pending reviews
if (review.status == WooProductReviewStatus.hold) {
  print('Review is pending moderation');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductReviewStatus fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_status

### enum WooProductStatus implements WooEnum

WooCommerce Product Status Enumeration

Defines the publication status of products in WooCommerce.
Controls the visibility and availability of products to customers.

## Usage Examples

```dart
// Create a published product
final product = WooProduct(
  name: 'T-Shirt',
  status: WooProductStatus.publish,
);

// Create a draft product
final draftProduct = WooProduct(
  name: 'Work in Progress',
  status: WooProductStatus.draft,
);

// Check product status
if (product.status == WooProductStatus.publish) {
  print('Product is live and visible');
}
```

### draft('draft'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### pending('pending'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### private('private'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### publish('publish'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### future('future'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductStatus(this.value)

WooCommerce Product Status Enumeration

Defines the publication status of products in WooCommerce.
Controls the visibility and availability of products to customers.

## Usage Examples

```dart
// Create a published product
final product = WooProduct(
  name: 'T-Shirt',
  status: WooProductStatus.publish,
);

// Create a draft product
final draftProduct = WooProduct(
  name: 'Work in Progress',
  status: WooProductStatus.draft,
);

// Check product status
if (product.status == WooProductStatus.publish) {
  print('Product is live and visible');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductStatus fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_stock_status

### enum WooProductStockStatus implements WooEnum

WooCommerce Product Stock Status Enumeration

Defines the current stock availability status of products.
Controls whether products can be purchased and how they appear to customers.

## Usage Examples

```dart
// Create a product with stock
final product = WooProduct(
  name: 'T-Shirt',
  stockStatus: WooProductStockStatus.instock,
  stockQuantity: 100,
);

// Check stock status
if (product.stockStatus == WooProductStockStatus.instock) {
  print('Product is available for purchase');
}

// Handle out of stock products
if (product.stockStatus == WooProductStockStatus.outofstock) {
  print('Product is currently unavailable');
}
```

### instock('instock'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### outofstock('outofstock'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### onbackorder('onbackorder'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductStockStatus(this.value)

WooCommerce Product Stock Status Enumeration

Defines the current stock availability status of products.
Controls whether products can be purchased and how they appear to customers.

## Usage Examples

```dart
// Create a product with stock
final product = WooProduct(
  name: 'T-Shirt',
  stockStatus: WooProductStockStatus.instock,
  stockQuantity: 100,
);

// Check stock status
if (product.stockStatus == WooProductStockStatus.instock) {
  print('Product is available for purchase');
}

// Handle out of stock products
if (product.stockStatus == WooProductStockStatus.outofstock) {
  print('Product is currently unavailable');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductStockStatus fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_tax_status

### enum WooProductTaxStatus implements WooEnum

WooCommerce Product Tax Status Enumeration

Defines the tax treatment for products in WooCommerce.
Controls whether and how taxes are applied to products and shipping.

## Usage Examples

```dart
// Create a taxable product
final product = WooProduct(
  name: 'T-Shirt',
  taxStatus: WooProductTaxStatus.taxable,
  price: 29.99,
);

// Create a tax-exempt product
final exemptProduct = WooProduct(
  name: 'Book',
  taxStatus: WooProductTaxStatus.none,
  price: 19.99,
);

// Check tax status
if (product.taxStatus == WooProductTaxStatus.taxable) {
  print('Product is subject to taxes');
}
```

### taxable('taxable'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### shipping('shipping'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### none('none'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductTaxStatus(this.value)

WooCommerce Product Tax Status Enumeration

Defines the tax treatment for products in WooCommerce.
Controls whether and how taxes are applied to products and shipping.

## Usage Examples

```dart
// Create a taxable product
final product = WooProduct(
  name: 'T-Shirt',
  taxStatus: WooProductTaxStatus.taxable,
  price: 29.99,
);

// Create a tax-exempt product
final exemptProduct = WooProduct(
  name: 'Book',
  taxStatus: WooProductTaxStatus.none,
  price: 19.99,
);

// Check tax status
if (product.taxStatus == WooProductTaxStatus.taxable) {
  print('Product is subject to taxes');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductTaxStatus fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_type

### enum WooProductType implements WooEnum

WooCommerce Product Type Enumeration

Defines the different types of products supported by WooCommerce.
Each type has specific capabilities and behaviors in the store.

## Usage Examples

```dart
// Create a simple product
final product = WooProduct(
  name: 'T-Shirt',
  type: WooProductType.simple,
  price: 29.99,
);

// Create a variable product
final variableProduct = WooProduct(
  name: 'T-Shirt with Options',
  type: WooProductType.variable,
);

// Check product type
if (product.type == WooProductType.simple) {
  print('This is a simple product');
}
```

### simple('simple'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### grouped('grouped'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### external('external'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### variable('variable'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooProductType(this.value)

WooCommerce Product Type Enumeration

Defines the different types of products supported by WooCommerce.
Each type has specific capabilities and behaviors in the store.

## Usage Examples

```dart
// Create a simple product
final product = WooProduct(
  name: 'T-Shirt',
  type: WooProductType.simple,
  price: 29.99,
);

// Create a variable product
final variableProduct = WooProduct(
  name: 'T-Shirt with Options',
  type: WooProductType.variable,
);

// Check product type
if (product.type == WooProductType.simple) {
  print('This is a simple product');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooProductType fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product

### class WooProduct

WooCommerce Product Model

Represents a complete WooCommerce product with all its attributes, pricing,
inventory, shipping, and metadata. This is the core model for managing products
in your WooCommerce store, supporting all product types and configurations.

## Product Structure

A WooCommerce product consists of several key components:

- **Basic Information**: Name, description, SKU, type, and status
- **Pricing & Sales**: Regular price, sale price, and promotional settings
- **Inventory Management**: Stock tracking, backorder handling, and stock status
- **Shipping & Physical**: Weight, dimensions, and shipping class configuration
- **Organization**: Categories, tags, and product relationships
- **Media**: Product images, galleries, and featured image settings
- **Attributes**: Custom product attributes and variation configurations
- **SEO & URLs**: Slug, permalink, and search engine optimization

## Product Types

WooCommerce supports different product types with varying capabilities:

- **Simple**: Basic products with fixed pricing and inventory
- **Variable**: Products with multiple variations (size, color, etc.)
- **Grouped**: Collections of related products sold together
- **External**: Products sold on external websites

## Key Features

- **Product Information**: Name, description, SKU, type, status
- **Pricing**: Regular price, sale price, price formatting
- **Inventory Management**: Stock quantity, stock status, backorders
- **Shipping**: Weight, dimensions, shipping class
- **Categories & Tags**: Product categorization and tagging
- **Images**: Product gallery and featured images
- **Attributes**: Custom product attributes and variations
- **SEO**: Slug, permalink for search engine optimization

## Usage Examples

### Creating a Simple Product

```dart
final product = WooProduct(
  name: 'Sample Product',
  type: WooProductType.simple,
  status: WooProductStatus.publish,
  price: 29.99,
  description: 'A sample product description',
);
```

### Working with Product Data

```dart
// Check if product is on sale
if (product.onSale == true) {
  print('Sale price: ${product.salePrice}');
}

// Get product images
for (final image in product.images) {
  print('Image URL: ${image.src}');
}

// Check stock status
if (product.stockStatus == WooProductStockStatus.instock) {
  print('Product is in stock');
}

// Access product categories
for (final category in product.categories) {
  print('Category: ${category.name}');
}
```

### Creating Variable Products

```dart
final variableProduct = WooProduct(
  name: 'T-Shirt',
  type: WooProductType.variable,
  status: WooProductStatus.publish,
  attributes: [
    WooProductItemAttribute(
      name: 'Size',
      options: ['Small', 'Medium', 'Large'],
    ),
    WooProductItemAttribute(
      name: 'Color',
      options: ['Red', 'Blue', 'Green'],
    ),
  ],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = product.toJson();

// Create from JSON response
final product = WooProduct.fromJson(jsonData);
```

### WooProduct({ this.id, this.name, this.slug, this.permalink, this.type, this.status, this.featured, this.catalogVisibility, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.dateOnSaleFrom, this.dateOnSaleFromGmt, this.dateOnSaleTo, this.dateOnSaleToGmt, this.description, this.shortDescription, this.sku, this.price, this.regularPrice, this.salePrice, this.priceHtml, this.onSale, this.purchasable, this.totalSales, this.virtual, this.downloadable, this.downloads, this.downloadLimit, this.downloadExpiry, this.externalUrl, this.buttonText, this.taxStatus, this.taxClass, this.manageStock, this.stockQuantity, this.stockStatus, this.backorders, this.backordersAllowed, this.backordered, this.soldIndividually, this.weight, this.dimensions, this.shippingRequired, this.shippingTaxable, this.shippingClass, this.shippingClassId, this.reviewsAllowed, this.averageRating, this.ratingCount, this.relatedIds, this.upsellIds, this.crossSellIds, this.parentId, this.purchaseNote, this.categories, this.tags, this.images, this.attributes, this.defaultAttributes, this.variations, this.groupedProducts, this.menuOrder, this.metaData, })

WooCommerce Product Model

Represents a complete WooCommerce product with all its attributes, pricing,
inventory, shipping, and metadata. This is the core model for managing products
in your WooCommerce store, supporting all product types and configurations.

## Product Structure

A WooCommerce product consists of several key components:

- **Basic Information**: Name, description, SKU, type, and status
- **Pricing & Sales**: Regular price, sale price, and promotional settings
- **Inventory Management**: Stock tracking, backorder handling, and stock status
- **Shipping & Physical**: Weight, dimensions, and shipping class configuration
- **Organization**: Categories, tags, and product relationships
- **Media**: Product images, galleries, and featured image settings
- **Attributes**: Custom product attributes and variation configurations
- **SEO & URLs**: Slug, permalink, and search engine optimization

## Product Types

WooCommerce supports different product types with varying capabilities:

- **Simple**: Basic products with fixed pricing and inventory
- **Variable**: Products with multiple variations (size, color, etc.)
- **Grouped**: Collections of related products sold together
- **External**: Products sold on external websites

## Key Features

- **Product Information**: Name, description, SKU, type, status
- **Pricing**: Regular price, sale price, price formatting
- **Inventory Management**: Stock quantity, stock status, backorders
- **Shipping**: Weight, dimensions, shipping class
- **Categories & Tags**: Product categorization and tagging
- **Images**: Product gallery and featured images
- **Attributes**: Custom product attributes and variations
- **SEO**: Slug, permalink for search engine optimization

## Usage Examples

### Creating a Simple Product

```dart
final product = WooProduct(
  name: 'Sample Product',
  type: WooProductType.simple,
  status: WooProductStatus.publish,
  price: 29.99,
  description: 'A sample product description',
);
```

### Working with Product Data

```dart
// Check if product is on sale
if (product.onSale == true) {
  print('Sale price: ${product.salePrice}');
}

// Get product images
for (final image in product.images) {
  print('Image URL: ${image.src}');
}

// Check stock status
if (product.stockStatus == WooProductStockStatus.instock) {
  print('Product is in stock');
}

// Access product categories
for (final category in product.categories) {
  print('Category: ${category.name}');
}
```

### Creating Variable Products

```dart
final variableProduct = WooProduct(
  name: 'T-Shirt',
  type: WooProductType.variable,
  status: WooProductStatus.publish,
  attributes: [
    WooProductItemAttribute(
      name: 'Size',
      options: ['Small', 'Medium', 'Large'],
    ),
    WooProductItemAttribute(
      name: 'Color',
      options: ['Red', 'Blue', 'Green'],
    ),
  ],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = product.toJson();

// Create from JSON response
final product = WooProduct.fromJson(jsonData);
```

### factory WooProduct.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProduct.fake()

Creates a fake WooProduct instance for testing purposes

This factory constructor generates a product with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated product will have valid data for all fields.

## Generated Data

The fake product includes:
- Random name and description
- Random product type from available types
- Random status from available statuses
- Random pricing information
- Random stock and inventory data
- Random categories, tags, and images
- Random attributes and metadata

## Returns

A `WooProduct` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake product for testing
final fakeProduct = WooProduct.fake();
print('Fake product: ${fakeProduct.name}');
print('Type: ${fakeProduct.type}');
print('Price: ${fakeProduct.price}');

// Use in tests
test('product creation', () {
  final product = WooProduct.fake();
  expect(product.name, isNotNull);
  expect(product.type, isNotNull);
  expect(product.price, isNotNull);
});
```

### final int? id

Unique identifier for the product

This ID is automatically assigned by WooCommerce when the product is created.
It's used to identify the product in API calls and is required for updates.

### final String? name

Product name

The display name of the product as it appears to customers.
This is the primary identifier for the product in the store.

### final String? slug

Product slug

A URL-friendly version of the product name, used in product URLs.
Automatically generated from the name but can be customized.

### final String? permalink

Product permalink URL

The full URL where the product can be viewed on the website.
This is automatically generated based on the slug and store settings.

### final WooProductType? type

Product type

Determines the behavior and capabilities of the product:
- `WooProductType.simple`: Basic products with fixed pricing
- `WooProductType.variable`: Products with multiple variations
- `WooProductType.grouped`: Collections of related products
- `WooProductType.external`: Products sold on external websites

### final WooProductStatus? status

Product status

Controls the visibility and availability of the product:
- `WooProductStatus.publish`: Product is live and visible to customers
- `WooProductStatus.draft`: Product is saved but not visible
- `WooProductStatus.pending`: Product is pending review
- `WooProductStatus.private`: Product is visible only to specific users

### final bool? featured

Whether the product is featured

Featured products can be highlighted in special sections of the store
and are often used for promotional purposes.

### final WooProductCatalogVisibility? catalogVisibility

Catalog visibility setting

Controls where the product appears in the store:
- `WooProductCatalogVisibility.visible`: Visible in catalog and search
- `WooProductCatalogVisibility.catalog`: Visible only in catalog
- `WooProductCatalogVisibility.search`: Visible only in search results
- `WooProductCatalogVisibility.hidden`: Hidden from catalog and search

### final DateTime? dateCreated

Date and time when the product was created (local time)

This timestamp reflects when the product was first created in the store's local timezone.

### final DateTime? dateCreatedGmt

Date and time when the product was created (GMT)

This timestamp reflects when the product was first created in GMT/UTC timezone.

### final DateTime? dateModified

Date and time when the product was last modified (local time)

This timestamp reflects when the product was last updated in the store's local timezone.

### final DateTime? dateModifiedGmt

Date and time when the product was last modified (GMT)

This timestamp reflects when the product was last updated in GMT/UTC timezone.

### final DateTime? dateOnSaleFrom

Start date of sale price, in the site's timezone.

### final DateTime? dateOnSaleFromGmt

Start date of sale price, as GMT.

### final DateTime? dateOnSaleTo

End date of sale price, in the site's timezone.

### final DateTime? dateOnSaleToGmt

End date of sale price, as GMT.

### final String? description

Product description

The full description of the product, displayed on the product page.
Supports HTML formatting and can include detailed information about the product.

### final String? shortDescription

Product short description

A brief summary of the product, often displayed in product listings
and search results. Should be concise and compelling.

### final String? sku

Product SKU (Stock Keeping Unit)

A unique identifier for the product used for inventory management.
Must be unique across all products in the store.

### final double? price

Current product price

The active price of the product. If the product is on sale,
this will be the sale price; otherwise, it will be the regular price.

### final double? regularPrice

Product regular price

The standard price of the product before any discounts or sales.
This is the price that will be shown when the product is not on sale.

### final double? salePrice

Product sale price

The discounted price of the product when it's on sale.
This price is only active during the sale period.

### final String? priceHtml

Price formatted in HTML.

### final bool? onSale

Shows if the product is on sale.

### final bool? purchasable

Shows if the product can be bought.

### final int? totalSales

Amount of sales.

### final bool? virtual

If the product is virtual. Default is false.

### final bool? downloadable

If the product is downloadable. Default is false.

### final List<WooProductDownload>? downloads

List of downloadable files.

### final int? downloadLimit

Number of times downloadable files can be downloaded after purchase. Default is -1.

### final int? downloadExpiry

Number of days until access to downloadable files expires. Default is -1.

### final String? externalUrl

Product external URL. Only for external products.

### final String? buttonText

Product external button text. Only for external products.

### final WooProductTaxStatus? taxStatus

Tax status. Options: taxable, shipping and none. Default is taxable.

### final String? taxClass

Tax class.

### final bool? manageStock

Stock management at product level. Default is false.

### final int? stockQuantity

Stock quantity.

### final WooProductStockStatus? stockStatus

Controls the stock status of the product. Options: instock, outofstock, onbackorder. Default is instock.

### final WooProductBackorder? backorders

If managing stock, this controls if backorders are allowed. Options: no, notify and yes. Default is no.

### final bool? backordersAllowed

Shows if backorders are allowed.

### final bool? backordered

Shows if the product is on backordered.

### final bool? soldIndividually

Allow one item to be bought in a single order. Default is false.

### final String? weight

Product weight.

### final WooProductDimension? dimensions

Product dimensions.

### final bool? shippingRequired

Shows if the product need to be shipped.

### final bool? shippingTaxable

Shows whether or not the product shipping is taxable.

### final String? shippingClass

Shipping class slug.

### final int? shippingClassId

Shipping class ID.

### final bool? reviewsAllowed

Allow reviews. Default is true.

### final double? averageRating

Reviews average rating.

### final int? ratingCount

Amount of reviews that the product have.

### final List<int>? relatedIds

List of related products IDs.

### final List<int>? upsellIds

List of up-sell products IDs.

### final List<int>? crossSellIds

List of cross-sell products IDs.

### final int? parentId

Product parent ID.

### final String? purchaseNote

Optional note to send the customer after purchase.

### final List<WooProductCategory>? categories

List of categories. it just includes id, name, slug

### final List<WooProductTag>? tags

List of tags.

### final List<WooProductImage>? images

List of images.

### final List<WooProductItemAttribute>? attributes

List of attributes.

### final List<WooProductDefaultAttribute>? defaultAttributes

Defaults variation attributes.

### final List<int>? variations

List of variations IDs.

### final List<int>? groupedProducts

List of grouped products ID.

### final int? menuOrder

Menu order, used to custom sort products.

### final List<WooMetaData>? metaData

Meta data

### Map<String, dynamic> toJson()

Converts the WooProduct instance to JSON format

This method serializes the product data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the product data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "id": 123,
  "name": "Sample Product",
  "type": "simple",
  "status": "publish",
  "price": "29.99",
  "regular_price": "39.99",
  "sale_price": "29.99",
  "description": "Product description",
  "short_description": "Short description",
  "sku": "PROD-123",
  "featured": false,
  "catalog_visibility": "visible",
  "manage_stock": true,
  "stock_quantity": 100,
  "stock_status": "instock",
  "categories": [...],
  "tags": [...],
  "images": [...],
  "attributes": [...],
  "meta_data": [...]
}
```

## Example Usage

```dart
// Convert product to JSON for API calls
final product = WooProduct(
  name: 'Sample Product',
  type: WooProductType.simple,
  price: 29.99,
);

final jsonData = product.toJson();
print('JSON: $jsonData');

// Send to API
await dio.post('/products', data: product.toJson());
```

### WooProduct copyWith({ int? id, String? name, String? slug, String? permalink, WooProductType? type, WooProductStatus? status, bool? featured, WooProductCatalogVisibility? catalogVisibility, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, DateTime? dateOnSaleFrom, DateTime? dateOnSaleFromGmt, DateTime? dateOnSaleTo, DateTime? dateOnSaleToGmt, String? description, String? shortDescription, String? sku, double? price, double? regularPrice, double? salePrice, String? priceHtml, bool? onSale, bool? purchasable, int? totalSales, bool? virtual, bool? downloadable, List<WooProductDownload>? downloads, int? downloadLimit, int? downloadExpiry, String? externalUrl, String? buttonText, WooProductTaxStatus? taxStatus, String? taxClass, bool? manageStock, int? stockQuantity, WooProductStockStatus? stockStatus, WooProductBackorder? backorders, bool? backordersAllowed, bool? backordered, bool? soldIndividually, String? weight, WooProductDimension? dimensions, bool? shippingRequired, bool? shippingTaxable, String? shippingClass, int? shippingClassId, bool? reviewsAllowed, double? averageRating, int? ratingCount, List<int>? relatedIds, List<int>? upsellIds, List<int>? crossSellIds, int? parentId, String? purchaseNote, List<WooProductCategory>? categories, List<WooProductTag>? tags, List<WooProductImage>? images, List<WooProductItemAttribute>? attributes, List<WooProductDefaultAttribute>? defaultAttributes, List<int>? variations, List<int>? groupedProducts, int? menuOrder, List<WooMetaData>? metaData, })

Creates a copy of this [WooProduct] with the given fields replaced with new values.

This method is useful for updating product data without modifying the original object.

## Example

```dart
final updatedProduct = product.copyWith(
  name: 'Updated Product Name',
  price: 39.99,
  onSale: true,
);
```

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute

### class WooProductAttribute

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttribute({ this.id, this.name, this.slug, this.type, this.orderBy, this.hasArchives, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttribute.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttribute.fake({int? id})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductAttributeType? type

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProductAttributeOrderBy? orderBy

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final bool? hasArchives

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttribute copyWith({ int? id, String? name, String? slug, WooProductAttributeType? type, WooProductAttributeOrderBy? orderBy, bool? hasArchives, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_batch_request

### class WooProductAttributeBatchRequest

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeBatchRequest({this.create, this.update, this.delete})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeBatchRequest.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttribute>? create

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttribute>? update

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? delete

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeBatchRequest copyWith({ List<WooProductAttribute>? create, List<WooProductAttribute>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_batch_response

### class WooProductAttributeBatchResponse

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeBatchResponse({this.create, this.update, this.delete})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeBatchResponse.fromJson

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttribute>? create

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttribute>? update

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttribute>? delete

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeBatchResponse copyWith({ List<WooProductAttribute>? create, List<WooProductAttribute>? update, List<WooProductAttribute>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_term

### class WooProductAttributeTerm

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeTerm({ this.id, this.name, this.slug, this.description, this.menuOrder, this.count, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeTerm.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeTerm.fake({int? id})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? name

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? description

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? menuOrder

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? count

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeTerm copyWith({ int? id, String? name, String? slug, String? description, int? menuOrder, int? count, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_term_batch_request

### class WooProductAttributeTermBatchRequest

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeTermBatchRequest({this.create, this.update, this.delete})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeTermBatchRequest.fromJson

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeTermBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttributeTerm>? create

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttributeTerm>? update

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? delete

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeTermBatchRequest copyWith({ List<WooProductAttributeTerm>? create, List<WooProductAttributeTerm>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_attribute_term_batch_response

### class WooProductAttributeTermBatchResponse

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeTermBatchResponse({this.create, this.update, this.delete})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeTermBatchResponse.fromJson

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductAttributeTermBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttributeTerm>? create

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttributeTerm>? update

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductAttributeTerm>? delete

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductAttributeTermBatchResponse copyWith({ List<WooProductAttributeTerm>? create, List<WooProductAttributeTerm>? update, List<WooProductAttributeTerm>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_batch_request

### class WooProductBatchRequest

WooCommerce Product Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple products in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple products in a single request
- **Bulk Updates**: Update multiple existing products simultaneously
- **Bulk Deletion**: Delete multiple products at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductBatchRequest(
  create: [
    WooProduct(
      name: 'New Product 1',
      type: WooProductType.simple,
      price: 29.99,
      status: WooProductStatus.publish,
    ),
    WooProduct(
      name: 'New Product 2',
      type: WooProductType.simple,
      price: 49.99,
      status: WooProductStatus.publish,
    ),
  ],
  update: [
    existingProduct.copyWith(
      name: 'Updated Product Name',
      price: 39.99,
    ),
  ],
  delete: [123, 456],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductBatchRequest(
  create: [product1, product2, product3],
);

// Create a batch request with only updates
final updateOnly = WooProductBatchRequest(
  update: [updatedProduct1, updatedProduct2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductBatchRequest.fromJson(jsonData);
```

### WooProductBatchRequest({this.create, this.update, this.delete})

WooCommerce Product Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple products in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple products in a single request
- **Bulk Updates**: Update multiple existing products simultaneously
- **Bulk Deletion**: Delete multiple products at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductBatchRequest(
  create: [
    WooProduct(
      name: 'New Product 1',
      type: WooProductType.simple,
      price: 29.99,
      status: WooProductStatus.publish,
    ),
    WooProduct(
      name: 'New Product 2',
      type: WooProductType.simple,
      price: 49.99,
      status: WooProductStatus.publish,
    ),
  ],
  update: [
    existingProduct.copyWith(
      name: 'Updated Product Name',
      price: 39.99,
    ),
  ],
  delete: [123, 456],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductBatchRequest(
  create: [product1, product2, product3],
);

// Create a batch request with only updates
final updateOnly = WooProductBatchRequest(
  update: [updatedProduct1, updatedProduct2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductBatchRequest.fromJson(jsonData);
```

### factory WooProductBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooProductBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooProductBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooProductBatchRequest.fromJson(jsonData);
```

### factory WooProductBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProduct>? create

List of products to create

Each product in this list will be created as a new product in the store.
Products in this list should not have an ID assigned.

### final List<WooProduct>? update

List of products to update

Each product in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of product IDs to delete

Each ID in this list represents a product that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooProductBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooProductBatchRequest copyWith({ List<WooProduct>? create, List<WooProduct>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooProductBatchRequest(
  create: [product1, product2],
  update: [product3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooProductBatchRequest(create: 2, update: 1, delete: 2)
```

## product_batch_response

### class WooProductBatchResponse

WooCommerce Product Batch Response Model

This class represents the response from a batch product operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created products with server-assigned IDs
- **Update Results**: List of successfully updated products
- **Delete Results**: List of successfully deleted products
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProducts(batchRequest);

// Process created products
for (final product in response.create ?? []) {
  print('Created product: ${product.name} with ID: ${product.id}');
}

// Process updated products
for (final product in response.update ?? []) {
  print('Updated product: ${product.name}');
}

// Process deleted products
for (final product in response.delete ?? []) {
  print('Deleted product: ${product.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProducts(batchRequest);

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
final batchResponse = WooProductBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooProductBatchResponse({this.create, this.update, this.delete})

WooCommerce Product Batch Response Model

This class represents the response from a batch product operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created products with server-assigned IDs
- **Update Results**: List of successfully updated products
- **Delete Results**: List of successfully deleted products
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProducts(batchRequest);

// Process created products
for (final product in response.create ?? []) {
  print('Created product: ${product.name} with ID: ${product.id}');
}

// Process updated products
for (final product in response.update ?? []) {
  print('Updated product: ${product.name}');
}

// Process deleted products
for (final product in response.delete ?? []) {
  print('Deleted product: ${product.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProducts(batchRequest);

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
final batchResponse = WooProductBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooProductBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooProductBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooProductBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooProductBatchResponse.fromJson(jsonData);
```

### factory WooProductBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProduct>? create

List of created products

Contains the products that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooProduct>? update

List of updated products

Contains the products that were successfully updated, reflecting
the current state after the update operation.

### final List<WooProduct>? delete

List of deleted products

Contains the products that were successfully deleted. These products
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooProductBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooProductBatchResponse copyWith({ List<WooProduct>? create, List<WooProduct>? update, List<WooProduct>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooProductBatchResponse(
  create: [product1, product2],
  update: [product3],
  delete: [product4, product5],
);
print(batchResponse.toString());
// Output: WooProductBatchResponse(create: 2, update: 1, delete: 2)
```

## product_dimension

### class WooProductDimension

Represents product dimensions with length, width, and height.

Brief description of the model's purpose and usage for product physical dimensions.

### WooProductDimension({this.length, this.height, this.width})

Represents product dimensions with length, width, and height.

Brief description of the model's purpose and usage for product physical dimensions.

### factory WooProductDimension.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductDimension.fake()

Creates a fake WooProductDimension instance for testing purposes.

### final String? length

Product length.

### final String? width

Product width.

### final String? height

Product height.

### Map<String, dynamic> toJson()

Converts the WooProductDimension instance to JSON format.

### WooProductDimension copyWith({ String? length, String? height, String? width, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductDimension instance.

Displays all main fields for debugging and logging purposes.

## product_download

### class WooProductDownload

Represents a downloadable file associated with a product.

Brief description of the model's purpose and usage for product downloads.

### WooProductDownload({this.id, this.name, this.file})

Represents a downloadable file associated with a product.

Brief description of the model's purpose and usage for product downloads.

### factory WooProductDownload.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductDownload.fake()

Creates a fake WooProductDownload instance for testing purposes.

### final String? id

File ID.

### final String? name

File name.

### final String? file

File URL.

### Map<String, dynamic> toJson()

Converts the WooProductDownload instance to JSON format.

### WooProductDownload copyWith({String? id, String? name, String? file})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductDownload instance.

Displays all main fields for debugging and logging purposes.

## product_image

### class WooProductImage

Represents a product image with metadata and URLs.

Brief description of the model's purpose and usage for product images.

## Product creation note

When creating a product, the WooCommerce REST API only accepts
`id`, `src`, `name` and `alt` inside the `images` array. The four
date fields below are populated by the server on read and should
be left `null` (the default) when constructing an image for a
create request — otherwise the API returns `400 Bad Request`.

### WooProductImage({ this.id, this.dateCreated, this.dateCreatedGMT, this.dateModified, this.dateModifiedGMT, this.src, this.name, this.alt, })

Represents a product image with metadata and URLs.

Brief description of the model's purpose and usage for product images.

## Product creation note

When creating a product, the WooCommerce REST API only accepts
`id`, `src`, `name` and `alt` inside the `images` array. The four
date fields below are populated by the server on read and should
be left `null` (the default) when constructing an image for a
create request — otherwise the API returns `400 Bad Request`.

### factory WooProductImage.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductImage.fake()

Creates a fake WooProductImage instance for testing purposes.

### final int? id

Image ID.

### final DateTime? dateCreated

The date the image was created, in the site's timezone.

### final DateTime? dateCreatedGMT

The date the image was created, as GMT.

### final DateTime? dateModified

The date the image was last modified, in the site's timezone.

### final DateTime? dateModifiedGMT

The date the image was last modified, as GMT.

### final String? src

Image URL.

### final String? name

Image name.

### final String? alt

Image alternative text.

### Map<String, dynamic> toJson()

Converts this WooProductImage instance into a JSON encodable Map.

Only emits date keys when they are non-null, so payloads for
product creation omit them entirely (the server assigns them).

### WooProductImage copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGMT, DateTime? dateModified, DateTime? dateModifiedGMT, String? src, String? name, String? alt, })

Returns a copy of this WooProductImage with the given fields replaced.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_item_attribute

### class WooProductItemAttribute

Represents a product attribute with options and settings.

Brief description of the model's purpose and usage for product attributes.

### WooProductItemAttribute({ this.id, this.name, this.position, this.visible, this.variation, this.options, })

Represents a product attribute with options and settings.

Brief description of the model's purpose and usage for product attributes.

### factory WooProductItemAttribute.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductItemAttribute.fake()

Creates a fake WooProductItemAttribute instance for testing purposes.

### final int? id

Attribute ID.

### final String? name

Attribute name.

### final int? position

Attribute position.

### final bool? visible

Define if the attribute is visible on the "Additional information" tab in the product's page. Default is false.

### final bool? variation

Define if the attribute can be used as variation. Default is false.

### final List<String>? options

List of available term names of the attribute.

### Map<String, dynamic> toJson()

Converts the WooProductItemAttribute instance to JSON format.

### WooProductItemAttribute copyWith({ int? id, String? name, int? position, bool? visible, bool? variation, List<String>? options, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductItemAttribute instance.

Displays all main fields for debugging and logging purposes.

### class WooProductDefaultAttribute

Represents a default product attribute with selected option.

Brief description of the model's purpose and usage for default product attributes.

### WooProductDefaultAttribute({this.id, this.name, this.option})

Represents a default product attribute with selected option.

Brief description of the model's purpose and usage for default product attributes.

### factory WooProductDefaultAttribute.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductDefaultAttribute.fake()

Creates a fake WooProductDefaultAttribute instance for testing purposes.

### final int? id

Attribute ID.

### final String? name

Attribute name.

### final String? option

Selected attribute term name.

### Map<String, dynamic> toJson()

Converts the WooProductItemAttribute instance to JSON format.

### WooProductDefaultAttribute copyWith({ int? id, String? name, String? option, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductItemAttribute instance.

Displays all main fields for debugging and logging purposes.

## product_review

### class WooProductReview

Represents a product review with rating and metadata.

Brief description of the model's purpose and usage for product reviews.

### WooProductReview({ this.id, this.dateCreated, this.dateCreatedGmt, this.productId, this.status = WooProductReviewStatus.approved, this.reviewer, this.reviewerEmail, this.review, this.rating, this.verified, })

Represents a product review with rating and metadata.

Brief description of the model's purpose and usage for product reviews.

### factory WooProductReview.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductReview.fake({int? id})

Creates a fake WooProductReview instance for testing purposes.

### final int? id

Unique identifier for the resource. Read-only.

### final DateTime? dateCreated

The date the review was created, in the site's timezone. Read-only.

### final DateTime? dateCreatedGmt

The date the review was created, as GMT. Read-only.

### final int? productId

Unique identifier for the product that the review belongs to.

### final WooProductReviewStatus? status

Status of the review. Options: approved, hold, spam, unspam, trash, and untrash. Defaults to approved.

### final String? reviewer

Reviewer name.

### final String? reviewerEmail

Reviewer email.

### final String? review

The content of the review.

### final int? rating

Review rating (0 to 5).

### final bool? verified

Shows if the reviewer bought the product or not.

### Map<String, dynamic> toJson()

Converts the WooProductReview instance to JSON format.

### WooProductReview copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGmt, int? productId, WooProductReviewStatus? status, String? reviewer, String? reviewerEmail, String? review, int? rating, bool? verified, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## product_review_batch_request

### class WooProductReviewBatchRequest

WooCommerce Product Review Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product reviews in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple reviews in a single request
- **Bulk Updates**: Update multiple existing reviews simultaneously
- **Bulk Deletion**: Delete multiple reviews at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Status Management**: Control review approval status (approved, hold, spam, trash)

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductReviewBatchRequest(
  create: [
    WooProductReview(
      productId: 123,
      reviewer: 'John Doe',
      reviewerEmail: 'john@example.com',
      review: 'Great product! Highly recommended.',
      rating: 5,
      status: WooProductReviewStatus.approved,
    ),
    WooProductReview(
      productId: 456,
      reviewer: 'Jane Smith',
      reviewerEmail: 'jane@example.com',
      review: 'Good quality, fast shipping.',
      rating: 4,
      status: WooProductReviewStatus.hold,
    ),
  ],
  update: [
    WooProductReview(
      id: 789,
      status: WooProductReviewStatus.approved,
      review: 'Updated review text',
    ),
  ],
  delete: [101, 102],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductReviewBatchRequest(
  create: [review1, review2, review3],
);

// Create a batch request with only updates (e.g., approve pending reviews)
final updateOnly = WooProductReviewBatchRequest(
  update: pendingReviews.map((review) => WooProductReview(
    id: review.id,
    status: WooProductReviewStatus.approved,
  )).toList(),
);

// Create a batch request with only deletes
final deleteOnly = WooProductReviewBatchRequest(
  delete: [101, 102, 103],
);
```

## Review Status Management

When creating or updating reviews, you can control their status:

- `WooProductReviewStatus.approved` - Review is visible to customers
- `WooProductReviewStatus.hold` - Review is pending moderation
- `WooProductReviewStatus.spam` - Mark review as spam
- `WooProductReviewStatus.trash` - Move review to trash

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductReviewBatchRequest.fromJson(jsonData);
```

### WooProductReviewBatchRequest({this.create, this.update, this.delete})

WooCommerce Product Review Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product reviews in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple reviews in a single request
- **Bulk Updates**: Update multiple existing reviews simultaneously
- **Bulk Deletion**: Delete multiple reviews at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Status Management**: Control review approval status (approved, hold, spam, trash)

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductReviewBatchRequest(
  create: [
    WooProductReview(
      productId: 123,
      reviewer: 'John Doe',
      reviewerEmail: 'john@example.com',
      review: 'Great product! Highly recommended.',
      rating: 5,
      status: WooProductReviewStatus.approved,
    ),
    WooProductReview(
      productId: 456,
      reviewer: 'Jane Smith',
      reviewerEmail: 'jane@example.com',
      review: 'Good quality, fast shipping.',
      rating: 4,
      status: WooProductReviewStatus.hold,
    ),
  ],
  update: [
    WooProductReview(
      id: 789,
      status: WooProductReviewStatus.approved,
      review: 'Updated review text',
    ),
  ],
  delete: [101, 102],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductReviewBatchRequest(
  create: [review1, review2, review3],
);

// Create a batch request with only updates (e.g., approve pending reviews)
final updateOnly = WooProductReviewBatchRequest(
  update: pendingReviews.map((review) => WooProductReview(
    id: review.id,
    status: WooProductReviewStatus.approved,
  )).toList(),
);

// Create a batch request with only deletes
final deleteOnly = WooProductReviewBatchRequest(
  delete: [101, 102, 103],
);
```

## Review Status Management

When creating or updating reviews, you can control their status:

- `WooProductReviewStatus.approved` - Review is visible to customers
- `WooProductReviewStatus.hold` - Review is pending moderation
- `WooProductReviewStatus.spam` - Mark review as spam
- `WooProductReviewStatus.trash` - Move review to trash

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductReviewBatchRequest.fromJson(jsonData);
```

### factory WooProductReviewBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooProductReviewBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooProductReviewBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooProductReviewBatchRequest.fromJson(jsonData);
```

### factory WooProductReviewBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductReview>? create

List of reviews to create

Each review in this list will be created as a new review in the store.
Reviews in this list should not have an ID assigned.

### final List<WooProductReview>? update

List of reviews to update

Each review in this list must have a valid ID and will be updated
with the provided values. Common use cases include:
- Approving pending reviews (changing status from hold to approved)
- Updating review content or ratings
- Changing review status (spam, trash, etc.)

### final List<int>? delete

List of review IDs to delete

Each ID in this list represents a review that will be permanently deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooProductReviewBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooProductReviewBatchRequest copyWith({ List<WooProductReview>? create, List<WooProductReview>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductReviewBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooProductReviewBatchRequest(
  create: [review1, review2],
  update: [review3],
  delete: [101, 102],
);
print(batchRequest.toString());
// Output: WooProductReviewBatchRequest(create: 2, update: 1, delete: 2)
```

## product_review_batch_response

### class WooProductReviewBatchResponse

WooCommerce Product Review Batch Response Model

This class represents the response from a batch product review operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created reviews with server-assigned IDs
- **Update Results**: List of successfully updated reviews
- **Delete Results**: List of successfully deleted reviews
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

// Process created reviews
for (final review in response.create ?? []) {
  print('Created review: ${review.reviewer} with ID: ${review.id}');
  print('Status: ${review.status}');
}

// Process updated reviews
for (final review in response.update ?? []) {
  print('Updated review: ${review.reviewer}');
  print('New status: ${review.status}');
}

// Process deleted reviews
for (final review in response.delete ?? []) {
  print('Deleted review: ${review.reviewer}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Handling Review Status Changes

```dart
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

// Check which reviews were approved
final approvedReviews = response.update
    ?.where((review) => review.status == WooProductReviewStatus.approved)
    .toList() ?? [];

print('Approved ${approvedReviews.length} reviews');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooProductReviewBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooProductReviewBatchResponse({this.create, this.update, this.delete})

WooCommerce Product Review Batch Response Model

This class represents the response from a batch product review operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created reviews with server-assigned IDs
- **Update Results**: List of successfully updated reviews
- **Delete Results**: List of successfully deleted reviews
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

// Process created reviews
for (final review in response.create ?? []) {
  print('Created review: ${review.reviewer} with ID: ${review.id}');
  print('Status: ${review.status}');
}

// Process updated reviews
for (final review in response.update ?? []) {
  print('Updated review: ${review.reviewer}');
  print('New status: ${review.status}');
}

// Process deleted reviews
for (final review in response.delete ?? []) {
  print('Deleted review: ${review.reviewer}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Handling Review Status Changes

```dart
final response = await wooCommerce.batchUpdateProductReviews(batchRequest);

// Check which reviews were approved
final approvedReviews = response.update
    ?.where((review) => review.status == WooProductReviewStatus.approved)
    .toList() ?? [];

print('Approved ${approvedReviews.length} reviews');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooProductReviewBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooProductReviewBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooProductReviewBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooProductReviewBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooProductReviewBatchResponse.fromJson(jsonData);
```

### factory WooProductReviewBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductReview>? create

List of created reviews

Contains the reviews that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooProductReview>? update

List of updated reviews

Contains the reviews that were successfully updated, reflecting
the current state after the update operation, including any status changes.

### final List<WooProductReview>? delete

List of deleted reviews

Contains the reviews that were successfully deleted. These reviews
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooProductReviewBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooProductReviewBatchResponse copyWith({ List<WooProductReview>? create, List<WooProductReview>? update, List<WooProductReview>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductReviewBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooProductReviewBatchResponse(
  create: [review1, review2],
  update: [review3],
  delete: [review4, review5],
);
print(batchResponse.toString());
// Output: WooProductReviewBatchResponse(create: 2, update: 1, delete: 2)
```

## product_shipping_class

### class WooProductShippingClass

Represents a product shipping class with metadata.

Brief description of the model's purpose and usage for product shipping classes.

### WooProductShippingClass({ this.id, this.name, this.slug, this.description, this.count, })

Represents a product shipping class with metadata.

Brief description of the model's purpose and usage for product shipping classes.

### factory WooProductShippingClass.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductShippingClass.fake({int? id})

Creates a fake WooProductShippingClass instance for testing purposes.

### final int? id

Unique identifier for the resource.

### final String? name

Shipping class name.

### final String? slug

An alphanumeric identifier for the resource unique to its type.

### final String? description

HTML description of the resource.

### final int? count

Number of published products for the resource.

### Map<String, dynamic> toJson()

Converts the WooProductShippingClass instance to JSON format.

### WooProductShippingClass copyWith({ int? id, String? name, String? slug, String? description, int? count, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductShippingClass instance.

Displays all main fields for debugging and logging purposes.

## product_shipping_class_batch_request

### class WooProductShippingClassBatchRequest

WooCommerce Product Shipping Class Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product shipping classes in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple shipping classes in a single request
- **Bulk Updates**: Update multiple existing shipping classes simultaneously
- **Bulk Deletion**: Delete multiple shipping classes at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductShippingClassBatchRequest(
  create: [
    WooProductShippingClass(
      name: 'Express Shipping',
      slug: 'express-shipping',
      description: 'Fast delivery option',
    ),
    WooProductShippingClass(
      name: 'Standard Shipping',
      slug: 'standard-shipping',
      description: 'Regular delivery option',
    ),
  ],
  update: [
    WooProductShippingClass(
      id: 123,
      name: 'Updated Express Shipping',
      slug: 'updated-express-shipping',
      description: 'Updated fast delivery option',
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductShippingClassBatchRequest(
  create: [shippingClass1, shippingClass2, shippingClass3],
);

// Create a batch request with only updates
final updateOnly = WooProductShippingClassBatchRequest(
  update: [updatedShippingClass1, updatedShippingClass2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductShippingClassBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductShippingClassBatchRequest.fromJson(jsonData);
```

### WooProductShippingClassBatchRequest({this.create, this.update, this.delete})

WooCommerce Product Shipping Class Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product shipping classes in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple shipping classes in a single request
- **Bulk Updates**: Update multiple existing shipping classes simultaneously
- **Bulk Deletion**: Delete multiple shipping classes at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductShippingClassBatchRequest(
  create: [
    WooProductShippingClass(
      name: 'Express Shipping',
      slug: 'express-shipping',
      description: 'Fast delivery option',
    ),
    WooProductShippingClass(
      name: 'Standard Shipping',
      slug: 'standard-shipping',
      description: 'Regular delivery option',
    ),
  ],
  update: [
    WooProductShippingClass(
      id: 123,
      name: 'Updated Express Shipping',
      slug: 'updated-express-shipping',
      description: 'Updated fast delivery option',
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductShippingClassBatchRequest(
  create: [shippingClass1, shippingClass2, shippingClass3],
);

// Create a batch request with only updates
final updateOnly = WooProductShippingClassBatchRequest(
  update: [updatedShippingClass1, updatedShippingClass2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductShippingClassBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductShippingClassBatchRequest.fromJson(jsonData);
```

### factory WooProductShippingClassBatchRequest.fromJson

Creates a WooProductShippingClassBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooProductShippingClassBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooProductShippingClassBatchRequest.fromJson(jsonData);
```

### factory WooProductShippingClassBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductShippingClass>? create

List of shipping classes to create

Each shipping class in this list will be created as a new shipping class in the store.
Shipping classes in this list should not have an ID assigned.

### final List<WooProductShippingClass>? update

List of shipping classes to update

Each shipping class in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of shipping class IDs to delete

Each ID in this list represents a shipping class that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooProductShippingClassBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooProductShippingClassBatchRequest copyWith({ List<WooProductShippingClass>? create, List<WooProductShippingClass>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductShippingClassBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooProductShippingClassBatchRequest(
  create: [shippingClass1, shippingClass2],
  update: [shippingClass3],
  delete: [101, 102],
);
print(batchRequest.toString());
// Output: WooProductShippingClassBatchRequest(create: 2, update: 1, delete: 2)
```

## product_shipping_class_batch_response

### class WooProductShippingClassBatchResponse

WooCommerce Product Shipping Class Batch Response Model

This class represents the response from a batch product shipping class operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created shipping classes with server-assigned IDs
- **Update Results**: List of successfully updated shipping classes
- **Delete Results**: List of successfully deleted shipping classes
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);

// Process created shipping classes
for (final shippingClass in response.create ?? []) {
  print('Created shipping class: ${shippingClass.name} with ID: ${shippingClass.id}');
}

// Process updated shipping classes
for (final shippingClass in response.update ?? []) {
  print('Updated shipping class: ${shippingClass.name}');
}

// Process deleted shipping classes
for (final shippingClass in response.delete ?? []) {
  print('Deleted shipping class: ${shippingClass.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);

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
final batchResponse = WooProductShippingClassBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooProductShippingClassBatchResponse({this.create, this.update, this.delete})

WooCommerce Product Shipping Class Batch Response Model

This class represents the response from a batch product shipping class operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created shipping classes with server-assigned IDs
- **Update Results**: List of successfully updated shipping classes
- **Delete Results**: List of successfully deleted shipping classes
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);

// Process created shipping classes
for (final shippingClass in response.create ?? []) {
  print('Created shipping class: ${shippingClass.name} with ID: ${shippingClass.id}');
}

// Process updated shipping classes
for (final shippingClass in response.update ?? []) {
  print('Updated shipping class: ${shippingClass.name}');
}

// Process deleted shipping classes
for (final shippingClass in response.delete ?? []) {
  print('Deleted shipping class: ${shippingClass.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);

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
final batchResponse = WooProductShippingClassBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooProductShippingClassBatchResponse.fromJson

Creates a WooProductShippingClassBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooProductShippingClassBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooProductShippingClassBatchResponse.fromJson(jsonData);
```

### factory WooProductShippingClassBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductShippingClass>? create

List of created shipping classes

Contains the shipping classes that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooProductShippingClass>? update

List of updated shipping classes

Contains the shipping classes that were successfully updated, reflecting
the current state after the update operation.

### final List<WooProductShippingClass>? delete

List of deleted shipping classes

Contains the shipping classes that were successfully deleted. These shipping classes
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooProductShippingClassBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooProductShippingClassBatchResponse copyWith({ List<WooProductShippingClass>? create, List<WooProductShippingClass>? update, List<WooProductShippingClass>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductShippingClassBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooProductShippingClassBatchResponse(
  create: [shippingClass1, shippingClass2],
  update: [shippingClass3],
  delete: [shippingClass4, shippingClass5],
);
print(batchResponse.toString());
// Output: WooProductShippingClassBatchResponse(create: 2, update: 1, delete: 2)
```

## product_tag

### class WooProductTag

Represents a product tag with metadata.

Brief description of the model's purpose and usage for product tags.

### WooProductTag({this.id, this.name, this.slug, this.description, this.count})

Represents a product tag with metadata.

Brief description of the model's purpose and usage for product tags.

### factory WooProductTag.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductTag.fake({int? tagId})

Creates a fake WooProductTag instance for testing purposes.

### final int? id

Unique identifier for the resource.

### final String? name

Tag name.

### final String? slug

An alphanumeric identifier for the resource unique to its type.

### final String? description

HTML description of the resource.

### final int? count

Number of published products for the resource.

### Map<String, dynamic> toJson()

Converts the WooProductTag instance to JSON format.

### WooProductTag copyWith({ int? id, String? name, String? slug, String? description, int? count, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductTag instance.

Displays all main fields for debugging and logging purposes.

## product_tag_batch_request

### class WooProductTagBatchRequest

WooCommerce Product Tag Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product tags in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple tags in a single request
- **Bulk Updates**: Update multiple existing tags simultaneously
- **Bulk Deletion**: Delete multiple tags at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductTagBatchRequest(
  create: [
    WooProductTag(
      null,
      'Electronics',
      'electronics',
      'Electronic products and gadgets',
    ),
    WooProductTag(
      null,
      'Clothing',
      'clothing',
      'Apparel and accessories',
    ),
  ],
  update: [
    WooProductTag(
      123,
      'Updated Electronics',
      'updated-electronics',
      'Updated description',
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductTagBatchRequest(
  create: [tag1, tag2, tag3],
);

// Create a batch request with only updates
final updateOnly = WooProductTagBatchRequest(
  update: [updatedTag1, updatedTag2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductTagBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductTagBatchRequest.fromJson(jsonData);
```

### WooProductTagBatchRequest({this.create, this.update, this.delete})

WooCommerce Product Tag Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple product tags in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple tags in a single request
- **Bulk Updates**: Update multiple existing tags simultaneously
- **Bulk Deletion**: Delete multiple tags at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooProductTagBatchRequest(
  create: [
    WooProductTag(
      null,
      'Electronics',
      'electronics',
      'Electronic products and gadgets',
    ),
    WooProductTag(
      null,
      'Clothing',
      'clothing',
      'Apparel and accessories',
    ),
  ],
  update: [
    WooProductTag(
      123,
      'Updated Electronics',
      'updated-electronics',
      'Updated description',
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooProductTagBatchRequest(
  create: [tag1, tag2, tag3],
);

// Create a batch request with only updates
final updateOnly = WooProductTagBatchRequest(
  update: [updatedTag1, updatedTag2],
);

// Create a batch request with only deletes
final deleteOnly = WooProductTagBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooProductTagBatchRequest.fromJson(jsonData);
```

### factory WooProductTagBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooProductTagBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooProductTagBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooProductTagBatchRequest.fromJson(jsonData);
```

### factory WooProductTagBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductTag>? create

List of tags to create

Each tag in this list will be created as a new tag in the store.
Tags in this list should not have an ID assigned (use null for id).

### final List<WooProductTag>? update

List of tags to update

Each tag in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of tag IDs to delete

Each ID in this list represents a tag that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooProductTagBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooProductTagBatchRequest copyWith({ List<WooProductTag>? create, List<WooProductTag>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductTagBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooProductTagBatchRequest(
  create: [tag1, tag2],
  update: [tag3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooProductTagBatchRequest(create: 2, update: 1, delete: 2)
```

## product_tag_batch_response

### class WooProductTagBatchResponse

WooCommerce Product Tag Batch Response Model

This class represents the response from a batch product tag operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created tags with server-assigned IDs
- **Update Results**: List of successfully updated tags
- **Delete Results**: List of successfully deleted tags
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductTags(batchRequest);

// Process created tags
for (final tag in response.create ?? []) {
  print('Created tag: ${tag.name} with ID: ${tag.id}');
}

// Process updated tags
for (final tag in response.update ?? []) {
  print('Updated tag: ${tag.name}');
}

// Process deleted tags
for (final tag in response.delete ?? []) {
  print('Deleted tag: ${tag.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductTags(batchRequest);

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
final batchResponse = WooProductTagBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooProductTagBatchResponse({this.create, this.update, this.delete})

WooCommerce Product Tag Batch Response Model

This class represents the response from a batch product tag operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created tags with server-assigned IDs
- **Update Results**: List of successfully updated tags
- **Delete Results**: List of successfully deleted tags
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateProductTags(batchRequest);

// Process created tags
for (final tag in response.create ?? []) {
  print('Created tag: ${tag.name} with ID: ${tag.id}');
}

// Process updated tags
for (final tag in response.update ?? []) {
  print('Updated tag: ${tag.name}');
}

// Process deleted tags
for (final tag in response.delete ?? []) {
  print('Deleted tag: ${tag.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateProductTags(batchRequest);

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
final batchResponse = WooProductTagBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooProductTagBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooProductTagBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooProductTagBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooProductTagBatchResponse.fromJson(jsonData);
```

### factory WooProductTagBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooProductTag>? create

List of created tags

Contains the tags that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooProductTag>? update

List of updated tags

Contains the tags that were successfully updated, reflecting
the current state after the update operation.

### final List<WooProductTag>? delete

List of deleted tags

Contains the tags that were successfully deleted. These tags
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooProductTagBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooProductTagBatchResponse copyWith({ List<WooProductTag>? create, List<WooProductTag>? update, List<WooProductTag>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductTagBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooProductTagBatchResponse(
  create: [tag1, tag2],
  update: [tag3],
  delete: [tag4, tag5],
);
print(batchResponse.toString());
// Output: WooProductTagBatchResponse(create: 2, update: 1, delete: 2)
```

## product_with_childrens

### class WooProductWithChildren

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooProductWithChildren({ required this.mainProduct, this.relatedProducts, this.upsellProducts, this.crossSellProducts, this.parentProduct, this.groupedProducts, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductWithChildren.fromData

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductWithChildren.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooProduct mainProduct

Main Product

### final List<WooProduct>? relatedProducts

Related Products

### final List<WooProduct>? upsellProducts

Upsell Products

### final List<WooProduct>? crossSellProducts

Cross Sell Products

### final WooProduct? parentProduct

Parent Products

### final List<WooProduct>? groupedProducts

Grouped Products

### WooProductWithChildren copyWith({ WooProduct? mainProduct, List<WooProduct>? relatedProducts, List<WooProduct>? upsellProducts, List<WooProduct>? crossSellProducts, WooProduct? parentProduct, List<WooProduct>? groupedProducts, })

Creates a copy of this WooProductWithChildrens with the given fields replaced.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductWithChildrens instance.

Displays all main fields for debugging and logging purposes.

