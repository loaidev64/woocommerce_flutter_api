---
name: woocommerce-flutter-api-documentation
description: Use when writing, reviewing, or fixing code that uses the woocommerce_flutter_api package — client setup, API methods, models, enums, JSON serialization, error handling, pagination, or fake-data mode. Covers every module (products, orders, customers, coupons, taxes, shipping, webhooks, reports, settings, and more) with examples and links to the official WooCommerce REST API docs.
---

# WooCommerce Flutter API — Usage Guide

This skill teaches the AI how to use the `woocommerce_flutter_api` package
correctly. The package is a typed, null-safe Flutter/Dart client for the
WooCommerce REST API.

The package ships **no code comments** — this skill and its reference files
are the documentation. Consult `references/` before guessing an API.

## Reference map

Each module has a reference file under `references/` with the full docs of
every class, field, method and enum (including REST API doc links):

| Reference | Contents |
|---|---|
| `references/product.md` | Products, attributes (+terms), reviews, shipping classes, tags, batch operations |
| `references/variation.md` | Product variations |
| `references/category.md` | Product categories |
| `references/order.md` | Orders, notes, refunds, line items, tax/shipping/fee/coupon lines |
| `references/refund.md` | Standalone refunds |
| `references/authentication.md` | Customers + experimental auth (login/register/forgot/change password) |
| `references/coupon.md` | Coupons |
| `references/tax.md` | Tax rates and classes |
| `references/shipping.md` | Shipping zones, zone locations, zone methods |
| `references/shipping_method.md` | Read-only shipping methods |
| `references/payment_gateway.md` | Payment gateways and settings |
| `references/settings.md` | Settings groups and setting options |
| `references/system_status.md` | System status + tools |
| `references/data.md` | Continents, countries, currencies, data index |
| `references/report.md` | Sales reports, top sellers, totals reports |
| `references/webhook.md` | Webhooks and deliveries |
| `references/cart.md` | Experimental cart API |
| `references/notification.md` | Experimental FCM notification API |
| `references/base.md` | `WooContext`, `WooSort`, `WooOrderBy`, `WooFilterStatus`, `WooMetaData`, `WooDeleteResult`, query classes |
| `references/exceptions.md` | The `WooCommerceException` hierarchy |
| `references/json.md` | `WooJson` parsing/writing helpers, `WooEnum` contract |
| `references/pagination.md` | `WooPage<T>` pagination wrapper |
| `references/helpers.md` | `FakeHelper`, `LocalStorageHelper` |
| `references/http.md` | `WooErrorInterceptor`, `WooLogInterceptor` |

## Client setup

```dart
final wooCommerce = WooCommerce(
  baseUrl: 'https://yourstore.com',
  consumerKey: 'ck_...',
  consumerSecret: 'cs_...',
  apiVersion: WooApiVersion.v3,     // optional, default v3
  authMethod: WooAuthMethod.basic,  // optional: basic (default) or queryString
  isDebug: false,                   // optional; logs never include credentials
  useFaker: false,                  // optional: fake data mode
  interceptors: [...],              // optional extra Dio interceptors
);
```

- `apiPath` overrides the API path entirely (takes precedence over
  `apiVersion`).
- Every method accepts an optional `useFaker:` parameter that overrides the
  client-wide setting.

## Core conventions

### API access pattern

Every module is a Dart `extension` on `WooCommerce`
(`extension WooProductApi on WooCommerce`). Call methods directly on the
client instance:

```dart
final page = await wooCommerce.getProducts(perPage: 10);
final product = await wooCommerce.getProduct(123);
```

### Errors

Never catch `DioException` in application code. All failures are mapped to a
typed hierarchy rooted at `WooCommerceException` (see
`references/exceptions.md`):

- `WooCommerceAuthException` — 401/403 (invalid key/secret)
- `WooCommerceValidationException` — 400, exposes `code`, `message`, `fieldErrors`
- `WooCommerceNotFoundException` — 404
- `WooCommerceRateLimitException` — 429, exposes `retryAfterSeconds`
- `WooCommerceServerException` — 5xx
- `WooCommerceNetworkException` — timeouts / no network
- `WooCommerceParseException` — unparseable response

```dart
try {
  final product = await wooCommerce.getProduct(123);
} on WooCommerceAuthException catch (e) {
  // credentials are wrong
} on WooCommerceNotFoundException catch (e) {
  // product does not exist
} on WooCommerceException catch (e) {
  // everything else
}
```

### Pagination

All list methods return `WooPage<T>` (see `references/pagination.md`):
`items`, `page`, `totalItems`, `totalPages` (from `X-WP-Total` headers) and
`hasNextPage`.

```dart
var page = await wooCommerce.getProducts(page: 1, perPage: 25);
final all = [...page.items];
while (page.hasNextPage) {
  page = await wooCommerce.getProducts(page: page.page + 1, perPage: 25);
  all.addAll(page.items);
}
```

### Query options

List methods accept typed query objects (`WooProductQuery`, `WooOrderQuery`,
`WooCustomerQuery`, …) plus convenience parameters (`page`, `perPage`,
`search`, `order`, `orderBy`, date filters, `include`/`exclude`, …).
Enums like `WooContext` (`view`/`edit`), `WooSort` (`asc`/`desc`) and
`WooOrderBy` (shared sort keys) are shared across modules. Read
`references/base.md` and the per-module reference for the exact parameters.

### Models

- All models are **immutable** (`final` fields) with a named-parameter
  constructor, `fromJson` factory, `toJson` (nulls omitted), `copyWith`,
  full-field `==`/`hashCode`, `toString`, and a `fake()` factory.
- To change a model, use `copyWith` — mutating cascades
  (`order..status = ...`) do not work.
- `fromJson` never throws on partial payloads: it reads through `WooJson`
  helpers (`readString`, `readInt`, `readDouble`, `readBool`, `readDate`,
  `readList`, `readIntList`, `readMap`, `readEnum` — see
  `references/json.md`).
- Update methods take `(int id, Model model)`:
  `await wooCommerce.updateProduct(product.id!, product.copyWith(price: '29.99'))`.
- Delete methods return `WooDeleteResult` with `id` and `deleted` fields.
- Batch operations: `WooXxxBatchRequest(create:, update:, delete:)` →
  `batchUpdateXxx(...)` returning `WooXxxBatchResponse`. Delete lists are
  `List<int>` (IDs) in requests, `List<Model>` in responses.

### Enums

- Every enum implements `WooEnum` and serializes with its exact wire value
  (`WooOrderStatus.onHold` → `"on-hold"`), never with `Enum.name`.
- Enums that deserialize wire values define an `unknown` fallback member.
  Always check for `unknown` when a store may use custom plugin statuses:

```dart
if (product.status == WooProductStatus.unknown) {
  // custom status from a plugin — handle gracefully
}
```

- `WooCurrency` is not an enum: `WooOrder.currency` is a plain ISO-4217
  `String` (e.g. `'EUR'`), with `WooCurrency.eur` constants available.
- `WooProductFilterWithType` (used by `getProductWithOptions`) implements
  `WooEnum`.

### Fake data mode

`useFaker: true` returns realistic fake models without network access —
useful for UI development. Every model and enum has a `fake()` factory for
tests and mocks. `WooCustomer.fake({int? id})`, `WooCoupon.fake({int? id})`,
etc. accept an optional `id` for faking single-resource responses.

### Custom endpoints

Use the client helpers for typed errors (prefer over raw `dio`):

```dart
final data = await wooCommerce.requestGet<Map<String, dynamic>>(
  '/custom-endpoint',
  queryParameters: {'filter': 'value'},
);
```

## Experimental modules

`login`, `register`, `forgotPassword`, `changePassword`, the cart API and
the notification API are `@experimental`: they are NOT part of the
WooCommerce REST API and require a custom WordPress plugin. Prefer the core
endpoints (products, orders, customers, coupons, taxes, shipping, webhooks,
reports, settings, data, system status) unless the app owns such a plugin.

## When using a module

1. Read the corresponding `references/<module>.md` file.
2. Follow the REST API doc link at the top of each method when the exact
   request/response shape matters.
3. Match the examples in the reference — they are the canonical usage
   patterns for this package.
4. Use `fake()` models and `useFaker: true` in tests and UI development.
5. Never invent model fields or methods that are not in the references.