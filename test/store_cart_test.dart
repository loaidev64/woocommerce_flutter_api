import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

import 'store_fakes.dart';

void main() {
  WooCommerce storeFor(FakeStoreApi api, {WooCartTokenStore? tokens}) =>
      WooCommerce(
        baseUrl: 'https://shop.test',
        consumerKey: 'ck_test',
        consumerSecret: 'cs_test',
        interceptors: <Interceptor>[api],
        cartTokenStore: tokens ?? InMemoryWooCartTokenStore(),
      );

  group('the Store API transport', () {
    test('uses the public route and sends no consumer credentials', () async {
      final api = FakeStoreApi(reply: (_) => cartJson());
      final woo = storeFor(api);

      await woo.getCart();

      expect(api.lastUri.path, '/wp-json/wc/store/v1/cart');
      expect(api.lastUri.queryParameters.containsKey('consumer_key'), isFalse);
      expect(api.calls.last.headers.containsKey('Authorization'), isFalse);
    });

    test('requests are not sent by the admin client', () async {
      final api = FakeStoreApi(reply: (_) => cartJson());
      final woo = storeFor(api);

      await woo.getCart();

      expect(woo.storeDio.options.baseUrl,
          'https://shop.test/wp-json/wc/store/v1');
      expect(woo.dio.options.baseUrl, 'https://shop.test/wp-json/wc/v3');
    });
  });

  group('the cart token', () {
    test('is taken from the first response and sent on the next', () async {
      final api = FakeStoreApi(reply: (_) => cartJson());
      final woo = storeFor(api);

      await woo.getCart();
      expect(
        api.calls.first.headers.containsKey('Cart-Token'),
        isFalse,
        reason: 'there is no cart yet on the first call',
      );

      await woo.getCart();
      expect(api.lastSentToken, 'cart-token-1');
      expect(await woo.cartSession.cartToken, 'cart-token-1');
    });

    test('a rotated token replaces the old one', () async {
      final woo = storeFor(FakeStoreApi(reply: (_) => cartJson()));
      await woo.cartSession.adopt('old');
      await woo.cartSession.absorb(<String, String>{'cart-token': 'new'});
      expect(await woo.cartSession.cartToken, 'new');
    });

    test('survives into a client built later, given a persistent store',
        () async {
      final tokens = InMemoryWooCartTokenStore();
      final api = FakeStoreApi(reply: (_) => cartJson());

      final first = storeFor(api, tokens: tokens);
      await first.getCart();

      final second = storeFor(api, tokens: tokens);
      await second.getCart();
      expect(api.lastSentToken, 'cart-token-1');
    });

    test('clearing forgets the cart', () async {
      final api = FakeStoreApi(reply: (_) => cartJson());
      final woo = storeFor(api);

      await woo.getCart();
      await woo.cartSession.clear();
      expect(await woo.cartSession.cartToken, isNull);

      await woo.getCart();
      expect(api.calls.last.headers.containsKey('Cart-Token'), isFalse);
    });
  });

  group('reading a cart', () {
    late WooStoreCart cart;

    setUp(() async {
      cart = await storeFor(FakeStoreApi(reply: (_) => cartJson())).getCart();
    });

    test('prices come out as the store would print them', () {
      expect(cart.totals.totalPrice.toString(), r'$82.56');
      expect(cart.totals.totalDiscount.toString(), r'$10.95');
      expect(cart.items.single.price.toString(), r'$18.00');
    });

    test('reads the line', () {
      final item = cart.items.single;
      expect(item.key, 'a5771bce93e200c36f7cd9dfd0e5deaa');
      expect(item.id, 38);
      expect(item.name, 'Beanie with Logo');
      expect(item.onSale, isTrue);
      expect(item.variation, <String, String>{'pa_colour': 'blue'});
      expect(item.image?.thumbnail, endsWith('450x450.jpg'));
    });

    test('quantity limits know about multiples', () {
      final limits = cart.items.single.limits;
      expect(limits.clamp(3), 4);
      expect(limits.clamp(99), 12);
      expect(limits.clamp(0), 1);
    });

    test('shipping packages carry their rates and which is chosen', () {
      final package = cart.shippingPackages.single;
      expect(package.rates, hasLength(2));
      expect(package.selected?.rateId, 'flat_rate:10');
      expect(package.selected?.price.toString(), r'$13.00');
      expect(package.rates.last.isFree, isTrue);
    });

    test('addresses parse', () {
      expect(cart.billingAddress.fullName, 'John Doe');
      expect(cart.billingAddress.email, 'john@example.com');
      expect(cart.shippingAddress.email, isEmpty);
      expect(cart.shippingAddress.isEmpty, isFalse);
    });

    test('the badge number and payment methods are there', () {
      expect(cart.itemsCount, 1);
      expect(cart.paymentMethods, <String>['cod', 'bacs']);
      expect(cart.needsShipping, isTrue);
      expect(cart.isNotEmpty, isTrue);
    });

    test('a line is findable by product id', () {
      expect(cart.itemFor(38)?.name, 'Beanie with Logo');
      expect(cart.itemFor(999), isNull);
    });
  });

  test('cart errors arrive inside a successful response', () async {
    final api = FakeStoreApi(
      reply: (_) => cartJson(errors: <Object?>[
        <String, dynamic>{
          'code': 'woocommerce_rest_product_partially_out_of_stock',
          'message': 'Beanie with Logo has only 2 left.',
        },
      ]),
    );
    final cart = await storeFor(api).getCart();
    expect(cart.hasErrors, isTrue);
    expect(cart.errors.single.message, contains('only 2 left'));
  });

  group('changing a cart', () {
    late FakeStoreApi api;
    late WooCommerce woo;

    setUp(() {
      api = FakeStoreApi(reply: (_) => cartJson());
      woo = storeFor(api);
    });

    test('addToCart sends id and quantity', () async {
      await woo.addToCart(id: 38, quantity: 2);
      expect(api.lastUri.path, endsWith('/cart/add-item'));
      expect(api.calls.last.method, 'POST');
      expect(api.lastBody, <String, dynamic>{'id': 38, 'quantity': 2});
    });

    test('a variation is sent as attribute/value pairs, not a map', () async {
      await woo.addToCart(
        id: 815,
        variation: <String, String>{'pa_colour': 'blue', 'Size': 'Large'},
      );
      expect(api.lastBody['variation'], <Object?>[
        <String, dynamic>{'attribute': 'pa_colour', 'value': 'blue'},
        <String, dynamic>{'attribute': 'Size', 'value': 'Large'},
      ]);
    });

    test('updateCartItem and removeCartItem address the line key', () async {
      await woo.updateCartItem(key: 'abc', quantity: 4);
      expect(api.lastBody, <String, dynamic>{'key': 'abc', 'quantity': 4});

      await woo.removeCartItem('abc');
      expect(api.lastUri.path, endsWith('/cart/remove-item'));
      expect(api.lastBody, <String, dynamic>{'key': 'abc'});
    });

    test('coupon codes are lowercased, because WooCommerce stores them so',
        () async {
      await woo.applyCoupon('SAVE10');
      expect(api.lastBody, <String, dynamic>{'code': 'save10'});
      await woo.removeCoupon('SAVE10');
      expect(api.lastBody, <String, dynamic>{'code': 'save10'});
    });

    test('updateCartCustomer sends the whole address, empty fields included',
        () async {
      await woo.updateCartCustomer(
        shippingAddress: const WooStoreAddress(
          postcode: 'N1 7GU',
          country: 'GB',
        ),
      );
      final sent = api.lastBody['shipping_address'] as Map;
      expect(sent['postcode'], 'N1 7GU');
      expect(sent['country'], 'GB');
      expect(sent['address_2'], '');
      expect(sent.containsKey('email'), isFalse);
    });

    test('selectShippingRate names the package and the rate', () async {
      await woo.selectShippingRate(packageId: 0, rateId: 'free_shipping:11');
      expect(api.lastBody, <String, dynamic>{
        'package_id': 0,
        'rate_id': 'free_shipping:11',
      });
    });
  });

  test('clearCart removes every line in one batch request', () async {
    final api = FakeStoreApi(
      reply: (options) => options.uri.path.endsWith('/batch')
          ? <String, dynamic>{'responses': <Object?>[]}
          : cartJson(quantity: 3),
    );
    final woo = storeFor(api);

    await woo.clearCart();

    final batch = api.calls.firstWhere(
      (call) => call.uri.path.endsWith('/batch'),
    );
    final requests = (batch.data as Map)['requests'] as List;
    final request = requests.single as Map;
    expect(request['path'], '/wp-json/wc/store/v1/cart/remove-item');
    expect(request['method'], 'POST');
    expect((request['body'] as Map)['key'], 'a5771bce93e200c36f7cd9dfd0e5deaa');
  });

  test('clearCart reports a failed batch instead of hiding it', () async {
    final api = FakeStoreApi(
      reply: (options) => options.uri.path.endsWith('/batch')
          ? <String, dynamic>{
              'responses': <Object?>[
                <String, dynamic>{
                  'status': 400,
                  'body': <String, dynamic>{'message': 'No such item.'},
                },
              ],
            }
          : cartJson(),
    );
    final woo = storeFor(api);

    expect(woo.clearCart(), throwsA(isA<WooCommerceCartException>()));
  });
}
