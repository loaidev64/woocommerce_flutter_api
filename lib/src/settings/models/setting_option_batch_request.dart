import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'setting_option.dart';

class WooSettingOptionBatchRequest {
  WooSettingOptionBatchRequest({this.create, this.update, this.delete});
  factory WooSettingOptionBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooSettingOptionBatchRequest(
        create: WooJson.readList(json, 'create', WooSettingOption.fromJson),
        update: WooJson.readList(json, 'update', WooSettingOption.fromJson),
        delete: _readStringList(json, 'delete'),
      );
  factory WooSettingOptionBatchRequest.fake() => WooSettingOptionBatchRequest(
        create: FakeHelper.list(() => WooSettingOption.fake()),
        update: FakeHelper.list(() => WooSettingOption.fake()),
        delete: FakeHelper.list(() => FakeHelper.word()),
      );
  final List<WooSettingOption>? create;
  final List<WooSettingOption>? update;
  final List<String>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putList('create', create?.map((option) => option.toJson()).toList())
    ..putList('update', update?.map((option) => option.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooSettingOptionBatchRequest copyWith({
    List<WooSettingOption>? create,
    List<WooSettingOption>? update,
    List<String>? delete,
  }) =>
      WooSettingOptionBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSettingOptionBatchRequest &&
        WooJson.listEquals(other.create, create) &&
        WooJson.listEquals(other.update, update) &&
        WooJson.listEquals(other.delete, delete);
  }

  @override
  int get hashCode => Object.hashAll([
        Object.hashAll(create ?? const []),
        Object.hashAll(update ?? const []),
        Object.hashAll(delete ?? const []),
      ]);
  @override
  String toString() =>
      'WooSettingOptionBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
