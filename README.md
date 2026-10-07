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

> **Note:** v2.1 also adds cart & checkout on the public Store API and removes
> the old experimental plugin cart. See the v2.0.x → v2.1.0 section in
> [MIGRATION.md](MIGRATION.md).

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
- **Cart & checkout** — add to cart and place orders through the public
  **Store API** (no consumer key is sent), with `Cart-Token` sessions,
  coupons, shipping rates and money printed in the store's own format.
  Requires WooCommerce 8.0+.

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

### Cart and checkout (Store API)

> **Requires WooCommerce 8.0+.** Cart and checkout use WooCommerce's public
> [Store API](https://developer.woocommerce.com/docs/apis/store-api/) at
> `/wp-json/wc/store/v1`. It shipped with WooCommerce Blocks and was merged
> into core in 8.0; older stores need the WooCommerce Blocks plugin.

The client's constructor still requires your consumer key and secret (the rest
of the API needs them), but cart and checkout calls **do not send them** — the
Store API is public and identifies a cart with a `Cart-Token` this client
captures and replays for you.

```dart
final woo = WooCommerce(
  baseUrl: 'https://yourstore.com',
  consumerKey: 'ck_...',
  consumerSecret: 'cs_...',
  // cartTokenStore: SecureStorageWooCartTokenStore(), // default
);

final cart = await woo.getCart();
await woo.addToCart(id: 799, quantity: 2);
await woo.addToCart(
  id: 815,
  variation: {'pa_colour': 'blue'}, // the variation's id
);

// A country and postcode are enough to quote shipping.
final quoted = await woo.updateCartCustomer(
  shippingAddress: const WooStoreAddress(postcode: 'N1 7GU', country: 'GB'),
);
for (final package in quoted.shippingPackages) {
  for (final rate in package.rates) {
    print('${rate.name} — $rate'); // money prints like the store does
  }
}

await woo.applyCoupon('SAVE10');

// Checkout
final address = WooStoreAddress(
  firstName: 'Ada',
  lastName: 'Lovelace',
  address1: '12 Analytical Way',
  city: 'London',
  postcode: 'N1 7GU',
  country: 'GB',
  email: 'ada@example.com',
);
final result = await woo.checkout(
  billingAddress: address,
  paymentMethod: 'cod',
  expectedTotal: quoted.totals.totalPrice,
);

if (result.paymentResult.needsRedirect) {
  // PayPal and friends finish off-site.
  await launchUrl(Uri.parse(result.paymentResult.redirectUrl));
} else if (result.isPaid) {
  print('Order ${result.orderId} placed');
}
```

Every cart call returns the whole recalculated cart. Money is modelled by
`WooStoreMoney`/`WooStoreCurrency`, so `toString()` gives the store's own
format (`$82.56`). Pass `expectedTotal` to `checkout` and the store refuses a
total that moved with `WooCommerceTotalMismatchException` (which carries the
refreshed cart) instead of charging a different amount. `checkoutAndClear`
forgets the basket only when the payment went through.

To keep a shopper's basket across app launches, pass a `WooCartTokenStore`
(the default uses `flutter_secure_storage`; use `InMemoryWooCartTokenStore`
for pure-Dart/server use). `woo.cartSession.adopt(token)` and
`woo.cartSession.clear()` manage it directly. For Store API routes this
package does not wrap, use `woo.requestStoreGet<Map<String, dynamic>>(...)` or
the credential-free `woo.storeDio`.

### Experimental modules (require a custom WordPress plugin)

The following are **not** part of the WooCommerce REST API. They target a
custom WordPress plugin and are marked `@experimental`:

- `login`, `register`, `forgotPassword`, `changePassword`
- the notification API (`getNotifications`, FCM registration)

```dart
final woo = WooCommerce(
  baseUrl: 'https://yourstore.com',
  consumerKey: 'ck_...',
  consumerSecret: 'cs_...',
);

// Requires the custom plugin:
final notifications = await woo.getNotifications();
```

## Supported resources

Products, product attributes (global, with terms), product variations,
product categories, tags, shipping classes, reviews, orders (+ notes,
refunds), customers, coupons, taxes (rates and classes), shipping zones and
methods, payment gateways, settings, system status (+ tools), data
(continents, countries, currencies), reports, webhooks (+ deliveries).
Cart and checkout are also supported through the public Store API
(WooCommerce 8.0+).

## AI skills for your coding assistant

This package ships **AI agent skills** so your coding assistant knows how to
use it correctly — full API documentation, conventions and the migration
guide (v1 → v2 and v2.0 → v2.1) — without guessing or hallucinating APIs.

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
- **`woocommerce-flutter-api-migration-guide`** — the v1.x → v2.0 and
  v2.0.x → v2.1.0 breaking changes with before/after examples. Activate when
  migrating existing code.

The skills work with Antigravity, Claude Code, Codex, Cursor, GitHub
Copilot and OpenCode.

## Roadmap

- [x] Full WooCommerce REST v3 resource coverage
- [x] Typed errors and pagination metadata
- [x] Product attributes & terms CRUD
- [x] Webhook deliveries
- [x] Cart & checkout via the public Store API
- [ ] WooCommerce v4 (beta) resource coverage
- [ ] Downloadable product / customer download flow helpers

## Contributing

Issues and pull requests are welcome at the
[GitHub repository](https://github.com/loaidev64/woocommerce_flutter_api).

## License

MIT — see [LICENSE](LICENSE).
