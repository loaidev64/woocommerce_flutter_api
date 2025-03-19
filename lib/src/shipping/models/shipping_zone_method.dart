import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooShippingZoneMethod {
  final int? instanceId;
  final String? title;
  final int? order;
  final bool? enabled;
  final String? methodId;
  final String? methodTitle;
  final String? methodDescription;
  final Map<String, WooShippingZoneMethodSetting>? settings;

  WooShippingZoneMethod({
    this.instanceId,
    this.title,
    this.order,
    this.enabled,
    required this.methodId,
    this.methodTitle,
    this.methodDescription,
    this.settings,
  });

  factory WooShippingZoneMethod.fromJson(Map<String, dynamic> json) {
    final settings = json['settings'] as Map<String, dynamic>?;

    return WooShippingZoneMethod(
      instanceId: json['instance_id'],
      title: json['title'],
      order: json['order'],
      enabled: json['enabled'],
      methodId: json['method_id'],
      methodTitle: json['method_title'],
      methodDescription: json['method_description'],
      settings: settings?.map((key, value) =>
          MapEntry(key, WooShippingZoneMethodSetting.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() => {
        'instance_id': instanceId,
        'title': title,
        'order': order,
        'enabled': enabled,
        'method_id': methodId,
        'method_title': methodTitle,
        'method_description': methodDescription,
        'settings':
            settings?.map((key, value) => MapEntry(key, value.toJson())),
      };

  factory WooShippingZoneMethod.fake() => WooShippingZoneMethod(
        instanceId: FakeHelper.integer(),
        title: FakeHelper.sentence(),
        order: FakeHelper.integer(),
        enabled: FakeHelper.boolean(),
        methodId: FakeHelper.randomItem(
            const ['flat_rate', 'free_shipping', 'local_pickup']),
        methodTitle: FakeHelper.sentence(),
        methodDescription: FakeHelper.sentence(),
        settings: {
          for (var i = 0; i < FakeHelper.integer(max: 3); i++)
            FakeHelper.word(): WooShippingZoneMethodSetting.fake(),
        },
      );
}
