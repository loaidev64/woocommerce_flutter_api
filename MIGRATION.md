# Migration Guide: v1.x → v2.0

Version 2.0 is a breaking release focused on correctness: safe JSON parsing,
real enum round-trips, typed errors, pagination metadata and consistent
signatures. This guide covers every breaking change and how to update your code.

## Client construction

```dart
// v1
final woo = WooCommerce(
  baseUrl: 'https://store.com',
  username: 'ck_xxx',   // these were consumer key/secret all along
  password: 'cs_xxx',
  isDebug: true,        // default true — logged your Authorization header!
);

// v2
final woo = WooCommerce(
  baseUrl: 'https://store.com',
  consumerKey: 'ck_xxx',
  consumerSecret: 'cs_xxx',
  isDebug: false,       // default false; logs are credential-redacted
);
```

New options: `apiVersion: WooApiVersion.v4`, `authMethod:
WooAuthMethod.queryString` (credentials in the URL instead of a Basic header),
and `apiPath` for fully custom paths.

## Errors

v1 threw raw `DioException`s (and crashed with `TypeError` on parse errors). v2
throws a typed hierarchy — `WooCommerceException` and its subclasses:

```dart
try {
  final products = await woo.getProducts();
} on WooCommerceAuthException {
  // 401/403 — check consumer key/secret
} on WooCommerceValidationException catch (e) {
  // 400 — e.code, e.message, e.fieldErrors
} on WooCommerceRateLimitException catch (e) {
  // 429 — wait e.retryAfterSeconds
} on WooCommerceException catch (e) {
  // everything else
}
```

Catch `on WooCommerceException` instead of `on DioException`.

## Pagination

List methods now return `WooPage<T>` with the store's totals:

```dart
// v1
final products = await woo.getProducts(perPage: 20);
print(products.length); // and guess when to stop with length < perPage

// v2
final page = await woo.getProducts(perPage: 20);
print(page.items);        // List<WooProduct>
print(page.totalItems);   // from X-WP-Total
print(page.totalPages);   // from X-WP-TotalPages
print(page.hasNextPage);
while (page.hasNextPage) {
  final next = await woo.getProducts(page: page.page + 1, perPage: 20);
  // ...
}
```

## Updates and deletes

```dart
// v1 (inconsistent)
await woo.updateOrder(order);                     // model only
final ok = await woo.deleteCustomer(customer.id!); // bool
final product = await woo.deleteProduct(id);       // model

// v2 (consistent)
await woo.updateOrder(order.id!, order.copyWith(status: WooOrderStatus.processing));
final result = await woo.deleteCustomer(1);
if (result.deleted) { /* ... */ }
```

All models now have `copyWith` and full-field equality; mutating cascades
(`order..status = ...`) no longer work — fields are `final`.

## Sort enums

Nine overlapping per-module enums (`WooSortOrder`, `WooSortOrderBy`,
`WooOrderOrderBy`, `WooCategoryOrderBy`, `WooTaxRateOrderBy`, `WooSortCoupon`,
`WooCustomerSort`, `WooSortProductReview`, `WooSortProductTag`,
`WooSortRefund`) are replaced by two shared enums:

```dart
final orders = await woo.getOrders(
  order: WooSort.desc,
  orderBy: WooOrderBy.date,
);
```

## Currencies

The 160-value `WooOrderCurrency` enum is gone — store currencies are
open-ended. Use plain ISO-code strings (with constants for the common ones):

```dart
final order = WooOrder(id: 1, currency: WooCurrency.eur); // 'EUR'
```

## Renamed members

| v1 | v2 |
|---|---|
| `getProductVaritaions` | `getProductVariations` |
| `WooProductWithChildrens` | `WooProductWithChildren` |
| `WooCategoryDisplay.default_` | `WooCategoryDisplay.standard` |
| `WooCustomernApi` (extension) | `WooCustomerApi` |
| data-module `WooCurrency` model | `WooDataCurrency` |

## Unknown enum values

Custom/plugin values (e.g. a custom order status) now map to the enum's
`unknown` member instead of silently becoming a default (`pending`, `simple`,
`USD`). If you relied on the silent coercion, check for `unknown` explicitly.

## Experimental modules

`login`/`register`/`forgotPassword`/`changePassword`, the cart API, the
notification API and `LocalStorageHelper` are marked `@experimental`: they are
not part of the WooCommerce REST API and require a custom WordPress plugin.
Core WooCommerce endpoints (products, orders, customers, coupons, taxes,
shipping, webhooks, reports, settings, data, system status) are unaffected.

## Custom endpoints

Use the request helpers on the client, which guarantee typed errors:

```dart
final response = await woo.requestGet<Map<String, dynamic>>(
  '/custom-endpoint',
  queryParameters: {'page': '1'},
);
```
