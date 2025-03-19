import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooPaymentGatewayApi on WooCommerce {
  /// Fetches all payment gateways
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

  /// Retrieves a specific payment gateway
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

  /// Updates a payment gateway
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