import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'store_address.dart';

enum WooStorePaymentStatus {
  success,

  failure,

  pending,

  error,

  unknown;

  static WooStorePaymentStatus parse(String? wire) => switch (wire) {
        'success' => success,
        'failure' => failure,
        'pending' => pending,
        'error' => error,
        _ => unknown,
      };

  static WooStorePaymentStatus fake() => FakeHelper.randomItem(values);
}

class WooStorePaymentResult {
  const WooStorePaymentResult({
    required this.status,
    this.redirectUrl = '',
    this.details = const <String, String>{},
    this.message = '',
  });

  factory WooStorePaymentResult.fromJson(Map<String, dynamic> json) =>
      WooStorePaymentResult(
        status: WooStorePaymentStatus.parse(
          WooJson.readString(json, 'payment_status'),
        ),
        redirectUrl: WooJson.readString(json, 'redirect_url') ?? '',
        details: <String, String>{
          for (final value in (json['payment_details'] as List?) ?? const [])
            if (value is Map)
              '${value['key'] ?? ''}': '${value['value'] ?? ''}',
        },
        message: WooJson.readString(json, 'message') ?? '',
      );

  factory WooStorePaymentResult.fake() => WooStorePaymentResult(
        status: WooStorePaymentStatus.fake(),
        message: FakeHelper.sentence(),
      );

  final WooStorePaymentStatus status;

  final String redirectUrl;

  final Map<String, String> details;

  final String message;

  bool get needsRedirect => redirectUrl.isNotEmpty;

  bool get isPaid => status == WooStorePaymentStatus.success;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'payment_status': status.name,
        'redirect_url': redirectUrl,
        'payment_details': <Object?>[
          for (final entry in details.entries)
            <String, dynamic>{'key': entry.key, 'value': entry.value},
        ],
        'message': message,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStorePaymentResult &&
          other.status == status &&
          other.redirectUrl == redirectUrl &&
          WooJson.mapEquals(other.details, details) &&
          other.message == message;

  @override
  int get hashCode => Object.hashAll([
        status,
        redirectUrl,
        ...details.entries,
        message,
      ]);

  @override
  String toString() => 'WooStorePaymentResult($status)';
}

class WooStoreCheckout {
  const WooStoreCheckout({
    required this.orderId,
    required this.status,
    required this.orderKey,
    required this.billingAddress,
    required this.shippingAddress,
    required this.paymentResult,
    this.customerId = 0,
    this.customerNote = '',
    this.paymentMethod = '',
    this.additionalFields = const <String, dynamic>{},
  });

  factory WooStoreCheckout.fromJson(Map<String, dynamic> json) =>
      WooStoreCheckout(
        orderId: WooJson.readInt(json, 'order_id') ?? 0,
        status: WooJson.readString(json, 'status') ?? '',
        orderKey: WooJson.readString(json, 'order_key') ?? '',
        customerId: WooJson.readInt(json, 'customer_id') ?? 0,
        customerNote: WooJson.readString(json, 'customer_note') ?? '',
        paymentMethod: WooJson.readString(json, 'payment_method') ?? '',
        billingAddress: WooStoreAddress.fromJson(
          WooJson.readMap(json, 'billing_address') ?? <String, dynamic>{},
        ),
        shippingAddress: WooStoreAddress.fromJson(
          WooJson.readMap(json, 'shipping_address') ?? <String, dynamic>{},
        ),
        paymentResult: WooStorePaymentResult.fromJson(
          WooJson.readMap(json, 'payment_result') ?? <String, dynamic>{},
        ),
        additionalFields:
            WooJson.readMap(json, 'additional_fields') ?? <String, dynamic>{},
      );

  factory WooStoreCheckout.fake() => WooStoreCheckout(
        orderId: FakeHelper.integer(),
        status: 'checkout-draft',
        orderKey: 'wc_order_${FakeHelper.word()}',
        customerId: FakeHelper.integer(),
        customerNote: FakeHelper.sentence(),
        paymentMethod: 'cod',
        billingAddress: WooStoreAddress.fake(),
        shippingAddress: WooStoreAddress.fake(),
        paymentResult: WooStorePaymentResult.fake(),
      );

  final int orderId;

  final String status;

  final String orderKey;

  final int customerId;

  final String customerNote;

  final String paymentMethod;

  final WooStoreAddress billingAddress;

  final WooStoreAddress shippingAddress;

  final WooStorePaymentResult paymentResult;

  final Map<String, dynamic> additionalFields;

  bool get isPaid => paymentResult.isPaid;

  Uri receivedUrl(String baseUrl) => Uri.parse(
        '${baseUrl.replaceAll(RegExp(r'/+$'), '')}'
        '/checkout/order-received/$orderId/?key=$orderKey',
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'order_id': orderId,
        'status': status,
        'order_key': orderKey,
        'customer_id': customerId,
        'customer_note': customerNote,
        'payment_method': paymentMethod,
        'billing_address': billingAddress.toJson(),
        'shipping_address': shippingAddress.toJson(),
        'payment_result': paymentResult.toJson(),
        'additional_fields': additionalFields,
      };

  WooStoreCheckout copyWith({
    int? orderId,
    String? status,
    String? orderKey,
    int? customerId,
    String? customerNote,
    String? paymentMethod,
    WooStoreAddress? billingAddress,
    WooStoreAddress? shippingAddress,
    WooStorePaymentResult? paymentResult,
    Map<String, dynamic>? additionalFields,
  }) =>
      WooStoreCheckout(
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        orderKey: orderKey ?? this.orderKey,
        customerId: customerId ?? this.customerId,
        customerNote: customerNote ?? this.customerNote,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        billingAddress: billingAddress ?? this.billingAddress,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        paymentResult: paymentResult ?? this.paymentResult,
        additionalFields: additionalFields ?? this.additionalFields,
      );

  @override
  String toString() => 'WooStoreCheckout(order $orderId, $status)';
}
