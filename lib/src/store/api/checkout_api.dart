import '../../exceptions/woocommerce_exception.dart';
import '../models/models.dart';
import '../../woocommerce_flutter_api_base.dart';

part 'checkout_endpoints.dart';

extension WooStoreCheckoutApi on WooCommerce {
  Future<WooStoreCheckout> getCheckout({bool? useFaker}) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCheckout.fake();
    final response = await requestStoreGet<Map<String, dynamic>>(
      _StoreCheckoutEndpoints.checkout,
    );
    return _parseCheckout(response.data);
  }

  Future<WooStoreCheckout> updateCheckout({
    String? paymentMethod,
    String? orderNotes,
    Map<String, dynamic>? additionalFields,
    bool recalculateTotals = true,
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCheckout.fake();
    final response = await requestStorePut<Map<String, dynamic>>(
      _StoreCheckoutEndpoints.checkout,
      queryParameters: <String, dynamic>{
        if (recalculateTotals) '__experimental_calc_totals': true,
      },
      data: <String, dynamic>{
        if (paymentMethod != null) 'payment_method': paymentMethod,
        if (orderNotes != null) 'order_notes': orderNotes,
        if (additionalFields != null) 'additional_fields': additionalFields,
      },
    );
    return _parseCheckout(response.data);
  }

  Future<WooStoreCheckout> checkout({
    required WooStoreAddress billingAddress,
    required String paymentMethod,
    WooStoreAddress? shippingAddress,
    String? customerNote,
    Map<String, dynamic>? paymentData,
    WooStoreMoney? expectedTotal,
    bool createAccount = false,
    String? customerPassword,
    Map<String, dynamic>? additionalFields,
    Map<String, dynamic> extensions = const <String, dynamic>{},
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCheckout.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCheckoutEndpoints.checkout,
      data: <String, dynamic>{
        'billing_address': billingAddress.toJson(),
        'shipping_address': (shippingAddress ?? billingAddress).toJson(),
        'payment_method': paymentMethod,
        if (customerNote != null) 'customer_note': customerNote,
        if (paymentData != null)
          'payment_data': <Object?>[
            for (final entry in paymentData.entries)
              <String, dynamic>{'key': entry.key, 'value': entry.value},
          ],
        if (expectedTotal != null)
          'expected_total': '${expectedTotal.minorUnits}',
        if (createAccount) 'create_account': true,
        if (customerPassword != null) 'customer_password': customerPassword,
        if (additionalFields != null) 'additional_fields': additionalFields,
        if (extensions.isNotEmpty) 'extensions': extensions,
      },
    );
    return _parseCheckout(response.data);
  }

  Future<WooStoreCheckout> payOrder(
    int orderId, {
    required String paymentMethod,
    Map<String, dynamic>? paymentData,
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCheckout.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCheckoutEndpoints.singleOrder(orderId),
      data: <String, dynamic>{
        'payment_method': paymentMethod,
        if (paymentData != null)
          'payment_data': <Object?>[
            for (final entry in paymentData.entries)
              <String, dynamic>{'key': entry.key, 'value': entry.value},
          ],
      },
    );
    return _parseCheckout(response.data);
  }

  Future<WooStoreCheckout> checkoutAndClear({
    required WooStoreAddress billingAddress,
    required String paymentMethod,
    WooStoreAddress? shippingAddress,
    String? customerNote,
    Map<String, dynamic>? paymentData,
    WooStoreMoney? expectedTotal,
    bool createAccount = false,
    String? customerPassword,
    Map<String, dynamic>? additionalFields,
    Map<String, dynamic> extensions = const <String, dynamic>{},
    bool? useFaker,
  }) async {
    final result = await checkout(
      billingAddress: billingAddress,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      customerNote: customerNote,
      paymentData: paymentData,
      expectedTotal: expectedTotal,
      createAccount: createAccount,
      customerPassword: customerPassword,
      additionalFields: additionalFields,
      extensions: extensions,
      useFaker: useFaker,
    );
    if (result.isPaid) await cartSession.clear();
    return result;
  }

  WooStoreCheckout _parseCheckout(Map<String, dynamic>? data) {
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a checkout object but the response body was empty',
        path: _StoreCheckoutEndpoints.checkout,
      );
    }
    return WooStoreCheckout.fromJson(data);
  }
}
