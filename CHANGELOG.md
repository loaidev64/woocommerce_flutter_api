# Changelog

All notable changes to this project are documented in this file.

## 2.0.0

Major release with a redesigned, safer public API. See [MIGRATION.md](MIGRATION.md)
for the v1 → v2 guide.

### Fixed

- **`WooOrder.fromJson` no longer crashes on every real order** — it previously
  assigned raw JSON strings (`status`, `currency`, dates, totals) directly into
  typed fields and threw `TypeError` at runtime. All models now parse through
  shared null-safe JSON helpers (`WooJson`).
- **Enums round-trip against the real WooCommerce wire values** —
  `WooOrderStatus.onHold` serializes as `on-hold` (was `onHold`), category
  `display` as `default`, `term_group`, `date_gmt`, `menu_order`,
  `registered_date`, etc. `.name` serialization is gone.
- **Unknown values no longer silently coerced** — unrecognized/plugin statuses
  map to a new `unknown` member instead of silently becoming `pending`/`simple`/`USD`.
- **`toJson` never emits explicit `null` values** (a recurring cause of
  `400 Bad Request` on update requests).
- **Credentials are never logged** — the default-on debug logger (which printed
  the `Authorization: Basic ck:cs` header) is replaced with a credential-safe
  logger that is **off by default** (`isDebug` now defaults to `false`).
- **Web support is real** — `dart:io` removed from the core client.
- Bug fixes carried from v1: order refund endpoint path (`/refunds/{id}`),
  `db` → `dp` query parameter, order note `type` parameter,
  `taxeClasses` typo, variation date key swap.
- **Model consistency pass** — every model now uses a `factory fromJson`
  (was a mix of factories and generative constructors), ships a `fake()`
  factory (batch models, category links and `WooDeleteResult` included),
  full `toJson`/`copyWith`/`==`/`hashCode` (added to `WooDeleteResult`;
  fixed `WooSettingOption.hashCode` omitting `options`), and one `Object.hashAll`
  hashCode idiom.
- **Enum consistency pass** — `unknown` fallback added to `WooOrderTaxStatus`,
  `WooOrderNoteType`, `WooReportPeriod`, `WooContext`, `WooSort`, `WooOrderBy`,
  `WooFilterStatus`, `WooApiVersion` and `WooAuthMethod`;
  `WooProductFilterWithType` is now a `WooEnum` with wire values;
  `fake()` added to `WooApiVersion`/`WooAuthMethod`;
  `WooWebhookTopic.randomTopic()` renamed `fake()`.
- **Uniform `fake()` signatures** — `fake({int? id})` named parameters
  everywhere (`WooCustomer.fake({int? id})`, …) instead of a mix of
  positional and named.
- **Unified conventions** — relative imports within `lib/src`, `Object.hashAll`
  hashCode style, and uniform `==` across all models.

### Changed (breaking)

- `WooCommerce(username:, password:)` → `WooCommerce(consumerKey:, consumerSecret:)`.
- New optional constructor parameters: `apiVersion` (`WooApiVersion.v3`/`v4`),
  `authMethod` (`WooAuthMethod.basic`/`queryString` — query-string credentials
  are the other officially supported WooCommerce auth scheme), `apiPath` override.
- All list methods return `WooPage<T>` exposing `X-WP-Total` / `X-WP-TotalPages`
  (`items`, `page`, `totalItems`, `totalPages`, `hasNextPage`) instead of a bare
  `List<T>`.
- All delete methods return `WooDeleteResult` (`id`, `deleted`) instead of a
  mix of `bool` and models.
- All update methods take `(int id, Model model)` consistently.
- Typed query option classes (`WooProductQuery`, `WooOrderQuery`,
  `WooCustomerQuery`, …) replace the per-module 20–30-parameter raw-map builders.
- All models: immutable (`final` fields), `copyWith`, full-field `==`/`hashCode`
  (no more id-only equality).
- Consolidated enums: 9 overlapping per-module sort enums → single `WooSort` and
  `WooOrderBy`; 160-value `WooOrderCurrency` enum → `String?` plus a
  `WooCurrency` constants class; the data-module currency model was renamed
  `WooDataCurrency`.
- `WooCouponDiscountType` is now a typed enum; coupon amounts parse to `double?`.
- `WooCategoryDisplay.default_` renamed to `standard` (wire value `default`).
- Fixed typos in the public API: `getProductVaritaions` → `getProductVariations`,
  `WooProductWithChildrens` → `WooProductWithChildren`,
  `WooCustomernApi` → `WooCustomerApi`.
- Non-core endpoints (`login`/`register`/`forgot-password`/`change-password`,
  cart, notifications/FCM, `sendOrderDetailsToCustomer`) are marked `@experimental`
  and documented as requiring a custom WordPress plugin.
- `pretty_dio_logger` kept for debug logging; the default-on v1 logger that
  printed the `Authorization` header is replaced by the credential-safe
  `WooLogInterceptor` (debug logging is off by default in v2).

### Added

- Typed exception hierarchy mapped from Dio errors: `WooCommerceException`,
  `WooCommerceAuthException` (401/403), `WooCommerceValidationException` (400,
  with field errors), `WooCommerceNotFoundException` (404),
  `WooCommerceRateLimitException` (429, with `Retry-After`),
  `WooCommerceServerException` (5xx), `WooCommerceNetworkException`,
  `WooCommerceParseException` — carrying `statusCode`, `code` and `requestId`.
- Global product attributes API (`/products/attributes`) with terms:
  full CRUD + batch operations.
- Webhook deliveries (`/webhooks/{id}/deliveries`): list and delete.
- Reports index (`GET /reports`): `getReports()` returning `WooReportItem`.
- `?currency=` request override on product list/create/update endpoints.
- Query-string authentication (`WooAuthMethod.queryString`).
- First real test suite: serialization round-trips against real payloads,
  enum wire values, exception mapping, pagination headers, client construction.
- **AI agent skills** — the package now ships `skills/` with two agent
  skills installable via `dart run skills@ get woocommerce_flutter_api`:
  `woocommerce-flutter-api-documentation` (full API usage guide with
  per-module references and links to the WooCommerce REST API docs) and
  `woocommerce-flutter-api-migration-guide` (the v1 → v2 breaking changes).
  The source code is intentionally comment-free; the skills are the
  documentation.

## 1.7.1

- Fix `WooProductImage` for product creation: all four `DateTime` fields are
  now nullable and optional. `fromJson` keeps them `null` when missing and
  `toJson` only emits them when present. Fixes #31.
- Fix `WooProductCategory.display` serialization: `fromJson` uses
  `WooCategoryDisplay.fromString` and `toJson` writes `"default"`. Fixes #30.

## 1.7.0

- Updated `flutter_secure_storage` to `^11.0.0` (WASM-compatible).
- Bumped SDK constraint to `>=3.3.0` and Flutter constraint to `>=3.19.0`.
- Resolved 18 `dangling_library_doc_comments` lints.
- Fixed 3 `comment_references` lints; cleaned up `avoid_print` warnings.

## 1.6.0

- Added batch update APIs for product shipping classes, product reviews, tax
  rates, webhooks and settings options, with matching batch request/response
  models.

## 1.5.0

- Enhanced documentation with detailed descriptions, usage examples and JSON
  serialization for refund, report, tax and variation models.

## 1.4.0

- Updated dependencies to the latest versions.

## 1.3.0

- Fixed `getOrders` orderby query parameter.
- Added create/update/delete for product categories.
- Added create/update/delete/duplicate for products.

## 1.2.2

- Fixed issue #23 (category orderby query parameter).

## 1.2.1

- Improved API structure and documentation.
- Added `interceptors` property to the `WooCommerce` class.

## 1.2.0

- Nearly complete coverage of the official WooCommerce REST API.

## 1.1.0

- Added product reviews, shipping classes, reports, tax rates and tax classes.

## 1.0.3

- Added product tags (`getProductTags()`) and `WooProductTagSort`.

## 1.0.2 - 1.0.0

- Initial release of the WooCommerce REST API client.
