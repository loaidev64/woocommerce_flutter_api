# order

## order_api

### extension WooOrderApi on WooCommerce

WooCommerce Order API Extension

This extension provides comprehensive order management capabilities for WooCommerce stores.
Orders represent customer purchases and contain all the information needed for fulfillment.

## Key Features

- **Order Retrieval**: Get orders with extensive filtering and pagination
- **Order Management**: Create, update, and delete orders
- **Order Status Management**: Track order lifecycle from pending to completed
- **Customer Orders**: Retrieve orders for specific customers
- **Order Notifications**: Send order details to customers via email
- **Advanced Filtering**: Filter by status, customer, product, date, and more

## Example Usage

```dart
// Get all orders
final orders = await wooCommerce.getOrders();

// Create a new order
final order = WooOrder(
  id: 0,
  status: WooOrderStatus.pending,
  total: 99.99,
);
final createdOrder = await wooCommerce.createOrder(order);

// Get orders for a specific customer
final customerOrders = await wooCommerce.getOrders(
  customer: 123,
  status: [WooOrderStatus.completed],
);
```

### Future<WooPage<WooOrder>> getOrders({ WooContext context = WooContext.view, int? page, int? perPage, String? search, DateTime? after, DateTime? before, DateTime? modifiedAfter, DateTime? modifiedBefore, bool? datesAreGmt, List<int>? exclude, List<int>? include, int? offset, WooSort? order, WooOrderBy? orderBy, List<int>? parent, List<int>? parentExclude, List<WooOrderStatus> status = const [WooOrderStatus.any], int? customer, int? product, int? dp, String? currency, bool? useFaker, }) async

Retrieves a list of orders from the WooCommerce store.

This method supports extensive filtering and pagination options to help you
find exactly the orders you need for order management and reporting.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-orders

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic order information (default)
  - `WooContext.edit`: Returns full order details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to orders matching a search string
* [after] - Limit response to orders created after this date
* [before] - Limit response to orders created before this date
* [modifiedAfter] - Limit response to orders modified after this date
* [modifiedBefore] - Limit response to orders modified before this date
* [datesAreGmt] - Whether to consider GMT dates when filtering by date
* [exclude] - Exclude orders with specific IDs from results
* [include] - Only include orders with specific IDs
* [offset] - Offset the result set by a specific number of items
* [parent] - Limit result set to orders with specific parent IDs
* [parentExclude] - Exclude orders with specific parent IDs
* [status] - Filter by order status (default: any)
* [customer] - Filter by customer ID
* [product] - Filter by product ID
* [dp] - Number of decimal points to use in each resource (default: 2)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooOrder>>` containing the order objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all pending orders
final pendingOrders = await wooCommerce.getOrders(
  status: [WooOrderStatus.pending],
  perPage: 50,
);

// Get orders for a specific customer
final customerOrders = await wooCommerce.getOrders(
  customer: 123,
);

// Get orders from the last 30 days
final recentOrders = await wooCommerce.getOrders(
  after: DateTime.now().subtract(Duration(days: 30)),
);
```

### Future<WooOrder> getOrder(int id, {bool? useFaker}) async

Retrieves a single order by its ID.

This method fetches detailed information about a specific order,
including all order data, line items, customer information, and metadata.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-an-order

## Parameters

* [id] - The unique identifier of the order to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrder>` containing the order object with all details.

## Throws

* `WooCommerceException` if the order is not found or access is denied

## Example Usage

```dart
// Get a specific order
final order = await wooCommerce.getOrder(123);
print('Order ${order.number}: \$${order.total}');

// Get order with customer details
if (order.billing != null) {
  print('Customer: ${order.billing!.firstName} ${order.billing!.lastName}');
}

// Check order status
if (order.status == WooOrderStatus.completed) {
  print('Order has been fulfilled');
}
```

### Future<WooOrder> createOrder(WooOrder order, {bool? useFaker}) async

Creates a new order in the WooCommerce store.

This method creates a new order with all the provided details including
customer information, line items, billing, shipping, and payment data.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-an-order

## Parameters

* [order] - The order object containing all order details
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrder>` containing the created order with assigned ID.

## Throws

* `WooCommerceException` if the order creation fails or validation errors occur

## Example Usage

```dart
// Create a new order
final order = WooOrder(
  id: 0, // Will be assigned by WooCommerce
  status: WooOrderStatus.pending,
  customerId: 123,
  billing: WooBilling(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
  ),
  lineItems: [
    WooLineItem(
      productId: 456,
      quantity: 2,
      total: 59.98,
    ),
  ],
  total: 59.98,
);

final createdOrder = await wooCommerce.createOrder(order);
print('Created order ID: ${createdOrder.id}');
```

### Future<WooOrder> updateOrder(int id, WooOrder order, {bool? useFaker}) async

Updates an existing order in the WooCommerce store.

This method updates an existing order with new information. You can modify
order status, customer details, line items, billing, shipping, and other order data.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-an-order

## Parameters

* [order] - The order object with updated information (must include valid ID)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrder>` containing the updated order with all changes applied.

## Throws

* `WooCommerceException` if the order update fails or the order doesn't exist

## Example Usage

```dart
// Update order status
final updatedOrder = order.copyWith(
  status: WooOrderStatus.processing,
  setPaid: true,
);
final result = await wooCommerce.updateOrder(updatedOrder);

// Update customer information
final orderWithNewBilling = order.copyWith(
  billing: WooBilling(
    firstName: 'Jane',
    lastName: 'Smith',
    email: 'jane@example.com',
  ),
);
await wooCommerce.updateOrder(orderWithNewBilling);
```

### Future<WooDeleteResult> deleteOrder

Deletes an order from the WooCommerce store.

This method removes an order from the store. By default, orders are moved to trash
and can be restored. Use the force parameter to permanently delete the order.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-an-order

## Parameters

* [id] - The unique identifier of the order to delete
* [force] - Whether to permanently delete the order (default: false - move to trash)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<bool>` indicating whether the deletion was successful.

## Throws

* `WooCommerceException` if the order deletion fails or the order doesn't exist

## Example Usage

```dart
// Move order to trash (default)
final deleted = await wooCommerce.deleteOrder(123);
if (deleted) {
  print('Order moved to trash');
}

// Permanently delete order
final permanentlyDeleted = await wooCommerce.deleteOrder(123, force: true);
if (permanentlyDeleted) {
  print('Order permanently deleted');
}
```

### Future<String> sendOrderDetailsToCustomer

Sends order details to the customer via email.

This method triggers an email notification to the customer containing
their order details, including items, totals, and shipping information.
The email is only sent if the order contains a valid customer email address.
https://woocommerce.github.io/woocommerce-rest-api-docs/#send-order-details-to-customer

## Parameters

* [orderId] - The unique identifier of the order
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<String>` containing the confirmation message about the email send.

## Throws

* `WooCommerceException` if the email sending fails or the order doesn't exist

## Example Usage

```dart
// Send order confirmation email
final message = await wooCommerce.sendOrderDetailsToCustomer(123);
print('Email status: $message');

// Send email after order completion
if (order.status == WooOrderStatus.completed) {
  final emailResult = await wooCommerce.sendOrderDetailsToCustomer(order.id!);
  print('Customer notified: $emailResult');
}
```

### Future<WooOrderBatchResponse> batchUpdateOrders

Performs batch operations on orders (create, update, delete) in a single request.

This method allows you to create, update, and delete multiple orders
efficiently in a single API call, reducing the number of requests needed
for bulk operations.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-orders

## Parameters

* [request] - The batch request containing orders to create, update, and/or delete
  - `create`: List of `WooOrder` objects to create (should have id: 0)
  - `update`: List of `WooOrder` objects to update (must include valid IDs)
  - `delete`: List of order IDs (integers) to delete
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrderBatchResponse>` containing the results of all batch operations:
- `create`: List of successfully created orders with server-assigned IDs
- `update`: List of successfully updated orders
- `delete`: List of successfully deleted orders

## Throws

* `WooCommerceException` if the batch operation fails or validation errors occur

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooOrderBatchRequest(
  create: [
    WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      total: 99.99,
      customerId: 123,
      billing: WooBilling(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
      ),
    ),
    WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      total: 149.99,
      customerId: 456,
    ),
  ],
  update: [
    existingOrder..status = WooOrderStatus.processing,
  ],
  delete: [789, 101112],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateOrders(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} orders');
print('Updated ${response.update?.length ?? 0} orders');
print('Deleted ${response.delete?.length ?? 0} orders');

// Access individual results
for (final order in response.create ?? []) {
  print('Created order: ${order.number} with ID: ${order.id}');
}
```

## Batch Operations Best Practices

- **Create operations**: Orders should have id set to 0 (will be assigned by WooCommerce)
- **Update operations**: Orders must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of orders to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## order_note_api

### extension WooOrderNoteApi on WooCommerce

WooCommerce Order Note API Extension

This extension provides comprehensive order note management capabilities for WooCommerce stores.
It allows you to retrieve, create, and delete order notes, which are comments or updates
associated with specific orders.

## Key Features

- **Retrieve Order Notes**: Get all notes for a specific order with filtering options
- **Get Single Note**: Retrieve a specific order note by ID
- **Create Notes**: Add new notes to orders (customer or internal)
- **Delete Notes**: Remove order notes (with force deletion)

## Example Usage

```dart
// Get all order notes
final notes = await wooCommerce.getOrderNotes(123);

// Create a new order note
final note = WooOrderNote(
  note: 'Order processed successfully',
  customerNote: true,
);
final created = await wooCommerce.createOrderNote(123, note);
```

### Future<WooPage<WooOrderNote>> getOrderNotes

Retrieves a list of order notes for a specific order.

This method fetches all notes associated with the given order ID, supporting
filtering by note type and context scope.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-order-notes

## Parameters

* [orderId] - The ID of the order to retrieve notes for
* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic note information (default)
  - `WooContext.edit`: Returns full note details including sensitive data
* [type] - Limit result to customers or internal notes.
  - `WooOrderNoteType.any`: Returns all notes (default)
  - `WooOrderNoteType.customer`: Returns only customer-visible notes
  - `WooOrderNoteType.internal`: Returns only internal notes
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooOrderNote>>` containing the order note objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all notes for an order
final notes = await wooCommerce.getOrderNotes(123);

// Get only customer notes
final customerNotes = await wooCommerce.getOrderNotes(
  123,
  type: WooOrderNoteType.customer,
);
```

### Future<WooOrderNote> getOrderNote

Retrieves a specific order note by its ID.

This method fetches a single order note associated with the given order ID and note ID.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-an-order-note

## Parameters

* [orderId] - The ID of the order that contains the note
* [noteId] - The ID of the specific note to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrderNote>` containing the order note object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get a specific order note
final note = await wooCommerce.getOrderNote(123, 456);
```

### Future<WooOrderNote> createOrderNote

Creates a new order note for a specific order.

This method adds a new note to the specified order. The note can be either
customer-visible or internal, depending on the note configuration.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-an-order-note

## Parameters

* [orderId] - The ID of the order to add the note to
* [note] - The WooOrderNote object containing the note data
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrderNote>` containing the created order note object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a customer note
final note = WooOrderNote(
  note: 'Order shipped via express delivery',
  customerNote: true,
);
final created = await wooCommerce.createOrderNote(123, note);

// Create an internal note
final internalNote = WooOrderNote(
  note: 'Customer called to change shipping address',
  customerNote: false,
);
final createdInternal = await wooCommerce.createOrderNote(123, internalNote);
```

### Future<WooOrderNote> updateOrderNote

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteOrderNote

Deletes a specific order note.

This method permanently removes an order note from the specified order.
Note: The force parameter is required to be true as order notes do not support trashing.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-an-order-note

## Parameters

* [orderId] - The ID of the order that contains the note
* [noteId] - The ID of the note to delete
* [useFaker] - When true, simulates successful deletion for testing purposes

## Returns

A `Future<bool>` indicating whether the deletion was successful.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Delete an order note
final success = await wooCommerce.deleteOrderNote(123, 456);
if (success) {
  print('Order note deleted successfully');
}
```

## order_note_query

### class WooOrderNoteQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderNoteQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context, this.type, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext? context

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooOrderNoteType? type

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## order_query

### class WooOrderQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context, this.after, this.before, this.modifiedAfter, this.modifiedBefore, this.datesAreGmt, this.exclude, this.include, this.parent, this.parentExclude, this.status, this.customer, this.product, this.dp, this.currency, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final WooContext? context

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

### final List<WooOrderStatus>? status

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? customer

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? product

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? dp

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? currency

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## order_refund_api

### extension WooOrderRefundApi on WooCommerce

WooCommerce Order Refund API Extension

This extension provides comprehensive order refund management capabilities for WooCommerce stores.
It allows you to retrieve, create, and delete order refunds, which represent money returned
to customers for orders.

## Key Features

- **Retrieve Order Refunds**: Get all refunds for a specific order with extensive filtering
- **Get Single Refund**: Retrieve a specific order refund by ID
- **Create Refunds**: Process new refunds for orders
- **Delete Refunds**: Remove order refunds (with force deletion)

## Example Usage

```dart
// Get all refunds for an order
final refunds = await wooCommerce.getOrderRefunds(123);

// Create a new refund
final refund = WooOrderRefund(
  amount: '25.00',
  reason: 'Product defect',
);
final created = await wooCommerce.createOrderRefund(123, refund);
```

### Future<WooPage<WooOrderRefund>> getOrderRefunds

Retrieves a list of order refunds for a specific order.

This method supports extensive filtering and pagination options to help you
find exactly the refunds you need.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-order-refunds

## Parameters

* [orderId] - The ID of the order to retrieve refunds for
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
* [orderby] - Sort collection by object attribute (default: date)
* [parent] - Limit result set to those of particular parent IDs
* [parentExclude] - Limit result set to all items except those of a particular parent ID
* [dp] - Number of decimal points to use in each resource (default: 2)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooOrderRefund>>` containing the order refund objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get all refunds for an order
final refunds = await wooCommerce.getOrderRefunds(123);

// Search for refunds with pagination
final searchResults = await wooCommerce.getOrderRefunds(
  123,
  search: 'defect',
  perPage: 20,
  page: 1,
);

// Get refunds within date range
final recentRefunds = await wooCommerce.getOrderRefunds(
  123,
  after: DateTime.now().subtract(Duration(days: 30)),
  before: DateTime.now(),
);
```

### Future<WooOrderRefund> getOrderRefund

Retrieves a specific order refund by its ID.

This method fetches a single order refund associated with the given order ID and refund ID.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-an-order-refund

## Parameters

* [orderId] - The ID of the order that contains the refund
* [refundId] - The ID of the specific refund to retrieve
* [db] - Number of decimal points to use in each resource
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrderRefund>` containing the order refund object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get a specific order refund
final refund = await wooCommerce.getOrderRefund(123, 456);

// Get refund with specific decimal precision
final preciseRefund = await wooCommerce.getOrderRefund(123, 456, db: 4);
```

### Future<WooOrderRefund> createOrderRefund

Creates a new order refund for a specific order.

This method processes a new refund for the specified order. The refund amount
and reason should be specified in the WooOrderRefund object.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-an-order-refund

## Parameters

* [orderId] - The ID of the order to create the refund for
* [refund] - The WooOrderRefund object containing the refund data
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooOrderRefund>` containing the created order refund object.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a full refund
final refund = WooOrderRefund(
  amount: '99.99',
  reason: 'Customer requested full refund',
);
final created = await wooCommerce.createOrderRefund(123, refund);

// Create a partial refund
final partialRefund = WooOrderRefund(
  amount: '25.00',
  reason: 'Product defect - partial refund',
);
final createdPartial = await wooCommerce.createOrderRefund(123, partialRefund);
```

### Future<WooOrderRefund> updateOrderRefund

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteOrderRefund

Deletes a specific order refund.

This method permanently removes an order refund from the specified order.
Note: The force parameter is required to be true as order refunds do not support trashing.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-an-order-refund

## Parameters

* [orderId] - The ID of the order that contains the refund
* [refundId] - The ID of the refund to delete
* [useFaker] - When true, simulates successful deletion for testing purposes

## Returns

A `Future<bool>` indicating whether the deletion was successful.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Delete an order refund
final success = await wooCommerce.deleteOrderRefund(123, 456);
if (success) {
  print('Order refund deleted successfully');
}
```

## order_refund_query

### class WooOrderRefundQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderRefundQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context, this.after, this.before, this.exclude, this.include, this.parent, this.parentExclude, this.dp, })

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

## currency

### abstract final class WooCurrency

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static String fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## order_note_type

### enum WooOrderNoteType implements WooEnum

WooCommerce Order Note Type Enumeration

Defines the possible types for order notes in WooCommerce.
Used to filter and categorize order notes based on their visibility and purpose.

## Usage Examples

```dart
// Filter notes by type
final customerNotes = notes.where((note) => note.type == WooOrderNoteType.customer);

// Check note visibility
if (noteType == WooOrderNoteType.customer) {
  print('This note is visible to customers');
}
```

### any('any'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### customer('customer'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### internal('internal'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderNoteType(this.value)

WooCommerce Order Note Type Enumeration

Defines the possible types for order notes in WooCommerce.
Used to filter and categorize order notes based on their visibility and purpose.

## Usage Examples

```dart
// Filter notes by type
final customerNotes = notes.where((note) => note.type == WooOrderNoteType.customer);

// Check note visibility
if (noteType == WooOrderNoteType.customer) {
  print('This note is visible to customers');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooOrderNoteType fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## order_status

### enum WooOrderStatus implements WooEnum

WooCommerce Order Status Enumeration

Defines the different statuses that an order can have in WooCommerce.
Each status represents a stage in the order fulfillment process.

## Usage Examples

```dart
// Create an order with specific status
final order = WooOrder(
  id: 123,
  status: WooOrderStatus.pending,
  total: 99.99,
);

// Check order status
if (order.status == WooOrderStatus.completed) {
  print('Order has been fulfilled');
}

// Update order status
order.status = WooOrderStatus.processing;
await wooCommerce.updateOrder(order);
```

### any('any'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### pending('pending'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### processing('processing'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### onHold('on-hold'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### completed('completed'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### cancelled('cancelled'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### refunded('refunded'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### failed('failed'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### trash('trash'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderStatus(this.value)

WooCommerce Order Status Enumeration

Defines the different statuses that an order can have in WooCommerce.
Each status represents a stage in the order fulfillment process.

## Usage Examples

```dart
// Create an order with specific status
final order = WooOrder(
  id: 123,
  status: WooOrderStatus.pending,
  total: 99.99,
);

// Check order status
if (order.status == WooOrderStatus.completed) {
  print('Order has been fulfilled');
}

// Update order status
order.status = WooOrderStatus.processing;
await wooCommerce.updateOrder(order);
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooOrderStatus fake()

Creates a fake WooOrderStatus instance for testing purposes

This method generates a random order status from the available options,
making it useful for testing and development.

## Returns

A `WooOrderStatus` instance with randomly selected status.

## Example Usage

```dart
final fakeStatus = WooOrderStatus.fake();
```

## order_tax_status

### enum WooOrderTaxStatus implements WooEnum

WooCommerce Order Tax Status Enumeration

Defines the possible tax statuses for order items in WooCommerce.
Used to determine whether items are subject to tax calculations.

## Usage Examples

```dart
// Create order item with tax status
final lineItem = WooLineItem(
  name: 'Product',
  taxStatus: WooOrderTaxStatus.taxable,
);

// Check if item is taxable
if (item.taxStatus == WooOrderTaxStatus.taxable) {
  print('Item is subject to tax');
}
```

### taxable('taxable'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### none('none'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooOrderTaxStatus(this.value)

WooCommerce Order Tax Status Enumeration

Defines the possible tax statuses for order items in WooCommerce.
Used to determine whether items are subject to tax calculations.

## Usage Examples

```dart
// Create order item with tax status
final lineItem = WooLineItem(
  name: 'Product',
  taxStatus: WooOrderTaxStatus.taxable,
);

// Check if item is taxable
if (item.taxStatus == WooOrderTaxStatus.taxable) {
  print('Item is subject to tax');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooOrderTaxStatus fake()

Creates a fake WooOrderTaxStatus for testing purposes.

This method generates a random tax status from the available values,
making it useful for testing and development.

## Returns

A `WooOrderTaxStatus` with randomly selected value.

## Example Usage

```dart
final fakeStatus = WooOrderTaxStatus.fake();
print('Random tax status: $fakeStatus');
```

## billing

### class WooBilling

Represents billing address information for a WooCommerce order.

Contains customer billing details including name, address, contact information,
and company details. Used for order processing and customer communication.

### WooBilling({ this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.state, this.postcode, this.country, this.email, this.phone, })

Represents billing address information for a WooCommerce order.

Contains customer billing details including name, address, contact information,
and company details. Used for order processing and customer communication.

### factory WooBilling.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooBilling.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? firstName

Customer's first name.

### final String? lastName

Customer's last name.

### final String? company

Company name (optional).

### final String? address1

Primary address line.

### final String? address2

Secondary address line (apartment, suite, etc.).

### final String? city

City name.

### final String? state

State, province, or district code/name.

### final String? postcode

Postal or ZIP code.

### final String? country

Country code in ISO 3166-1 alpha-2 format.

### final String? email

Customer's email address.

### final String? phone

Customer's phone number.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooBilling copyWith({ String? firstName, String? lastName, String? company, String? address1, String? address2, String? city, String? state, String? postcode, String? country, String? email, String? phone, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooBilling instance.

Displays all main fields for debugging and logging purposes.

## fee_line_tax

### class WooFeeLineTax

Represents tax information for a fee line in a WooCommerce order.

Contains tax rate details, calculations, and amounts for taxes applied
to fee lines. Used for tax tracking and order processing.

### WooFeeLineTax({ this.id, this.rateCode, this.rateId, this.label, this.compound, this.taxTotal, this.shippingTaxTotal, this.metaData, })

Represents tax information for a fee line in a WooCommerce order.

Contains tax rate details, calculations, and amounts for taxes applied
to fee lines. Used for tax tracking and order processing.

### factory WooFeeLineTax.fromJson(Map<String, dynamic> json)

Creates a WooFeeLineTax instance from JSON data.

### factory WooFeeLineTax.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the fee line tax item.

### final String? rateCode

Tax rate code.

### final String? rateId

Tax rate identifier.

### final String? label

Tax rate display label.

### final bool? compound

Whether this is a compound tax rate.

### final double? taxTotal

Tax total excluding shipping taxes.

### final double? shippingTaxTotal

Shipping tax total.

### final List<WooMetaData>? metaData

Custom metadata for the fee line tax item.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooFeeLineTax copyWith({ int? id, String? rateCode, String? rateId, String? label, bool? compound, double? taxTotal, double? shippingTaxTotal, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooFeeLineTax instance.

Displays all main fields for debugging and logging purposes.

## line_item

### class WooLineItem

Represents a line item in a WooCommerce order.

Contains product information, quantities, pricing, and tax details for items
in an order. Used for order processing and inventory management.

### WooLineItem({ this.id, this.name, this.productId, this.variationId, this.quantity, this.taxClass, this.subtotal, this.subtotalTax, this.total, this.totalTax, this.taxes, this.metaData, this.sku, this.price, })

Represents a line item in a WooCommerce order.

Contains product information, quantities, pricing, and tax details for items
in an order. Used for order processing and inventory management.

### factory WooLineItem.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooLineItem.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the line item.

### final String? name

Product name.

### final int? productId

Product ID.

### final int? variationId

Variation ID, if applicable.

### final int? quantity

Quantity ordered.

### final String? taxClass

Tax class slug for the product.

### final double? subtotal

Line subtotal before discounts.

### final double? subtotalTax

Line subtotal tax before discounts.

### final double? total

Line total after discounts.

### final double? totalTax

Line total tax after discounts.

### final List<WooTax>? taxes

Tax details for the line item.

### final List<WooMetaData>? metaData

Custom metadata for the line item.

### final String? sku

Product SKU.

### final double? price

Product unit price.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooLineItem copyWith({ int? id, String? name, int? productId, int? variationId, int? quantity, String? taxClass, double? subtotal, double? subtotalTax, double? total, double? totalTax, List<WooTax>? taxes, List<WooMetaData>? metaData, String? sku, double? price, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooLineItem instance.

Displays all main fields for debugging and logging purposes.

## order

### class WooOrder

WooCommerce Order Model

Represents a complete WooCommerce order with all its details, line items,
customer information, and financial data. This is the core model for managing
orders in your WooCommerce store, supporting all order types and statuses.

## Order Structure

A WooCommerce order consists of several key components:

- **Order Information**: ID, number, key, status, and currency
- **Customer Data**: Customer ID, IP address, and user agent
- **Addresses**: Billing and shipping address information
- **Financial Data**: Totals, taxes, discounts, and payment information
- **Line Items**: Products, quantities, and prices in the order
- **Timestamps**: Creation, modification, payment, and completion dates
- **Metadata**: Custom order metadata and administrative notes

## Order Lifecycle

Orders progress through different statuses during their lifecycle:

1. **Pending**: Order is created but payment is pending
2. **Processing**: Payment is confirmed, order is being prepared
3. **On Hold**: Order is temporarily paused (e.g., awaiting payment)
4. **Completed**: Order is fulfilled and delivered
5. **Cancelled**: Order is cancelled before completion
6. **Refunded**: Order is refunded to the customer

## Key Features

- **Order Information**: ID, number, key, status, currency
- **Customer Data**: Customer ID, IP address, user agent
- **Addresses**: Billing and shipping address information
- **Financial**: Totals, taxes, discounts, payment information
- **Line Items**: Products, quantities, prices in the order
- **Timestamps**: Creation, modification, payment, completion dates
- **Metadata**: Custom order metadata and notes

## Usage Examples

### Creating a New Order

```dart
final order = WooOrder(
  id: 0, // Will be assigned by WooCommerce
  status: WooOrderStatus.pending,
  customerId: 123,
  billing: WooBilling(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
  ),
);
```

### Working with Order Data

```dart
// Check order status
if (order.status == WooOrderStatus.completed) {
  print('Order is completed');
}

// Get order total
print('Order total: \$${order.total}');

// Access line items
for (final item in order.lineItems ?? []) {
  print('Item: ${item.name}, Qty: ${item.quantity}');
}

// Access billing information
if (order.billing != null) {
  print('Customer: ${order.billing!.firstName} ${order.billing!.lastName}');
  print('Email: ${order.billing!.email}');
}
```

### Order Status Management

```dart
// Update order status
order.status = WooOrderStatus.processing;
await wooCommerce.updateOrder(order);

// Check if order is paid
if (order.datePaid != null) {
  print('Order was paid on: ${order.datePaid}');
}

// Check if order is completed
if (order.dateCompleted != null) {
  print('Order was completed on: ${order.dateCompleted}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = order.toJson();

// Create from JSON response
final order = WooOrder.fromJson(jsonData);
```

### WooOrder({ this.id, this.parentId, this.number, this.orderKey, this.createdVia, this.version, this.status, this.currency, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, this.discountTotal, this.discountTax, this.shippingTotal, this.shippingTax, this.cartTax, this.total, this.totalTax, this.pricesIncludeTax, this.customerId, this.customerIpAddress, this.customerUserAgent, this.customerNote, this.billing, this.shipping, this.paymentMethod, this.paymentMethodTitle, this.transactionId, this.datePaid, this.datePaidGmt, this.dateCompleted, this.dateCompletedGmt, this.cartHash, this.metaData, this.lineItems, this.taxLines, this.shippingLines, this.feeLines, this.couponLines, this.refunds, this.setPaid = false, })

WooCommerce Order Model

Represents a complete WooCommerce order with all its details, line items,
customer information, and financial data. This is the core model for managing
orders in your WooCommerce store, supporting all order types and statuses.

## Order Structure

A WooCommerce order consists of several key components:

- **Order Information**: ID, number, key, status, and currency
- **Customer Data**: Customer ID, IP address, and user agent
- **Addresses**: Billing and shipping address information
- **Financial Data**: Totals, taxes, discounts, and payment information
- **Line Items**: Products, quantities, and prices in the order
- **Timestamps**: Creation, modification, payment, and completion dates
- **Metadata**: Custom order metadata and administrative notes

## Order Lifecycle

Orders progress through different statuses during their lifecycle:

1. **Pending**: Order is created but payment is pending
2. **Processing**: Payment is confirmed, order is being prepared
3. **On Hold**: Order is temporarily paused (e.g., awaiting payment)
4. **Completed**: Order is fulfilled and delivered
5. **Cancelled**: Order is cancelled before completion
6. **Refunded**: Order is refunded to the customer

## Key Features

- **Order Information**: ID, number, key, status, currency
- **Customer Data**: Customer ID, IP address, user agent
- **Addresses**: Billing and shipping address information
- **Financial**: Totals, taxes, discounts, payment information
- **Line Items**: Products, quantities, prices in the order
- **Timestamps**: Creation, modification, payment, completion dates
- **Metadata**: Custom order metadata and notes

## Usage Examples

### Creating a New Order

```dart
final order = WooOrder(
  id: 0, // Will be assigned by WooCommerce
  status: WooOrderStatus.pending,
  customerId: 123,
  billing: WooBilling(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
  ),
);
```

### Working with Order Data

```dart
// Check order status
if (order.status == WooOrderStatus.completed) {
  print('Order is completed');
}

// Get order total
print('Order total: \$${order.total}');

// Access line items
for (final item in order.lineItems ?? []) {
  print('Item: ${item.name}, Qty: ${item.quantity}');
}

// Access billing information
if (order.billing != null) {
  print('Customer: ${order.billing!.firstName} ${order.billing!.lastName}');
  print('Email: ${order.billing!.email}');
}
```

### Order Status Management

```dart
// Update order status
order.status = WooOrderStatus.processing;
await wooCommerce.updateOrder(order);

// Check if order is paid
if (order.datePaid != null) {
  print('Order was paid on: ${order.datePaid}');
}

// Check if order is completed
if (order.dateCompleted != null) {
  print('Order was completed on: ${order.dateCompleted}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = order.toJson();

// Create from JSON response
final order = WooOrder.fromJson(jsonData);
```

### factory WooOrder.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooOrder.fake()

Creates a fake WooOrder instance for testing purposes

This factory constructor generates an order with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated order will have valid data for all fields.

## Generated Data

The fake order includes:
- Random order ID and number
- Random status from available statuses
- Random currency from available currencies
- Random customer information
- Random billing and shipping addresses
- Random line items with products
- Random financial totals
- Random timestamps

## Returns

A `WooOrder` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake order for testing
final fakeOrder = WooOrder.fake();
print('Fake order: ${fakeOrder.number}');
print('Status: ${fakeOrder.status}');
print('Total: ${fakeOrder.total}');

// Use in tests
test('order creation', () {
  final order = WooOrder.fake();
  expect(order.id, isNotNull);
  expect(order.status, isNotNull);
  expect(order.total, isNotNull);
});
```

### final int? id

Unique identifier for the order

This ID is automatically assigned by WooCommerce when the order is created.
It's used to identify the order in API calls and is required for updates.

### final int? parentId

Parent order ID

For child orders (like refunds or partial orders), this references
the parent order. For main orders, this is typically null.

### final String? number

Order number

A human-readable order number displayed to customers.
This is different from the order ID and is often formatted as a sequence.

### final String? orderKey

Order key

A unique key used for order identification in URLs and API calls.
This key is used for guest order lookups and order tracking.

### final String? createdVia

Source where the order was created

Indicates how the order was created (e.g., 'rest-api', 'checkout', 'admin').
Useful for tracking order origins and analytics.

### final String? version

WooCommerce version that last updated the order

Tracks which version of WooCommerce last modified the order.
Useful for compatibility and debugging purposes.

### final WooOrderStatus? status

Order status

Current status of the order in the fulfillment process:
- `WooOrderStatus.pending`: Payment is pending
- `WooOrderStatus.processing`: Payment confirmed, being prepared
- `WooOrderStatus.onHold`: Temporarily paused
- `WooOrderStatus.completed`: Order fulfilled and delivered
- `WooOrderStatus.cancelled`: Order cancelled
- `WooOrderStatus.refunded`: Order refunded
- `WooOrderStatus.failed`: Payment failed
- `WooOrderStatus.trash`: Order deleted

### final String? currency

Currency used for the order

The currency in which the order was placed. Supports all major
currencies including USD, EUR, GBP, and many others.
Default is USD if not specified.

### final DateTime? dateCreated

Date and time when the order was created (local time)

This timestamp reflects when the order was first created in the store's local timezone.

### final DateTime? dateCreatedGmt

Date and time when the order was created (GMT)

This timestamp reflects when the order was first created in GMT/UTC timezone.

### final DateTime? dateModified

Date and time when the order was last modified (local time)

This timestamp reflects when the order was last updated in the store's local timezone.

### final DateTime? dateModifiedGmt

Date and time when the order was last modified (GMT)

This timestamp reflects when the order was last updated in GMT/UTC timezone.

### final double? discountTotal

Total discount amount for the order

The total amount of discounts applied to the order, including
coupon discounts and other promotional reductions.

### final double? discountTax

Total discount tax amount for the order

The tax amount associated with the discounts applied to the order.
This is relevant when taxes are calculated on discounted amounts.

### final double? shippingTotal

Total shipping amount for the order

The total cost of shipping for the order, including all shipping
methods and any shipping-related fees.

### final double? shippingTax

Total shipping tax amount for the order

The tax amount applied to shipping costs, if shipping is taxable
in the customer's location.

### final double? cartTax

Sum of line item taxes only

The total tax amount calculated on product line items,
excluding shipping taxes and other fees.

### final double? total

Grand total of the order

The final amount the customer pays, including all products,
taxes, shipping, and fees, minus any discounts.

### final double? totalTax

Sum of all taxes applied to the order

The total amount of all taxes, including product taxes,
shipping taxes, and any other applicable taxes.

### final bool? pricesIncludeTax

Whether prices included tax during checkout

If true, the displayed prices already include tax.
If false, tax is calculated and added at checkout.

### final int? customerId

User ID who owns the order. 0 for guests. Default is 0.

### final String? customerIpAddress

Customer's IP address.

### final String? customerUserAgent

User agent of the customer.

### final String? customerNote

Note left by customer during checkout.

### final WooBilling? billing

Billing address.

### final WooShipping? shipping

Shipping address.

### final String? paymentMethod

Payment method ID.

### final String? paymentMethodTitle

Payment method title.

### final String? transactionId

Unique transaction ID.

### final DateTime? datePaid

The date the order was paid, in the site's timezone.

### final DateTime? datePaidGmt

The date the order was paid, as GMT.

### final DateTime? dateCompleted

The date the order was completed, in the site's timezone.

### final DateTime? dateCompletedGmt

The date the order was completed, as GMT.

### final String? cartHash

MD5 hash of cart items to ensure orders are not modified.

### final List<WooMetaData>? metaData

Custom order metadata.

### final List<WooLineItem>? lineItems

Line items in the order.

### final List<WooTaxLine>? taxLines

Tax lines for the order.

### final List<WooShippingLine>? shippingLines

Shipping lines for the order.

### final List<WooOrderFeeLine>? feeLines

Fee lines for the order.

### final List<WooOrderCouponLine>? couponLines

Coupon lines for the order.

### final List<WooRefunds>? refunds

List of refunds for the order.

### final bool setPaid

Define if the order is paid. It will set the status to processing and reduce stock items. Default is false.

### Map<String, dynamic> toJson()

Converts the WooOrder instance to JSON format

This method serializes the order data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the order data in JSON format.

## Example Usage

```dart
final jsonData = order.toJson();
```

### WooOrder copyWith({ int? id, int? parentId, String? number, String? orderKey, String? createdVia, String? version, WooOrderStatus? status, String? currency, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, double? discountTotal, double? discountTax, double? shippingTotal, double? shippingTax, double? cartTax, double? total, double? totalTax, bool? pricesIncludeTax, int? customerId, String? customerIpAddress, String? customerUserAgent, String? customerNote, WooBilling? billing, WooShipping? shipping, String? paymentMethod, String? paymentMethodTitle, String? transactionId, DateTime? datePaid, DateTime? datePaidGmt, DateTime? dateCompleted, DateTime? dateCompletedGmt, String? cartHash, List<WooMetaData>? metaData, List<WooLineItem>? lineItems, List<WooTaxLine>? taxLines, List<WooShippingLine>? shippingLines, List<WooOrderFeeLine>? feeLines, List<WooOrderCouponLine>? couponLines, List<WooRefunds>? refunds, bool? setPaid, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrder instance

This method provides a human-readable representation of the order,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the order's main field values in a readable format.

## Example Usage

```dart
final order = WooOrder(
  id: 123,
  number: '12345',
  status: WooOrderStatus.completed,
  total: 99.99,
  customerId: 456,
);
print(order.toString());
// Output: WooOrder(id: 123, number: 12345, status: completed, total: 99.99, customerId: 456)
```

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## order_batch_request

### class WooOrderBatchRequest

WooCommerce Order Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple orders in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple orders in a single request
- **Bulk Updates**: Update multiple existing orders simultaneously
- **Bulk Deletion**: Delete multiple orders at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooOrderBatchRequest(
  create: [
    WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      total: 99.99,
      customerId: 123,
    ),
    WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      total: 149.99,
      customerId: 456,
    ),
  ],
  update: [
    existingOrder..status = WooOrderStatus.processing,
  ],
  delete: [789, 101112],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooOrderBatchRequest(
  create: [order1, order2, order3],
);

// Create a batch request with only updates
final updateOnly = WooOrderBatchRequest(
  update: [updatedOrder1, updatedOrder2],
);

// Create a batch request with only deletes
final deleteOnly = WooOrderBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooOrderBatchRequest.fromJson(jsonData);
```

### WooOrderBatchRequest({ this.create, this.update, this.delete, })

WooCommerce Order Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple orders in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple orders in a single request
- **Bulk Updates**: Update multiple existing orders simultaneously
- **Bulk Deletion**: Delete multiple orders at once
- **Flexible Operations**: Mix create, update, and delete operations in one request

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooOrderBatchRequest(
  create: [
    WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      total: 99.99,
      customerId: 123,
    ),
    WooOrder(
      id: 0,
      status: WooOrderStatus.pending,
      total: 149.99,
      customerId: 456,
    ),
  ],
  update: [
    existingOrder..status = WooOrderStatus.processing,
  ],
  delete: [789, 101112],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooOrderBatchRequest(
  create: [order1, order2, order3],
);

// Create a batch request with only updates
final updateOnly = WooOrderBatchRequest(
  update: [updatedOrder1, updatedOrder2],
);

// Create a batch request with only deletes
final deleteOnly = WooOrderBatchRequest(
  delete: [101, 102, 103],
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = batchRequest.toJson();

// Create from JSON response
final batchRequest = WooOrderBatchRequest.fromJson(jsonData);
```

### factory WooOrderBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooOrderBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooOrderBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooOrderBatchRequest.fromJson(jsonData);
```

### factory WooOrderBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooOrder>? create

List of orders to create

Each order in this list will be created as a new order in the store.
Orders in this list should have id set to 0 (will be assigned by WooCommerce).

### final List<WooOrder>? update

List of orders to update

Each order in this list must have a valid ID and will be updated
with the provided values.

### final List<int>? delete

List of order IDs to delete

Each ID in this list represents an order that will be deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooOrderBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooOrderBatchRequest copyWith({ List<WooOrder>? create, List<WooOrder>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooOrderBatchRequest(
  create: [order1, order2],
  update: [order3],
  delete: [123, 456],
);
print(batchRequest.toString());
// Output: WooOrderBatchRequest(create: 2, update: 1, delete: 2)
```

## order_batch_response

### class WooOrderBatchResponse

WooCommerce Order Batch Response Model

This class represents the response from a batch order operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created orders with server-assigned IDs
- **Update Results**: List of successfully updated orders
- **Delete Results**: List of successfully deleted orders
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateOrders(batchRequest);

// Process created orders
for (final order in response.create ?? []) {
  print('Created order: ${order.number} with ID: ${order.id}');
}

// Process updated orders
for (final order in response.update ?? []) {
  print('Updated order: ${order.number}');
}

// Process deleted orders
for (final order in response.delete ?? []) {
  print('Deleted order: ${order.number}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateOrders(batchRequest);

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
final batchResponse = WooOrderBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooOrderBatchResponse({ this.create, this.update, this.delete, })

WooCommerce Order Batch Response Model

This class represents the response from a batch order operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created orders with server-assigned IDs
- **Update Results**: List of successfully updated orders
- **Delete Results**: List of successfully deleted orders
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateOrders(batchRequest);

// Process created orders
for (final order in response.create ?? []) {
  print('Created order: ${order.number} with ID: ${order.id}');
}

// Process updated orders
for (final order in response.update ?? []) {
  print('Updated order: ${order.number}');
}

// Process deleted orders
for (final order in response.delete ?? []) {
  print('Deleted order: ${order.number}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateOrders(batchRequest);

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
final batchResponse = WooOrderBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooOrderBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooOrderBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooOrderBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooOrderBatchResponse.fromJson(jsonData);
```

### factory WooOrderBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooOrder>? create

List of created orders

Contains the orders that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooOrder>? update

List of updated orders

Contains the orders that were successfully updated, reflecting
the current state after the update operation.

### final List<WooOrder>? delete

List of deleted orders

Contains the orders that were successfully deleted. These orders
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooOrderBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooOrderBatchResponse copyWith({ List<WooOrder>? create, List<WooOrder>? update, List<WooOrder>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooOrderBatchResponse(
  create: [order1, order2],
  update: [order3],
  delete: [order4, order5],
);
print(batchResponse.toString());
// Output: WooOrderBatchResponse(create: 2, update: 1, delete: 2)
```

## order_coupon_line

### class WooOrderCouponLine

Represents a coupon line in a WooCommerce order.

Contains coupon information, discount amounts, and tax details for coupons
applied to an order. Used for discount tracking and order processing.

### WooOrderCouponLine({ this.id, this.code, this.discount, this.discountTax, this.metaData = const [], })

Represents a coupon line in a WooCommerce order.

Contains coupon information, discount amounts, and tax details for coupons
applied to an order. Used for discount tracking and order processing.

### factory WooOrderCouponLine.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooOrderCouponLine.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the coupon line.

### final String? code

Coupon code applied.

### final double? discount

Total discount amount.

### final double? discountTax

Total discount tax amount.

### final List<WooMetaData> metaData

Custom metadata for the coupon line.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooOrderCouponLine copyWith({ int? id, String? code, double? discount, double? discountTax, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderCouponLine instance.

Displays all main fields for debugging and logging purposes.

## order_fee_line

### class WooOrderFeeLine

Represents a fee line in a WooCommerce order.

Contains fee information, amounts, and tax details for additional fees
applied to an order. Used for fee tracking and order processing.

### WooOrderFeeLine({ this.id, this.name, this.taxClass, this.taxStatus, this.totalTax, this.total, this.taxes = const [], this.metaData = const [], })

Represents a fee line in a WooCommerce order.

Contains fee information, amounts, and tax details for additional fees
applied to an order. Used for fee tracking and order processing.

### factory WooOrderFeeLine.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooOrderFeeLine.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the fee line.

### final String? name

Fee name or description.

### final String? taxClass

Tax class for the fee.

### final WooOrderTaxStatus? taxStatus

Tax status of the fee (taxable or none).

### final double? total

Line total after discounts.

### final double? totalTax

Line total tax after discounts.

### final List<WooFeeLineTax> taxes

Tax details for the fee line.

### final List<WooMetaData> metaData

Custom metadata for the fee line.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooOrderFeeLine copyWith({ int? id, String? name, String? taxClass, WooOrderTaxStatus? taxStatus, double? totalTax, double? total, List<WooFeeLineTax>? taxes, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderFeeLine instance.

Displays all main fields for debugging and logging purposes.

## order_note

### class WooOrderNote

Represents an order note in a WooCommerce order.

Contains note information, author details, and visibility settings for notes
added to an order. Used for order communication and tracking.

### WooOrderNote({ required this.note, this.id, this.author, this.dateCreated, this.dateCreatedGmt, this.customerNote = false, this.addedByUser = false, })

Represents an order note in a WooCommerce order.

Contains note information, author details, and visibility settings for notes
added to an order. Used for order communication and tracking.

### factory WooOrderNote.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooOrderNote.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the order note.

### final String? author

Author of the order note.

### final DateTime? dateCreated

Date when the note was created (local time).

### final DateTime? dateCreatedGmt

Date when the note was created (GMT).

### final String? note

Content of the order note.

### final bool? customerNote

Whether the note is visible to customers.

### final bool? addedByUser

Whether the note was added by a user.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooOrderNote copyWith({ String? note, int? id, String? author, DateTime? dateCreated, DateTime? dateCreatedGmt, bool? customerNote, bool? addedByUser, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderNote instance.

Displays all main fields for debugging and logging purposes.

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## order_refund

### class WooOrderRefund

WooCommerce Order Refund Model

Represents a refund for a WooCommerce order, containing all refund details,
line items, and financial information. This model is used to manage order
refunds and track refund history in your WooCommerce store.

## Refund Structure

A WooCommerce order refund consists of several key components:

- **Refund Information**: ID, creation date, amount, and reason
- **Financial Data**: Refund amount, taxes, and payment processing
- **Line Items**: Specific products and quantities being refunded
- **Tax Information**: Tax lines and calculations for the refund
- **Shipping**: Shipping costs and taxes being refunded
- **Fees**: Additional fees and their refund amounts
- **Metadata**: Custom refund metadata and notes

## Refund Process

Refunds can be processed in different ways:

1. **API Refund**: Uses payment gateway API to process refund
2. **Manual Refund**: Manual refund without gateway processing
3. **Partial Refund**: Refund specific line items or amounts
4. **Full Refund**: Complete refund of the entire order

## Key Features

- **Refund Information**: ID, date, amount, reason, and processing details
- **Financial Data**: Refund totals, taxes, and payment processing
- **Line Items**: Products and quantities being refunded
- **Tax Information**: Tax calculations and refund amounts
- **Shipping**: Shipping costs and taxes being refunded
- **Fees**: Additional fees and their refund amounts
- **Metadata**: Custom refund metadata and administrative notes

## Usage Examples

### Creating a New Refund

```dart
final refund = WooOrderRefund(
  amount: '25.00',
  reason: 'Customer requested refund',
  lineItems: [
    WooLineItem(
      id: 1,
      quantity: 1,
      total: 25.00,
    ),
  ],
  apiRefund: true,
  apiRestock: true,
);
```

### Working with Refund Data

```dart
// Check refund amount
print('Refund amount: \$${refund.amount}');

// Check if refund was processed via API
if (refund.apiRefund == true) {
  print('Refund processed via payment gateway');
}

// Access refund line items
for (final item in refund.lineItems ?? []) {
  print('Refunded item: ${item.name}, Qty: ${item.quantity}');
}

// Check refund date
if (refund.dateCreated != null) {
  print('Refund created on: ${refund.dateCreated}');
}
```

### Refund Processing

```dart
// Create a full refund
final fullRefund = WooOrderRefund(
  amount: order.total.toString(),
  reason: 'Full order refund',
  apiRefund: true,
  apiRestock: true,
);

// Create a partial refund
final partialRefund = WooOrderRefund(
  amount: '15.00',
  reason: 'Partial refund for damaged item',
  lineItems: [
    WooLineItem(
      id: 1,
      quantity: 1,
      total: 15.00,
    ),
  ],
  apiRefund: false,
  apiRestock: true,
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = refund.toJson();

// Create from JSON response
final refund = WooOrderRefund.fromJson(jsonData);
```

### WooOrderRefund({ this.id, this.dateCreated, this.dateCreatedGmt, this.amount, this.reason, this.refundedBy, this.refundedPayment, this.metaData, this.lineItems, this.taxLines, this.shippingLines, this.feeLines, this.apiRefund, this.apiRestock, })

WooCommerce Order Refund Model

Represents a refund for a WooCommerce order, containing all refund details,
line items, and financial information. This model is used to manage order
refunds and track refund history in your WooCommerce store.

## Refund Structure

A WooCommerce order refund consists of several key components:

- **Refund Information**: ID, creation date, amount, and reason
- **Financial Data**: Refund amount, taxes, and payment processing
- **Line Items**: Specific products and quantities being refunded
- **Tax Information**: Tax lines and calculations for the refund
- **Shipping**: Shipping costs and taxes being refunded
- **Fees**: Additional fees and their refund amounts
- **Metadata**: Custom refund metadata and notes

## Refund Process

Refunds can be processed in different ways:

1. **API Refund**: Uses payment gateway API to process refund
2. **Manual Refund**: Manual refund without gateway processing
3. **Partial Refund**: Refund specific line items or amounts
4. **Full Refund**: Complete refund of the entire order

## Key Features

- **Refund Information**: ID, date, amount, reason, and processing details
- **Financial Data**: Refund totals, taxes, and payment processing
- **Line Items**: Products and quantities being refunded
- **Tax Information**: Tax calculations and refund amounts
- **Shipping**: Shipping costs and taxes being refunded
- **Fees**: Additional fees and their refund amounts
- **Metadata**: Custom refund metadata and administrative notes

## Usage Examples

### Creating a New Refund

```dart
final refund = WooOrderRefund(
  amount: '25.00',
  reason: 'Customer requested refund',
  lineItems: [
    WooLineItem(
      id: 1,
      quantity: 1,
      total: 25.00,
    ),
  ],
  apiRefund: true,
  apiRestock: true,
);
```

### Working with Refund Data

```dart
// Check refund amount
print('Refund amount: \$${refund.amount}');

// Check if refund was processed via API
if (refund.apiRefund == true) {
  print('Refund processed via payment gateway');
}

// Access refund line items
for (final item in refund.lineItems ?? []) {
  print('Refunded item: ${item.name}, Qty: ${item.quantity}');
}

// Check refund date
if (refund.dateCreated != null) {
  print('Refund created on: ${refund.dateCreated}');
}
```

### Refund Processing

```dart
// Create a full refund
final fullRefund = WooOrderRefund(
  amount: order.total.toString(),
  reason: 'Full order refund',
  apiRefund: true,
  apiRestock: true,
);

// Create a partial refund
final partialRefund = WooOrderRefund(
  amount: '15.00',
  reason: 'Partial refund for damaged item',
  lineItems: [
    WooLineItem(
      id: 1,
      quantity: 1,
      total: 15.00,
    ),
  ],
  apiRefund: false,
  apiRestock: true,
);
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = refund.toJson();

// Create from JSON response
final refund = WooOrderRefund.fromJson(jsonData);
```

### factory WooOrderRefund.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooOrderRefund.fake()

Creates a fake WooOrderRefund instance for testing purposes

This factory constructor generates a refund with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated refund will have valid data for all fields.

## Generated Data

The fake refund includes:
- Random refund ID and amount
- Random reason and refunded by user
- Random timestamps for creation dates
- Random line items, tax lines, and shipping lines
- Random metadata and fee lines
- Random API refund and restock settings

## Returns

A `WooOrderRefund` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake refund for testing
final fakeRefund = WooOrderRefund.fake();
print('Fake refund amount: ${fakeRefund.amount}');
print('Reason: ${fakeRefund.reason}');

// Use in tests
test('refund creation', () {
  final refund = WooOrderRefund.fake();
  expect(refund.id, isNotNull);
  expect(refund.amount, isNotNull);
  expect(refund.reason, isNotNull);
});
```

### final int? id

Unique identifier for the refund

This ID is automatically assigned by WooCommerce when the refund is created.
It's used to identify the refund in API calls and is read-only.

### final DateTime? dateCreated

Date and time when the refund was created (local time)

This timestamp reflects when the refund was created in the store's local timezone.
This field is read-only and set automatically by WooCommerce.

### final DateTime? dateCreatedGmt

Date and time when the refund was created (GMT)

This timestamp reflects when the refund was created in GMT/UTC timezone.
This field is read-only and set automatically by WooCommerce.

### final String? amount

Total refund amount

The amount to be refunded to the customer. This can be a partial or full
refund amount. Must be a valid decimal number as a string.

### final String? reason

Reason for the refund

A description explaining why the refund was issued. This helps track
refund reasons for reporting and customer service purposes.

### final int? refundedBy

User ID of the user who created the refund

The ID of the user (admin, shop manager, etc.) who processed the refund.
This field is read-only and set automatically by WooCommerce.

### final bool? refundedPayment

Whether the payment was refunded via the API

If true, the refund was processed through the payment gateway API.
If false, it was a manual refund. This field is read-only.

### final List<WooMetaData>? metaData

Custom refund metadata

Additional custom data associated with the refund, including
administrative notes and custom fields.

### final List<WooLineItem>? lineItems

Line items being refunded

The specific products and quantities that are being refunded.
Each line item includes the product details and refund amounts.

### final List<WooTaxLine>? taxLines

Tax lines for the refund

Tax calculations and amounts for the refunded items.
This field is read-only and calculated automatically.

### final List<WooShippingLine>? shippingLines

Shipping lines for the refund

Shipping costs and methods being refunded, including
any shipping-related taxes.

### final List<WooOrderFeeLine>? feeLines

Fee lines for the refund

Additional fees and charges being refunded, including
any fee-related taxes.

### final bool? apiRefund

Whether to use payment gateway API for refund

When true, the payment gateway API will be used to process the refund.
When false, it will be a manual refund. This is a write-only field.

### final bool? apiRestock

Whether to restock refunded items

When true, the refunded items will be added back to inventory.
When false, inventory levels will remain unchanged. This is a write-only field.

### Map<String, dynamic> toJson()

Converts the WooOrderRefund instance to JSON format

This method serializes the refund data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the refund data in JSON format.

## Example Usage

```dart
final jsonData = refund.toJson();
```

### WooOrderRefund copyWith({ int? id, DateTime? dateCreated, DateTime? dateCreatedGmt, String? amount, String? reason, int? refundedBy, bool? refundedPayment, List<WooMetaData>? metaData, List<WooLineItem>? lineItems, List<WooTaxLine>? taxLines, List<WooShippingLine>? shippingLines, List<WooOrderFeeLine>? feeLines, bool? apiRefund, bool? apiRestock, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderRefund instance

This method provides a human-readable representation of the refund,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the refund's main field values in a readable format.

## Example Usage

```dart
final refund = WooOrderRefund(
  id: 123,
  amount: '25.00',
  reason: 'Customer requested refund',
);
print(refund.toString());
// Output: WooOrderRefund(id: 123, amount: 25.00, reason: Customer requested refund)
```

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## refund

### class WooRefunds

Represents a refund summary in a WooCommerce order.

Contains basic refund information including ID, reason, and total amount.
Used for displaying refund summaries in order details.

### WooRefunds({this.id, this.reason, this.total})

Represents a refund summary in a WooCommerce order.

Contains basic refund information including ID, reason, and total amount.
Used for displaying refund summaries in order details.

### factory WooRefunds.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooRefunds.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the refund.

### final String? reason

Reason for the refund.

### final double? total

Total refund amount.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooRefunds copyWith({int? id, String? reason, double? total})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooRefunds instance.

Displays all main fields for debugging and logging purposes.

## shipping

### class WooShipping

Represents shipping address information for a WooCommerce order.

Contains customer shipping details including name, address, and company information.
Used for order fulfillment and delivery purposes.

### WooShipping({ this.firstName, this.lastName, this.company, this.address1, this.address2, this.city, this.state, this.postcode, this.country, })

Represents shipping address information for a WooCommerce order.

Contains customer shipping details including name, address, and company information.
Used for order fulfillment and delivery purposes.

### factory WooShipping.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooShipping.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? firstName

Recipient's first name.

### final String? lastName

Recipient's last name.

### final String? company

Company name (optional).

### final String? address1

Primary address line.

### final String? address2

Secondary address line (apartment, suite, etc.).

### final String? city

City name.

### final String? state

State, province, or district code/name.

### final String? postcode

Postal or ZIP code.

### final String? country

Country code in ISO 3166-1 alpha-2 format.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooShipping copyWith({ String? firstName, String? lastName, String? company, String? address1, String? address2, String? city, String? state, String? postcode, String? country, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooShipping instance.

Displays all main fields for debugging and logging purposes.

## shipping_line

### class WooShippingLine

Represents a shipping line in a WooCommerce order.

Contains shipping method information, costs, and tax details for shipping
methods used in an order. Used for shipping cost tracking and order processing.

### WooShippingLine({ this.id, this.methodTitle, this.methodId, this.total, this.totalTax, this.taxes, this.metaData, })

Represents a shipping line in a WooCommerce order.

Contains shipping method information, costs, and tax details for shipping
methods used in an order. Used for shipping cost tracking and order processing.

### factory WooShippingLine.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooShippingLine.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the shipping line.

### final String? methodTitle

Shipping method display name.

### final String? methodId

Shipping method identifier.

### final double? total

Line total after discounts.

### final double? totalTax

Line total tax after discounts.

### final List<WooTax>? taxes

Tax details for the shipping line.

### final List<WooMetaData>? metaData

Custom metadata for the shipping line.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooShippingLine copyWith({ int? id, String? methodTitle, String? methodId, double? total, double? totalTax, List<WooTax>? taxes, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooShippingLine instance.

Displays all main fields for debugging and logging purposes.

## tax

### class WooTax

Represents tax information for a WooCommerce order.

Contains tax rate details, calculations, and amounts for taxes applied
to order items. Used for tax tracking and order processing.

### WooTax({ this.id, this.rateCode, this.rateId, this.label, this.compound, this.taxTotal, this.shippingTaxTotal, this.metaData, })

Represents tax information for a WooCommerce order.

Contains tax rate details, calculations, and amounts for taxes applied
to order items. Used for tax tracking and order processing.

### factory WooTax.fromJson(Map<String, dynamic> json)

Creates a WooTax instance from JSON data.

### factory WooTax.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the tax item.

### final String? rateCode

Tax rate code.

### final String? rateId

Tax rate identifier.

### final String? label

Tax rate display label.

### final bool? compound

Whether this is a compound tax rate.

### final double? taxTotal

Tax total excluding shipping taxes.

### final double? shippingTaxTotal

Shipping tax total.

### final List<WooMetaData>? metaData

Custom metadata for the tax item.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooTax copyWith({ int? id, String? rateCode, String? rateId, String? label, bool? compound, double? taxTotal, double? shippingTaxTotal, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTax instance.

Displays all main fields for debugging and logging purposes.

## tax_line

### class WooTaxLine

Represents a tax line in a WooCommerce order.

Contains tax rate details, calculations, and amounts for taxes applied
to order items. Used for tax tracking and order processing.

### WooTaxLine({ this.id, this.rateCode, this.rateId, this.label, this.compound, this.taxTotal, this.shippingTaxTotal, this.metaData, })

Represents a tax line in a WooCommerce order.

Contains tax rate details, calculations, and amounts for taxes applied
to order items. Used for tax tracking and order processing.

### factory WooTaxLine.fromJson(Map<String, dynamic> json)

Creates a WooTaxLine instance from JSON data.

### factory WooTaxLine.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Unique identifier for the tax line.

### final String? rateCode

Tax rate code.

### final String? rateId

Tax rate identifier.

### final String? label

Tax rate display label.

### final bool? compound

Whether this is a compound tax rate.

### final double? taxTotal

Tax total excluding shipping taxes.

### final double? shippingTaxTotal

Shipping tax total.

### final List<WooMetaData>? metaData

Custom metadata for the tax line.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooTaxLine copyWith({ int? id, String? rateCode, String? rateId, String? label, bool? compound, double? taxTotal, double? shippingTaxTotal, List<WooMetaData>? metaData, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTaxLine instance.

Displays all main fields for debugging and logging purposes.

