import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooShippingZoneMethodSetting {
  WooShippingZoneMethodSetting({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
  });
  factory WooShippingZoneMethodSetting.fromJson(Map<String, dynamic> json) =>
      WooShippingZoneMethodSetting(
        id: WooJson.readString(json, 'id'),
        label: WooJson.readString(json, 'label'),
        description: WooJson.readString(json, 'description'),
        type: WooJson.readString(json, 'type'),
        value: WooJson.readString(json, 'value'),
        defaultValue: WooJson.readString(json, 'default'),
        tip: WooJson.readString(json, 'tip'),
        placeholder: WooJson.readString(json, 'placeholder'),
      );
  factory WooShippingZoneMethodSetting.fake() => WooShippingZoneMethodSetting(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        type: FakeHelper.randomItem(const ['text', 'select', 'checkbox']),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
      );
  final String? id;
  final String? label;
  final String? description;
  final String? type;
  final String? value;
  final String? defaultValue;
  final String? tip;
  final String? placeholder;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('label', label)
    ..putIfPresent('description', description)
    ..putIfPresent('type', type)
    ..putIfPresent('value', value)
    ..putIfPresent('default', defaultValue)
    ..putIfPresent('tip', tip)
    ..putIfPresent('placeholder', placeholder);
  WooShippingZoneMethodSetting copyWith({
    String? id,
    String? label,
    String? description,
    String? type,
    String? value,
    String? defaultValue,
    String? tip,
    String? placeholder,
  }) =>
      WooShippingZoneMethodSetting(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        type: type ?? this.type,
        value: value ?? this.value,
        defaultValue: defaultValue ?? this.defaultValue,
        tip: tip ?? this.tip,
        placeholder: placeholder ?? this.placeholder,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooShippingZoneMethodSetting &&
        other.id == id &&
        other.label == label &&
        other.description == description &&
        other.type == type &&
        other.value == value &&
        other.defaultValue == defaultValue &&
        other.tip == tip &&
        other.placeholder == placeholder;
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        label,
        description,
        type,
        value,
        defaultValue,
        tip,
        placeholder,
      ]);
  @override
  String toString() => 'WooShippingZoneMethodSetting(id: $id)';
}
