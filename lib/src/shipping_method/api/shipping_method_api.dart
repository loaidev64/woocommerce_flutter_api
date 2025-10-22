import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Shipping Method API Extension
///
/// This extension provides comprehensive shipping method management capabilities for WooCommerce stores.
/// Shipping methods define how products are delivered to customers, including delivery options, costs,
/// and availability rules for e-commerce applications.
///
/// ## Shipping Method Overview
///
/// Shipping methods are delivery options configured in WooCommerce that determine how products
/// are shipped to customers. They provide a way to offer different delivery options with varying
/// costs and timeframes to enhance the customer shopping experience.
///
/// ## Key Features
///
/// - **Method Retrieval**: Fetch all available shipping methods from the store
/// - **Individual Access**: Get specific shipping method details by ID
/// - **Display Information**: Access human-readable titles and descriptions
/// - **Fake Data Support**: Built-in fake data generation for testing and development
///
/// ## Shipping Method Types
///
/// - **Flat Rate**: Fixed cost shipping regardless of weight or distance
/// - **Free Shipping**: No cost shipping (usually with minimum order requirements)
/// - **Local Pickup**: Customer picks up items from physical location
/// - **Custom Methods**: Third-party shipping integrations and custom solutions
///
/// ## Example Usage
///
/// ```dart
/// // Get all shipping methods
/// final methods = await wooCommerce.getShippingMethods();
///
/// // Get specific shipping method
/// final method = await wooCommerce.getShippingMethod(id: 'flat_rate');
///
/// // Display shipping options to customers
/// for (final method in methods) {
///   print('${method.title}: ${method.description}');
/// }
/// ```
extension WooShippingMethodApi on WooCommerce {
  /// Retrieves a paginated list of shipping methods from the WooCommerce store.
  ///
  /// This method allows you to fetch all available shipping methods configured in your store.
  /// It's particularly useful for displaying shipping options to customers during checkout
  /// or for administrative management of shipping configurations.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-shipping-methods
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooShippingMethod>>` containing the shipping method objects.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all shipping methods
  /// final methods = await wooCommerce.getShippingMethods();
  ///
  /// // Display shipping options in UI
  /// for (final method in methods) {
  ///   print('${method.title}: ${method.description}');
  /// }
  ///
  /// // Use fake data for testing
  /// final fakeMethods = await wooCommerce.getShippingMethods(useFaker: true);
  /// ```
  Future<List<WooShippingMethod>> getShippingMethods({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooShippingMethod.fake);
    }

    final response = await dio.get(
      _ShippingMethodEndpoints.methods,
    );

    return (response.data as List)
        .map((e) => WooShippingMethod.fromJson(e))
        .toList();
  }

  /// Retrieves a specific shipping method by its unique identifier.
  ///
  /// This method fetches detailed information about a single shipping method
  /// identified by its unique ID. It's useful for getting specific shipping
  /// method details, validating shipping method existence, or displaying
  /// detailed information about a particular shipping option.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-shipping-method
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the shipping method to retrieve
  /// * [useFaker] - Override the global faker setting for this request (optional)
  ///
  /// ## Returns
  ///
  /// A `Future<WooShippingMethod>` containing the shipping method details.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the shipping method is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific shipping method
  /// final method = await wooCommerce.getShippingMethod(id: 'flat_rate');
  /// print('Shipping Method: ${method.title}');
  /// print('Description: ${method.description}');
  ///
  /// // Check if method exists
  /// try {
  ///   final method = await wooCommerce.getShippingMethod(id: 'express');
  ///   print('Express shipping is available');
  /// } catch (e) {
  ///   print('Express shipping not found');
  /// }
  /// ```
  Future<WooShippingMethod> getShippingMethod({
    required String id,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooShippingMethod.fake();
    }

    final response = await dio.get(
      _ShippingMethodEndpoints.singleMethod(id),
    );

    return WooShippingMethod.fromJson(response.data);
  }
}
