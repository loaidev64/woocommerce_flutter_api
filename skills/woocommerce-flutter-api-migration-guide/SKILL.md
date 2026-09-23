---
name: woocommerce-flutter-api-migration-guide
description: Use when helping a developer migrate code from woocommerce_flutter_api v1.x to v2.x — client construction, error handling, pagination, update/delete signatures, sort enums, currencies, renamed members, and unknown enum values. Read this skill before rewriting any v1 code that uses the package.
---

# Migration Guide: woocommerce_flutter_api v1.x → v2.0

Version 2.0 is a breaking release focused on correctness: safe JSON parsing,
real enum round-trips, typed errors, pagination metadata and consistent
signatures. When migrating user code, apply every change below and update
compiler errors that the new signatures surface.

## 1. Client construction

The `username:`/`password:` parameters were really the consumer key/secret
all along, and `isDebug` used to default to `true` while logging the
`Authorization` header.

```dart
// v1
final woo = WooCommerce(
  baseUrl: 'https://store.com',
  username: 'ck_xxx',
  password: 'cs_xxx',
  isDebug: true,   // default true — logged the Authorization header!
);

// v2
final woo = WooCommerce(
  baseUrl: 'https://store.com',
  consumerKey: 'ck_xxx',
  consumerSecret: 'cs_xxx',
  isDebug: false,  // default false; logs are credential-redacted
);
```

New optional options: `apiVersion` (`WooApiVersion.v3`/`v4`),
`authMethod` (`WooAuthMethod.basic`/`queryString` — credentials in the URL
instead of a Basic header) and `apiPath` (fully custom API paths).

## 2. Errors

v1 threw raw `DioException`s (and crashed with `TypeError` on parse errors).
v2 throws a typed hierarchy rooted at `WooCommerceException`. Replace
`on DioException` catches with `on WooCommerceException` and handle the
specific subclasses:

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

## 3. Pagination

List methods return `WooPage<T>` instead of a bare `List<T>`, exposing the
store's real totals from the `X-WP-Total` / `X-WP-TotalPages` headers:

```dart
// v1
final products = await woo.getProducts(perPage: 20);
print(products.length); // guessing: length < perPage means "last page"

// v2
final page = await woo.getProducts(perPage: 20);
print(page.items);       // List<WooProduct>
print(page.totalItems);  // from X-WP-Total
print(page.totalPages);  // from X-WP-TotalPages
print(page.hasNextPage);
while (page.hasNextPage) {
  final next = await woo.getProducts(page: page.page + 1, perPage: 20);
  // ...
}
```

## 4. Updates and deletes

v1 was inconsistent (`updateOrder(order)` model-only; `deleteCustomer` → bool;
`deleteProduct` → model). v2 is uniform:

```dart
// v1
await woo.updateOrder(order);
final ok = await woo.deleteCustomer(customer.id!);

// v2
await woo.updateOrder(
  order.id!,
  order.copyWith(status: WooOrderStatus.processing),
);
final result = await woo.deleteCustomer(1);
if (result.deleted) { /* ... */ }
```

All models have `copyWith` and full-field equality. Mutating cascades
(`order..status = ...`) no longer compile — fields are `final`; use
`order.copyWith(status: ...)` instead.

## 5. Sort enums

Nine per-module enums (`WooSortOrder`, `WooSortOrderBy`, `WooOrderOrderBy`,
`WooCategoryOrderBy`, `WooTaxRateOrderBy`, `WooSortCoupon`, `WooCustomerSort`,
`WooSortProductReview`, `WooSortProductTag`, `WooSortRefund`) were replaced
by two shared enums:

```dart
final orders = await woo.getOrders(
  order: WooSort.desc,
  orderBy: WooOrderBy.date,
);
```

## 6. Currencies

The 160-value `WooOrderCurrency` enum is gone; store currencies are
open-ended. Use plain ISO-4217 code strings, with `WooCurrency` constants
for the common ones:

```dart
final order = WooOrder(id: 1, currency: WooCurrency.eur); // 'EUR'
```

## 7. Renamed members

| v1 | v2 |
|---|---|
| `getProductVaritaions` | `getProductVariations` |
| `WooProductWithChildrens` | `WooProductWithChildren` |
| `WooCategoryDisplay.default_` | `WooCategoryDisplay.standard` |
| `WooCustomernApi` (extension) | `WooCustomerApi` |
| data-module `WooCurrency` model | `WooDataCurrency` |

## 8. Unknown enum values

Custom/plugin values (e.g. a custom order status) now map to the enum's
`unknown` member instead of silently becoming a default (`pending`, `simple`,
`USD`). Code that relied on the silent coercion must check for `unknown`
explicitly:

```dart
if (order.status == WooOrderStatus.unknown) {
  // custom status registered by a plugin — handle gracefully
}
```

## 9. Experimental modules

`login`/`register`/`forgotPassword`/`changePassword`, the cart API, the
notification API and `LocalStorageHelper` are `@experimental`: not part of
the WooCommerce REST API and require a custom WordPress plugin. Core
endpoints (products, orders, customers, coupons, taxes, shipping, webhooks,
reports, settings, data, system status) are unaffected.

## 10. Custom endpoints

Prefer the client request helpers, which guarantee typed errors:

```dart
final response = await woo.requestGet<Map<String, dynamic>>(
  '/custom-endpoint',
  queryParameters: {'page': '1'},
);
```

## Migration checklist

1. Constructor: `username`/`password` → `consumerKey`/`consumerSecret`;
   review `isDebug`.
2. Replace every `on DioException` catch with the `WooCommerceException`
   hierarchy.
3. Adapt list results from `List<T>` to `WooPage<T>` (`.items` + pagination
   loop).
4. Update/delete calls to `(id, model)` / `WooDeleteResult` signatures; use
   `copyWith` instead of mutation.
5. Replace per-module sort enums with `WooSort`/`WooOrderBy`; replace
   `WooOrderCurrency` values with ISO code strings.
6. Apply the renamed members table.
7. Handle `unknown` enum values where the store may return custom statuses.
8. Run `flutter analyze` and fix remaining errors — the package APIs are
   consistent, so errors pinpoint every call site that needs updating.