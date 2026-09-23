import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/models.dart';
import '../models/shipping_zone_location.dart';
part 'shipping_zone_location_endpoints.dart';

extension WooShippingZoneLocationApi on WooCommerce {
  Future<List<WooShippingZoneLocation>> getShippingZoneLocations({
    required int zoneId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooShippingZoneLocation.fake);
    }
    final response = await requestGet<List<dynamic>>(
      _ShippingZoneLocationEndpoints.zoneLocations(zoneId),
    );
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooShippingZoneLocation.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooShippingZoneLocation>> updateShippingZoneLocations({
    required int zoneId,
    required List<WooShippingZoneLocation> locations,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return locations;
    }
    final response = await requestPut<List<dynamic>>(
      _ShippingZoneLocationEndpoints.zoneLocations(zoneId),
      data: locations.map((e) => e.toJson()).toList(),
    );
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooShippingZoneLocation.fromJson)
            .toList() ??
        [];
  }
}
