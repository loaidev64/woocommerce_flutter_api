import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'shipping_zone_method_endpoints.dart';

/// WooCommerce Shipping Zone Method API Extension
///
/// This extension provides comprehensive shipping zone method management capabilities for WooCommerce stores.
/// Shipping zone methods define the specific shipping options available within a shipping zone,
/// including rates, settings, and delivery options for customers in that geographical area.
///
/// ## Shipping Zone Method Overview
///
/// Shipping zone methods are the actual shipping options available to customers within a shipping zone.
/// They include methods like flat rate shipping, free shipping, local pickup, and custom shipping solutions.
/// Each method can be configured with specific rates, settings, and delivery conditions.
///
/// ## Key Features
///
/// - **Method Management**: Create, update, and delete shipping methods within zones
/// - **Flexible Configuration**: Support for various shipping method types
/// - **Rate Control**: Configure shipping rates and conditions
/// - **Method Settings**: Customize method behavior and display options
/// - **Order Management**: Control the order in which methods are presented
///
/// ## Common Shipping Methods
///
/// - **Flat Rate**: Fixed cost shipping regardless of weight or distance
/// - **Free Shipping**: No cost shipping (usually with minimum order requirements)
/// - **Local Pickup**: Customer picks up items from physical location
/// - **Custom Methods**: Third-party shipping integrations and custom solutions
///
/// ## Example Usage
///
/// ```dart
/// // Get all shipping methods for a zone
/// final methods = await wooCommerce.getShippingZoneMethods(zoneId: 1);
///
/// // Create a new shipping method
/// final method = WooShippingZoneMethod(
///   methodId: 'flat_rate',
///   title: 'Standard Shipping',
///   enabled: true,
/// );
/// final createdMethod = await wooCommerce.createShippingZoneMethod(
///   zoneId: 1,
///   method: method,
/// );
///
/// // Update a shipping method
/// method.title = 'Express Shipping';
/// final updatedMethod = await wooCommerce.updateShippingZoneMethod(
///   zoneId: 1,
///   method: method,
/// );
///
/// // Delete a shipping method
/// await wooCommerce.deleteShippingZoneMethod(
///   zoneId: 1,
///   methodId: methodId,
/// );
/// ```
extension WooShippingZoneMethodApi on WooCommerce {
  /// Retrieves all shipping methods for a specific shipping zone
  ///
  /// This method fetches all shipping methods configured within a shipping zone.
  /// It's useful for displaying available shipping options or managing method
  /// configurations for a specific geographical area.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooShippingZoneMethod>>` containing all zone shipping methods
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all shipping methods for a zone
  /// final methods = await wooCommerce.getShippingZoneMethods(zoneId: 1);
  /// for (final method in methods) {
  ///   print('${method.title}: ${method.methodId}');
  /// }
  /// ```
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

  /// Retrieves a specific shipping method within a shipping zone
  ///
  /// This method fetches detailed information about a single shipping method
  /// within a shipping zone. It's useful for getting specific method details
  /// or validating method existence.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [methodId] - The unique identifier of the shipping method
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingZoneMethod>` containing the shipping method details
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific shipping method
  /// final method = await wooCommerce.getShippingZoneMethod(
  ///   zoneId: 1,
  ///   methodId: 2,
  /// );
  /// print('Method: ${method.title}');
  /// print('Enabled: ${method.enabled}');
  /// ```
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

  /// Creates a new shipping method within a shipping zone
  ///
  /// This method allows you to add a new shipping method to a shipping zone
  /// with the specified configuration. The method will be created with the
  /// provided settings and will be available to customers in that zone.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [method] - The shipping method object containing all configuration details
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingZoneMethod>` containing the created shipping method with assigned instance ID
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a new shipping method
  /// final method = WooShippingZoneMethod(
  ///   methodId: 'flat_rate',
  ///   title: 'Standard Shipping',
  ///   enabled: true,
  /// );
  /// final createdMethod = await wooCommerce.createShippingZoneMethod(
  ///   zoneId: 1,
  ///   method: method,
  /// );
  /// print('Created method with ID: ${createdMethod.instanceId}');
  /// ```
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

  /// Updates an existing shipping method within a shipping zone
  ///
  /// This method allows you to modify shipping method configuration, including
  /// title, settings, and enabled status. The method must have a valid instance ID.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [method] - The shipping method object with updated configuration
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingZoneMethod>` containing the updated shipping method
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update shipping method title
  /// method.title = 'Express Shipping';
  /// final updatedMethod = await wooCommerce.updateShippingZoneMethod(
  ///   zoneId: 1,
  ///   method: method,
  /// );
  /// print('Updated method: ${updatedMethod.title}');
  /// ```
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

  /// Deletes a shipping method from a shipping zone
  ///
  /// This method permanently removes a shipping method from a shipping zone.
  /// Use with caution as this action cannot be undone.
  ///
  /// ## Parameters
  ///
  /// * [zoneId] - The unique identifier of the shipping zone
  /// * [methodId] - The unique identifier of the shipping method to delete
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Delete a shipping method
  /// await wooCommerce.deleteShippingZoneMethod(
  ///   zoneId: 1,
  ///   methodId: 2,
  /// );
  /// print('Shipping method deleted successfully');
  /// ```
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
