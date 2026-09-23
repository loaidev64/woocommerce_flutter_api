import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooWebhookDelivery {
  WooWebhookDelivery({
    this.id,
    this.createdDate,
    this.createdDateGmt,
    this.duration,
    this.requestUrl,
    this.requestHeaders,
    this.requestBody,
    this.responseCode,
    this.responseMessage,
    this.responseHeaders,
    this.responseBody,
  });
  factory WooWebhookDelivery.fromJson(Map<String, dynamic> json) =>
      WooWebhookDelivery(
        id: WooJson.readInt(json, 'id'),
        createdDate: WooJson.readDate(json, 'created_date'),
        createdDateGmt: WooJson.readDate(json, 'created_date_gmt'),
        duration: WooJson.readInt(json, 'duration'),
        requestUrl: WooJson.readString(json, 'request_url'),
        requestHeaders: WooJson.readMap(json, 'request_headers'),
        requestBody: WooJson.readString(json, 'request_body'),
        responseCode: WooJson.readInt(json, 'response_code'),
        responseMessage: WooJson.readString(json, 'response_message'),
        responseHeaders: WooJson.readMap(json, 'response_headers'),
        responseBody: WooJson.readString(json, 'response_body'),
      );
  factory WooWebhookDelivery.fake() => WooWebhookDelivery(
        id: FakeHelper.integer(),
        createdDate: FakeHelper.datetime(),
        createdDateGmt: FakeHelper.datetime(),
        duration: FakeHelper.integer(max: 5000),
        requestUrl: FakeHelper.url(),
        requestHeaders: const {
          'User-Agent': 'WooCommerce/8.0.0',
          'Content-Type': 'application/json',
        },
        requestBody: FakeHelper.sentence(),
        responseCode: 200,
        responseMessage: 'OK',
        responseHeaders: const {'Content-Type': 'application/json'},
        responseBody: '{"success": true}',
      );
  final int? id;
  final DateTime? createdDate;
  final DateTime? createdDateGmt;
  final int? duration;
  final String? requestUrl;
  final Map<String, dynamic>? requestHeaders;
  final String? requestBody;
  final int? responseCode;
  final String? responseMessage;
  final Map<String, dynamic>? responseHeaders;
  final String? responseBody;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('created_date', createdDate)
    ..putDate('created_date_gmt', createdDateGmt)
    ..putIfPresent('duration', duration)
    ..putIfPresent('request_url', requestUrl)
    ..putIfPresent('request_headers', requestHeaders)
    ..putIfPresent('request_body', requestBody)
    ..putIfPresent('response_code', responseCode)
    ..putIfPresent('response_message', responseMessage)
    ..putIfPresent('response_headers', responseHeaders)
    ..putIfPresent('response_body', responseBody);
  WooWebhookDelivery copyWith({
    int? id,
    DateTime? createdDate,
    DateTime? createdDateGmt,
    int? duration,
    String? requestUrl,
    Map<String, dynamic>? requestHeaders,
    String? requestBody,
    int? responseCode,
    String? responseMessage,
    Map<String, dynamic>? responseHeaders,
    String? responseBody,
  }) =>
      WooWebhookDelivery(
        id: id ?? this.id,
        createdDate: createdDate ?? this.createdDate,
        createdDateGmt: createdDateGmt ?? this.createdDateGmt,
        duration: duration ?? this.duration,
        requestUrl: requestUrl ?? this.requestUrl,
        requestHeaders: requestHeaders ?? this.requestHeaders,
        requestBody: requestBody ?? this.requestBody,
        responseCode: responseCode ?? this.responseCode,
        responseMessage: responseMessage ?? this.responseMessage,
        responseHeaders: responseHeaders ?? this.responseHeaders,
        responseBody: responseBody ?? this.responseBody,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooWebhookDelivery &&
          other.id == id &&
          other.createdDate == createdDate &&
          other.createdDateGmt == createdDateGmt &&
          other.duration == duration &&
          other.requestUrl == requestUrl &&
          WooJson.mapEquals(other.requestHeaders, requestHeaders) &&
          other.requestBody == requestBody &&
          other.responseCode == responseCode &&
          other.responseMessage == responseMessage &&
          WooJson.mapEquals(other.responseHeaders, responseHeaders) &&
          other.responseBody == responseBody;
  @override
  int get hashCode => Object.hashAll([
        id,
        createdDate,
        createdDateGmt,
        duration,
        requestUrl,
        requestBody,
        responseCode,
        responseMessage,
        responseBody,
      ]);
  @override
  String toString() => 'WooWebhookDelivery(id: $id, requestUrl: $requestUrl, '
      'responseCode: $responseCode)';
}
