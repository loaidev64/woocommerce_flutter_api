import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'shipping_zone_method_endpoints.dart';

extension WooShippingZoneMethodApi on WooCommerce {
  /// Get all shipping methods for a zone
  Future<List<WooShippingZoneMethod>> getShippingZoneMethods({
    required int zoneId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooShippingZoneMethod.fake);
    }

    final response = await dio.get(
      _ShippingZoneMethodEndpoints.zoneMethods(zoneId),
    );

    return (response.data as List)
        .map((e) => WooShippingZoneMethod.fromJson(e))
        .toList();
  }

  /// Get a specific shipping method
  Future<WooShippingZoneMethod> getShippingZoneMethod({
    required int zoneId,
    required int methodId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooShippingZoneMethod.fake();
    }

    final response = await dio.get(
      _ShippingZoneMethodEndpoints.singleMethod(zoneId, methodId),
    );

    return WooShippingZoneMethod.fromJson(response.data);
  }

  /// Create a new shipping method
  Future<WooShippingZoneMethod> createShippingZoneMethod({
    required int zoneId,
    required WooShippingZoneMethod method,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return method;
    }

    final response = await dio.post(
      _ShippingZoneMethodEndpoints.zoneMethods(zoneId),
      data: method.toJson(),
    );

    return WooShippingZoneMethod.fromJson(response.data);
  }

  /// Update a shipping method
  Future<WooShippingZoneMethod> updateShippingZoneMethod({
    required int zoneId,
    required WooShippingZoneMethod method,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return method;
    }

    final response = await dio.put(
      _ShippingZoneMethodEndpoints.singleMethod(zoneId, method.instanceId!),
      data: method.toJson(),
    );

    return WooShippingZoneMethod.fromJson(response.data);
  }

  /// Delete a shipping method
  Future<void> deleteShippingZoneMethod({
    required int zoneId,
    required int methodId,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return;
    }

    await dio.delete(
      _ShippingZoneMethodEndpoints.singleMethod(zoneId, methodId),
      queryParameters: {
        'force': true,
      },
    );
  }
}