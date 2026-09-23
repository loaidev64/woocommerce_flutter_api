part of 'shipping_zone_method_api.dart';

abstract class _ShippingZoneMethodEndpoints {
  static String zoneMethods(int zoneId) => '/shipping/zones/$zoneId/methods';

  static String singleMethod(int zoneId, int instanceId) =>
      '/shipping/zones/$zoneId/methods/$instanceId';
}
