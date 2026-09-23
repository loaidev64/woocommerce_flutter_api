# WooCommerce Flutter API

A typed, null-safe Dart/Flutter client for the [WooCommerce REST API](https://woocommerce.github.io/woocommerce-rest-api-docs/).
Manage products, variations, orders, customers, coupons, taxes, shipping,
webhooks, reports, settings and more — with pagination metadata, typed
exceptions and a fake-data mode for development.

## Migrating from v1

> **Important for existing users of v1.x:** version 2.0 is a **breaking**
> release. The client constructor, error handling, pagination, update/delete
> signatures, sort enums and currencies all changed, and several members were
> renamed. Your v1 code will not compile without changes.

You have two ways to migrate:

1. **Read [MIGRATION.md](MIGRATION.md)** — the complete list of breaking
   changes with before/after code examples.
2. **Ask your AI assistant (recommended)** — after installing the skills
   (`dart run skills@ get woocommerce_flutter_api`), your assistant
   automatically loads `woocommerce-flutter-api-migration-guide` and can
   migrate your code for you.

## Features

- **Typed, null-safe models** — every model has safe JSON parsing (no
  `TypeError` crashes on real payloads), `copyWith`, and full-field equality.
- **Real enum round-trips** — enums serialize with the exact wire values the
  WooCommerce REST API expects (`on-hold`, `date_gmt`, `term_group`, …) and
  map unknown/plugin values to an `unknown` member instead of crashing or
  silently guessing.
- **Pagination metadata** — list methods return `WooPage<T>` with
  `totalItems`, `totalPages` and `hasNextPage` (from the `X-WP-Total`
  headers) so you never guess when to stop paginating.
- **Typed errors** — all failures map to `WooCommerceException` subclasses
  (`Auth`, `Validation`, `NotFound`, `RateLimit`, `Server`, `Network`,
  `Parse`) carrying the HTTP status, WooCommerce error code and request id.
- **Both official auth schemes** — HTTP Basic (default) or query-string
  credentials, selectable per client. Targets WooCommerce REST API v3 or v4.
- **Fake data mode** — `useFaker` returns generated fake models for UI
  development and tests without touching a real store.
- **Debug logging that can't leak secrets** — credentials are never logged.
- **Web support** — no `dart:io` anywhere in the core client.

## Installation

```bash
flutter pub add woocommerce_flutter_api
```

## Quick start

Create the client once and use it everywhere:

```dart
final woocommerce = WooCommerce(
  baseUrl: 'https://yourstore.com',
  consumerKey: 'ck_your_consumer_key',
  consumerSecret: 'cs_your_consumer_secret',
  // apiVersion: WooApiVersion.v3,           // default
  // authMethod: WooAuthMethod.basic,        // default
  // isDebug: false,                         // default; logs are credential-safe
  // useFaker: false,                        // return fake data for development
  // interceptors: [/* your Dio interceptors */],
);
```

### Fetching products (with pagination)

```dart
final page = await woocommerce.getProducts(perPage: 20);
print('${page.totalItems} products across ${page.totalPages} pages');

for (final product in page.items) {
  print('${product.id}: ${product.name} — ${product.price}');
}

while (page.hasNextPage) {
  final next =
      await woocommerce.getProducts(page: page.page + 1, perPage: 20);
  // ...
}
```

### Creating and updating

```dart
final product = WooProduct(
  name: 'Vinyl Album',
  type: WooProductType.simple,
  regularPrice: 20.0,
);

final created = await woocommerce.createProduct(product);

final updated = await woocommerce.updateProduct(
  created.id!,
  created.copyWith(status: WooProductStatus.publish),
);
```

### Deleting

```dart
final result = await woocommerce.deleteProduct(42);
print(result.deleted); // true
```

### Orders

```dart
final orderPage = await woocommerce.getOrders(
  status: WooOrderStatus.processing,
  order: WooSort.desc,
  orderBy: WooOrderBy.date,
);

final order = orderPage.items.first;
final processed = await woocommerce.updateOrder(
  order.id!,
  order.copyWith(status: WooOrderStatus.completed),
);
```

### Customers

```dart
final customers = await woocommerce.getCustomers(email: 'john@example.com');
final customer = customers.items.first;

await woocommerce.updateCustomer(
  customer.id!,
  customer.copyWith(firstName: 'Jane'),
);
```

### Errors

```dart
try {
  final coupons = await woocommerce.getCoupons();
} on WooCommerceAuthException {
  // 401/403 — check consumer key and secret
} on WooCommerceValidationException catch (e) {
  // 400 — inspect e.code, e.message and e.fieldErrors
} on WooCommerceRateLimitException catch (e) {
  // 429 — wait e.retryAfterSeconds before retrying
} on WooCommerceException catch (e) {
  // any other mapped error: e.statusCode, e.code, e.requestId
}
```

### Fake data mode

```dart
final woocommerce = WooCommerce(
  baseUrl: 'https://yourstore.com',
  consumerKey: 'ck_...',
  consumerSecret: 'cs_...',
  useFaker: true,
);

final products = await woocommerce.getProducts(); // fake, no network calls
```

Every method also accepts a per-call `useFaker` override.

### Custom API calls

Endpoints not yet wrapped by the package can be called through the request
helpers (typed errors included):

```dart
try {
  final response = await woocommerce.requestGet<Map<String, dynamic>>(
    '/wc/v3/custom-endpoint',
  );
  print(response.data);
} on WooCommerceException catch (e) {
  print('${e.statusCode}: ${e.message}');
}
```

Or use the raw [dio] instance for full control:

```dart
final response = await woocommerce.dio.get('/custom-endpoint');
```

### Experimental modules (require a custom WordPress plugin)

The following are **not** part of the WooCommerce REST API. They target a
custom WordPress plugin and are marked `@experimental`:

- `login`, `register`, `forgotPassword`, `changePassword`
- the cart API (`getCart`, `updateCart`)
- the notification API (`getNotifications`, FCM registration)

```dart
final woo = WooCommerce(
  baseUrl: 'https://yourstore.com',
  consumerKey: 'ck_...',
  consumerSecret: 'cs_...',
);

// Requires the custom plugin:
final cart = await woo.getCart();
final notifications = await woo.getNotifications();
```

## Supported resources

Products, product attributes (global, with terms), product variations,
product categories, tags, shipping classes, reviews, orders (+ notes,
refunds), customers, coupons, taxes (rates and classes), shipping zones and
methods, payment gateways, settings, system status (+ tools), data
(continents, countries, currencies), reports, webhooks (+ deliveries).

## AI skills for your coding assistant

This package ships **AI agent skills** so your coding assistant knows how to
use it correctly — full API documentation, conventions and the v1 → v2
migration guide — without guessing or hallucinating APIs.

The skills follow the official [Agent Skills
specification](https://agentskills.io/specification) and are installed with
the [`skills`](https://pub.dev/packages/skills) CLI (maintained by
`labs.dart.dev`). The package itself ships the skills in its `skills/`
directory; the CLI is only used to install them into your agent.

Install them from the root of *any* project that depends on this package:

```bash
dart run skills@ get woocommerce_flutter_api
```

Two skills are installed:

- **`woocommerce-flutter-api-documentation`** — the complete usage guide for
  every module (products, orders, customers, coupons, taxes, shipping,
  webhooks, reports, settings, …) with examples and links to the official
  WooCommerce REST API docs. Activate automatically whenever you write or
  review code that uses this package.
- **`woocommerce-flutter-api-migration-guide`** — the v1.x → v2.0 breaking
  changes with before/after examples. Activate when migrating existing code.

The skills work with Antigravity, Claude Code, Codex, Cursor, GitHub
Copilot and OpenCode.

## Roadmap

- [x] Full WooCommerce REST v3 resource coverage
- [x] Typed errors and pagination metadata
- [x] Product attributes & terms CRUD
- [x] Webhook deliveries
- [ ] WooCommerce v4 (beta) resource coverage
- [ ] Downloadable product / customer download flow helpers

## Contributing

Issues and pull requests are welcome at the
[GitHub repository](https://github.com/loaidev64/woocommerce_flutter_api).

## License

MIT — see [LICENSE](LICENSE).
