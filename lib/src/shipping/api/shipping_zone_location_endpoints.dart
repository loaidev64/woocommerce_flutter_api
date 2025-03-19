part of 'shipping_zone_location_api.dart';

abstract class _ShippingZoneLocationEndpoints {
  static String zoneLocations(int zoneId) => '/shipping/zones/$zoneId/locations';
}