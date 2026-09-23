# refund

## refund_api

### extension WooRefundApi on WooCommerce

WooCommerce Refund API Extension

This extension provides comprehensive refund management capabilities for WooCommerce stores.
It enables retrieval of refund information with extensive filtering and pagination options
to help store owners track and manage order refunds effectively.

## Key Features

- **Refund Retrieval**: Get detailed refund information with comprehensive filtering
- **Advanced Filtering**: Filter by date ranges, parent orders, and specific criteria
- **Pagination Support**: Handle large datasets with page-based navigation
- **Search Capabilities**: Find refunds by specific search terms
- **Sorting Options**: Sort refunds by various attributes (date, amount, etc.)

## Example Usage

```dart
// Get all refunds
final refunds = await wooCommerce.getRefunds();

// Get refunds for a specific order
final orderRefunds = await wooCommerce.getRefunds(
  parent: [123],
  perPage: 50,
);

// Search for refunds by reason
final searchResults = await wooCommerce.getRefunds(
  search: 'defective product',
);
```

### Future<WooPage<WooRefund>> getRefunds({ WooContext context = WooContext.view, int? page, int? perPage, String? search, DateTime? after, DateTime? before, List<int>? exclude, List<int>? include, int? offset, WooSort? order, WooOrderBy? orderBy, List<int>? parent, List<int>? parentExclude, int? dp, bool? useFaker, }) async

Retrieves a list of refunds from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the refunds you need. You can filter by date ranges, parent orders,
search terms, and more.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-refunds

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic refund information (default)
  - `WooContext.edit`: Returns full refund details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to refunds matching a search string
* [after] - Limit response to refunds created after a given ISO8601 compliant date
* [before] - Limit response to refunds created before a given ISO8601 compliant date
* [exclude] - Ensure result set excludes specific refund IDs
* [include] - Limit result set to specific refund IDs
* [offset] - Offset the result set by a specific number of items
* [order] - Order sort attribute ascending or descending (default: desc)
* [orderBy] - Sort collection by object attribute (default: date)
* [parent] - Limit result set to refunds of particular parent order IDs
* [parentExclude] - Limit result set to all refunds except those of particular parent order IDs
* [dp] - Number of decimal points to use in each resource (default: 2)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooRefund>>` containing the refund objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all refunds
final refunds = await wooCommerce.getRefunds();

// Get refunds for a specific order
final orderRefunds = await wooCommerce.getRefunds(
  parent: [123],
  perPage: 50,
);

// Search for refunds by reason
final searchResults = await wooCommerce.getRefunds(
  search: 'defective product',
);

// Get refunds within date range
final recentRefunds = await wooCommerce.getRefunds(
  after: DateTime(2024, 1, 1),
  before: DateTime(2024, 12, 31),
);
```

## refund_query

### class WooRefundQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooRefundQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context, this.after, this.before, this.exclude, this.include, this.parent, this.parentExclude, this.dp, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext? context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? after

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? before

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? exclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? include

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? parent

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<int>? parentExclude

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? dp

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## refund

### class WooRefund extends WooOrderRefund

WooCommerce Refund Model

Represents a refund transaction in WooCommerce, extending the base WooOrderRefund
with additional parent order information. This model provides comprehensive refund
details including financial information, line items, and metadata.

## Key Features

- **Parent Order Tracking**: Links refunds to their originating orders
- **Financial Details**: Tracks refund amounts, reasons, and payment status
- **Line Item Support**: Detailed breakdown of refunded items
- **Tax and Shipping**: Handles tax lines and shipping line refunds
- **Metadata Support**: Custom data storage for refund-specific information

## Usage Examples

### Creating a Refund

```dart
final refund = WooRefund(
  parentId: 123,
  amount: '25.00',
  reason: 'Defective product',
  refundedBy: 1,
);
```

### Working with Refund Data

```dart
// Check refund details
if (refund.amount != null) {
  print('Refund amount: \$${refund.amount}');
}

// Access parent order information
if (refund.parentId != null) {
  print('Parent order ID: ${refund.parentId}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = refund.toJson();

// Create from JSON response
final refund = WooRefund.fromJson(jsonData);
```

### WooRefund({ super.id, super.dateCreated, super.dateCreatedGmt, super.amount, super.reason, super.refundedBy, super.refundedPayment, super.metaData, super.lineItems, super.taxLines, super.shippingLines, super.feeLines, super.apiRefund, super.apiRestock, this.parentId, })

WooCommerce Refund Model

Represents a refund transaction in WooCommerce, extending the base WooOrderRefund
with additional parent order information. This model provides comprehensive refund
details including financial information, line items, and metadata.

## Key Features

- **Parent Order Tracking**: Links refunds to their originating orders
- **Financial Details**: Tracks refund amounts, reasons, and payment status
- **Line Item Support**: Detailed breakdown of refunded items
- **Tax and Shipping**: Handles tax lines and shipping line refunds
- **Metadata Support**: Custom data storage for refund-specific information

## Usage Examples

### Creating a Refund

```dart
final refund = WooRefund(
  parentId: 123,
  amount: '25.00',
  reason: 'Defective product',
  refundedBy: 1,
);
```

### Working with Refund Data

```dart
// Check refund details
if (refund.amount != null) {
  print('Refund amount: \$${refund.amount}');
}

// Access parent order information
if (refund.parentId != null) {
  print('Parent order ID: ${refund.parentId}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = refund.toJson();

// Create from JSON response
final refund = WooRefund.fromJson(jsonData);
```

### factory WooRefund.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooRefund.fake()

Creates a fake WooRefund instance for testing purposes

This factory constructor generates a refund with random but realistic
data, making it useful for testing and development.

## Returns

A `WooRefund` instance with randomly generated fake data.

## Example Usage

```dart
final fakeRefund = WooRefund.fake();
```

### final int? parentId

The ID of the order the refund is associated with.

This field links the refund to its parent order, allowing you to track
which order the refund was issued for. This is essential for order
management and financial reporting.

### Map<String, dynamic> toJson()

Converts the WooRefund instance to JSON format

This method serializes the refund data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the refund data in JSON format.

## Example Usage

```dart
final jsonData = refund.toJson();
```

### WooRefund copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGmt, String? amount, String? reason, int? refundedBy, bool? refundedPayment, List<WooMetaData>? metaData, List<WooLineItem>? lineItems, List<WooTaxLine>? taxLines, List<WooShippingLine>? shippingLines, List<WooOrderFeeLine>? feeLines, bool? apiRefund, bool? apiRestock, int? parentId, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooRefund instance

This method provides a human-readable representation of the refund,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the refund's main field values in a readable format.

## Example Usage

```dart
final refund = WooRefund(id: 1, parentId: 123, amount: '25.00');
print(refund.toString());
// Output: {id: 1, parent_id: 123, amount: 25.00, ...}
```

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

