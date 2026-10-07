# Migration Guides

## v2.0.x → v2.1.0

Version 2.1 adds real cart and checkout support through WooCommerce's public
**Store API** (`/wp-json/wc/store/v1`), and removes the old experimental
custom-plugin cart. The `WooCommerce` constructor is unchanged: `baseUrl`,
`consumerKey` and `consumerSecret` are still required. Cart and checkout calls
simply do not send those credentials — the Store API is keyless and identifies
a cart with a `Cart-Token` this client manages for you.

> **Requires WooCommerce 8.0+.** The Store API shipped with WooCommerce Blocks
> and was merged into core in 8.0. Older stores need the WooCommerce Blocks
> plugin. Note that this is unrelated to the version of this package.

### The old plugin cart is gone

`WooCart`, `WooCartItem`, `getCart()` and `updateCart(List<WooCartItem>)` were
part of a custom WordPress plugin (they called a `/cart` route with a
`user_id`). They have been replaced by Store API models and methods:

| v2.0 (plugin) | v2.1 (Store API) |
|---|---|
| `getCart()` → `WooCart` | `getCart()` → `WooStoreCart` |
| `updateCart([WooCartItem(...)])` | `addToCart`, `updateCartItem`, `removeCartItem`, `clearCart` |
| `WooCart` / `WooCartItem` | `WooStoreCart` / `WooStoreCartItem` + totals, coupons, shipping, addresses |

```dart
// v2.0 — replace the whole cart with a list
await woo.updateCart(<WooCartItem>[WooCartItem(id: 38, quantity: 2)]);

// v2.1 — granular, and each call returns the recalculated cart
await woo.addToCart(id: 38, quantity: 2);
final cart = await woo.getCart();
await woo.updateCartItem(key: cart.items.first.key, quantity: 3);
await woo.removeCartItem(cart.items.first.key);
await woo.clearCart();
```

### Cart, coupons, shipping and addresses

```dart
final cart = await woo.getCart();

await woo.addToCart(id: 815, variation: {'pa_colour': 'blue'});
await woo.updateCartCustomer(
  shippingAddress: const WooStoreAddress(postcode: 'N1 7GU', country: 'GB'),
);
for (final package in cart.shippingPackages) {
  for (final rate in package.rates) {
    print('${rate.name} — $rate');
  }
}
await woo.selectShippingRate(packageId: 0, rateId: 'flat_rate:10');
await woo.applyCoupon('SAVE10');
```

### Money

Store API amounts arrive as integer minor units (`"8256"` = `$82.56`) with the
store's own formatting. They are modelled by `WooStoreMoney` /
`WooStoreCurrency`; `toString()` prints what the store would print.

```dart
print(cart.totals.totalPrice);        // $82.56
cart.totals.totalPrice.minorUnits;    // 8256
```

### Checkout

```dart
final result = await woo.checkout(
  billingAddress: address,
  paymentMethod: 'cod',
  expectedTotal: cart.totals.totalPrice,
);

if (result.paymentResult.needsRedirect) {
  // PayPal and friends finish off-site
} else if (result.isPaid) {
  // done
}
```

Pass `expectedTotal` and the store refuses a moved total with
`WooCommerceTotalMismatchException` (carrying the refreshed cart) instead of
charging a different amount. `checkoutAndClear` forgets the basket only when
the payment went through.

### Keeping the basket

The cart is identified by a `Cart-Token`. It lives in
`flutter_secure_storage` by default; pass your own `WooCartTokenStore` to the
constructor (or `InMemoryWooCartTokenStore` for pure-Dart use) to control it.
Use `woo.cartSession.adopt(token)` / `woo.cartSession.clear()`, and
`woo.storeDio` / `woo.requestStoreGet<...>` for Store API routes this package
does not wrap.

### New exceptions

- `WooCommerceTotalMismatchException` — checkout total moved; exposes `cart`.
- `WooCommerceCartException` — a Store API batch reported failed entries.

---

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

`login`/`register`/`forgotPassword`/`changePassword`, the notification API and
`LocalStorageHelper` are marked `@experimental`: they are not part of the
WooCommerce REST API and require a custom WordPress plugin. Core WooCommerce
endpoints (products, orders, customers, coupons, taxes, shipping, webhooks,
reports, settings, data, system status) are unaffected.

> As of v2.1, the cart is no longer experimental: it is backed by the public
> Store API. See the v2.0.x → v2.1.0 guide above.

## Custom endpoints

Use the request helpers on the client, which guarantee typed errors:

```dart
final response = await woo.requestGet<Map<String, dynamic>>(
  '/custom-endpoint',
  queryParameters: {'page': '1'},
);
```
