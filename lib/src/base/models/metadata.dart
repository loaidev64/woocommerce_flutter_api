import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooMetaData {
  const WooMetaData({this.id, this.key, this.value});
  factory WooMetaData.fromJson(Map<String, dynamic> json) => WooMetaData(
        id: WooJson.readInt(json, 'id'),
        key: WooJson.readString(json, 'key'),
        value: WooJson.readString(json, 'value') ?? '',
      );
  factory WooMetaData.fake() => WooMetaData(
        id: FakeHelper.integer(),
        key: FakeHelper.word(),
        value: FakeHelper.word(),
      );
  final int? id;
  final String? key;
  final String? value;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('key', key)
    ..putIfPresent('value', value);
  WooMetaData copyWith({int? id, String? key, String? value}) => WooMetaData(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooMetaData &&
          other.id == id &&
          other.key == key &&
          other.value == value;
  @override
  int get hashCode => Object.hashAll([id, key, value]);
  @override
  String toString() => 'WooMetaData(id: $id, key: $key, value: $value)';
}
