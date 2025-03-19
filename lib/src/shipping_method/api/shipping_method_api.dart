import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooShippingMethodApi on WooCommerce {
  /// Fetches all shipping methods
  Future<List<WooShippingMethod>> getShippingMethods({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooShippingMethod.fake);
    }

    final response = await dio.get(
      _ShippingMethodEndpoints.methods,
    );

    return (response.data as List)
        .map((e) => WooShippingMethod.fromJson(e))
        .toList();
  }

  /// Retrieves a specific shipping method
  Future<WooShippingMethod> getShippingMethod({
    required String id,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooShippingMethod.fake();
    }

    final response = await dio.get(
      _ShippingMethodEndpoints.singleMethod(id),
    );

    return WooShippingMethod.fromJson(response.data);
  }
}
