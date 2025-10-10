import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Payment Gateway API Extension
///
/// This extension provides comprehensive payment gateway management capabilities for WooCommerce stores.
/// Payment gateways handle the processing of payments from customers, including credit cards,
/// digital wallets, bank transfers, and other payment methods.
///
/// ## Payment Gateway Overview
///
/// Payment gateways are the systems that process payments for your WooCommerce store.
/// They handle the secure transmission of payment information between your store and
/// payment processors, ensuring transactions are completed safely and efficiently.
///
/// ## Key Features
///
/// - **Multiple payment methods**: Support for various payment types and processors
/// - **Configuration management**: Customize gateway settings and behavior
/// - **Status control**: Enable or disable payment methods as needed
/// - **Feature support**: Configure supported features like refunds, subscriptions
/// - **Order management**: Control display order and checkout experience
///
/// ## Common Payment Gateways
///
/// - **PayPal**: PayPal Standard, PayPal Express, PayPal Pro
/// - **Stripe**: Credit cards, digital wallets, bank transfers
/// - **Square**: Point of sale integration and online payments
/// - **Authorize.Net**: Credit card processing
/// - **Bank Transfer**: Direct bank transfers
/// - **Cash on Delivery**: Payment upon delivery
///
/// ## Example Usage
///
/// ```dart
/// // Get all payment gateways
/// final gateways = await wooCommerce.getPaymentGateways();
///
/// // Get a specific gateway
/// final paypal = await wooCommerce.getPaymentGateway(id: 'paypal');
///
/// // Update gateway settings
/// paypal.enabled = true;
/// await wooCommerce.updatePaymentGateway(paypal);
/// ```
extension WooPaymentGatewayApi on WooCommerce {
  /// Retrieves all payment gateways from the WooCommerce store.
  ///
  /// This method fetches all available payment gateways, including their
  /// configuration, status, and supported features. Payment gateways determine
  /// how customers can pay for their orders.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-payment-gateways
  ///
  /// ## Parameters
  ///
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooPaymentGateway>>` containing all available payment gateways.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all payment gateways
  /// final gateways = await wooCommerce.getPaymentGateways();
  ///
  /// // Filter enabled gateways
  /// final enabledGateways = gateways.where((gateway) => gateway.enabled == true);
  ///
  /// // Print gateway information
  /// for (final gateway in gateways) {
  ///   print('Gateway: ${gateway.title} (${gateway.id})');
  ///   print('Enabled: ${gateway.enabled}');
  ///   print('Supports: ${gateway.methodSupports}');
  /// }
  /// ```
  Future<List<WooPaymentGateway>> getPaymentGateways({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooPaymentGateway.fake);
    }

    final response = await dio.get(
      _PaymentGatewayEndpoints.gateways,
    );

    return (response.data as List)
        .map((e) => WooPaymentGateway.fromJson(e))
        .toList();
  }

  /// Retrieves a specific payment gateway by its ID.
  ///
  /// This method fetches detailed information about a single payment gateway,
  /// including its configuration, settings, and supported features.
  /// Useful when you need to work with a specific gateway without loading all gateways.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-payment-gateway
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the payment gateway (e.g., 'paypal', 'stripe')
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooPaymentGateway>` containing the payment gateway details.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the gateway is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get PayPal gateway
  /// final paypal = await wooCommerce.getPaymentGateway(id: 'paypal');
  ///
  /// print('Gateway: ${paypal.title}');
  /// print('Enabled: ${paypal.enabled}');
  /// print('Supports: ${paypal.methodSupports}');
  ///
  /// // Check if gateway supports refunds
  /// if (paypal.methodSupports?.contains('refunds') == true) {
  ///   print('PayPal supports refunds');
  /// }
  /// ```
  Future<WooPaymentGateway> getPaymentGateway({
    required String id,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooPaymentGateway.fake();
    }

    final response = await dio.get(
      _PaymentGatewayEndpoints.singleGateway(id),
    );

    return WooPaymentGateway.fromJson(response.data);
  }

  /// Updates a payment gateway in the WooCommerce store.
  ///
  /// This method allows you to modify payment gateway configuration, including
  /// enabling/disabling the gateway, updating settings, and changing display options.
  /// The gateway must have a valid ID.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-payment-gateway
  ///
  /// ## Parameters
  ///
  /// * [gateway] - The payment gateway object with updated configuration
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooPaymentGateway>` containing the updated payment gateway.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the update fails or gateway not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get current gateway configuration
  /// final paypal = await wooCommerce.getPaymentGateway(id: 'paypal');
  ///
  /// // Enable the gateway
  /// paypal.enabled = true;
  /// paypal.title = 'PayPal - Safe and Secure';
  ///
  /// // Update gateway settings
  /// final updatedPaypal = await wooCommerce.updatePaymentGateway(paypal);
  /// print('Gateway updated: ${updatedPaypal.enabled}');
  /// ```
  Future<WooPaymentGateway> updatePaymentGateway(
    WooPaymentGateway gateway, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return gateway;
    }

    final response = await dio.put(
      _PaymentGatewayEndpoints.singleGateway(gateway.id!),
      data: gateway.toJson(),
    );

    return WooPaymentGateway.fromJson(response.data);
  }
}
