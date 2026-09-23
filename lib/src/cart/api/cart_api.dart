import 'package:meta/meta.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../helpers/local_storage_helper.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../../woocommerce_flutter_api_base.dart';
part 'endpoints.dart';

extension WooCartApi on WooCommerce {
  @experimental
  Future<WooCart> getCart({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCart.fake();
    }
    final userId = await LocalStorageHelper.getSecurityUserId();
    final response = await requestGet<Map<String, dynamic>>(
      _CartEndpoints.cart,
      queryParameters: {
        if (userId != null) 'user_id': userId,
      },
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a cart object but the response body was empty',
        statusCode: response.statusCode,
        path: _CartEndpoints.cart,
      );
    }
    return WooCart.fromJson(data);
  }

  @experimental
  Future<WooCart> updateCart(
    List<WooCartItem> items, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCart.fake();
    }
    final userId = await LocalStorageHelper.getSecurityUserId();
    final response = await requestPost<Map<String, dynamic>>(
      _CartEndpoints.cart,
      data: {
        'products': items.map((item) => item.toJson()).toList(),
        if (userId != null) 'user_id': userId,
      },
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a cart object but the response body was empty',
        statusCode: response.statusCode,
        path: _CartEndpoints.cart,
      );
    }
    return WooCart.fromJson(data);
  }
}
