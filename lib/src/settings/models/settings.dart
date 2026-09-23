import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSettings {
  WooSettings({
    this.id,
    this.label,
    this.description,
    this.parentId,
    this.subGroups,
  });
  factory WooSettings.fromJson(Map<String, dynamic> json) => WooSettings(
        id: WooJson.readString(json, 'id'),
        label: WooJson.readString(json, 'label'),
        description: WooJson.readString(json, 'description'),
        parentId: WooJson.readString(json, 'parent_id'),
        subGroups: _readStringList(json, 'sub_groups'),
      );
  factory WooSettings.fake() => WooSettings(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        parentId: FakeHelper.word(),
        subGroups: FakeHelper.list(() => FakeHelper.word()),
      );
  final String? id;
  final String? label;
  final String? description;
  final String? parentId;
  final List<String>? subGroups;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('label', label)
    ..putIfPresent('description', description)
    ..putIfPresent('parent_id', parentId)
    ..putIfPresent('sub_groups', subGroups);
  WooSettings copyWith({
    String? id,
    String? label,
    String? description,
    String? parentId,
    List<String>? subGroups,
  }) =>
      WooSettings(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        parentId: parentId ?? this.parentId,
        subGroups: subGroups ?? this.subGroups,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSettings &&
        other.id == id &&
        other.label == label &&
        other.description == description &&
        other.parentId == parentId &&
        WooJson.listEquals(other.subGroups, subGroups);
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        label,
        description,
        parentId,
      ]);
  @override
  String toString() => 'WooSettings(id: $id, label: $label)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
