part of 'payment_gateway_api.dart';

abstract class _PaymentGatewayEndpoints {
  static String get gateways => '/payment_gateways';

  static String singleGateway(String id) => '/payment_gateways/$id';
}
