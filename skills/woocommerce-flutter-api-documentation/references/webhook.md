# webhook

## webhook_api

### extension WooWebhookApi on WooCommerce

WooCommerce Webhooks API Extension

This extension provides comprehensive webhook management capabilities for WooCommerce stores.
Webhooks allow you to receive real-time notifications when specific events occur in your store,
such as when orders are created, products are updated, or customers are registered.

## Webhook Overview

Webhooks are HTTP callbacks that are triggered by specific events in your WooCommerce store.
They provide a way to integrate with external systems and receive real-time updates about
store activities without constantly polling the API.

## Key Features

- **Event-driven notifications**: Get notified instantly when important events occur
- **Flexible delivery**: Configure custom URLs to receive webhook payloads
- **Security**: Optional secret keys for HMAC-SHA256 signature verification
- **Status management**: Control webhook delivery (active, paused, disabled)
- **Topic-based filtering**: Subscribe to specific resource events

## Webhook Lifecycle

1. **Creation**: Define webhook with topic, delivery URL, and optional secret
2. **Activation**: Set status to 'active' to start receiving notifications
3. **Delivery**: WooCommerce sends HTTP POST requests to your delivery URL
4. **Verification**: Use the secret to verify webhook authenticity
5. **Management**: Update, pause, or delete webhooks as needed

## Supported Topics

- **Coupons**: `coupon.created`, `coupon.updated`, `coupon.deleted`
- **Customers**: `customer.created`, `customer.updated`, `customer.deleted`
- **Orders**: `order.created`, `order.updated`, `order.deleted`
- **Products**: `product.created`, `product.updated`, `product.deleted`

## Example Usage

```dart
// Get all webhooks
final webhooks = await wooCommerce.getWebhooks();

// Create a new webhook for order updates
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: 'order.updated',
  deliveryUrl: 'https://your-app.com/webhooks/orders',
  secret: 'your-secret-key',
);
final createdWebhook = await wooCommerce.createWebhook(webhook);

// Update webhook status
webhook.status = WooWebhookStatus.paused;
await wooCommerce.updateWebhook(webhook);
```

### Future<WooPage<WooWebhook>> getWebhooks({ WooContext context = WooContext.view, int? page, int? perPage, String? search, DateTime? after, DateTime? before, List<int>? exclude, List<int>? include, int? offset, WooSort order = WooSort.desc, WooOrderBy orderBy = WooOrderBy.date, WooWebhookStatus? status, bool? useFaker, }) async

Retrieves a paginated list of webhooks from the WooCommerce store.

This method allows you to fetch webhooks with various filtering and sorting options.
It's particularly useful for managing multiple webhooks or monitoring webhook status.
https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-webhooks

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic webhook information (default)
  - `WooContext.edit`: Returns full webhook details including sensitive data

* [page] - Current page of the collection (default: 1)
* [perPage] - Maximum number of items to return (default: 10, max: 100)
* [search] - Limit results to webhooks matching a search string
* [after] - Limit response to webhooks created after this date
* [before] - Limit response to webhooks created before this date
* [exclude] - Exclude webhooks with specific IDs from results
* [include] - Only include webhooks with specific IDs
* [offset] - Offset the result set by a specific number of items
* [status] - Filter by webhook status: `WooWebhookStatus.active`, `WooWebhookStatus.paused`, `WooWebhookStatus.disabled`
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooWebhook>>` containing the webhook objects.

## Example Usage

```dart
// Get all active webhooks
final activeWebhooks = await wooCommerce.getWebhooks(
  status: WooWebhookStatus.active,
  perPage: 50,
);

// Search for webhooks containing "order"
final orderWebhooks = await wooCommerce.getWebhooks(
  search: 'order',
);

// Get webhooks created in the last 30 days
final recentWebhooks = await wooCommerce.getWebhooks(
  after: DateTime.now().subtract(Duration(days: 30)),
);
```

### Future<WooWebhook> getWebhook(int id, {bool? useFaker}) async

Retrieves a specific webhook by its ID.

This method fetches detailed information about a single webhook, including
its configuration, status, and delivery settings.
https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-webhook

## Parameters

* [id] - The unique identifier of the webhook to retrieve
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooWebhook>` containing the webhook details.

## Throws

* `WooCommerceException` if the webhook is not found or access is denied

## Example Usage

```dart
// Get a specific webhook
final webhook = await wooCommerce.getWebhook(123);
print('Webhook: ${webhook.name}');
print('Status: ${webhook.status}');
print('Topic: ${webhook.topic}');
```

### Future<WooWebhook> createWebhook(WooWebhook webhook, {bool? useFaker}) async

Creates a new webhook in the WooCommerce store.

This method allows you to set up automated notifications for specific events
in your store. The webhook will be created with the specified configuration
and can be activated immediately.
https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-webhook
## Parameters

* [webhook] - The webhook object containing all configuration details
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooWebhook>` containing the created webhook with assigned ID.

## Throws

* `WooCommerceException` if webhook creation fails or validation errors occur

## Example Usage

```dart
// Create a webhook for order updates
final webhook = WooWebhook(
  name: 'Order Updates Webhook',
  topic: 'order.updated',
  deliveryUrl: 'https://your-app.com/webhooks/orders',
  secret: 'your-secret-key',
  status: WooWebhookStatus.active,
);

final createdWebhook = await wooCommerce.createWebhook(webhook);
print('Created webhook with ID: ${createdWebhook.id}');
```

### Future<WooWebhook> updateWebhook

Updates an existing webhook in the WooCommerce store.

This method allows you to modify webhook configuration, including status,
delivery URL, secret, and other settings. The webhook must have a valid ID.
https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-webhook

## Parameters

* [webhook] - The webhook object with updated configuration
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooWebhook>` containing the updated webhook.

## Throws

* `WooCommerceException` if webhook update fails or webhook not found

## Example Usage

```dart
// Update webhook status to paused
webhook.status = WooWebhookStatus.paused;
final updatedWebhook = await wooCommerce.updateWebhook(webhook);

// Update delivery URL
webhook.deliveryUrl = 'https://new-endpoint.com/webhooks';
await wooCommerce.updateWebhook(webhook);
```

### Future<WooDeleteResult> deleteWebhook

Deletes a webhook from the WooCommerce store.

This method permanently removes a webhook and all its associated data.
Use with caution as this action cannot be undone.
https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-webhook

## Parameters

* [id] - The unique identifier of the webhook to delete
* [force] - Whether to force delete the webhook (default: false)
  - `false`: Move to trash (can be restored)
  - `true`: Permanently delete (cannot be restored)
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<bool>` indicating whether the deletion was successful.

## Throws

* `WooCommerceException` if webhook deletion fails or webhook not found

## Example Usage

```dart
// Soft delete (move to trash)
await wooCommerce.deleteWebhook(123);

// Force delete (permanent)
await wooCommerce.deleteWebhook(123, force: true);
```

### Future<WooWebhookBatchResponse> batchUpdateWebhooks

Performs batch operations on webhooks.

This method allows you to create, update, and delete multiple webhooks
in a single API request, making bulk operations more efficient. This is particularly
useful for setting up multiple webhook subscriptions, managing webhook configurations
across different topics, or bulk status updates.
https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-webhooks

## Parameters

* [request] - The `WooWebhookBatchRequest` object containing
  the create, update, and delete operations to perform
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<WooWebhookBatchResponse>` containing the results of
all batch operations, including created, updated, and deleted webhooks.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Create a batch request with multiple operations
final batchRequest = WooWebhookBatchRequest(
  create: [
    WooWebhook(
      name: 'Order Created Webhook',
      topic: 'order.created',
      deliveryUrl: 'https://your-app.com/webhooks/orders',
      secret: 'your-secret-key',
      status: WooWebhookStatus.active,
    ),
    WooWebhook(
      name: 'Product Updated Webhook',
      topic: 'product.updated',
      deliveryUrl: 'https://your-app.com/webhooks/products',
      secret: 'another-secret-key',
      status: WooWebhookStatus.active,
    ),
  ],
  update: [
    WooWebhook(
      id: 123,
      name: 'Updated Order Webhook',
      status: WooWebhookStatus.paused,
    ),
  ],
  delete: [456, 789],
);

// Execute the batch operation
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Process results
print('Created ${response.create?.length ?? 0} webhooks');
print('Updated ${response.update?.length ?? 0} webhooks');
print('Deleted ${response.delete?.length ?? 0} webhooks');

// Access individual results
for (final webhook in response.create ?? []) {
  print('Created webhook: ${webhook.name} with ID: ${webhook.id}');
  print('Topic: ${webhook.topic}');
  print('Delivery URL: ${webhook.deliveryUrl}');
}
```

## Webhook Topics Example

```dart
// Create webhooks for different event topics
final batchRequest = WooWebhookBatchRequest(
  create: [
    WooWebhook(
      name: 'Order Events',
      topic: 'order.created',
      deliveryUrl: 'https://your-app.com/webhooks/orders',
      secret: 'order-secret',
    ),
    WooWebhook(
      name: 'Customer Events',
      topic: 'customer.created',
      deliveryUrl: 'https://your-app.com/webhooks/customers',
      secret: 'customer-secret',
    ),
    WooWebhook(
      name: 'Product Events',
      topic: 'product.updated',
      deliveryUrl: 'https://your-app.com/webhooks/products',
      secret: 'product-secret',
    ),
  ],
);

final response = await wooCommerce.batchUpdateWebhooks(batchRequest);
print('Created ${response.create?.length ?? 0} webhooks for different topics');
```

## Batch Operations Best Practices

- **Create operations**: Webhooks should not have IDs assigned
- **Update operations**: Webhooks must have valid IDs and will be updated with provided values
- **Delete operations**: Provide only the IDs of webhooks to delete
- **Mixed operations**: You can combine create, update, and delete in a single request
- **Webhook topics**: Use valid topic strings (e.g., 'order.created', 'product.updated')
- **Delivery URLs**: Must be valid HTTP or HTTPS URLs that can receive POST requests
- **Secret keys**: Use strong, unique secrets for HMAC-SHA256 signature verification
- **Status management**: Control webhook delivery with status (active, paused, disabled)
- **Error handling**: If any operation fails, the entire batch may fail depending on API behavior

## Webhook Topics

Webhooks support various topics for different resource events:

- **Orders**: `order.created`, `order.updated`, `order.deleted`, `order.restored`
- **Products**: `product.created`, `product.updated`, `product.deleted`, `product.restored`
- **Customers**: `customer.created`, `customer.updated`, `customer.deleted`
- **Coupons**: `coupon.created`, `coupon.updated`, `coupon.deleted`, `coupon.restored`

## Delivery URLs and Secret Keys

- **Delivery URLs**: Must be valid HTTP or HTTPS endpoints that can receive POST requests
- **Secret Keys**: Optional but recommended for security. Used to generate HMAC-SHA256 signatures
- **Signature**: Sent in `X-WC-Webhook-Signature` header for payload verification

Example webhook with secret:

```dart
WooWebhook(
  name: 'Secure Order Webhook',
  topic: 'order.created',
  deliveryUrl: 'https://your-app.com/webhooks/orders',
  secret: 'your-strong-secret-key-here',
  status: WooWebhookStatus.active,
)
```

### Future<WooPage<WooWebhookDelivery>> getWebhookDeliveries

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooDeleteResult> deleteWebhookDelivery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## webhook_query

### class WooWebhookQuery extends WooQuery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooWebhookQuery({ super.page, super.perPage, super.order, super.orderBy, super.search, super.offset, this.context = WooContext.view, this.after, this.before, this.exclude, this.include, this.status, })

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

### final WooWebhookStatus? status

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toMap()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## webhook_status

### enum WooWebhookStatus implements WooEnum

WooCommerce Webhook Status Enumeration

Defines the possible states for a webhook in WooCommerce. The status determines
whether a webhook is actively delivering payloads, temporarily paused, or disabled
due to failures or administrative action.

## Webhook Status Lifecycle

Webhooks can transition between different statuses based on various conditions:

1. **Active**: Webhook is functioning normally and delivering payloads
2. **Paused**: Webhook is temporarily disabled by admin action
3. **Disabled**: Webhook is automatically disabled due to delivery failures

## Status Descriptions

### Active Status
- Webhook is actively monitoring for events
- Payloads are delivered to the configured URL
- All webhook functionality is operational
- This is the default status for new webhooks

### Paused Status
- Webhook is temporarily disabled by administrator
- No payloads are delivered while paused
- Can be reactivated by changing status back to active
- Useful for maintenance or temporary disabling

### Disabled Status
- Webhook is automatically disabled due to delivery failures
- Occurs when delivery attempts fail repeatedly
- Requires manual intervention to reactivate
- Indicates potential issues with delivery URL or network

## Usage Examples

```dart
// Create webhook with active status
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: WooWebhookTopic.orderUpdated,
  deliveryUrl: 'https://example.com/webhook',
  status: WooWebhookStatus.active,
);

// Pause webhook temporarily
webhook.status = WooWebhookStatus.paused;
await wooCommerce.updateWebhook(webhook);

// Check webhook status
if (webhook.status == WooWebhookStatus.active) {
  print('Webhook is delivering payloads');
} else if (webhook.status == WooWebhookStatus.paused) {
  print('Webhook is paused by admin');
} else if (webhook.status == WooWebhookStatus.disabled) {
  print('Webhook is disabled due to failures');
}

// Filter webhooks by status
final activeWebhooks = await wooCommerce.getWebhooks(
  status: WooWebhookStatus.active,
);
```

## Status Transitions

| From Status | To Status | Trigger | Description |
|-------------|-----------|---------|-------------|
| - | Active | Webhook creation | Default status for new webhooks |
| Active | Paused | Admin action | Manually paused by administrator |
| Paused | Active | Admin action | Manually reactivated by administrator |
| Active | Disabled | Delivery failures | Automatically disabled after repeated failures |
| Disabled | Active | Admin action | Manually reactivated after fixing issues |

## Best Practices

- **Monitor Status**: Regularly check webhook status to ensure delivery
- **Handle Failures**: Implement retry logic for disabled webhooks
- **Use Paused Status**: Pause webhooks during maintenance instead of deleting
- **Log Status Changes**: Track status transitions for debugging

## Related Documentation

- [WooWebhook] - Webhook model with status property
- [WooWebhookApi] - API methods for managing webhook status
- [WooWebhookTopic] - Webhook topics that trigger delivery

### active('active'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### paused('paused'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### disabled('disabled'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooWebhookStatus(this.value)

WooCommerce Webhook Status Enumeration

Defines the possible states for a webhook in WooCommerce. The status determines
whether a webhook is actively delivering payloads, temporarily paused, or disabled
due to failures or administrative action.

## Webhook Status Lifecycle

Webhooks can transition between different statuses based on various conditions:

1. **Active**: Webhook is functioning normally and delivering payloads
2. **Paused**: Webhook is temporarily disabled by admin action
3. **Disabled**: Webhook is automatically disabled due to delivery failures

## Status Descriptions

### Active Status
- Webhook is actively monitoring for events
- Payloads are delivered to the configured URL
- All webhook functionality is operational
- This is the default status for new webhooks

### Paused Status
- Webhook is temporarily disabled by administrator
- No payloads are delivered while paused
- Can be reactivated by changing status back to active
- Useful for maintenance or temporary disabling

### Disabled Status
- Webhook is automatically disabled due to delivery failures
- Occurs when delivery attempts fail repeatedly
- Requires manual intervention to reactivate
- Indicates potential issues with delivery URL or network

## Usage Examples

```dart
// Create webhook with active status
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: WooWebhookTopic.orderUpdated,
  deliveryUrl: 'https://example.com/webhook',
  status: WooWebhookStatus.active,
);

// Pause webhook temporarily
webhook.status = WooWebhookStatus.paused;
await wooCommerce.updateWebhook(webhook);

// Check webhook status
if (webhook.status == WooWebhookStatus.active) {
  print('Webhook is delivering payloads');
} else if (webhook.status == WooWebhookStatus.paused) {
  print('Webhook is paused by admin');
} else if (webhook.status == WooWebhookStatus.disabled) {
  print('Webhook is disabled due to failures');
}

// Filter webhooks by status
final activeWebhooks = await wooCommerce.getWebhooks(
  status: WooWebhookStatus.active,
);
```

## Status Transitions

| From Status | To Status | Trigger | Description |
|-------------|-----------|---------|-------------|
| - | Active | Webhook creation | Default status for new webhooks |
| Active | Paused | Admin action | Manually paused by administrator |
| Paused | Active | Admin action | Manually reactivated by administrator |
| Active | Disabled | Delivery failures | Automatically disabled after repeated failures |
| Disabled | Active | Admin action | Manually reactivated after fixing issues |

## Best Practices

- **Monitor Status**: Regularly check webhook status to ensure delivery
- **Handle Failures**: Implement retry logic for disabled webhooks
- **Use Paused Status**: Pause webhooks during maintenance instead of deleting
- **Log Status Changes**: Track status transitions for debugging

## Related Documentation

- [WooWebhook] - Webhook model with status property
- [WooWebhookApi] - API methods for managing webhook status
- [WooWebhookTopic] - Webhook topics that trigger delivery

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooWebhookStatus fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## webhook_topic

### abstract final class WooWebhookTopic

WooCommerce Webhook Topics

This class provides predefined webhook topic constants for WooCommerce webhooks.
Webhook topics determine which events will trigger webhook delivery.
https://woocommerce.github.io/woocommerce-rest-api-docs/#topics

## How Webhook Topics Work

Webhook topics are strings that combine a resource (e.g., 'order', 'product')
with an event (e.g., 'created', 'updated', 'deleted'). When these events occur
in your WooCommerce store, webhooks subscribed to the corresponding topic will
be triggered and their payloads delivered to the configured URL.

## Core WooCommerce Topics

The following topics are supported by default in WooCommerce:

### Coupon Events
- `coupon.created` - Triggered when a new coupon is created
- `coupon.updated` - Triggered when an existing coupon is modified
- `coupon.deleted` - Triggered when a coupon is deleted

### Customer Events
- `customer.created` - Triggered when a new customer registers
- `customer.updated` - Triggered when customer information is updated
- `customer.deleted` - Triggered when a customer account is deleted

### Order Events
- `order.created` - Triggered when a new order is placed
- `order.updated` - Triggered when order status or details change
- `order.deleted` - Triggered when an order is deleted

### Product Events
- `product.created` - Triggered when a new product is added
- `product.updated` - Triggered when product information is modified
- `product.deleted` - Triggered when a product is removed

## Custom Topics

You can also create custom topics that map to specific WordPress hooks.
Custom topics should follow the format: `action.hook_name`

Example: `action.woocommerce_add_to_cart`

## Usage Examples

```dart
// Create a webhook for order updates
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: WooWebhookTopic.orderUpdated,
  deliveryUrl: 'https://your-app.com/webhooks/orders',
);

// Create a webhook for new products
final productWebhook = WooWebhook(
  name: 'New Products',
  topic: WooWebhookTopic.productCreated,
  deliveryUrl: 'https://your-app.com/webhooks/products',
);

// Get a random topic for testing
final randomTopic = WooWebhookTopic.randomTopic();
```

## Webhook Delivery Headers

When a webhook is delivered, WooCommerce includes several headers to help
you process the webhook:

- `X-WC-Webhook-Source`: The store URL
- `X-WC-Webhook-Topic`: The topic that triggered the webhook
- `X-WC-Webhook-Resource`: The resource type (e.g., 'order', 'product')
- `X-WC-Webhook-Event`: The event type (e.g., 'created', 'updated')
- `X-WC-Webhook-Signature`: HMAC-SHA256 signature for verification
- `X-WC-Webhook-ID`: The webhook's ID
- `X-WC-Webhook-Delivery-ID`: The delivery log ID

### static String randomTopic()

Generates a random webhook topic for testing purposes.

This method returns a randomly selected topic from all available
webhook topics. It's primarily used for generating fake data
during testing and development.

## Returns

A `String` containing a randomly selected webhook topic.

## Example Usage

```dart
// Generate a random topic for testing
final randomTopic = WooWebhookTopic.randomTopic();
print('Random topic: $randomTopic');

// Use in fake webhook generation
final fakeWebhook = WooWebhook(
  name: 'Test Webhook',
  topic: WooWebhookTopic.randomTopic(),
  deliveryUrl: 'https://test.com/webhook',
);
```

## webhook

### class WooWebhook

WooCommerce Webhook Model

Represents a webhook configuration in WooCommerce. Webhooks are HTTP callbacks
that are triggered by specific events in your store, allowing you to receive
real-time notifications about store activities.

## Webhook Structure

A webhook consists of several key components:

- **Identification**: Unique ID and human-readable name
- **Event Subscription**: Topic that determines which events trigger the webhook
- **Delivery Configuration**: URL where payloads are sent and optional secret for verification
- **Status Management**: Control whether the webhook is active, paused, or disabled
- **Timestamps**: Creation and modification tracking

## Webhook Lifecycle

1. **Creation**: Webhook is created with topic and delivery URL
2. **Activation**: Status is set to 'active' to start receiving events
3. **Delivery**: WooCommerce sends HTTP POST requests to the delivery URL
4. **Verification**: Optional HMAC-SHA256 signature verification using the secret
5. **Management**: Update, pause, or delete as needed

## Security Features

- **Secret Key**: Optional HMAC-SHA256 signature for payload verification
- **HTTPS Support**: Delivery URLs must use HTTP or HTTPS
- **Status Control**: Pause or disable webhooks without deletion

## Example Usage

```dart
// Create a new webhook
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: 'order.updated',
  deliveryUrl: 'https://your-app.com/webhooks/orders',
  secret: 'your-secret-key',
  status: WooWebhookStatus.active,
);

// Create webhook via API
final createdWebhook = await wooCommerce.createWebhook(webhook);

// Update webhook status
webhook.status = WooWebhookStatus.paused;
await wooCommerce.updateWebhook(webhook);

// Generate fake webhook for testing
final fakeWebhook = WooWebhook.fake();
```

## Webhook Delivery Headers

When a webhook is delivered, WooCommerce includes these headers:

- `X-WC-Webhook-Source`: Store URL
- `X-WC-Webhook-Topic`: The topic that triggered the webhook
- `X-WC-Webhook-Resource`: Resource type (e.g., 'order', 'product')
- `X-WC-Webhook-Event`: Event type (e.g., 'created', 'updated')
- `X-WC-Webhook-Signature`: HMAC-SHA256 signature (if secret is set)
- `X-WC-Webhook-ID`: Webhook's ID
- `X-WC-Webhook-Delivery-ID`: Delivery log ID

### WooWebhook({ required this.name, required this.topic, required this.deliveryUrl, this.id, this.status = WooWebhookStatus.active, this.resource, this.event, this.hooks, this.secret, this.dateCreated, this.dateCreatedGmt, this.dateModified, this.dateModifiedGmt, })

WooCommerce Webhook Model

Represents a webhook configuration in WooCommerce. Webhooks are HTTP callbacks
that are triggered by specific events in your store, allowing you to receive
real-time notifications about store activities.

## Webhook Structure

A webhook consists of several key components:

- **Identification**: Unique ID and human-readable name
- **Event Subscription**: Topic that determines which events trigger the webhook
- **Delivery Configuration**: URL where payloads are sent and optional secret for verification
- **Status Management**: Control whether the webhook is active, paused, or disabled
- **Timestamps**: Creation and modification tracking

## Webhook Lifecycle

1. **Creation**: Webhook is created with topic and delivery URL
2. **Activation**: Status is set to 'active' to start receiving events
3. **Delivery**: WooCommerce sends HTTP POST requests to the delivery URL
4. **Verification**: Optional HMAC-SHA256 signature verification using the secret
5. **Management**: Update, pause, or delete as needed

## Security Features

- **Secret Key**: Optional HMAC-SHA256 signature for payload verification
- **HTTPS Support**: Delivery URLs must use HTTP or HTTPS
- **Status Control**: Pause or disable webhooks without deletion

## Example Usage

```dart
// Create a new webhook
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: 'order.updated',
  deliveryUrl: 'https://your-app.com/webhooks/orders',
  secret: 'your-secret-key',
  status: WooWebhookStatus.active,
);

// Create webhook via API
final createdWebhook = await wooCommerce.createWebhook(webhook);

// Update webhook status
webhook.status = WooWebhookStatus.paused;
await wooCommerce.updateWebhook(webhook);

// Generate fake webhook for testing
final fakeWebhook = WooWebhook.fake();
```

## Webhook Delivery Headers

When a webhook is delivered, WooCommerce includes these headers:

- `X-WC-Webhook-Source`: Store URL
- `X-WC-Webhook-Topic`: The topic that triggered the webhook
- `X-WC-Webhook-Resource`: Resource type (e.g., 'order', 'product')
- `X-WC-Webhook-Event`: Event type (e.g., 'created', 'updated')
- `X-WC-Webhook-Signature`: HMAC-SHA256 signature (if secret is set)
- `X-WC-Webhook-ID`: Webhook's ID
- `X-WC-Webhook-Delivery-ID`: Delivery log ID

### factory WooWebhook.fromJson(Map<String, dynamic> json)

Creates a WooWebhook instance from JSON data

This factory constructor is used to deserialize webhook data received
from the WooCommerce REST API. It handles the conversion of JSON fields
to the appropriate Dart types and provides fallback values where needed.

## Parameters

* [json] - A Map containing the webhook data in JSON format

## Returns

A `WooWebhook` instance populated with data from the JSON.

## JSON Structure

The expected JSON structure includes:
```json
{
  "id": 123,
  "name": "Order Updates",
  "status": "active",
  "topic": "order.updated",
  "resource": "order",
  "event": "updated",
  "hooks": ["woocommerce_order_status_changed"],
  "delivery_url": "https://example.com/webhook",
  "secret": "secret-key",
  "date_created": "2023-01-01T00:00:00",
  "date_created_gmt": "2023-01-01T00:00:00",
  "date_modified": "2023-01-01T00:00:00",
  "date_modified_gmt": "2023-01-01T00:00:00"
}
```

## Example Usage

```dart
// Parse webhook from API response
final jsonData = {
  'id': 123,
  'name': 'Order Updates',
  'status': 'active',
  'topic': 'order.updated',
  'delivery_url': 'https://example.com/webhook',
};

final webhook = WooWebhook.fromJson(jsonData);
print('Webhook: ${webhook.name}');
```

### factory WooWebhook.fake()

Creates a fake WooWebhook instance for testing purposes

This factory constructor generates a webhook with random but realistic
data, making it useful for testing, development, and demonstration purposes.
The generated webhook will have valid data for all fields.

## Generated Data

The fake webhook includes:
- Random name from sentence generator
- Random status from available statuses
- Random topic from available topics
- Random delivery URL
- Random secret key

## Returns

A `WooWebhook` instance with randomly generated fake data.

## Example Usage

```dart
// Generate a fake webhook for testing
final fakeWebhook = WooWebhook.fake();
print('Fake webhook: ${fakeWebhook.name}');
print('Topic: ${fakeWebhook.topic}');

// Use in tests
test('webhook creation', () {
  final webhook = WooWebhook.fake();
  expect(webhook.name, isNotNull);
  expect(webhook.topic, isNotNull);
  expect(webhook.deliveryUrl, isNotNull);
});
```

### final int? id

Unique identifier for the webhook

This ID is automatically assigned by WooCommerce when the webhook is created.
It's used to identify the webhook in API calls and is included in delivery headers.

### final String? name

Human-readable name for the webhook

This name helps you identify the webhook in the WooCommerce admin panel
and in your application. It should be descriptive of the webhook's purpose.

### final WooWebhookStatus? status

Current status of the webhook

Controls whether the webhook is active and delivering payloads:
- `WooWebhookStatus.active`: Webhook is active and delivering payloads
- `WooWebhookStatus.paused`: Webhook is paused by admin (no delivery)
- `WooWebhookStatus.disabled`: Webhook is disabled due to delivery failures

### final String? topic

The event topic that triggers this webhook

Determines which events will trigger webhook delivery. Common topics include:
- `order.created`, `order.updated`, `order.deleted`
- `product.created`, `product.updated`, `product.deleted`
- `customer.created`, `customer.updated`, `customer.deleted`
- `coupon.created`, `coupon.updated`, `coupon.deleted`

You can use [WooWebhookTopic] to get the available topics.

### final String? resource

The resource type for this webhook

Automatically derived from the topic (e.g., 'order', 'product', 'customer').
This is included in the delivery headers to help identify the resource type.

### final String? event

The event type for this webhook

Automatically derived from the topic (e.g., 'created', 'updated', 'deleted').
This is included in the delivery headers to help identify the event type.

### final List<String>? hooks

Array of WordPress hook names bound to this webhook

These are the actual WordPress hooks that trigger the webhook delivery.
They are automatically determined based on the topic when the webhook is created.

### final String? deliveryUrl

URL where webhook payloads are delivered

This must be a valid HTTP or HTTPS URL that can receive POST requests.
The endpoint should be able to handle JSON payloads and verify signatures.

### final String? secret

Optional secret key for HMAC-SHA256 signature verification

If provided, WooCommerce will generate a signature using this secret
and include it in the `X-WC-Webhook-Signature` header. This allows
you to verify that the webhook payload is authentic and hasn't been tampered with.

### final DateTime? dateCreated

Date and time when the webhook was created (local time)

This timestamp reflects when the webhook was first created in the store's local timezone.

### final DateTime? dateCreatedGmt

Date and time when the webhook was created (GMT)

This timestamp reflects when the webhook was first created in GMT/UTC timezone.

### final DateTime? dateModified

Date and time when the webhook was last modified (local time)

This timestamp reflects when the webhook was last updated in the store's local timezone.

### final DateTime? dateModifiedGmt

Date and time when the webhook was last modified (GMT)

This timestamp reflects when the webhook was last updated in GMT/UTC timezone.

### Map<String, dynamic> toJson()

Converts the WooWebhook instance to JSON format

This method serializes the webhook data into a Map that can be sent
to the WooCommerce REST API. It handles the conversion of Dart types
to JSON-compatible formats and includes all necessary fields.

## Returns

A `Map<String, dynamic>` containing the webhook data in JSON format.

## JSON Structure

The returned JSON structure includes:
```json
{
  "id": 123,
  "name": "Order Updates",
  "status": "active",
  "topic": "order.updated",
  "resource": "order",
  "event": "updated",
  "hooks": ["woocommerce_order_status_changed"],
  "delivery_url": "https://example.com/webhook",
  "secret": "secret-key",
  "date_created": "2023-01-01T00:00:00",
  "date_created_gmt": "2023-01-01T00:00:00",
  "date_modified": "2023-01-01T00:00:00",
  "date_modified_gmt": "2023-01-01T00:00:00"
}
```

## Example Usage

```dart
// Convert webhook to JSON for API calls
final webhook = WooWebhook(
  name: 'Order Updates',
  topic: 'order.updated',
  deliveryUrl: 'https://example.com/webhook',
);

final jsonData = webhook.toJson();
print('JSON: $jsonData');

// Send to API
await dio.post('/webhooks', data: webhook.toJson());
```

### WooWebhook copyWith({ int? id, String? name, WooWebhookStatus? status, String? topic, String? resource, String? event, List<String>? hooks, String? deliveryUrl, String? secret, DateTime? dateCreated, DateTime? dateCreatedGmt, DateTime? dateModified, DateTime? dateModifiedGmt, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## webhook_batch_request

### class WooWebhookBatchRequest

WooCommerce Webhook Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple webhooks in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple webhooks in a single request
- **Bulk Updates**: Update multiple existing webhooks simultaneously
- **Bulk Deletion**: Delete multiple webhooks at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Webhook Configuration**: Manage topics, delivery URLs, and secret keys in bulk

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooWebhookBatchRequest(
  create: [
    WooWebhook(
      name: 'Order Created Webhook',
      topic: 'order.created',
      deliveryUrl: 'https://your-app.com/webhooks/orders',
      secret: 'your-secret-key',
      status: WooWebhookStatus.active,
    ),
    WooWebhook(
      name: 'Product Updated Webhook',
      topic: 'product.updated',
      deliveryUrl: 'https://your-app.com/webhooks/products',
      secret: 'another-secret-key',
      status: WooWebhookStatus.active,
    ),
  ],
  update: [
    WooWebhook(
      id: 123,
      name: 'Updated Order Webhook',
      status: WooWebhookStatus.paused,
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooWebhookBatchRequest(
  create: [webhook1, webhook2, webhook3],
);

// Create a batch request with only updates
final updateOnly = WooWebhookBatchRequest(
  update: [updatedWebhook1, updatedWebhook2],
);

// Create a batch request with only deletes
final deleteOnly = WooWebhookBatchRequest(
  delete: [101, 102, 103],
);
```

### Managing Webhook Topics

```dart
// Create webhooks for different topics
final batchRequest = WooWebhookBatchRequest(
  create: [
    WooWebhook(
      name: 'Order Events',
      topic: 'order.created',
      deliveryUrl: 'https://your-app.com/webhooks/orders',
    ),
    WooWebhook(
      name: 'Customer Events',
      topic: 'customer.created',
      deliveryUrl: 'https://your-app.com/webhooks/customers',
    ),
    WooWebhook(
      name: 'Product Events',
      topic: 'product.updated',
      deliveryUrl: 'https://your-app.com/webhooks/products',
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
final batchRequest = WooWebhookBatchRequest.fromJson(jsonData);
```

### WooWebhookBatchRequest({this.create, this.update, this.delete})

WooCommerce Webhook Batch Request Model

This class represents a batch request for creating, updating, and deleting
multiple webhooks in a single API call. It allows you to perform bulk operations
efficiently without making multiple individual requests.

## Key Features

- **Bulk Creation**: Create multiple webhooks in a single request
- **Bulk Updates**: Update multiple existing webhooks simultaneously
- **Bulk Deletion**: Delete multiple webhooks at once
- **Flexible Operations**: Mix create, update, and delete operations in one request
- **Webhook Configuration**: Manage topics, delivery URLs, and secret keys in bulk

## Usage Examples

### Creating a Batch Request

```dart
final batchRequest = WooWebhookBatchRequest(
  create: [
    WooWebhook(
      name: 'Order Created Webhook',
      topic: 'order.created',
      deliveryUrl: 'https://your-app.com/webhooks/orders',
      secret: 'your-secret-key',
      status: WooWebhookStatus.active,
    ),
    WooWebhook(
      name: 'Product Updated Webhook',
      topic: 'product.updated',
      deliveryUrl: 'https://your-app.com/webhooks/products',
      secret: 'another-secret-key',
      status: WooWebhookStatus.active,
    ),
  ],
  update: [
    WooWebhook(
      id: 123,
      name: 'Updated Order Webhook',
      status: WooWebhookStatus.paused,
    ),
  ],
  delete: [456, 789],
);
```

### Working with Batch Requests

```dart
// Create a batch request with only creates
final createOnly = WooWebhookBatchRequest(
  create: [webhook1, webhook2, webhook3],
);

// Create a batch request with only updates
final updateOnly = WooWebhookBatchRequest(
  update: [updatedWebhook1, updatedWebhook2],
);

// Create a batch request with only deletes
final deleteOnly = WooWebhookBatchRequest(
  delete: [101, 102, 103],
);
```

### Managing Webhook Topics

```dart
// Create webhooks for different topics
final batchRequest = WooWebhookBatchRequest(
  create: [
    WooWebhook(
      name: 'Order Events',
      topic: 'order.created',
      deliveryUrl: 'https://your-app.com/webhooks/orders',
    ),
    WooWebhook(
      name: 'Customer Events',
      topic: 'customer.created',
      deliveryUrl: 'https://your-app.com/webhooks/customers',
    ),
    WooWebhook(
      name: 'Product Events',
      topic: 'product.updated',
      deliveryUrl: 'https://your-app.com/webhooks/products',
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
final batchRequest = WooWebhookBatchRequest.fromJson(jsonData);
```

### factory WooWebhookBatchRequest.fromJson(Map<String, dynamic> json)

Creates a WooWebhookBatchRequest instance from JSON data

This factory constructor is used to deserialize batch request data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch request data in JSON format

## Returns

A `WooWebhookBatchRequest` instance populated with data from the JSON.

## Example Usage

```dart
final batchRequest = WooWebhookBatchRequest.fromJson(jsonData);
```

### factory WooWebhookBatchRequest.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooWebhook>? create

List of webhooks to create

Each webhook in this list will be created as a new webhook in the store.
Webhooks in this list should not have an ID assigned.

### final List<WooWebhook>? update

List of webhooks to update

Each webhook in this list must have a valid ID and will be updated
with the provided values. Common use cases include:
- Updating webhook status (active, paused, disabled)
- Changing delivery URLs
- Updating secret keys
- Modifying webhook names or topics

### final List<int>? delete

List of webhook IDs to delete

Each ID in this list represents a webhook that will be permanently deleted from the store.

### Map<String, dynamic> toJson()

Converts the WooWebhookBatchRequest instance to JSON format

This method serializes the batch request data into a Map that can be sent
to the WooCommerce REST API.

## Returns

A `Map<String, dynamic>` containing the batch request data in JSON format.

## Example Usage

```dart
final jsonData = batchRequest.toJson();
```

### WooWebhookBatchRequest copyWith({ List<WooWebhook>? create, List<WooWebhook>? update, List<int>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooWebhookBatchRequest instance

This method provides a human-readable representation of the batch request,
displaying the counts of create, update, and delete operations.

## Returns

A `String` containing the batch request's operation counts in a readable format.

## Example Usage

```dart
final batchRequest = WooWebhookBatchRequest(
  create: [webhook1, webhook2],
  update: [webhook3],
  delete: [101, 102],
);
print(batchRequest.toString());
// Output: WooWebhookBatchRequest(create: 2, update: 1, delete: 2)
```

## webhook_batch_response

### class WooWebhookBatchResponse

WooCommerce Webhook Batch Response Model

This class represents the response from a batch webhook operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created webhooks with server-assigned IDs
- **Update Results**: List of successfully updated webhooks
- **Delete Results**: List of successfully deleted webhooks
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Process created webhooks
for (final webhook in response.create ?? []) {
  print('Created webhook: ${webhook.name} with ID: ${webhook.id}');
  print('Topic: ${webhook.topic}');
  print('Delivery URL: ${webhook.deliveryUrl}');
  print('Status: ${webhook.status}');
}

// Process updated webhooks
for (final webhook in response.update ?? []) {
  print('Updated webhook: ${webhook.name}');
  print('New status: ${webhook.status}');
}

// Process deleted webhooks
for (final webhook in response.delete ?? []) {
  print('Deleted webhook: ${webhook.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Analyzing Webhook Topics

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Group created webhooks by topic
final byTopic = <String, List<WooWebhook>>{};
for (final webhook in response.create ?? []) {
  final topic = webhook.topic ?? 'Unknown';
  byTopic.putIfAbsent(topic, () => []).add(webhook);
}

print('Webhooks by topic:');
byTopic.forEach((topic, webhooks) {
  print('  $topic: ${webhooks.length} webhooks');
});
```

### Verifying Webhook Status

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Check which webhooks are active
final activeWebhooks = response.create
    ?.where((webhook) => webhook.status == WooWebhookStatus.active)
    .toList() ?? [];

print('Active webhooks: ${activeWebhooks.length}');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooWebhookBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### WooWebhookBatchResponse({this.create, this.update, this.delete})

WooCommerce Webhook Batch Response Model

This class represents the response from a batch webhook operation. It contains
the results of create, update, and delete operations performed in a single
batch request.

## Key Features

- **Create Results**: List of successfully created webhooks with server-assigned IDs
- **Update Results**: List of successfully updated webhooks
- **Delete Results**: List of successfully deleted webhooks
- **Comprehensive Response**: All operations results in a single response object

## Usage Examples

### Processing Batch Response

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Process created webhooks
for (final webhook in response.create ?? []) {
  print('Created webhook: ${webhook.name} with ID: ${webhook.id}');
  print('Topic: ${webhook.topic}');
  print('Delivery URL: ${webhook.deliveryUrl}');
  print('Status: ${webhook.status}');
}

// Process updated webhooks
for (final webhook in response.update ?? []) {
  print('Updated webhook: ${webhook.name}');
  print('New status: ${webhook.status}');
}

// Process deleted webhooks
for (final webhook in response.delete ?? []) {
  print('Deleted webhook: ${webhook.name}');
}
```

### Checking Batch Results

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

final createdCount = response.create?.length ?? 0;
final updatedCount = response.update?.length ?? 0;
final deletedCount = response.delete?.length ?? 0;

print('Batch operation completed:');
print('  Created: $createdCount');
print('  Updated: $updatedCount');
print('  Deleted: $deletedCount');
```

### Analyzing Webhook Topics

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Group created webhooks by topic
final byTopic = <String, List<WooWebhook>>{};
for (final webhook in response.create ?? []) {
  final topic = webhook.topic ?? 'Unknown';
  byTopic.putIfAbsent(topic, () => []).add(webhook);
}

print('Webhooks by topic:');
byTopic.forEach((topic, webhooks) {
  print('  $topic: ${webhooks.length} webhooks');
});
```

### Verifying Webhook Status

```dart
final response = await wooCommerce.batchUpdateWebhooks(batchRequest);

// Check which webhooks are active
final activeWebhooks = response.create
    ?.where((webhook) => webhook.status == WooWebhookStatus.active)
    .toList() ?? [];

print('Active webhooks: ${activeWebhooks.length}');
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Create from JSON response
final batchResponse = WooWebhookBatchResponse.fromJson(jsonData);

// Convert to JSON if needed
final json = batchResponse.toJson();
```

### factory WooWebhookBatchResponse.fromJson(Map<String, dynamic> json)

Creates a WooWebhookBatchResponse instance from JSON data

This factory constructor is used to deserialize batch response data
received from the WooCommerce REST API.

## Parameters

* [json] - A Map containing the batch response data in JSON format

## Returns

A `WooWebhookBatchResponse` instance populated with data from the JSON.

## Example Usage

```dart
final batchResponse = WooWebhookBatchResponse.fromJson(jsonData);
```

### factory WooWebhookBatchResponse.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final List<WooWebhook>? create

List of created webhooks

Contains the webhooks that were successfully created, each with a
server-assigned ID and all other properties as returned by the API.

### final List<WooWebhook>? update

List of updated webhooks

Contains the webhooks that were successfully updated, reflecting
the current state after the update operation, including any status changes.

### final List<WooWebhook>? delete

List of deleted webhooks

Contains the webhooks that were successfully deleted. These webhooks
may have limited information depending on the API response.

### Map<String, dynamic> toJson()

Converts the WooWebhookBatchResponse instance to JSON format

This method serializes the batch response data into a Map.

## Returns

A `Map<String, dynamic>` containing the batch response data in JSON format.

## Example Usage

```dart
final jsonData = batchResponse.toJson();
```

### WooWebhookBatchResponse copyWith({ List<WooWebhook>? create, List<WooWebhook>? update, List<WooWebhook>? delete, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooWebhookBatchResponse instance

This method provides a human-readable representation of the batch response,
displaying the counts of create, update, and delete results.

## Returns

A `String` containing the batch response's result counts in a readable format.

## Example Usage

```dart
final batchResponse = WooWebhookBatchResponse(
  create: [webhook1, webhook2],
  update: [webhook3],
  delete: [webhook4, webhook5],
);
print(batchResponse.toString());
// Output: WooWebhookBatchResponse(create: 2, update: 1, delete: 2)
```

## webhook_delivery

### class WooWebhookDelivery

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooWebhookDelivery({ this.id, this.createdDate, this.createdDateGmt, this.duration, this.requestUrl, this.requestHeaders, this.requestBody, this.responseCode, this.responseMessage, this.responseHeaders, this.responseBody, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooWebhookDelivery.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooWebhookDelivery.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? createdDate

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final DateTime? createdDateGmt

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? duration

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? requestUrl

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? requestBody

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? responseCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? responseMessage

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? responseBody

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooWebhookDelivery copyWith({ int? id, DateTime? createdDate, DateTime? createdDateGmt, int? duration, String? requestUrl, Map<String, dynamic>? requestHeaders, String? requestBody, int? responseCode, String? responseMessage, Map<String, dynamic>? responseHeaders, String? responseBody, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

