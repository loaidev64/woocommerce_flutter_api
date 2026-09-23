import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSettingOption {
  WooSettingOption({
    this.id,
    this.label,
    this.description,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
    this.type,
    this.options,
    this.groupId,
  });
  factory WooSettingOption.fromJson(Map<String, dynamic> json) =>
      WooSettingOption(
        id: WooJson.readString(json, 'id'),
        label: WooJson.readString(json, 'label'),
        description: WooJson.readString(json, 'description'),
        value: json['value'],
        defaultValue: json['default'],
        tip: WooJson.readString(json, 'tip'),
        placeholder: WooJson.readString(json, 'placeholder'),
        type: WooJson.readString(json, 'type'),
        options: WooJson.readMap(json, 'options'),
        groupId: WooJson.readString(json, 'group_id'),
      );
  factory WooSettingOption.fake() => WooSettingOption(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
        type: FakeHelper.randomItem(['text', 'select', 'checkbox']),
        options: {
          FakeHelper.word(): FakeHelper.sentence(),
          FakeHelper.word(): FakeHelper.sentence(),
        },
        groupId: FakeHelper.word(),
      );
  final String? id;
  final String? label;
  final String? description;
  final dynamic value;
  final dynamic defaultValue;
  final String? tip;
  final String? placeholder;
  final String? type;
  final Map<String, dynamic>? options;
  final String? groupId;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('label', label)
    ..putIfPresent('description', description)
    ..putIfPresent('value', value)
    ..putIfPresent('default', defaultValue)
    ..putIfPresent('tip', tip)
    ..putIfPresent('placeholder', placeholder)
    ..putIfPresent('type', type)
    ..putIfPresent('options', options)
    ..putIfPresent('group_id', groupId);
  WooSettingOption copyWith({
    String? id,
    String? label,
    String? description,
    dynamic value,
    dynamic defaultValue,
    String? tip,
    String? placeholder,
    String? type,
    Map<String, dynamic>? options,
    String? groupId,
  }) =>
      WooSettingOption(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        value: value ?? this.value,
        defaultValue: defaultValue ?? this.defaultValue,
        tip: tip ?? this.tip,
        placeholder: placeholder ?? this.placeholder,
        type: type ?? this.type,
        options: options ?? this.options,
        groupId: groupId ?? this.groupId,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSettingOption &&
        other.id == id &&
        other.label == label &&
        other.description == description &&
        other.value == value &&
        other.defaultValue == defaultValue &&
        other.tip == tip &&
        other.placeholder == placeholder &&
        other.type == type &&
        WooJson.mapEquals(other.options, options) &&
        other.groupId == groupId;
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        label,
        description,
        value,
        defaultValue,
        tip,
        placeholder,
        type,
        groupId,
        if (options != null) _mapHash(options!),
      ]);
  static int _mapHash(Map<String, dynamic> map) {
    var hash = 0;
    for (final entry in map.entries) {
      hash ^= Object.hash(entry.key, entry.value);
    }
    return hash;
  }

  @override
  String toString() => 'WooSettingOption(id: $id, type: $type)';
}
