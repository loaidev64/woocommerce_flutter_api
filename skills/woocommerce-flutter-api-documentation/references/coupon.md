# coupon

## coupon_api

### extension WooCouponApi on WooCommerce

WooCommerce Coupon API Extension

This extension provides comprehensive coupon management capabilities for WooCommerce stores.
It allows you to create, read, update, and delete coupons, as well as retrieve coupon lists
with extensive filtering and pagination options.

## Key Features

- **Coupon Management**: Create, read, update, and delete coupons
- **Advanced Filtering**: Filter coupons by date, status, code, and more
- **Pagination Support**: Efficiently handle large coupon collections
- **Search Capabilities**: Find coupons by code or other criteria
- **Bulk Operations**: Handle multiple coupons efficiently

## Example Usage

```dart
// Get all coupons
final coupons = await wooCommerce.getCoupons();

// Create a new coupon
final coupon = WooCoupon(
  code: 'SAVE20',
  discountType: WooCouponDiscountType.percent,
  amount: '20',
);
final created = await wooCommerce.createCoupon(coupon);
```

### Future<WooPage<WooCoupon>> getCoupons({ WooContext context = WooContext.view, int? page, int? perPage, String? search, DateTime? after, DateTime? before, DateTime? modifiedAfter, DateTime? modifiedBefore, bool? datesAreGmt, List<int>? exclude, List<int>? include, int? offset, WooSort order = WooSort.desc, WooOrderBy orderBy = WooOrderBy.date, String? code, bool? useFaker, }) async

Retrieves a list of coupons from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the coupons you need.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-coupons

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic coupon information (default)
  - `WooContext.edit`: Returns full coupon details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to coupons matching a search string
* [after] - Limit response to coupons published after a given ISO8601 compliant date
* [before] - Limit response to coupons published before a given ISO8601 compliant date
* [modifiedAfter] - Limit response to coupons modified after a given ISO8601 compliant date
* [modifiedBefore] - Limit response to coupons modified before a given ISO8601 compliant date
* [datesAreGmt] - Whether to consider GMT post dates when limiting response by published or modified date
* [exclude] - Ensure result set excludes specific coupon IDs
* [include] - Limit result set to specific coupon IDs
* [offset] - Offset the result set by a specific number of items
* [order] - Order sort attribute ascending or descending (default: desc)
* [orderby] - Sort collection by object attribute (default: date)
* [code] - Limit result set to coupons with a specific code
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooCoupon>>` containing the coupon objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all coupons
final coupons = await wooCommerce.getCoupons();

// Search for coupons with specific code
final searchResults = await wooCommerce.getCoupons(
  search: 'SAVE20',
  perPage: 20,
);

// Get coupons created after a specific date
final recentCoupons = await wooCommerce.getCoupons(
  after: DateTime(2024, 1, 1),
);
```

### Future<WooCoupon> getCoupon(int id, {bool? useFaker}) async

Retrieves a single coupon by its ID from the WooCommerce store.

This method fetches detailed information about a specific coupon,
including all its properties and settings.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-coupon

## Parameters

* [id] - The unique identifier of the coupon to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooCoupon>` containing the coupon object.

## Throws

* `WooCommerceException` if the coupon is not found or access is denied

## Example Usage

```dart
// Get a specific coupon
final coupon = await wooCommerce.getCoupon(123);

// Check coupon details
if (coupon.isActive) {
  print('Coupon ${coupon.code} is active');
}
```

### Future<WooCoupon> createCoupon(WooCoupon coupon, {bool? useFaker}) async

Creates a new coupon in the WooCommerce store.

This method creates a new coupon with the specified properties and settings.
The coupon will be immediately available for use in the store.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-coupon

## Parameters

* [coupon] - The coupon object containing all the coupon details
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooCoupon>` containing the created coupon object with server-assigned ID.

## Throws

* `WooCommerceException` if the coupon creation fails or validation errors occur

## Example Usage

```dart
// Create a percentage discount coupon
final coupon = WooCoupon(
  code: 'SAVE20',
  discountType: WooCouponDiscountType.percent,
  amount: '20',
  description: '20% off your order',
);
final created = await wooCommerce.createCoupon(coupon);

// Create a fixed amount discount coupon
final fixedCoupon = WooCoupon(
  code: 'FIXED10',
  discountType: WooCouponDiscountType.fixedCart,
  amount: '10.00',
);
final createdFixed = await wooCommerce.createCoupon(fixedCoupon);
```

### Future<WooCoupon> updateCoupon

Updates an existing coupon in the WooCommerce store.

This method updates the properties and settings of an existing coupon.
The coupon must have a valid ID to be updated.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-coupon

## Parameters

* [coupon] - The coupon object with updated properties (must include valid ID)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooCoupon>` containing the updated coupon object.

## Throws

* `WooCommerceException` if the coupon update fails, coupon not found, or validation errors occur

## Example Usage

```dart
// Update an existing coupon
final existingCoupon = await wooCommerce.getCoupon(123);
final updatedCoupon = existingCoupon.copyWith(
  amount: '25', // Change discount from 20% to 25%
  description: 'Updated 25% off your order',
);
final result = await wooCommerce.updateCoupon(updatedCoupon);

// Update coupon status
final deactivatedCoupon = existingCoupon.copyWith(
  status: WooCouponStatus.draft,
);
await wooCommerce.updateCoupon(deactivatedCoupon);
```

### Future<WooDeleteResult> deleteCoupon

Deletes a coupon from the WooCommerce store.

This method removes a coupon from the store. By default, the coupon is moved to trash,
but it can be permanently deleted using the force parameter.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-coupon

## Parameters

* [id] - The unique identifier of the coupon to delete
* [useFaker] - When true, returns fake data for testing purposes
* [force] - Whether to permanently delete the coupon (default: false, moves to trash)

## Returns

A `Future<bool>` indicating whether the deletion was successful.

## Throws

* `WooCommerceException` if the coupon deletion fails or coupon not found

## Example Usage

```dart
// Move coupon to trash (can be restored)
final success = await wooCommerce.deleteCoupon(123);

// Permanently delete coupon
final permanentDelete = await wooCommerce.deleteCoupon(
  123,
  force: true,
);

if (success) {
  print('Coupon deleted successfully');
}
```

### Future<WooCouponBatchResponse> batchUpdateCoupons

Performs batch operations on coupons (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple coupons
efficiently in a single API call, reducing the number of requests needed
for bulk operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-coupons

## Parameters

* [request] - The batch request containing coupons to create, update, and/or delete
  - `create`: List of `WooCoupon` objects to create (should not have IDs)
  - `update`: List of `WooCoupon` objects to update (must include valid IDs)
  - `delete`: List of coupon IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooCouponBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created coupons with server-assigned IDs
- `update`: List of successfully updated coupons
- `delete`: List of successfully deleted coupons

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooCouponBatchRequest(
  create: [
    WooCoupon(
      code: 'SAVE20',
      discountType: 'percent',
      amount: '20',
      description: '20% off your order',
    ),
    WooCoupon(
      code: 'FIXED10',
      discountType: 'fixed_cart',
      amount: '10.00',
      description: '$10 off your order',
    ),
  ],
  update: [
    existingCoupon.copyWith(
      amount: '25',
      description: 'Updated 25% off',
    ),
  ],
  delete: [123, 456],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateCoupons(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} coupons');
print('Updated ${response.update?.length ?? 0} coupons');
print('Deleted ${response.delete?.length ?? 0} coupons');

// Access individual results
for (final coupon in response.create ?? []) {
  print('Created coupon: ${coupon.code} with ID: ${coupon.id}');
}
```

## Batch Operations Best Practices

- **Create operations**: Coupons should not have IDs assigned
- **Update operations**: Coupons must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of coupons to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## coupon_query

### class WooCouponQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooCouponQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.after, this.before, this.modifiedAfter, this.modifiedBefore, this.datesAreGmt, this.exclude, this.include, this.code, })

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

### final String? code

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## coupon_discount_type

### enum WooCouponDiscountType implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### percent('percent'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### fixedCart('fixed_cart'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### fixedProduct('fixed_product'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooCouponDiscountType(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooCouponDiscountType fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## coupon

### class WooCoupon

WooCommerce Coupon Model

This class represents a discount coupon in WooCommerce with comprehensive
rules, restrictions, and usage tracking capabilities. Coupons can provide
percentage or fixed amount discounts with various conditions and limitations.

## Key Features

- **Flexible Discount Types**: Percentage, fixed cart, or fixed product discounts
- **Usage Controls**: Limit total usage, per-user usage, and individual use restrictions
- **Product/Category Targeting**: Apply to specific products or categories
- **Amount Restrictions**: Set minimum and maximum order amounts
- **Email Restrictions**: Limit usage to specific customer emails
- **Expiration Support**: Set coupon expiration dates
- **Free Shipping**: Enable free shipping when coupon is applied

## Usage Examples

### Creating a Coupon

```dart
final coupon = WooCoupon(
  code: 'SAVE20',
  discountType: 'percent',
  amount: '20',
  description: '20% off your order',
  usageLimit: 100,
);
```

### Working with Coupon Data

```dart
// Check if coupon is expired
if (coupon.dateExpires != null &&
    coupon.dateExpires!.isBefore(DateTime.now())) {
  print('Coupon has expired');
}

// Check usage limits
if (coupon.usageLimit != null &&
    coupon.usageCount! >= coupon.usageLimit!) {
  print('Coupon usage limit reached');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = coupon.toJson();

// Create from JSON response
final coupon = WooCoupon.fromJson(jsonData);
```

### WooCoupon({ this.id, this.code, this.amount, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.discountType, this.description, this.dateExpires, this.dateExpiresGmt, this.usageCount, this.individualUse, this.productIds, this.excludedProductIds, this.usageLimit, this.usageLimitPerUser, this.limitUsageToXItems, this.freeShipping, this.productCategories, this.excludedProductCategories, this.excludeSaleItems, this.minimumAmount, this.maximumAmount, this.emailRestrictions, this.usedBy, this.metaData, })

WooCommerce Coupon Model

This class represents a discount coupon in WooCommerce with comprehensive
rules, restrictions, and usage tracking capabilities. Coupons can provide
percentage or fixed amount discounts with various conditions and limitations.

## Key Features

- **Flexible Discount Types**: Percentage, fixed cart, or fixed product discounts
- **Usage Controls**: Limit total usage, per-user usage, and individual use restrictions
- **Product/Category Targeting**: Apply to specific products or categories
- **Amount Restrictions**: Set minimum and maximum order amounts
- **Email Restrictions**: Limit usage to specific customer emails
- **Expiration Support**: Set coupon expiration dates
- **Free Shipping**: Enable free shipping when coupon is applied

## Usage Examples

### Creating a Coupon

```dart
final coupon = WooCoupon(
  code: 'SAVE20',
  discountType: 'percent',
  amount: '20',
  description: '20% off your order',
  usageLimit: 100,
);
```

### Working with Coupon Data

```dart
// Check if coupon is expired
if (coupon.dateExpires != null &&
    coupon.dateExpires!.isBefore(DateTime.now())) {
  print('Coupon has expired');
}

// Check usage limits
if (coupon.usageLimit != null &&
    coupon.usageCount! >= coupon.usageLimit!) {
  print('Coupon usage limit reached');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = coupon.toJson();

// Create from JSON response
final coupon = WooCoupon.fromJson(jsonData);
```

### factory WooCoupon.fromJson(Map<String, dynamic> json)

Creates a WooCoupon instance from JSON data

This factory constructor is used to deserialize coupon data received
from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the coupon data in JSON format

## Returns

A `WooCoupon` instance populated with data from the JSON.

## Example Usage

```dart
final coupon = WooCoupon.fromJson(jsonData);
```

### factory WooCoupon.fake({int? id})

Creates a fake WooCoupon instance for testing purposes

This factory constructor generates a coupon with random but realistic
data, making it useful for testing and development.

## Parameters

* [id] - Optional specific ID to use for the fake coupon

## Returns

A `WooCoupon` instance with randomly generated fake data.

## Example Usage

```dart
final fakeCoupon = WooCoupon.fake();
final fakeCouponWithId = WooCoupon.fake(123);
```

### final int? id

Unique identifier for the coupon

This ID is automatically assigned by WooCommerce when the coupon is created.

### final String? code

Coupon code

The code that customers enter to apply the discount.
Must be unique across all coupons.

### final double? amount

Discount amount

The amount of discount, either as a fixed value or percentage.
Should always be numeric, even for percentage discounts.

### final DateTime? dateCreated

Date and time when the coupon was created (local time)

This timestamp reflects when the coupon was first created in the store's local timezone.

### final DateTime? dateCreatedGmt

Date and time when the coupon was created (GMT)

This timestamp reflects when the coupon was first created in GMT/UTC timezone.

### final DateTime? dateModified

Date and time when the coupon was last modified (local time)

This timestamp reflects when the coupon was last updated in the store's local timezone.

### final DateTime? dateModifiedGmt

Date and time when the coupon was last modified (GMT)

This timestamp reflects when the coupon was last updated in GMT/UTC timezone.

### final WooCouponDiscountType? discountType

Type of discount

- `percent`: Percentage discount
- `fixed_cart`: Fixed amount discount for entire cart
- `fixed_product`: Fixed amount discount per product

### final String? description

Coupon description

Description of the coupon for administrative purposes.

### final DateTime? dateExpires

Date and time when the coupon expires (local time)

The coupon will no longer be valid after this date.

### final DateTime? dateExpiresGmt

Date and time when the coupon expires (GMT)

The coupon will no longer be valid after this date in GMT/UTC timezone.

### final int? usageCount

Number of times the coupon has been used

Tracks how many times this coupon has been applied to orders.

### final bool? individualUse

Whether the coupon can only be used individually

If true, the coupon cannot be combined with other coupons.

### final List<int>? productIds

List of product IDs the coupon can be used on

If specified, the coupon can only be applied to these specific products.

### final List<int>? excludedProductIds

List of product IDs the coupon cannot be used on

If specified, the coupon cannot be applied to these products.

### final int? usageLimit

Maximum number of times the coupon can be used in total

Once this limit is reached, the coupon becomes invalid.

### final int? usageLimitPerUser

Maximum number of times the coupon can be used per customer

Limits how many times each customer can use this coupon.

### final int? limitUsageToXItems

Maximum number of items the coupon can be applied to

Limits the number of items in the cart that can use this coupon.

### final bool? freeShipping

Whether this coupon enables free shipping

If true, applying this coupon will make shipping free.

### final List<int>? productCategories

List of category IDs the coupon applies to

If specified, the coupon can only be applied to products in these categories.

### final List<int>? excludedProductCategories

List of category IDs the coupon does not apply to

If specified, the coupon cannot be applied to products in these categories.

### final bool? excludeSaleItems

Whether the coupon excludes items on sale

If true, the coupon will not be applied to items that are currently on sale.

### final double? minimumAmount

Minimum order amount required to apply the coupon

The cart total must be at least this amount for the coupon to be valid.

### final double? maximumAmount

Maximum order amount allowed when using the coupon

The cart total cannot exceed this amount for the coupon to be valid.

### final List<String>? emailRestrictions

List of email addresses that can use this coupon

If specified, only customers with these email addresses can use the coupon.

### final List<String>? usedBy

List of users who have used this coupon

Tracks which users or guest emails have applied this coupon.

### final List<WooMetaData>? metaData

Additional metadata related to the coupon

Custom fields and additional data associated with the coupon.

### Map<String, dynamic> toJson()

Converts the WooCoupon instance to JSON format

This method serializes the coupon data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the coupon data in JSON format.

## Example Usage

```dart
final jsonData = coupon.toJson();
```

### WooCoupon copyWith({ int? id, String? code, double? amount, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, WooCouponDiscountType? discountType, String? description, DateTime? dateExpires, DateTime? dateExpiresGmt, int? usageCount, bool? individualUse, List<int>? productIds, List<int>? excludedProductIds, int? usageLimit, int? usageLimitPerUser, int? limitUsageToXItems, bool? freeShipping, List<int>? productCategories, List<int>? excludedProductCategories, bool? excludeSaleItems, double? minimumAmount, double? maximumAmount, List<String>? emailRestrictions, List<String>? usedBy, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCoupon instance

This method provides a human-readable representation of the coupon,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the coupon's main field values in a readable format.

## Example Usage

```dart
final coupon = WooCoupon(
  id: 123,
  code: 'SAVE20',
  discountType: 'percent',
  amount: '20',
);
print(coupon.toString());
// Output: WooCoupon(id: 123, code: SAVE20, discountType: percent, amount: 20, usageCount: 0)
```

## coupon_batch_request

### class WooCouponBatchRequest

WooCommerce Coupon Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple coupons in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple coupons in a single request
- **Bulk Updates**: Update multiple existing coupons simultaneously
- **Bulk Deletion**: Delete multiple coupons at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooCouponBatchRequest(
  create: [
    WooCoupon(
      code: 'SAVE20',
      discountType: 'percent',
      amount: '20',
    ),
    WooCoupon(
      code: 'FIXED10',
      discountType: 'fixed_cart',
      amount: '10.00',
    ),
  ],
  update: [
    existingCoupon.copyWith(amount: '25'),
  ],
  delete: [123, 456],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooCouponBatchRequest(
  create: [coupon1, coupon2, coupon3],
);

// Create a batch request with only updates
final updateOnly = WooCouponBatchRequest(
  update: [updatedCoupon1, updatedCoupon2],
);

// Create a batch request with only deletes
final deleteOnly = WooCouponBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooCouponBatchRequest.fromJson(jsonData);
```

### WooCouponBatchRequest({this.create, this.update, this.delete})

WooCommerce Coupon Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple coupons in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple coupons in a single request
- **Bulk Updates**: Update multiple existing coupons simultaneously
- **Bulk Deletion**: Delete multiple coupons at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooCouponBatchRequest(
  create: [
    WooCoupon(
      code: 'SAVE20',
      discountType: 'percent',
      amount: '20',
    ),
    WooCoupon(
      code: 'FIXED10',
      discountType: 'fixed_cart',
      amount: '10.00',
    ),
  ],
  update: [
    existingCoupon.copyWith(amount: '25'),
  ],
  delete: [123, 456],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooCouponBatchRequest(
  create: [coupon1, coupon2, coupon3],
);

// Create a batch request with only updates
final updateOnly = WooCouponBatchRequest(
  update: [updatedCoupon1, updatedCoupon2],
);

// Create a batch request with only deletes
final deleteOnly = WooCouponBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooCouponBatchRequest.fromJson(jsonData);
```

### factory WooCouponBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooCouponBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooCouponBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooCouponBatchRequest.fromJson(jsonData);
```

### factory WooCouponBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooCoupon>? create

List of coupons to create

Each coupon in this list will be created as a new coupon in the store.
Coupons in this list should not have an ID assigned.

### final List<WooCoupon>? update

List of coupons to update

Each coupon in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of coupon IDs to delete

Each ID in this list represents a coupon that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooCouponBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooCouponBatchRequest copyWith({ List<WooCoupon>? create, List<WooCoupon>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCouponBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooCouponBatchRequest(
  create: [coupon1, coupon2],
  update: [coupon3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooCouponBatchRequest(create: 2, update: 1, delete: 2)
```

## coupon_batch_response

### class WooCouponBatchResponse

WooCommerce Coupon Batch Response Model

This class represents the response from a batch coupon operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created coupons with server-assigned IDs
- **Update Results**: List of successfully updated coupons
- **Delete Results**: List of successfully deleted coupons
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateCoupons(batchRequest);

// Process created coupons
for (final coupon in response.create ?? []) {
  print('Created coupon: ${coupon.code} with ID: ${coupon.id}');
}

// Process updated coupons
for (final coupon in response.update ?? []) {
  print('Updated coupon: ${coupon.code}');
}

// Process deleted coupons
for (final coupon in response.delete ?? []) {
  print('Deleted coupon: ${coupon.code}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateCoupons(batchRequest);

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
final batchResponse = WooCouponBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooCouponBatchResponse({this.create, this.update, this.delete})

WooCommerce Coupon Batch Response Model

This class represents the response from a batch coupon operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created coupons with server-assigned IDs
- **Update Results**: List of successfully updated coupons
- **Delete Results**: List of successfully deleted coupons
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateCoupons(batchRequest);

// Process created coupons
for (final coupon in response.create ?? []) {
  print('Created coupon: ${coupon.code} with ID: ${coupon.id}');
}

// Process updated coupons
for (final coupon in response.update ?? []) {
  print('Updated coupon: ${coupon.code}');
}

// Process deleted coupons
for (final coupon in response.delete ?? []) {
  print('Deleted coupon: ${coupon.code}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateCoupons(batchRequest);

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
final batchResponse = WooCouponBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooCouponBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooCouponBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooCouponBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooCouponBatchResponse.fromJson(jsonData);
```

### factory WooCouponBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooCoupon>? create

List of created coupons

Contains the coupons that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooCoupon>? update

List of updated coupons

Contains the coupons that were successfully updated, reflecting
the current state after the update operation.

### final List<WooCoupon>? delete

List of deleted coupons

Contains the coupons that were successfully deleted. These coupons
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooCouponBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooCouponBatchResponse copyWith({ List<WooCoupon>? create, List<WooCoupon>? update, List<WooCoupon>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCouponBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooCouponBatchResponse(
  create: [coupon1, coupon2],
  update: [coupon3],
  delete: [coupon4, coupon5],
);
print(batchResponse.toString());
// Output: WooCouponBatchResponse(create: 2, update: 1, delete: 2)
```

