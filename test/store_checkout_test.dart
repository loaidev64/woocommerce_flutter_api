import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

import 'store_fakes.dart';

void main() {
  const ada = WooStoreAddress(
    firstName: 'Ada',
    lastName: 'Lovelace',
    address1: '12 Analytical Way',
    city: 'London',
    postcode: 'N1 7GU',
    country: 'GB',
    email: 'ada@example.com',
  );

  WooCommerce storeFor(FakeStoreApi api) => WooCommerce(
        baseUrl: 'https://shop.test',
        consumerKey: 'ck_test',
        consumerSecret: 'cs_test',
        interceptors: <Interceptor>[api],
        cartTokenStore: InMemoryWooCartTokenStore(),
      );

  test('the draft order is readable before paying', () async {
    final woo = storeFor(FakeStoreApi(reply: (_) => checkoutJson()));
    final draft = await woo.getCheckout();
    expect(draft.orderId, 146);
    expect(draft.status, 'checkout-draft');
    expect(draft.isPaid, isFalse);
    expect(draft.billingAddress.fullName, 'Ada Lovelace');
  });

  test('checkout sends both addresses and the payment method', () async {
    final api = FakeStoreApi(
      reply: (_) =>
          checkoutJson(status: 'processing', paymentStatus: 'success'),
    );
    final woo = storeFor(api);

    final result = await woo.checkout(
      billingAddress: ada,
      paymentMethod: 'cod',
    );

    expect(api.calls.last.method, 'POST');
    expect(api.lastUri.path, endsWith('/checkout'));
    expect(api.lastBody['payment_method'], 'cod');
    // Shipping defaults to billing rather than being left blank.
    final shipping = api.lastBody['shipping_address'] as Map;
    expect(shipping['postcode'], 'N1 7GU');
    expect(result.isPaid, isTrue);
  });

  test('payment data goes as key/value pairs, not an object', () async {
    final api = FakeStoreApi(reply: (_) => checkoutJson());
    await storeFor(api).checkout(
      billingAddress: ada,
      paymentMethod: 'stripe',
      paymentData: const <String, dynamic>{'stripe_source': 'src_123'},
    );
    expect(api.lastBody['payment_data'], <Object?>[
      <String, dynamic>{'key': 'stripe_source', 'value': 'src_123'},
    ]);
  });

  test('expectedTotal is sent in minor units', () async {
    final api = FakeStoreApi(reply: (_) => checkoutJson());
    await storeFor(api).checkout(
      billingAddress: ada,
      paymentMethod: 'cod',
      expectedTotal: const WooStoreMoney(8256, WooStoreCurrency(code: 'USD')),
    );
    // "8256", not "82.56" — sending the decimal would never match.
    expect(api.lastBody['expected_total'], '8256');
  });

  test('a moved total is its own exception, and carries the new cart',
      () async {
    final api = FakeStoreApi(
      reply: (options) => wooStoreError(
        options,
        409,
        'woocommerce_rest_checkout_total_mismatch',
        'The cart has been updated since you last viewed it.',
        data: <String, dynamic>{'cart': cartJson(totalPrice: '9000')},
      ),
    );

    try {
      await storeFor(api).checkout(
        billingAddress: ada,
        paymentMethod: 'cod',
        expectedTotal: const WooStoreMoney(8256, WooStoreCurrency()),
      );
      fail('should have thrown');
    } on WooCommerceTotalMismatchException catch (e) {
      final fresh = e.cart == null ? null : WooStoreCart.fromJson(e.cart!);
      expect(fresh?.totals.totalPrice.toString(), r'$90.00');
    }
  });

  test('an off-site gateway says so instead of pretending it is done',
      () async {
    final api = FakeStoreApi(
      reply: (_) => checkoutJson(
        paymentStatus: 'pending',
        redirectUrl: 'https://paypal.test/pay/abc',
      ),
    );

    final result = await storeFor(api).checkout(
      billingAddress: ada,
      paymentMethod: 'paypal',
    );

    expect(result.paymentResult.status, WooStorePaymentStatus.pending);
    expect(result.paymentResult.needsRedirect, isTrue);
    expect(result.isPaid, isFalse, reason: 'not paid until they come back');
  });

  test('a declined card is a failure, not an exception', () async {
    final api = FakeStoreApi(
      reply: (_) => checkoutJson(paymentStatus: 'failure'),
    );
    final result = await storeFor(api).checkout(
      billingAddress: ada,
      paymentMethod: 'stripe',
    );
    expect(result.paymentResult.status, WooStorePaymentStatus.failure);
    expect(result.orderId, 146);
  });

  test('checkoutAndClear forgets the cart only when paid', () async {
    var status = 'failure';
    final api = FakeStoreApi(
      reply: (options) => options.uri.path.endsWith('/checkout')
          ? checkoutJson(paymentStatus: status)
          : cartJson(),
    );
    final woo = storeFor(api);

    await woo.getCart();
    expect(await woo.cartSession.cartToken, isNotNull);

    await woo.checkoutAndClear(billingAddress: ada, paymentMethod: 'stripe');
    expect(
      await woo.cartSession.cartToken,
      isNotNull,
      reason: 'a declined card must leave the basket alone',
    );

    status = 'success';
    await woo.checkoutAndClear(billingAddress: ada, paymentMethod: 'stripe');
    expect(await woo.cartSession.cartToken, isNull);
  });

  test('an unpaid order can be paid again at its own route', () async {
    final api = FakeStoreApi(
      reply: (_) => checkoutJson(paymentStatus: 'success'),
    );
    await storeFor(api).payOrder(146, paymentMethod: 'bacs');
    expect(api.lastUri.path, endsWith('/checkout/146'));
    expect(api.lastBody['payment_method'], 'bacs');
  });

  test('updateCheckout persists a field without paying', () async {
    final api = FakeStoreApi(reply: (_) => checkoutJson());
    await storeFor(api).updateCheckout(
      paymentMethod: 'cod',
      orderNotes: 'Ring bell',
    );
    expect(api.calls.last.method, 'PUT');
    expect(api.lastUri.queryParameters['__experimental_calc_totals'], 'true');
    expect(api.lastBody['order_notes'], 'Ring bell');
  });
}
