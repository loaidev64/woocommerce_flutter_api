import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'shipping_zone_method_setting.dart';

class WooShippingZoneMethod {
  WooShippingZoneMethod({
    required this.methodId,
    this.instanceId,
    this.title,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.settings,
  });
  factory WooShippingZoneMethod.fromJson(Map<String, dynamic> json) =>
      WooShippingZoneMethod(
        instanceId: WooJson.readInt(json, 'instance_id'),
        title: WooJson.readString(json, 'title'),
        order: WooJson.readInt(json, 'order'),
        enabled: WooJson.readBool(json, 'enabled'),
        methodId: WooJson.readString(json, 'method_id'),
        methodTitle: WooJson.readString(json, 'method_title'),
        methodDescription: WooJson.readString(json, 'method_description'),
        settings: _parseSettings(json),
      );
  factory WooShippingZoneMethod.fake() => WooShippingZoneMethod(
        instanceId: FakeHelper.integer(),
        title: FakeHelper.sentence(),
        order: FakeHelper.integer(),
        enabled: FakeHelper.boolean(),
        methodId: FakeHelper.randomItem(
          const ['flat_rate', 'free_shipping', 'local_pickup'],
        ),
        methodTitle: FakeHelper.sentence(),
        methodDescription: FakeHelper.sentence(),
        settings: {
          for (var i = 0; i < FakeHelper.integer(max: 3); i++)
            FakeHelper.word(): WooShippingZoneMethodSetting.fake(),
        },
      );
  final String? methodId;
  final int? instanceId;
  final String? title;
  final int? order;
  final bool? enabled;
  final String? methodTitle;
  final String? methodDescription;
  final Map<String, WooShippingZoneMethodSetting>? settings;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('instance_id', instanceId)
    ..putIfPresent('title', title)
    ..putIfPresent('order', order)
    ..putIfPresent('enabled', enabled)
    ..putIfPresent('method_id', methodId)
    ..putIfPresent('method_title', methodTitle)
    ..putIfPresent('method_description', methodDescription)
    ..putIfPresent(
      'settings',
      settings?.map((key, value) => MapEntry(key, value.toJson())),
    );
  WooShippingZoneMethod copyWith({
    String? methodId,
    int? instanceId,
    String? title,
    int? order,
    bool? enabled,
    String? methodTitle,
    String? methodDescription,
    Map<String, WooShippingZoneMethodSetting>? settings,
  }) =>
      WooShippingZoneMethod(
        methodId: methodId ?? this.methodId,
        instanceId: instanceId ?? this.instanceId,
        title: title ?? this.title,
        order: order ?? this.order,
        enabled: enabled ?? this.enabled,
        methodTitle: methodTitle ?? this.methodTitle,
        methodDescription: methodDescription ?? this.methodDescription,
        settings: settings ?? this.settings,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooShippingZoneMethod &&
        other.methodId == methodId &&
        other.instanceId == instanceId &&
        other.title == title &&
        other.order == order &&
        other.enabled == enabled &&
        other.methodTitle == methodTitle &&
        other.methodDescription == methodDescription &&
        WooJson.mapEquals(other.settings, settings);
  }

  @override
  int get hashCode => Object.hashAll([
        methodId,
        instanceId,
        title,
        order,
        enabled,
        methodTitle,
        methodDescription,
      ]);
  @override
  String toString() => 'WooShippingZoneMethod(methodId: $methodId, '
      'instanceId: $instanceId, title: $title)';
  static Map<String, WooShippingZoneMethodSetting>? _parseSettings(
    Map<String, dynamic> json,
  ) {
    final settings = WooJson.readMap(json, 'settings');
    if (settings == null) return null;
    return {
      for (final entry in settings.entries)
        if (entry.value is Map<String, dynamic>)
          entry.key: WooShippingZoneMethodSetting.fromJson(
            entry.value as Map<String, dynamic>,
          ),
    };
  }
}
