import '../../base/models/woo_delete_result.dart';
import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/models.dart';
import '../models/shipping_zone_method.dart';
part 'shipping_zone_method_endpoints.dart';

extension WooShippingZoneMethodApi on WooCommerce {
  Future<List<WooShippingZoneMethod>> getShippingZoneMethods({
    required int zoneId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooShippingZoneMethod.fake);
    }
    final response = await requestGet<List<dynamic>>(
      _ShippingZoneMethodEndpoints.zoneMethods(zoneId),
    );
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooShippingZoneMethod.fromJson)
            .toList() ??
        [];
  }

  Future<WooShippingZoneMethod> getShippingZoneMethod({
    required int zoneId,
    required int instanceId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooShippingZoneMethod.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ShippingZoneMethodEndpoints.singleMethod(zoneId, instanceId),
    );
    return WooShippingZoneMethod.fromJson(response.data!);
  }

  Future<WooShippingZoneMethod> createShippingZoneMethod({
    required int zoneId,
    required WooShippingZoneMethod method,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return method;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ShippingZoneMethodEndpoints.zoneMethods(zoneId),
      data: method.toJson(),
    );
    return WooShippingZoneMethod.fromJson(response.data!);
  }

  Future<WooShippingZoneMethod> updateShippingZoneMethod({
    required int zoneId,
    required WooShippingZoneMethod method,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return method;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ShippingZoneMethodEndpoints.singleMethod(
        zoneId,
        method.instanceId!,
      ),
      data: method.toJson(),
    );
    return WooShippingZoneMethod.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteShippingZoneMethod({
    required int zoneId,
    required int instanceId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: instanceId, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ShippingZoneMethodEndpoints.singleMethod(zoneId, instanceId),
      queryParameters: const {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }
}
