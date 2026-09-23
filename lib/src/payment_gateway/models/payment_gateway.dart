import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'payment_gateway_settings.dart';

class WooPaymentGateway {
  WooPaymentGateway({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
  });
  factory WooPaymentGateway.fromJson(Map<String, dynamic> json) =>
      WooPaymentGateway(
        id: WooJson.readString(json, 'id'),
        title: WooJson.readString(json, 'title'),
        description: WooJson.readString(json, 'description'),
        order: WooJson.readInt(json, 'order'),
        enabled: WooJson.readBool(json, 'enabled'),
        methodTitle: WooJson.readString(json, 'method_title'),
        methodDescription: WooJson.readString(json, 'method_description'),
        methodSupports: _readStringList(json, 'method_supports'),
        settings: _parseSettings(json),
      );
  factory WooPaymentGateway.fake() => WooPaymentGateway(
        id: FakeHelper.word(),
        title: FakeHelper.word(),
        description: FakeHelper.sentence(),
        order: FakeHelper.integer(),
        enabled: FakeHelper.boolean(),
        methodTitle: FakeHelper.sentence(),
        methodDescription: FakeHelper.sentence(),
        methodSupports: FakeHelper.list(() => FakeHelper.word()),
        settings: {
          for (var i = 0; i < FakeHelper.integer(max: 2); i++)
            FakeHelper.word(): WooPaymentGatewaySetting.fake(),
        },
      );
  final String? id;
  final String? title;
  final String? description;
  final int? order;
  final bool? enabled;
  final String? methodTitle;
  final String? methodDescription;
  final List<String>? methodSupports;
  final Map<String, WooPaymentGatewaySetting>? settings;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('title', title)
    ..putIfPresent('description', description)
    ..putIfPresent('order', order)
    ..putIfPresent('enabled', enabled)
    ..putIfPresent('method_title', methodTitle)
    ..putIfPresent('method_description', methodDescription)
    ..putIfPresent('method_supports', methodSupports)
    ..putIfPresent(
      'settings',
      settings?.map((key, value) => MapEntry(key, value.toJson())),
    );
  WooPaymentGateway copyWith({
    String? id,
    String? title,
    String? description,
    int? order,
    bool? enabled,
    String? methodTitle,
    String? methodDescription,
    List<String>? methodSupports,
    Map<String, WooPaymentGatewaySetting>? settings,
  }) =>
      WooPaymentGateway(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        order: order ?? this.order,
        enabled: enabled ?? this.enabled,
        methodTitle: methodTitle ?? this.methodTitle,
        methodDescription: methodDescription ?? this.methodDescription,
        methodSupports: methodSupports ?? this.methodSupports,
        settings: settings ?? this.settings,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooPaymentGateway &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.order == order &&
        other.enabled == enabled &&
        other.methodTitle == methodTitle &&
        other.methodDescription == methodDescription &&
        WooJson.listEquals(other.methodSupports, methodSupports) &&
        WooJson.mapEquals(other.settings, settings);
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        description,
        order,
        enabled,
        methodTitle,
        methodDescription,
        Object.hashAll(methodSupports ?? const []),
      ]);
  @override
  String toString() => 'WooPaymentGateway(id: $id, title: $title, '
      'enabled: $enabled)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }

  static Map<String, WooPaymentGatewaySetting>? _parseSettings(
    Map<String, dynamic> json,
  ) {
    final settings = WooJson.readMap(json, 'settings');
    if (settings == null) return null;
    return {
      for (final entry in settings.entries)
        if (entry.value is Map<String, dynamic>)
          entry.key: WooPaymentGatewaySetting.fromJson(
            entry.value as Map<String, dynamic>,
          ),
    };
  }
}
