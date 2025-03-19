import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'shipping_zone_location_endpoints.dart';

extension WooShippingZoneLocationApi on WooCommerce {
  /// Fetches all locations for a shipping zone
  Future<List<WooShippingZoneLocation>> getShippingZoneLocations({
    required int zoneId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooShippingZoneLocation.fake);
    }

    final response = await dio.get(
      _ShippingZoneLocationEndpoints.zoneLocations(zoneId),
    );

    return (response.data as List)
        .map((e) => WooShippingZoneLocation.fromJson(e))
        .toList();
  }

  /// Updates locations for a shipping zone
  Future<List<WooShippingZoneLocation>> updateShippingZoneLocations({
    required int zoneId,
    required List<WooShippingZoneLocation> locations,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return locations;
    }

    final response = await dio.put(
      _ShippingZoneLocationEndpoints.zoneLocations(zoneId),
      data: locations.map((e) => e.toJson()).toList(),
    );

    return (response.data as List)
        .map((e) => WooShippingZoneLocation.fromJson(e))
        .toList();
  }
}