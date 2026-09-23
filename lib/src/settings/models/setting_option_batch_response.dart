import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'setting_option.dart';

class WooSettingOptionBatchResponse {
  WooSettingOptionBatchResponse({this.create, this.update, this.delete});
  factory WooSettingOptionBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooSettingOptionBatchResponse(
        create: WooJson.readList(json, 'create', WooSettingOption.fromJson),
        update: WooJson.readList(json, 'update', WooSettingOption.fromJson),
        delete: WooJson.readList(json, 'delete', WooSettingOption.fromJson),
      );
  factory WooSettingOptionBatchResponse.fake() => WooSettingOptionBatchResponse(
        create: FakeHelper.list(() => WooSettingOption.fake()),
        update: FakeHelper.list(() => WooSettingOption.fake()),
        delete: FakeHelper.list(() => WooSettingOption.fake()),
      );
  final List<WooSettingOption>? create;
  final List<WooSettingOption>? update;
  final List<WooSettingOption>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putList('create', create?.map((option) => option.toJson()).toList())
    ..putList('update', update?.map((option) => option.toJson()).toList())
    ..putList('delete', delete?.map((option) => option.toJson()).toList());
  WooSettingOptionBatchResponse copyWith({
    List<WooSettingOption>? create,
    List<WooSettingOption>? update,
    List<WooSettingOption>? delete,
  }) =>
      WooSettingOptionBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSettingOptionBatchResponse &&
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
      'WooSettingOptionBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
