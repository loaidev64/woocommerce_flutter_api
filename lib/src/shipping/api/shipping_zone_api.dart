import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'shipping_zone_endpoints.dart';

/// WooCommerce Shipping Zone API Extension
///
/// This extension provides comprehensive shipping zone management capabilities for WooCommerce stores.
/// Shipping zones define geographical areas where specific shipping methods and rates apply,
/// enabling flexible shipping configurations for different regions and customer locations.
///
/// ## Shipping Zone Overview
///
/// Shipping zones are geographical areas that determine which shipping methods and rates
/// are available to customers based on their location. They provide a flexible way to
/// configure different shipping options for different regions, countries, or specific areas.
///
/// ## Key Features
///
/// - **Zone Management**: Create, update, and delete shipping zones
/// - **Geographical Control**: Define specific areas where zones apply
/// - **Method Assignment**: Associate shipping methods with zones
/// - **Priority Ordering**: Control the order in which zones are evaluated
/// - **Flexible Configuration**: Support for countries, states, postcodes, and continents
///
/// ## Shipping Zone Structure
///
/// A shipping zone consists of:
///
/// - **Zone Definition**: Name and priority order
/// - **Geographical Coverage**: Countries, states, or postcodes
/// - **Shipping Methods**: Available shipping options for the zone
/// - **Method Settings**: Configuration for each shipping method
///
/// ## Example Usage
///
/// ```dart
/// // Get all shipping zones
/// final zones = await wooCommerce.getShippingZones();
///
/// // Create a new shipping zone
/// final zone = WooShippingZone(
///   name: 'North America',
///   order: 1,
/// );
/// final createdZone = await wooCommerce.createShippingZone(zone);
///
/// // Update a shipping zone
/// zone.name = 'North America - Updated';
/// final updatedZone = await wooCommerce.updateShippingZone(zone);
///
/// // Delete a shipping zone
/// await wooCommerce.deleteShippingZone(zoneId);
/// ```
extension WooShippingZoneApi on WooCommerce {
  /// Retrieves all shipping zones from the WooCommerce store
  ///
  /// This method fetches a complete list of shipping zones configured in the store.
  /// It's particularly useful for displaying available shipping zones or managing
  /// zone configurations in administrative interfaces.
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooShippingZone>>` containing all available shipping zones
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all shipping zones
  /// final zones = await wooCommerce.getShippingZones();
  /// for (final zone in zones) {
  ///   print('Zone: ${zone.name} (Order: ${zone.order})');
  /// }
  /// ```
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

  /// Retrieves a specific shipping zone by its ID
  ///
  /// This method fetches detailed information about a single shipping zone
  /// identified by its unique ID. It's useful for getting specific zone details
  /// or validating zone existence.
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the shipping zone to retrieve
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingZone>` containing the shipping zone details
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific shipping zone
  /// final zone = await wooCommerce.getShippingZone(id: 1);
  /// print('Zone: ${zone.name}');
  /// print('Order: ${zone.order}');
  /// ```
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

  /// Creates a new shipping zone in the WooCommerce store
  ///
  /// This method allows you to create a new shipping zone with the specified
  /// configuration. The zone will be created with the provided name and order.
  ///
  /// ## Parameters
  ///
  /// * [zone] - The shipping zone object containing all configuration details
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingZone>` containing the created shipping zone with assigned ID
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a new shipping zone
  /// final zone = WooShippingZone(
  ///   name: 'North America',
  ///   order: 1,
  /// );
  /// final createdZone = await wooCommerce.createShippingZone(zone);
  /// print('Created zone with ID: ${createdZone.id}');
  /// ```
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

  /// Updates an existing shipping zone in the WooCommerce store
  ///
  /// This method allows you to modify shipping zone configuration, including
  /// name and order. The zone must have a valid ID.
  ///
  /// ## Parameters
  ///
  /// * [zone] - The shipping zone object with updated configuration
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingZone>` containing the updated shipping zone
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update shipping zone name
  /// zone.name = 'North America - Updated';
  /// final updatedZone = await wooCommerce.updateShippingZone(zone);
  /// print('Updated zone: ${updatedZone.name}');
  /// ```
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

  /// Deletes a shipping zone from the WooCommerce store
  ///
  /// This method permanently removes a shipping zone and all its associated
  /// data. Use with caution as this action cannot be undone.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone to delete
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Delete a shipping zone
  /// await wooCommerce.deleteShippingZone(zoneId);
  /// print('Shipping zone deleted successfully');
  /// ```
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
