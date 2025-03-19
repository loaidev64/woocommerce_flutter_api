part of 'shipping_zone_api.dart';

abstract class _ShippingZoneEndpoints {
  static String get zones => '/shipping/zones';
  static String singleZone(int id) => '/shipping/zones/$id';
}