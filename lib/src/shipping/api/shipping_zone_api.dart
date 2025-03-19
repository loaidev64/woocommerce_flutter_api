import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'shipping_zone_endpoints.dart';

extension WooShippingZoneApi on WooCommerce {
  /// Fetches all shipping zones
  Future<List<WooShippingZone>> getShippingZones({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooShippingZone.fake);
    }

    final response = await dio.get(
      _ShippingZoneEndpoints.zones,
    );

    return (response.data as List)
        .map((e) => WooShippingZone.fromJson(e))
        .toList();
  }

  /// Retrieves a specific shipping zone
  Future<WooShippingZone> getShippingZone({
    required int id,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooShippingZone.fake();
    }

    final response = await dio.get(
      _ShippingZoneEndpoints.singleZone(id),
    );

    return WooShippingZone.fromJson(response.data);
  }

  /// Creates a new shipping zone
  Future<WooShippingZone> createShippingZone(
    WooShippingZone zone, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return zone;
    }

    final response = await dio.post(
      _ShippingZoneEndpoints.zones,
      data: zone.toJson(),
    );

    return WooShippingZone.fromJson(response.data);
  }

  /// Updates a shipping zone
  Future<WooShippingZone> updateShippingZone(
    WooShippingZone zone, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return zone;
    }

    final response = await dio.put(
      _ShippingZoneEndpoints.singleZone(zone.id!),
      data: zone.toJson(),
    );

    return WooShippingZone.fromJson(response.data);
  }

  /// Deletes a shipping zone
  Future<void> deleteShippingZone(
    int zoneId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return;
    }

    await dio.delete(
      _ShippingZoneEndpoints.singleZone(zoneId),
      queryParameters: {
        'force': true,
      },
    );
  }
}