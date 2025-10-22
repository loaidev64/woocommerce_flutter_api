import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'shipping_zone_location_endpoints.dart';

/// WooCommerce Shipping Zone Location API Extension
///
/// This extension provides comprehensive shipping zone location management capabilities for WooCommerce stores.
/// Shipping zone locations define the geographical areas where a shipping zone applies,
/// enabling precise control over which customers can access specific shipping methods.
///
/// ## Shipping Zone Location Overview
///
/// Shipping zone locations specify the geographical coverage of a shipping zone.
/// They determine which customers are eligible for the shipping methods and rates
/// defined within that zone based on their location.
///
/// ## Key Features
///
/// - **Location Management**: Add, update, and remove locations from shipping zones
/// - **Geographical Control**: Support for countries, states, postcodes, and continents
/// - **Flexible Coverage**: Multiple location types can be combined in a single zone
/// - **Precise Targeting**: Target specific areas with postcode or state-level precision
///
/// ## Location Types
///
/// - **Country**: Entire countries (e.g., 'US', 'CA', 'GB')
/// - **State**: Specific states/provinces within countries
/// - **Postcode**: Specific postal codes or postal code ranges
/// - **Continent**: Entire continents (e.g., 'NA', 'EU', 'AS')
///
/// ## Example Usage
///
/// ```dart
/// // Get all locations for a shipping zone
/// final locations = await wooCommerce.getShippingZoneLocations(zoneId: 1);
///
/// // Update zone locations
/// final newLocations = [
///   WooShippingZoneLocation(code: 'US', type: 'country'),
///   WooShippingZoneLocation(code: 'CA', type: 'country'),
/// ];
/// final updatedLocations = await wooCommerce.updateShippingZoneLocations(
///   zoneId: 1,
///   locations: newLocations,
/// );
/// ```
extension WooShippingZoneLocationApi on WooCommerce {
  /// Retrieves all locations for a specific shipping zone
  ///
  /// This method fetches all geographical locations associated with a shipping zone.
  /// It's useful for understanding which areas are covered by a zone or for
  /// displaying zone coverage in administrative interfaces.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooShippingZoneLocation>>` containing all zone locations
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all locations for a shipping zone
  /// final locations = await wooCommerce.getShippingZoneLocations(zoneId: 1);
  /// for (final location in locations) {
  ///   print('${location.type}: ${location.code}');
  /// }
  /// ```
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

  /// Updates the locations for a shipping zone
  ///
  /// This method allows you to modify the geographical coverage of a shipping zone
  /// by updating its associated locations. This replaces all existing locations
  /// with the new set of locations provided.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [locations] - List of new locations to assign to the zone
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooShippingZoneLocation>>` containing the updated zone locations
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update zone locations
  /// final newLocations = [
  ///   WooShippingZoneLocation(code: 'US', type: 'country'),
  ///   WooShippingZoneLocation(code: 'CA', type: 'country'),
  /// ];
  /// final updatedLocations = await wooCommerce.updateShippingZoneLocations(
  ///   zoneId: 1,
  ///   locations: newLocations,
  /// );
  /// print('Updated ${updatedLocations.length} locations');
  /// ```
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
