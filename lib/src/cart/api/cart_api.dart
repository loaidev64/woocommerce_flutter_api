import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooCartApi on WooCommerce {
  ///
  /// [useFaker], fakes the api request
  Future<WooCart> getCart({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCart.fake();
    }

    final response = await dio.get(_CartEndpoints.cart, queryParameters: {
      'user_id': await LocalStorageHelper.getSecurityUserId(),
    });

    return WooCart.fromJson(response.data as Map<String, dynamic>);
  }

  /// [items] the items of the cart
  /// if the item has a quantity equal to 0 then it will be deleted from the cart
  ///
  /// [useFaker], fakes the api request
  Future<WooCart> updateCart(List<WooCartItem> items, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCart.fake();
    }

    final response = await dio.post(_CartEndpoints.cart, data: {
      'products': items.map((item) => item.toJson()).toList(),
      'user_id': await LocalStorageHelper.getSecurityUserId(),
    });

    return WooCart.fromJson(response.data as Map<String, dynamic>);
  }
}
