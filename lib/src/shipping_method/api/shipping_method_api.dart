import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/models.dart';
import '../models/shipping_method.dart';
part 'endpoints.dart';

extension WooShippingMethodApi on WooCommerce {
  Future<List<WooShippingMethod>> getShippingMethods({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooShippingMethod.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ShippingMethodEndpoints.methods);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooShippingMethod.fromJson)
            .toList() ??
        [];
  }

  Future<WooShippingMethod> getShippingMethod(String id,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooShippingMethod.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ShippingMethodEndpoints.singleMethod(id),
    );
    return WooShippingMethod.fromJson(response.data!);
  }
}
