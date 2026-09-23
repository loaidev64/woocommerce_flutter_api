import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/models.dart';
import '../models/payment_gateway.dart';
part 'endpoints.dart';

extension WooPaymentGatewayApi on WooCommerce {
  Future<List<WooPaymentGateway>> getPaymentGateways({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooPaymentGateway.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_PaymentGatewayEndpoints.gateways);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooPaymentGateway.fromJson)
            .toList() ??
        [];
  }

  Future<WooPaymentGateway> getPaymentGateway(String id,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPaymentGateway.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _PaymentGatewayEndpoints.singleGateway(id),
    );
    return WooPaymentGateway.fromJson(response.data!);
  }

  Future<WooPaymentGateway> updatePaymentGateway(
    String id,
    WooPaymentGateway gateway, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return gateway;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _PaymentGatewayEndpoints.singleGateway(id),
      data: gateway.toJson(),
    );
    return WooPaymentGateway.fromJson(response.data!);
  }
}
