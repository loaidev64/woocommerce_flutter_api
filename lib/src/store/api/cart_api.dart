import '../../exceptions/woocommerce_exception.dart';
import '../models/models.dart';
import '../../woocommerce_flutter_api_base.dart';

part 'cart_endpoints.dart';

extension WooStoreCartApi on WooCommerce {
  Future<WooStoreCart> getCart({bool? useFaker}) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStoreGet<Map<String, dynamic>>(
      _StoreCartEndpoints.cart,
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> addToCart({
    required int id,
    int quantity = 1,
    Map<String, String>? variation,
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.addItem,
      data: <String, dynamic>{
        'id': id,
        'quantity': quantity,
        if (variation != null && variation.isNotEmpty)
          'variation': <Object?>[
            for (final entry in variation.entries)
              <String, dynamic>{'attribute': entry.key, 'value': entry.value},
          ],
      },
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> updateCartItem({
    required String key,
    required int quantity,
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.updateItem,
      data: <String, dynamic>{'key': key, 'quantity': quantity},
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> removeCartItem(String key, {bool? useFaker}) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.removeItem,
      data: <String, dynamic>{'key': key},
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> clearCart({bool? useFaker}) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final current = await getCart(useFaker: false);
    if (current.isEmpty) return current;
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.batch,
      data: <String, dynamic>{
        'requests': <Object?>[
          for (final item in current.items)
            <String, dynamic>{
              'path': '$storeApiPath${_StoreCartEndpoints.removeItem}',
              'method': 'POST',
              'cache': 'no-store',
              'body': <String, dynamic>{'key': item.key},
            },
        ],
      },
    );
    _throwIfAnyFailed(_responses(response.data), 'remove');
    return getCart(useFaker: false);
  }

  Future<WooStoreCart> applyCoupon(String code, {bool? useFaker}) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.applyCoupon,
      data: <String, dynamic>{'code': code.toLowerCase()},
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> removeCoupon(String code, {bool? useFaker}) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.removeCoupon,
      data: <String, dynamic>{'code': code.toLowerCase()},
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> updateCartCustomer({
    WooStoreAddress? billingAddress,
    WooStoreAddress? shippingAddress,
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.updateCustomer,
      data: <String, dynamic>{
        if (billingAddress != null) 'billing_address': billingAddress.toJson(),
        if (shippingAddress != null)
          'shipping_address': shippingAddress.toJson(),
      },
    );
    return _parseCart(response.data);
  }

  Future<WooStoreCart> selectShippingRate({
    required int packageId,
    required String rateId,
    bool? useFaker,
  }) async {
    final faking = useFaker ?? this.useFaker;
    if (faking) return WooStoreCart.fake();
    final response = await requestStorePost<Map<String, dynamic>>(
      _StoreCartEndpoints.selectShippingRate,
      data: <String, dynamic>{'package_id': packageId, 'rate_id': rateId},
    );
    return _parseCart(response.data);
  }

  WooStoreCart _parseCart(Map<String, dynamic>? data) {
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a cart object but the response body was empty',
        path: _StoreCartEndpoints.cart,
      );
    }
    return WooStoreCart.fromJson(data);
  }

  List<Map<String, dynamic>> _responses(Map<String, dynamic>? data) =>
      <Map<String, dynamic>>[
        for (final entry in (data?['responses'] as List?) ?? const [])
          if (entry is Map<String, dynamic>) entry,
      ];

  void _throwIfAnyFailed(List<Map<String, dynamic>> responses, String verb) {
    final failed = <Map<String, dynamic>>[
      for (final response in responses)
        if (_statusOf(response) >= 400) response,
    ];
    if (failed.isEmpty) return;
    final why = failed.map((response) {
      final body = response['body'];
      final message = body is Map<String, dynamic> ? body['message'] : null;
      return message is String && message.isNotEmpty
          ? message
          : 'HTTP ${response['status']}';
    }).join('; ');
    throw WooCommerceCartException(
      message: 'The store refused to $verb ${failed.length} of '
          '${responses.length} items: $why',
      code: 'woocommerce_rest_batch_partial_failure',
      failures: failed,
    );
  }

  int _statusOf(Map<String, dynamic> response) {
    final status = response['status'];
    if (status is num) return status.toInt();
    if (status is String) return int.tryParse(status) ?? 200;
    return 200;
  }
}
