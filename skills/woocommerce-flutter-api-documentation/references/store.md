# cart & checkout (Store API)

Cart and checkout use WooCommerce's public **Store API** at
`/wp-json/wc/store/v1`. These calls need **no consumer key**; a cart is
identified by a `Cart-Token` the store issues on the first request, which the
client stores and replays. The `WooCommerce` constructor still requires
`consumerKey`/`consumerSecret` for the rest of the API.

> **Requires WooCommerce 8.0+.** The Store API shipped with WooCommerce Blocks
> and was merged into core in 8.0. This is unrelated to the package version.

Official reference: https://developer.woocommerce.com/docs/apis/store-api/

## Client members

- `String storeApiPath` — where the Store API lives (default
  `/wp-json/wc/store/v1`); overridable via the constructor.
- `WooCartTokenStore? cartTokenStore` — constructor parameter controlling where
  the `Cart-Token` is persisted.
- `WooCartSession cartSession` — token bookkeeping: `cartToken`, `nonce`,
  `adopt(token)`, `clear()`.
- `Dio storeDio` — the credential-free Dio for the Store API.
- `requestStoreGet<T>`, `requestStorePost<T>`, `requestStorePut<T>`,
  `requestStoreDelete<T>` — typed helpers that inject/absorb the `Cart-Token`
  and `Nonce` headers.

## extension WooStoreCartApi on WooCommerce

### Future<WooStoreCart> getCart({ bool? useFaker })

The current cart. The first call creates a cart and takes a `Cart-Token`.

### Future<WooStoreCart> addToCart({ required int id, int quantity = 1, Map<String, String>? variation, bool? useFaker })

Adds a product or variation. For a variable product, `id` is the
**variation's** id and `variation` keys are attribute names as the store
spells them (`pa_` taxonomy for global attributes, the name for
product-specific ones; case sensitive). Sent on the wire as a list of
`{attribute, value}` pairs.

### Future<WooStoreCart> updateCartItem({ required String key, required int quantity, bool? useFaker })

Changes a line's quantity. `key` is `WooStoreCartItem.key` (not a product id).

### Future<WooStoreCart> removeCartItem(String key, { bool? useFaker })

Removes a line by key.

### Future<WooStoreCart> clearCart({ bool? useFaker })

Empties the cart. The Store API has no "empty cart" route, so this removes
every line in one `/batch` request.

### Future<WooStoreCart> applyCoupon(String code, { bool? useFaker })

Applies a coupon. The code is lowercased (WooCommerce stores them so). Throws
`WooCommerceValidationException` with the shopper-facing `message` when the
store rejects it.

### Future<WooStoreCart> removeCoupon(String code, { bool? useFaker })

Removes a coupon (lowercased).

### Future<WooStoreCart> updateCartCustomer({ WooStoreAddress? billingAddress, WooStoreAddress? shippingAddress, bool? useFaker })

Sets addresses. A country and postcode are enough to make shipping quotes
appear (`shippingPackages` populated, `hasCalculatedShipping` true).

### Future<WooStoreCart> selectShippingRate({ required int packageId, required String rateId, bool? useFaker })

Chooses a rate for a package (`WooStoreShippingPackage.packageId`,
`WooStoreShippingRate.rateId`).

## extension WooStoreCheckoutApi on WooCommerce

### Future<WooStoreCheckout> getCheckout({ bool? useFaker })

The draft order built from the cart. Creates a `checkout-draft` order on the
store, so call it on the checkout screen, not on every cart change.

### Future<WooStoreCheckout> updateCheckout({ String? paymentMethod, String? orderNotes, Map<String, dynamic>? additionalFields, bool recalculateTotals = true, bool? useFaker })

Saves checkout fields without paying. Sends
`?__experimental_calc_totals=true` by default.

### Future<WooStoreCheckout> checkout({ required WooStoreAddress billingAddress, required String paymentMethod, WooStoreAddress? shippingAddress, String? customerNote, Map<String, dynamic>? paymentData, WooStoreMoney? expectedTotal, bool createAccount = false, String? customerPassword, Map<String, dynamic>? additionalFields, Map<String, dynamic> extensions = const {}, bool? useFaker })

Places the order and attempts payment. `shippingAddress` defaults to
`billingAddress`. `paymentData` is sent as `{key, value}` pairs. When
`expectedTotal` is set and the total moved, throws
`WooCommerceTotalMismatchException` (nothing charged; `.cart` has the
refreshed cart).

### Future<WooStoreCheckout> payOrder(int orderId, { required String paymentMethod, Map<String, dynamic>? paymentData, bool? useFaker })

Retries payment on an order created but not paid (`POST /checkout/{id}`).

### Future<WooStoreCheckout> checkoutAndClear({ ... same as checkout ... })

Calls `checkout`, then `cartSession.clear()` **only when**
`WooStoreCheckout.isPaid` — a declined card leaves the basket intact.

## Money

### class WooStoreCurrency

`code`, `symbol`, `minorUnit`, `decimalSeparator`, `thousandSeparator`,
`prefix`, `suffix`; `format(int minorUnits)`, `fromJson`, `toJson`,
`copyWith`, `fake()`.

### class WooStoreMoney implements Comparable<WooStoreMoney>

`WooStoreMoney(int minorUnits, WooStoreCurrency currency)`;
`WooStoreMoney.read(Map json, String field, [WooStoreCurrency? currency])`.
Fields: `minorUnits`, `currency`; getters `amount` (double), `isZero`.
Operators `+ - * < <= > >=`, `compareTo`. `toString()` prints the store's
format (`$82.56`). `fake()`.

## Cart models

### class WooStoreCart

Fields: `items` (`List<WooStoreCartItem>`), `coupons`
(`List<WooStoreCartCoupon>`), `totals` (`WooStoreCartTotals`),
`billingAddress`/`shippingAddress` (`WooStoreAddress`), `shippingPackages`
(`List<WooStoreShippingPackage>`), `itemsCount`, `itemsWeight`, `needsPayment`,
`needsShipping`, `hasCalculatedShipping`, `paymentMethods` (`List<String>`),
`errors` (`List<WooStoreCartError>`). Getters: `isEmpty`, `isNotEmpty`,
`hasErrors`, `itemFor(int productId)`. `fromJson`, `toJson`, `fake()`.

### class WooStoreCartItem

Fields: `key`, `id`, `quantity`, `name`, `sku`, `permalink`,
`shortDescription`, `price`/`regularPrice`/`salePrice`/`lineSubtotal`/
`lineTotal` (`WooStoreMoney`), `images`, `limits`
(`WooStoreQuantityLimits`), `variation` (`Map<String, String>`),
`lowStockRemaining`, `backordersAllowed`, `soldIndividually`. Getters:
`onSale`, `image`. `fromJson`, `toJson`, `copyWith`, `fake()`.

### class WooStoreCartTotals

`currency`, `totalItems`, `totalItemsTax`, `totalFees`, `totalDiscount`,
`totalShipping`, `totalShippingTax`, `totalTax`, `totalPrice` (all
`WooStoreMoney`). `fromJson`, `toJson`, `fake()`.

### class WooStoreCartCoupon

`code`, `discountType`, `totalDiscount`, `totalDiscountTax`.

### class WooStoreCartError

`code`, `message`; arrives inside a successful response. `WooStoreCart.hasErrors`.

### class WooStoreQuantityLimits

`minimum`, `maximum`, `multipleOf`, `editable`; `clamp(int wanted)` respects
`multipleOf`.

### class WooStoreImage

`id`, `src`, `thumbnail`, `srcset`, `sizes`, `name`, `alt`.

### class WooStoreShippingPackage

`packageId`, `name`, `destination` (`WooStoreAddress?`), `itemNames`, `rates`;
getter `selected`.

### class WooStoreShippingRate

`rateId`, `name`, `description`, `deliveryTime`, `price`, `taxes`, `methodId`,
`instanceId`, `selected`; getter `isFree`.

## Address

### class WooStoreAddress

`firstName`, `lastName`, `company`, `address1`, `address2`, `city`, `state`,
`postcode`, `country`, `email`, `phone`. Getters `fullName`, `isEmpty`.
`fromJson`, `toJson` (sends empty fields; omits empty email/phone), `copyWith`,
`fake()`.

## Checkout models

### class WooStoreCheckout

`orderId`, `status`, `orderKey`, `customerId`, `customerNote`, `paymentMethod`,
`billingAddress`, `shippingAddress`, `paymentResult`
(`WooStorePaymentResult`), `additionalFields`. Getter `isPaid`;
`receivedUrl(String baseUrl)` builds the guest order-received URL.

### class WooStorePaymentResult

`status` (`WooStorePaymentStatus`), `redirectUrl`, `details`, `message`.
Getters `needsRedirect`, `isPaid`.

### enum WooStorePaymentStatus

`success`, `failure`, `pending`, `error`, `unknown`; `parse(String?)`.

## Session

### abstract interface class WooCartTokenStore

`Future<String?> read()`, `Future<void> write(String? token)`.

### class InMemoryWooCartTokenStore

Process-lifetime token. For tests and pure-Dart/server use.

### class SecureStorageWooCartTokenStore

Default. Stores the token in `flutter_secure_storage` under
`woocommerce_cart_token` (`defaultKey`).

### class WooCartSession

`cartToken`, `nonce`, `adopt(token)`, `clear()`. Managed automatically by the
client.

## Exceptions

- `WooCommerceTotalMismatchException` — checkout with `expectedTotal` where
  the total moved; exposes `cart` (`Map<String, dynamic>?`).
- `WooCommerceCartException` — a Store API batch reported failed entries;
  exposes `failures`.
