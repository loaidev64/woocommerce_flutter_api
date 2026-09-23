import '../../base/models/woo_delete_result.dart';
import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/models.dart';
import '../models/shipping_zone.dart';
part 'shipping_zone_endpoints.dart';

extension WooShippingZoneApi on WooCommerce {
  Future<List<WooShippingZone>> getShippingZones({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooShippingZone.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_ShippingZoneEndpoints.zones);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooShippingZone.fromJson)
            .toList() ??
        [];
  }

  Future<WooShippingZone> getShippingZone(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooShippingZone.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ShippingZoneEndpoints.singleZone(id),
    );
    return WooShippingZone.fromJson(response.data!);
  }

  Future<WooShippingZone> createShippingZone(
    WooShippingZone zone, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return zone;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ShippingZoneEndpoints.zones,
      data: zone.toJson(),
    );
    return WooShippingZone.fromJson(response.data!);
  }

  Future<WooShippingZone> updateShippingZone(
    int id,
    WooShippingZone zone, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return zone;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ShippingZoneEndpoints.singleZone(id),
      data: zone.toJson(),
    );
    return WooShippingZone.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteShippingZone(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ShippingZoneEndpoints.singleZone(id),
      queryParameters: const {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }
}
